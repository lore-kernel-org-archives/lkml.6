Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14476C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AA6219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVnpZ7dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AA6219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeHFV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:58:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42155 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732621AbeHFV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:58:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id b16-v6so10976896oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WT33tMwYFx4M2Cq4BSN4d/pedjfOBD+SB4mSVpBEe8g=;
        b=DVnpZ7dlwH5zPT1UNBngQOSPcNBESVx4a5Lifymx9tgqadDYJfUGrG7pXxYnXsh/sT
         SPZ2BvwoUUilXPXse+cUbNsDTGsr+0l64X+Xznax9VgN4KyGNlBYHRotZElrC4xJT1mM
         RjxyaGzhXOHVmn1ksbbelV5bAO/XpIcSTE+ihlNzTKoaACALDM2HR1Hh9freAd7QbHv2
         hwA3WzSmWr+pdKg38X32Rn4iytj90csC11mNR+MdLyn7RdEkFNGVthri2mSNZJUpvYr1
         WuJhqNYhxrSjAL73lBkXcitEIFGhW1aGEc6MYTPUkm38LIIOO1S3vwlDvYo5VuwdoaQC
         FrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT33tMwYFx4M2Cq4BSN4d/pedjfOBD+SB4mSVpBEe8g=;
        b=outwhkGDRff906SYKyGq2OOaemR34Y/vgS/su6Ya3rHmHwyg7AR1rUgUbIh8XgjzG6
         bMgf+z9RqxnKpLRpTaKER3vFtiwZVXWiR51HipR0Iq65nQeXzOOe5OY1bhcec0fXBS8s
         UaSLZ6do/sFlVoAdkNHsAWS8ayc83KBO0x6B4NJNgHk+Z0U/dJOmafHK/6mAtJoMTp+u
         wqBkijQyEiumEmIV+N+p4SWrlHeXcPhBozu13sLCffMIDzOf35TFre43uvN0XjU7G/TY
         KqH0Dbe1bru9nFKsh4I03qP3SZK5kZC8qLXG/WqNjUQnAqCb5Ye95UBja10xy9SeZq98
         g75Q==
X-Gm-Message-State: AOUpUlESd+g7BkcxvbwQb08dTx7b92RdhZiOxXwqBVLlrtrjTWaFPJNw
        3r6Ct16BhZXUjWTFl2bWYtRmhwmQtnkNg4qXD4caESXz
X-Google-Smtp-Source: AAOMgpeYWh+PJ5XVDb5ua7LI3PTgdCtkh3SpNAfdwqEYu0R/L29SXWGgPy/5JyEVIfR52CcOgWgUAS7r/9LwyP5FuCw=
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr17098334oib.323.1533584848490;
 Mon, 06 Aug 2018 12:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180803093604.38254-1-jannh@google.com> <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
In-Reply-To: <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Aug 2018 21:47:02 +0200
Message-ID: <CAG48ez0UPrDQ1t=3gWB3ahj3ksc1_FAC0T6-y2ngi6tLTpUUxg@mail.gmail.com>
Subject: Re: [PATCH] selinux: stricter parsing in mls_context_to_sid()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 2:01 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Aug 3, 2018 at 5:36 AM Jann Horn <jannh@google.com> wrote:
> >
> > mls_context_to_sid incorrectly accepted MLS context strings that are
> > followed by a dash and trailing garbage.
> >
> > Before this change, the following command works:
> >
> > # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> > none mount
> >
> > After this change, it fails with the following error message in dmesg:
> >
> > SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> > failed for (dev tmpfs, type tmpfs) errno=-22
> >
> > This is not an important bug; but it is a small quirk that was useful for
> > exploiting a vulnerability in fusermount.
> >
> > This patch does not change the behavior when the policy does not have MLS
> > enabled.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  security/selinux/ss/mls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ooof.  mls_context_to_sid() isn't exactly the most elegant function is
> it?  I suppose some of that is due to the label format, but it still
> seems like we can do better.  However, before I jump into that let me
> say that speaking strictly about your patch, yes, it does look correct
> to me.
>
> What I'm wonder is if we rework/reorder some of the parser to remove
> some of the ordering specific (e.g. "l == 0") and reduce some
> redundancy ... be patient with me for a moment ...
>
> The while loops immediately following the "Extract low sensitivity"
> and "Extract high sensitivity" comments are basically the same,
> including NULL'ing the delimiter if necessary, the only difference is
> the additional '-' delimiter in the low sensitivity search.
>
> The only *legal* place for a '-' in the MLS portion of the label is to
> separate the low/high portions.
>
> What if we were to do a quick search for the low/high separator before
> extracting the low sensitivity and stored low/high pointers for later
> use?  e.g.
>
>   rangep[0] = *scontext;
>   rangep[1] = strchr(rangep[0], '-');
>   if (rangep[1])
>     rangep[1]++ = '\0';
>
> ... we could then move the "Extract X sensitivity" into the main for
> loop as well remove all of the '-' special case parsing checks, e.g.
>
>   for (l = 0; l < 2; l++) {
>
>     scontextp = rangep[l];
>     if (!scontextp)
>       break;
>
>     while (*p && *p != ':')
>       p++;
>     delim = *p;
>     if (delim != '\0')
>       *p++ = '\0';
>
>     /* extract the level (use existing code) */
>
>     /* extract the category set, if present (use existing code) */
>
>     /* no need to worry about the '-' delimiter */
>
>   }
>
> I *believe* that should work.  I think.  Does that make sense?

I'm fiddling with the code a bit now - your suggestion sounds good to
me, and I think there are a couple other small tweaks that can make
the code more readable. I hope I'll have a patch ready soon.
