Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0884FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE792177E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="rawHtMg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfBOBVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:21:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35894 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfBOBVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:21:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so8925152qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 17:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0fAk4pSt7iV6A9PWwP9L37buZKmPSquUpty34V6Pbw=;
        b=rawHtMg/C8YXzz2pYiVb/AgTbmfdexX6cpkqo7wA7YsbEP1LfijmW/3OXNJU5UUEOj
         TQy+T0BIa1XuISen5zrhMqVJi6vxBBLzpWoRhgqtzt7IDLrI0h2m/mMiSwtu/WBSRQzc
         lko6ogDrlRX0gKc0xObBzVQagDVhynZTj2LOYaEiMnlAbSQaTNOX2JyiI5z/J+IiWj78
         PfJfZWcZDe64iiEY90/MkedsHoX6Qs6Gc/MYCbI8LJIo300MLi/MEGeFaCTVguTDfLAN
         8ergndLXNKczbdNDdGaqZYY8NcwwJLgKV5X8xaz3oi7yw4zRzbm/p5fpkSLvzSrAap4f
         6bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0fAk4pSt7iV6A9PWwP9L37buZKmPSquUpty34V6Pbw=;
        b=fas29O76+W/OMyV2oMP1iZFv5p18n4g9kPJcCnvkXsD9dW3GL+IFRf0S4aD55+dghT
         aCsys52P3HpxA7UEBC+V8ZdFdY5CPhLujAxgQpw0+T2noimyr+bwW19XXugWExeZm/tq
         Dm/TDOJtNiYb5eBvX6z1O3t7u4o6PphBGADefOL7iibrpfCN/EX8AHKyS5krxvcMeUL+
         0658E/DUb3bX0F1EkGqXusI8SZ1DAb2sP3iSn4JWVut1qS32Y/Qzgt41rcgL/PQxm48z
         6gsJACaReDc1/nhyfWb5g0o9mvCy0wzoKJhb4w4uoRhYV3znSy0MzKtSZ1PRQvNrXNI8
         PcFg==
X-Gm-Message-State: AHQUAuZga83POhiq+W/6q1f+zhvLUVl0gokes3Lb4YBy/cftLo572wCV
        ZvTocAIGQxOQeYW6yTdANiv5wMMf0YsVshp7lnbJlQ==
X-Google-Smtp-Source: AHgI3Ibbky1W7YH81MDrbUqq+bnGBiheDY5vvoB+j23WyPIGyGAAEjf1jexXQJSTOH7yfzOAIOQyZDSY6+PP72EHkr0=
X-Received: by 2002:a0c:92a9:: with SMTP id b38mr5167157qvb.70.1550193660229;
 Thu, 14 Feb 2019 17:21:00 -0800 (PST)
MIME-Version: 1.0
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica> <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica> <20181031025657.GA17861@nautica> <20190215010029.GA10899@nautica>
In-Reply-To: <20190215010029.GA10899@nautica>
From:   Tom Herbert <tom@herbertland.com>
Date:   Thu, 14 Feb 2019 17:20:49 -0800
Message-ID: <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     David Miller <davem@davemloft.net>, doronrk@fb.com,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:00 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Dominique Martinet wrote on Wed, Oct 31, 2018:
> > Anyway, that probably explains I have no problem with bigger VM
> > (uselessly more memory available) or without KASAN (I guess there's
> > overhead?), but I'm sending at most 300k of data and the VM has a 1.5GB
> > of ram, so if there's an allocation failure there I think there's a
> > problem ! . . .
> >
> > So, well, I'm not sure on the way forward. Adding a bpf helper and
> > document that kcm users should mind the offset?
>
> bump on this - I had mostly forgotten about it but the nfs-ganesha
> community that could make use of KCM reminded me of my patch that's
> waiting for this.
>
> Summary for people coming back after four months:
>  - kcm is great, but the bpf function that's supposed to be called for
> each packet does not automatically adjust the offset so that it can
> assume the skb starts with the packet it needs to look at
>
>  - there is some workaround code that is far from obvious and
> undocumented, see the original thread[1]:
> [1] http://lkml.kernel.org/r/20180822183852.jnwlxnz54gbbf6po@davejwatson-mba.dhcp.thefacebook.com
>
>  - my patch here tried to automatically pull the corresponding packet to
> the front, but apparently with KASAN can trigger out of memory
> behaviours on "small" VMs, so even if it doesn't seem to impact
> performance much without KASAN I don't think it's really ok to
> potentially hang the connection due to oom under severe conditions.
>
>
> The best alternative I see is adding a proper helper to get
> "kcm_rx_msg(skb)->offset" from bpf and document it so users aren't as
> lost as I have been; I'm not quite sure how/where to add such a helper
> though as I've barely looked at the bpf code until now, but should we go
> for that?

Dominique,

Thanks for looking into this.

I'd rather not complicate the bpf code for this. Can we just always do
an pskb_pull after skb_clone?

Tom

>
>
> (it really feels wrong to me that some random person who just started by
> trying to use kcm has to put this much effort to keep the ball rolling,
> if nobody cares about kcm I'm also open to have it removed completely
> despite the obvious performance gain I benchmarked for ganesha[2] ;
> barely maintained feature is worse than no feature)
>
> [2] https://review.gerrithub.io/c/ffilz/nfs-ganesha/+/421314
>
> Thanks,
> --
> Dominique
