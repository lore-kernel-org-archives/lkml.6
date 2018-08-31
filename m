Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BFF2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYWJG/K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BFF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeHaTzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:55:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46004 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeHaTzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:55:06 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so22405258oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMYAtSjmJSSZCIscgWpdE9VXJTFtliGnv4BV5VEPwZM=;
        b=RYWJG/K55uduEX7gOOvy4yFrBdff1y1ydNUFb2GqZHu+79KhsS90gAZ6Qz/1jn6Mlg
         5n/5dcIQyGM3OuOa2crVNyrJJCMbLvTwI/Y8UkEgKiKIrwwYH+F/68NMOpj1OyUKzm9R
         0gECxa8Rs4VHr3DTmKf4vRpYNRrygZ8M5KkO8u4E/wwdKjwME4lV+EetXnan1BZBxQa2
         beljzkqI+NLREdM8FhLVpRf/geDED3sV1/JgXjb5oe8miN0DBLykr5orL2+XnvveXW7S
         RTFxxznXGAqtwIFK978/Dn6LYwQ2Jc+biiBMjE+DdVbuNGm1ouhK+ngBpgCYf012YW6Y
         e1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMYAtSjmJSSZCIscgWpdE9VXJTFtliGnv4BV5VEPwZM=;
        b=UIvplSUI6NPJlB/NyG96rhiwSbZnbN0tPyDa8vS8wf1xOlzWqahyNzocMcgrxfz4Xm
         0RvEvRruO8yfHTK0XiI0mBGP+ol7hyj+21B68k9au3B7VfnFYBu9HABnwqg/69j6C7Zq
         /lAdzI6mUBaK8uizR9NdB3hj/4MwUMqnvcIbfjROeGFNp+96pU8NnlQAVgD8NNnzmPwS
         HLOScTUKK9DmtqQ9z9Mn18pzPY9OYE+pzv6lUCnZdJ6OmPcDW45yLUAO4h9Ep/KVu45z
         HjQ4wiOlPM1843ebNs3HKkV2kLzVLuJylYOwZhXJ08y9ym+rkHdnMYyuQDA00s+nL3wL
         84CA==
X-Gm-Message-State: APzg51AfMMmVuwEF42R2lB9kRAAAiW6G4ZYxH2Z0bKFfZcu4RlCekmQH
        W7eYAKZxS0636v8G2ZITm0gPSBTrk6/YLGXPR1IwAw==
X-Google-Smtp-Source: ANB0VdYIlK0bzEubYG3YJpd6IAvVPIZTdcQ/md2pk7rLrxuhcEcZuptmf0hDheETb6Vr3n9QdqcAIrMxxkt1dndWurY=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr8124839oif.348.1535730419531;
 Fri, 31 Aug 2018 08:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com> <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 Aug 2018 17:46:33 +0200
Message-ID: <CAG48ez1VMp=NXWb2eSEZsnszs-g5NVUhCVLXrjnMcHZYBJus8w@mail.gmail.com>
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make it stricter
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

