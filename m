Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71462188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Gc/Ozp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71462188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeHQL1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:27:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33905 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:27:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id g9-v6so74677lfh.1;
        Fri, 17 Aug 2018 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MxUgcdaTG5NxTX6uGKmegdZq0YDuh2K0IpLA0pmb2QM=;
        b=O7Gc/OzpsF5eH6V+gvcFZGoLrCsCjOJ+LaUoN4PcET1ZoaSS1nQO4WEwEuT/xmVSJ6
         WoLffyJ0pxWmnsskenSfSa8Ch/ZQ353H5gYWgszOx4FoKAAFinROcFTekARvRKnmJcX9
         bk7op3j6kJXI/WXyIb2NhoorO9x3cKLc3Si1yBLq5ydXaacu06tCIlztUGH7mjxachbY
         uROs/EA8PR8Q8xFMlJ71XAU0+fBTDsRirAeJ4FQ6JvjT7lI89CVbvmJdNYmCiUQ3gVnQ
         ilUCqCJ1/A00lE/VmriUr1Yv76b9Imjqav4xVBYnYG8j6FAlSKl0ZrySOeOI5rRQaDvL
         XmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MxUgcdaTG5NxTX6uGKmegdZq0YDuh2K0IpLA0pmb2QM=;
        b=p4Pv7Rn8QC/FIovxtg3X2ml9o0GS6SMvVo0CnLjKFnsYSpoGxK5ayjydD/94V0fLP6
         AWeTCSTJ+pZ08qY8DMponmb4elB8I4IJGLoOmA6sWRexycIy49+oShWwsF5jawloLHjt
         iJ4CXInd0cmL+ZgPw0EE8lbEdqRNBs7wCDwbyYcIo1Ju+sfDme1L+fDvStUTIByxx15K
         cSy1z9vkKOzP6C0///+IZ3IHfdVvF7DlMGELUMI3mHn0YaFXgmGgPsR2X9yCaoOa4T9T
         lEIWk8NyRA9wl1Fk6p0HxWj63yFLTNpGrwa96RoT5jQlIP2d/uyyvBXlT0b9sYJ3gd0B
         wkNQ==
X-Gm-Message-State: AOUpUlH1+6C467Odd/MILE6EIhEXZgipH0HrLyiH0dKa4UAZ7Bw4jafM
        Fm5DkaqNfadrI2cpLzQKmlL2thpTA0x1ghoJjyU=
X-Google-Smtp-Source: AA+uWPwuygpu03AWzbwCBnFUh+BppQqP8fxCrAbc1uRLU4L9aUyfafMlwiYUcs/khulTyCPoI29+5rU8je2/KcaGjF8=
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr21248122lfi.121.1534494289362;
 Fri, 17 Aug 2018 01:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAP4sYWUDb8wtNVvgPO+3a5MWoiBGuafQpvG6KR30RWinf36Msw@mail.gmail.com>
 <20180816.123002.844201503080913720.davem@davemloft.net> <d3c380fc-cebd-0a91-1acc-916a453c9f11@redhat.com>
In-Reply-To: <d3c380fc-cebd-0a91-1acc-916a453c9f11@redhat.com>
From:   Wang Jian <jianjian.wang1@gmail.com>
Date:   Fri, 17 Aug 2018 16:24:37 +0800
Message-ID: <CAP4sYWWBgyz39xUH7y8UVPWoNJWGMN8ToHx0W9ax6qJ9QgZ22g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tap: comment fix
To:     Jason <jasowang@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        girish.moodalbail@oracle.com, mst@redhat.com,
        Willem de Bruijn <willemb@google.com>,
        viro@zeniv.linux.org.uk, wexu@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reminder.
Because this change is trivial, I change the subject.
On Fri, Aug 17, 2018 at 12:29 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
>
> On 2018=E5=B9=B408=E6=9C=8817=E6=97=A5 03:30, David Miller wrote:
> > From: Wang Jian <jianjian.wang1@gmail.com>
> > Date: Thu, 16 Aug 2018 21:01:27 +0800
> >
> >> The tap_queue and the "tap_dev" are loosely coupled, not "macvlan_dev"=
.
> >>
> >> And I also change one rcu_read_lock's place, seems can reduce rcu
> >> critical section a little.
> >>
> >> Signed-off-by: Wang Jian <jianjian.wang1@gmail.com>
> > This patch was corrupted by your email client, for example it turned
> > TAB characters into sequences of spaces.
> >
> > Please fix this, email a test patch to yourself, and do not resend the
> > patch to this mailing list until you can successfully extract and
> > cleanly apply the test patch you email to yourself.
> >
> > Thank you.
>
> Besides this, please split it into two patches. The RCU change does not
> belong to "comment fix" for sure.
>
> Thanks
>


--=20
Regards,
Wang Jian
