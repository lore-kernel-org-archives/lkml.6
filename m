Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DCAC64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD31921470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6+wDdi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD31921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJDQR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:17:26 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42312 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJDQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:17:25 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so3606400ybc.9;
        Thu, 04 Oct 2018 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARVJdzXwwWYSg5KyY09Nxq+J5zX57B5O4/1LZTfEfZM=;
        b=i6+wDdi//OabOzuaH0338ek2dXs1qtGyEWwHtkOQY89gRrVCUDUnTzt8CtoGzD+AGh
         SqX6NeFtvuCeobrNJQDD3IEQyC63JZqzg9mk3mmVdy2Dh2rD9mLWJPw9xn0KPLcQOa+U
         5eAkP//YzQ/DXzrDgkpzZLTCDx3+XOSe7yBFDtm8CUkXU8WLx7UKrb4kvEIWT4qZe7XX
         OBuP4xXr6vvwK4DZCfIsxylmkCk5cBEMtwMuPeN7iAepZBTTf5tTjXCYZx41nGWsWjho
         9o9V3XsmTLDI3uQtuylubK+du+qjQI4xKjF/BC5qZ4LUSShR8i57ZEv8+LuB/623q3pa
         V+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARVJdzXwwWYSg5KyY09Nxq+J5zX57B5O4/1LZTfEfZM=;
        b=hQWUaLlCTh6xF+GxKmSRS8ZQx5FPdJqy5D3u8T9lQXVbp4FReWeW/XZAO1+G4S9Ohr
         CMxbFF52Q3xPDZnPP3WPH8jWqiS39kMeKoNT9PRqluHulMksMZtB3o4m8luk8nD2Jute
         j4X0xWKoinM5DfBIAmPrear2Wia12c98Mz+5hm09pojRjf9U5V8ep9ttstCaimN2nwlk
         EIoZ+98/xG4gkhBSIGFw+MKLRuoCSqFki743RdAYoMpr7wogMlCNZZUIbEOG++FPj48d
         GejhPCEsaNIuDubzna3KTEHTB9p3HpRwmw7AnZgaIiFaNdOTWsaWgzSeF7PmqyEBJKwk
         QuDw==
X-Gm-Message-State: ABuFfoh4er+KauGGkyWjAi9KQrOQyX4twuTl4FZyz2+rVFz+5nBQ1Yld
        MeewjImUCsQrYjOOSUOlZYRLRFpaFs8FFKtDpRg=
X-Google-Smtp-Source: ACcGV60r+ZIwQr2PL0T3Bd0bpTTFft0uHTowAcdpE4NEoVus4MmbM2t5cN4R33OEZcXNeRrDsMyJ7mDpBdLzKv3Bx84=
X-Received: by 2002:a25:86c2:: with SMTP id y2-v6mr3014097ybm.472.1538645102527;
 Thu, 04 Oct 2018 02:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181004085415.12925-1-peron.clem@gmail.com> <20181004085415.12925-3-peron.clem@gmail.com>
 <20181004091632.GA30658@n2100.armlinux.org.uk>
In-Reply-To: <20181004091632.GA30658@n2100.armlinux.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 4 Oct 2018 11:24:51 +0200
Message-ID: <CAJiuCcd3ANzX63X+ZtGFeeeEKdWPS6b=YhF4KKyBZgA3L0AxNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
To:     Russell King <linux@armlinux.org.uk>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Oct 2018 at 11:16, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 04, 2018 at 10:54:15AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Dinh Nguyen <dinguyen@kernel.org>
> >
> > Turn on these ARM and PL310 errata for SoCFPGA:
> >
> > ARM_ERRATA_754322
> > ARM_ERRATA_764369
> > ARM_ERRATA_775420
> >
> > PL310_ERRATA_588369
> > PL310_ERRATA_727915
> > PL310_ERRATA_753970
> > PL310_ERRATA_769419
> >
> > Fixes: 387798b37c8d ("ARM: initial multiplatform support")
>
> What was broken in the referred to commit that caused this regression?
> If it's not a regression, why does it have a Fixes: line?

Sorry I'm not familiar with the "Fixes" tag, I though it was required
to be backported on the stable branch.
I will remove it in the v2

Thanks,
Cl=C3=A9ment
