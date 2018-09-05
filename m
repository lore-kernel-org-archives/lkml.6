Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B70C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224E220652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PNHyHqZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIFCtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:49:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39962 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIFCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:49:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so7329316lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3fI59WR7PWgzaQfSCKN9f+n0hr/keKYaE4QcnZO81k=;
        b=PNHyHqZeRy0RZD+YrTnU5QEWkYN5uCe1kRVD974YYslv9DpAZeFqoP8VAJ1MTlenmA
         3dKE+yeALkncpra7LTrpl2MQI3m1uunQJEe2oEKW2Yv+x1KYHC2/UKKC8/xaTu7B7JJc
         a33vrTK9o4lnhUXLZnZR9p/M1h5EXzTjcmqq2JLRnjiw1n12eKoBTZM7o/T5apgqnPmK
         WHJM+yWFAwtyR6XvbyH5Zo0cyFpmcLOYfePB9mFWP1gXH9DGJLxvuXDZ8XLOX+QflCkv
         kOslk+dBPK5DQ7iQ1VMowyKMZseNWjQ39lM58So4wOAmb4/p2s0Ty71TLS7FEcy0dc5U
         TLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3fI59WR7PWgzaQfSCKN9f+n0hr/keKYaE4QcnZO81k=;
        b=KtqE43vzXG5AUElaoA4hzfdTtUli5Pi62055gOOgz6CeDyi+TYnV0ETuMTOxwGLyg1
         U/Q2fk52h9CxUvhpAtg6ZDLz4AN/piwGK6Y/OC1Eni6nfaos5zYOGbD3n37/rIHOMz59
         UtqiJ4PLQwlXJTxjn3+umyWXwgnKhsR5/nlGLElg4IYu74o7JK9g99r0fqqoIeIuWowB
         T9UhuR3pnsro7YbLu1SoFdW9BEyuaKv8rNMBhzqhdE4MphmQhS7Thw+VBE8eEteWJY0F
         ldVbsSr/utMqbki9kogM9FL8Z47Xrk7tKVsSRYA6+B2hDA8pIE9/SMBW4NyDXgM//LQu
         MbrA==
X-Gm-Message-State: APzg51B8ggRoX5TDVroFwdJrmoMILmTQvNCew1nIqRqjRm/6EFvZish9
        QVR1fy86QTmr9dajdAVG078/Oi9tNpm+ekd0evTp
X-Google-Smtp-Source: ANB0VdaznKEuJT745EgkOwA7KzzGb3831jnndOfMrAfxFYrevv5hCR7kWkGT9fhu4rxHrn4U3rSQn4ZGGyBSrzrPjYY=
X-Received: by 2002:ac2:4308:: with SMTP id l8-v6mr25956831lfh.35.1536185817626;
 Wed, 05 Sep 2018 15:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com> <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
 <CAG48ez1VMp=NXWb2eSEZsnszs-g5NVUhCVLXrjnMcHZYBJus8w@mail.gmail.com>
In-Reply-To: <CAG48ez1VMp=NXWb2eSEZsnszs-g5NVUhCVLXrjnMcHZYBJus8w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Sep 2018 18:16:46 -0400
Message-ID: <CAHC9VhRrSYxsqQ==8anCKT+BEjBgD3wppMyeyGec_DMbowq=Tg@mail.gmail.com>
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make it stricter
To:     jannh@google.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:47 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 9, 2018 at 3:56 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:

...

> > In the case where we have a MLS policy loaded (pol->mls_enabled != 0)
> > and scontext is empty (scontext[0] = '\0'), we could end up returning
> > 0 couldn't we?  It seems like we might want a quick check for this
> > before we parse the low/high portions of the field into the rangep
> > array.
>
> I don't think so. In the first loop iteration, `sensitivity` will be
> an empty string, and so the hashtab_search() should return NULL,
> leading to -EINVAL. Am I missing something?

Looking at this again, no, I think you've got it right.  My guess is
that I just mistook the NULL sensitivity check at the top of the loop
as getting triggered in this case, which isn't the case here.  Sorry
for the noise.

> > As an aside, I believe my other comments on this patch still stand.
> > It's a nice improvement but I think there are some other small things
> > that need to be addressed.
>
> Is there anything I need to fix apart from the overly verbose comment
> and the unnecessary curly braces?

Nope.  I wouldn't even bother with that brace/comment changes, those
were minor nits and only worth changing if you needed to respin the
patch for some other reason.

Consider the patch merged, thanks!

--
paul moore
www.paul-moore.com
