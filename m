Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBCC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA8A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTeXydWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA8A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeJWXI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:08:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44093 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeJWXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:08:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id t78-v6so630188ywg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vC30W0P9TgFWxYZfCT1yBUJ6YXIcvcWsS0pwV0WP2Ko=;
        b=cTeXydWPwiZU3FwnEojEjoMHrfgWqQucQBE3YLLCxOVUUKnecGZvADi4Rfrvi58Q9l
         r7YbmNxQzwqQ1zMFtHib1HlCvsbeBy86kS82oOMcB18DIu61KDfo+TH50HXKlljb8IuC
         Wcld4UKDAqNS7/mkxbezuX8DBjXyB2x2sYd9mBE8fkVOSz4lkVAxZtPqaeIWYNtApJhr
         YfsZqSwV3ruVpX/dx8IffPOejitiX6IREfcx1BR+5wVOTBTPAbN4PMMntCgjXXN48Gn3
         FtvDmTPqYwfAbTi6adjb03qlc0sMk8z1f+D1/YPltx1SDPug6pgEDBnqJ4bLG6qeJ399
         gmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vC30W0P9TgFWxYZfCT1yBUJ6YXIcvcWsS0pwV0WP2Ko=;
        b=M6IjUvMTYq0ow2V3neDzDcD8Wn/SD0ZRi/j1hwzgvtlFc4mU4p00YxEKxiuD0QQB3Q
         BcN43wa7xjrPO1RA18/QrWCxOihXfZ8wCUbiXxQVsqDfZoimz1+cQ0CjOZIzkrG/XxAj
         X4PRGIJiU323HFIZyLtLshp+PbIHRvzIghPtWquY6bBtPOaCVV5aBdyV8r6dSV1FYy+T
         tVj/CuSaSW1yptDMOeMv+jSL1XWgCTnoX/NvFZkmSfPcjh5gmy8jVClVX55G+d0f0ndm
         cxr3Gk8YEZ6b3XnZy+Ikk0C7FUKYKMkzdXtdR44durdssZcyBRebkxXg77yDY+I1chBS
         NDFA==
X-Gm-Message-State: ABuFfoioJsJRSEORqIqfC4260kg9WK54kQX5tdABxSatQ64UaOGnp7JI
        ZfQajh9mIiJf0Xy1ZAesGEsaGrtYmBD8xpg/kvw=
X-Google-Smtp-Source: ACcGV62m5NGLGg7Ra6B+Zjs0EGGtbnjH2JuAPCkHoOLC9lyGFX9t8MlvW6HO/THiYqtJALUsqGL2csRupfrywHLLwcM=
X-Received: by 2002:a81:a50d:: with SMTP id c13-v6mr35902413ywh.264.1540305883863;
 Tue, 23 Oct 2018 07:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181009112837.2517-1-peron.clem@gmail.com> <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
In-Reply-To: <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 23 Oct 2018 16:44:32 +0200
Message-ID: <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dinh,

On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 10/09/2018 06:28 AM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> >
> > Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for =
Cylone5.
> >
>
> I'm not sure the need for this patch. Are there any cyclone5 based
> boards that has UART1 as the debug uart? I see that all of them are
> using UART0.

There is no upstream device with this UART used. But the board I have
use it, and there is no limitation to not have it available upstream
no ?

Thanks,
Clement

>
> Dinh
>
