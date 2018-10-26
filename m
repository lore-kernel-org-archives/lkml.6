Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C276FECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FED92085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzWRiAxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FED92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeJ0Hrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:47:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39488 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJ0Hrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:47:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so3134126qtq.6;
        Fri, 26 Oct 2018 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8d8lJVCdYnJMndrGOEWef5V93Rg4WpW7AxpdyTCgcdY=;
        b=HzWRiAxYCHMGHBciZ9AVeqBu1s7P9umxatSclfMtKU1RAvCTm4Xv5uxlj6SqSgGafL
         wGiWCwv2vvF/sxUpMG++hR5O7YxsBW85LUI13283v/aR0i5RpZh0COCOJybLIAZqi4G1
         hgm5UCqeDPL9JBrPn9DsIjdyQ0tq7QKEh+uWXJuFHgOciGFVJH1nDHfbNK9YgfBSQW7w
         g+dHQKutb8zcdQBbOd+lq0fKZ58tvtE+TXcR6w+d//UMTNO9uhk9doh9qEtG9Gwl8ygh
         7tcTZuoBqE7yEnpYJrD4ObcdiGUTL0TZWtoXETZN25HKQNYuDH5Ls8Cosz4afvAq15ta
         i9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8d8lJVCdYnJMndrGOEWef5V93Rg4WpW7AxpdyTCgcdY=;
        b=Sqnw/Yv2okvTeIVn5Jmi2ikDzg95IQ5D2Uw9ivLolesu6B0RQqLE7um+rtlRVOhyN7
         w/+PlllZt1zKya9k7ji0l68YKe/vUQv6ncZlo9wv4osf1nyqrmfcvMCy8MxL8olO1+ig
         qJ+3aItEP8uQsTXpNuddgpGftR5t8geBE0sapSL+oVB+B/bGeayLoN/pbU0XJr/CLUXT
         wET7SN/g0SKUojJ0IpWcrBdDQGTK7No5X0hlRcsBy1dGoEE+dYIUBkm7JtciIvGUOtEx
         89TA7/fHia+mhpRciJHPVKpJoWwq4UJ3M+iUU6kS2oLE2Lw3acOcgIIPoxtA7T6pYb70
         V4dQ==
X-Gm-Message-State: AGRZ1gIcwPof3N81N/zTsljosdIzoJp+YWkp3QrQqmWzrslsNK3ZpQml
        Nvlm6fNmRodjENTjufsmloFZBYeHy/D0xS/EB/8=
X-Google-Smtp-Source: AJdET5f7dZq33G9pGypcko1S27QmxVhtWpHKCI6FnQnQrajuC5x7EbmQq53CD5XMpuqzNXN4SrYmF93UxVgH5JZLUFI=
X-Received: by 2002:aed:27de:: with SMTP id m30-v6mr1847010qtg.328.1540595328017;
 Fri, 26 Oct 2018 16:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
 <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com> <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
 <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
In-Reply-To: <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Fri, 26 Oct 2018 16:08:35 -0700
Message-ID: <CAA93jw4pvEYiXZ-C=yH1H_twZigSYAuEMrE_CCDjzLnVHwAdVA@mail.gmail.com>
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     hkallweit1@gmail.com,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:54 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hi.
>
> On 26.10.2018 22:25, Dave Taht wrote:
> > Can you repeat your test, disabling gro splitting in cake?
> >
> > the option is "no-split-gso"
>
> Still panics. Takes a couple of rounds, but panics.
>
> Moreover, I've stressed my HTB setup like this too for a longer time,
> and it panics as well. So, at least, now I have a proof this is not a
> CAKE-specific thing.

Groovy. :whew:

I do look forward to more cake test results, particularly on different
network cards such as these, and at speeds higher than 10Gbit on high
end hardware, and in the 100-1Gbit range on low to mid-range. After
the last round of features added to cake before it went into linux, we
run now out of cpu on inbound shaping at those speeds on low end apu2
(x86) hardware, (atom and a15 chips are not so hot now either) and I
wish I knew what we could do to speed it up. The new "list skb" and
mirred code looked promising but we haven't got around to exploring it
yet.

Thank you for trying and I hope this gets sorted out on your chipset.

>
> Also, I've stressed it even with noqueue, and the panic is still there.
> So, this thing is not even sch-specific.
>
> Next, I've seen GRO bits in the call trace and decided to disable GRO on
> this NIC. So far, I cannot trigger a panic with GRO disabled even after
> 20 rounds of speedtest.

We tend to use flent's rrul test to *really* abuse things. :)

So cake's ok with gro disabled in hw?

>
> So, must be some generic thing indeed.
>
> --
>    Oleksandr Natalenko (post-factum)



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