On Thu, Aug 9, 2018 at 3:56 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:
> >
> > The intended behavior change for this patch is to reject any MLS strings
> > that contain (trailing) garbage if p->mls_enabled is true.
> >
> > As suggested by Paul Moore, change mls_context_to_sid() so that the two
> > parts of the range are extracted before the rest of the parsing. Because
> > now we don't have to scan for two different separators simultaneously
> > everywhere, we can actually switch to strchr() everywhere instead of the
> > open-coded loops that scan for two separators at once.
> >
> > mls_context_to_sid() used to signal how much of the input string was parsed
> > by updating `*scontext`. However, there is actually no case in which
> > mls_context_to_sid() only parses a subset of the input and still returns
> > a success (other than the buggy case with a second '-' in which it
> > incorrectly claims to have consumed the entire string). Turn `scontext`
> > into a simple pointer argument and stop redundantly checking whether the
> > entire input was consumed in string_to_context_struct(). This also lets us
> > remove the `scontext_len` argument from `string_to_context_struct()`.
[...]
> > -       /* Extract low sensitivity. */
> > -       scontextp = p = *scontext;
> > -       while (*p && *p != ':' && *p != '-')
> > -               p++;
> > -
> > -       delim = *p;
> > -       if (delim != '\0')
> > -               *p++ = '\0';
> > +       /*
> > +        * If we're dealing with a range, figure out where the two parts
> > +        * of the range begin.
> > +        */
> > +       rangep[0] = scontext;
> > +       rangep[1] = strchr(scontext, '-');
> > +       if (rangep[1]) {
> > +               rangep[1][0] = '\0';
> > +               rangep[1]++;
> > +       }
> >
> > +       /* For each part of the range: */
> >         for (l = 0; l < 2; l++) {
> > -               levdatum = hashtab_search(pol->p_levels.table, scontextp);
> > -               if (!levdatum) {
> > -                       rc = -EINVAL;
> > -                       goto out;
> > -               }
> > +               /* Split sensitivity and category set. */
> > +               sensitivity = rangep[l];
> > +               if (sensitivity == NULL)
> > +                       break;
> > +               next_cat = strchr(sensitivity, ':');
> > +               if (next_cat)
> > +                       *(next_cat++) = '\0';
> >
> > +               /* Parse sensitivity. */
> > +               levdatum = hashtab_search(pol->p_levels.table, sensitivity);
> > +               if (!levdatum)
> > +                       return -EINVAL;
> >                 context->range.level[l].sens = levdatum->level->sens;
> >
> > -               if (delim == ':') {
> > -                       /* Extract category set. */
> > -                       while (1) {
> > -                               scontextp = p;
> > -                               while (*p && *p != ',' && *p != '-')
> > -                                       p++;
> > -                               delim = *p;
> > -                               if (delim != '\0')
> > -                                       *p++ = '\0';
> > -
> > -                               /* Separate into range if exists */
> > -                               rngptr = strchr(scontextp, '.');
> > -                               if (rngptr != NULL) {
> > -                                       /* Remove '.' */
> > -                                       *rngptr++ = '\0';
> > -                               }
> > +               /* Extract category set. */
> > +               while (next_cat != NULL) {
> > +                       cur_cat = next_cat;
> > +                       next_cat = strchr(next_cat, ',');
> > +                       if (next_cat != NULL)
> > +                               *(next_cat++) = '\0';
> > +
> > +                       /* Separate into range if exists */
> > +                       rngptr = strchr(cur_cat, '.');
> > +                       if (rngptr != NULL) {
> > +                               /* Remove '.' */
>
> On the chance you need to respin this patch, you can probably get rid
> of the above comment and the if-body braces; we don't have "Remove X"
> comments in other similar places in this function.

I'll amend that.

> > +                               *rngptr++ = '\0';
> > +                       }
> >
> > -                               catdatum = hashtab_search(pol->p_cats.table,
> > -                                                         scontextp);
> > -                               if (!catdatum) {
> > -                                       rc = -EINVAL;
> > -                                       goto out;
> > -                               }
> > +                       catdatum = hashtab_search(pol->p_cats.table, cur_cat);
> > +                       if (!catdatum)
> > +                               return -EINVAL;
> >
> > -                               rc = ebitmap_set_bit(&context->range.level[l].cat,
> > -                                                    catdatum->value - 1, 1);
> > -                               if (rc)
> > -                                       goto out;
> > -
> > -                               /* If range, set all categories in range */
> > -                               if (rngptr) {
> > -                                       int i;
> > -
> > -                                       rngdatum = hashtab_search(pol->p_cats.table, rngptr);
> > -                                       if (!rngdatum) {
> > -                                               rc = -EINVAL;
> > -                                               goto out;
> > -                                       }
> > -
> > -                                       if (catdatum->value >= rngdatum->value) {
> > -                                               rc = -EINVAL;
> > -                                               goto out;
> > -                                       }
> > -
> > -                                       for (i = catdatum->value; i < rngdatum->value; i++) {
> > -                                               rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
> > -                                               if (rc)
> > -                                                       goto out;
> > -                                       }
> > -                               }
> > +                       rc = ebitmap_set_bit(&context->range.level[l].cat,
> > +                                            catdatum->value - 1, 1);
> > +                       if (rc)
> > +                               return rc;
> > +
> > +                       /* If range, set all categories in range */
> > +                       if (rngptr == NULL)
> > +                               continue;
> > +
> > +                       rngdatum = hashtab_search(pol->p_cats.table, rngptr);
> > +                       if (!rngdatum)
> > +                               return -EINVAL;
> > +
> > +                       if (catdatum->value >= rngdatum->value)
> > +                               return -EINVAL;
> >
> > -                               if (delim != ',')
> > -                                       break;
> > +                       for (i = catdatum->value; i < rngdatum->value; i++) {
> > +                               rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
> > +                               if (rc)
> > +                                       return rc;
> >                         }
> >                 }
> > -               if (delim == '-') {
> > -                       /* Extract high sensitivity. */
> > -                       scontextp = p;
> > -                       while (*p && *p != ':')
> > -                               p++;
> > -
> > -                       delim = *p;
> > -                       if (delim != '\0')
> > -                               *p++ = '\0';
> > -               } else
> > -                       break;
> >         }
> >
> > -       if (l == 0) {
> > +       /* If we didn't see a '-', the range start is also the range end. */
> > +       if (rangep[1] == NULL) {
> >                 context->range.level[1].sens = context->range.level[0].sens;
> >                 rc = ebitmap_cpy(&context->range.level[1].cat,
> >                                  &context->range.level[0].cat);
> >                 if (rc)
> > -                       goto out;
> > +                       return rc;
> >         }
> > -       *scontext = ++p;
> > -       rc = 0;
> > -out:
> > -       return rc;
> > +
> > +       return 0;
>
> In the case where we have a MLS policy loaded (pol->mls_enabled != 0)
> and scontext is empty (scontext[0] = '\0'), we could end up returning
> 0 couldn't we?  It seems like we might want a quick check for this
> before we parse the low/high portions of the field into the rangep
> array.

I don't think so. In the first loop iteration, `sensitivity` will be
an empty string, and so the hashtab_search() should return NULL,
leading to -EINVAL. Am I missing something?

> As an aside, I believe my other comments on this patch still stand.
> It's a nice improvement but I think there are some other small things
> that need to be addressed.

Is there anything I need to fix apart from the overly verbose comment
and the unnecessary curly braces?
