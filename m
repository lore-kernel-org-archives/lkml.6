Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFCC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D94217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Sx5ZIDMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D94217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHDCAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:00:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38470 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbeHDCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:00:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so6253070ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXTacpeLItCt4EQdJIag3OlxGsbbNMJp33QZs1eoaTo=;
        b=Sx5ZIDMyYbcZiGjW7x5OWq/BlEopT7OUUjtAlv8Sws7kIP8C4iVp847QStIhXQZWOb
         Qko5mUWPwi+XemeComveu2GPfCI/5NCkjRnl2NcepIn6crxJ44gOozfOk2YBBzFclGM9
         lFLgau87I+3Tda1gkHz7Fe/qNtWGx3kOtX2yChlSVjFv+cDk+SdetcVcarCNv3pwb6Xk
         5UbjgMGVi+AlEb7SPJXtAkv7CvUe7y5DdP2gU2FJaSPgr07pGyyUgZhXbJcp30YpItia
         7lcUPS2wjO/nyQFARhOSakrMSS/V3tq3e1QmTOYzF5rSH7xvbqR/chn2bFmO8/QNDE8Q
         Klmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXTacpeLItCt4EQdJIag3OlxGsbbNMJp33QZs1eoaTo=;
        b=giJXPli6hKrTLCRC4XjeAGJiHQ5FXdj8jrTYS0DAfkRTMZsvNzrtfie/QMUsvUB4Qi
         F+UIETFreqmrUJ6BxlUUnntHtUSSFFwF5FvYMFzikS8xVd3H48BVj7rSHrt6e1t1Wtgd
         ikqCG0aT3Bm/mAwFNPqV7fRIrP0SDOXoD3fM+Y5J4RCVsD8qVX0dofsZrmePJ22uALrn
         X2EILnTnZgZWhhEOGb8XnVqBn9ZeWhKyd5rHjezb099xN3TOMVAUBxlQIVRqCLriYnKa
         V+JBmxu1HYRmzXg40hAfNroppCryaMI8+ZI33bnHEy31XGeZOe3ZfJ1FD2qKBUlYK7wA
         qklw==
X-Gm-Message-State: AOUpUlEl08T2hDpT+SGi7HhxjdxqeDQesv1vTjd25dOSatQEBTOWCU93
        WVzxzlBYN7RBhLJqk4/9LVDvUinERr7bCfr67jQk
X-Google-Smtp-Source: AAOMgpfs5CoItNg8C9cS5W56aHVZsef3np2PsphvaZq16rzgLObh8IfMYYEXGJ6lZ3XcUg4r1TlGeXH8qa8+xwXoVFQ=
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr6487814ljt.8.1533340893941;
 Fri, 03 Aug 2018 17:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180803093604.38254-1-jannh@google.com>
In-Reply-To: <20180803093604.38254-1-jannh@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Aug 2018 20:01:22 -0400
Message-ID: <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
Subject: Re: [PATCH] selinux: stricter parsing in mls_context_to_sid()
To:     jannh@google.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 5:36 AM Jann Horn <jannh@google.com> wrote:
>
> mls_context_to_sid incorrectly accepted MLS context strings that are
> followed by a dash and trailing garbage.
>
> Before this change, the following command works:
>
> # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> none mount
>
> After this change, it fails with the following error message in dmesg:
>
> SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> failed for (dev tmpfs, type tmpfs) errno=-22
>
> This is not an important bug; but it is a small quirk that was useful for
> exploiting a vulnerability in fusermount.
>
> This patch does not change the behavior when the policy does not have MLS
> enabled.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/selinux/ss/mls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ooof.  mls_context_to_sid() isn't exactly the most elegant function is
it?  I suppose some of that is due to the label format, but it still
seems like we can do better.  However, before I jump into that let me
say that speaking strictly about your patch, yes, it does look correct
to me.

What I'm wonder is if we rework/reorder some of the parser to remove
some of the ordering specific (e.g. "l == 0") and reduce some
redundancy ... be patient with me for a moment ...

The while loops immediately following the "Extract low sensitivity"
and "Extract high sensitivity" comments are basically the same,
including NULL'ing the delimiter if necessary, the only difference is
the additional '-' delimiter in the low sensitivity search.

The only *legal* place for a '-' in the MLS portion of the label is to
separate the low/high portions.

What if we were to do a quick search for the low/high separator before
extracting the low sensitivity and stored low/high pointers for later
use?  e.g.

  rangep[0] = *scontext;
  rangep[1] = strchr(rangep[0], '-');
  if (rangep[1])
    rangep[1]++ = '\0';

... we could then move the "Extract X sensitivity" into the main for
loop as well remove all of the '-' special case parsing checks, e.g.

  for (l = 0; l < 2; l++) {

    scontextp = rangep[l];
    if (!scontextp)
      break;

    while (*p && *p != ':')
      p++;
    delim = *p;
    if (delim != '\0')
      *p++ = '\0';

    /* extract the level (use existing code) */

    /* extract the category set, if present (use existing code) */

    /* no need to worry about the '-' delimiter */

  }

I *believe* that should work.  I think.  Does that make sense?

Yes, I do understand that this likely isn't quite as performant as the
existing approach due to that initial strchr(), but I think the code
will be much cleaner and less fragile.  If we feel the need to claw
back some performance there are some other things in here would could
probably work on (e.g. imagine an ebitmap_set_range()).

> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 39475fb455bc..2c73d612d2ee 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
>                                         break;
>                         }
>                 }
> -               if (delim == '-') {
> +               if (delim == '-' && l == 0) {
>                         /* Extract high sensitivity. */
>                         scontextp = p;
>                         while (*p && *p != ':')
> --
> 2.18.0.597.ga71716f1ad-goog
>

--
paul moore
www.paul-moore.com
