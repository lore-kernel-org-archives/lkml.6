Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A46C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498632172F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omHVZcml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498632172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeJUGtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:49:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37506 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJUGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:49:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so29453545oib.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JU3Bj7Pzs8JIFKB9PR80uo7Qvdd/RaoMHnkGfSVh1eI=;
        b=omHVZcmlQcCkriobQv3WnUslKsQZrPWMcLYWJcCNLxmUtoFR2bQD5gSM9szL6Wsi97
         ZCESMnQA7lNEywA72WtND9rWPzh0sojcCkHenxm1LEesP7GduQiNkCPeDL9QN5M+AsJo
         265FTE8ZsM+Lpev+PHiEESvbjdkdCtVVJY65YedVLNpotMPi7x4GLm+92AtzXdndSgrs
         3VWvXBBmR0jSHgLgD4B1srHq4FdIL5Z2wPTVB5IIo9j/BH6lCqZ0A9MU/sEZkvbGiAVO
         VtlMEPocHdGFf2lV0/w713gt6rfw6ywjQVU6bw+BNLe7ON/LfyMi7yWAqKSpi2QNGehj
         fa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JU3Bj7Pzs8JIFKB9PR80uo7Qvdd/RaoMHnkGfSVh1eI=;
        b=JCoAxD/PUvj6bh13wTTrShMuRyfPY34yQSSuB6hT/2XInl804VtmMQEY7gJJX61Zfe
         AEvsJBNTh4t/DSUwqeu+WA6yzdaDqah/du5Dr8u5iRdbKdzxG7MEttsbiHmHow6Rmw9Z
         sanpgdX3qmJH4KbeY1nZ3648s/CMbeFK5LxuFxvqB7D/yGqilyzyLPsr+HnSznqsaKg7
         vFBWl79SWZ261Ql2RGKy2rtJA+B7S5VFCfZmanpxtL8U2kqTyziRhMVYbQPpJ0bgdZYR
         GIuByst3hbjbDBm30enSoVcx62yH5a/Ce8BKlJpjZdDPlF7D6Wh0tvL1eI5rawLOrjaT
         XPGQ==
X-Gm-Message-State: ABuFfojnwCFeUs4WwG69Yfm1Onl996R9L4Saiid89tZRAy4gQ16IVgKh
        BrP25HXIYXho9ikiYsOhnNgS+2f54+Tr0NxkN1e6CdVx
X-Google-Smtp-Source: ACcGV62riWoSUfWXYT+0hq9NSDjMSYbdqYToMK6tHlYyay2b1M/599xOuiH9R6ie3kdTa0NbgfhFuIrIClNdxP/rnc0=
X-Received: by 2002:aca:4e09:: with SMTP id c9-v6mr20383387oib.254.1540075048418;
 Sat, 20 Oct 2018 15:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <1539701820.2805.6.camel@HansenPartnership.com> <1539701896.2805.7.camel@HansenPartnership.com>
In-Reply-To: <1539701896.2805.7.camel@HansenPartnership.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Sat, 20 Oct 2018 18:11:16 +0000
Message-ID: <CAMkWEXPSSXG_f1v-BYEXwkwoniJ8wndo49z01BSh-QaLcD3ChQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] code-of-conduct: Fix the ambiguity about
 collecting email addresses
To:     James.Bottomley@hansenpartnership.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James, and our other friends,


On Tue, Oct 16, 2018 at 2:59 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The current code of conduct has an ambiguity

More than one ambiguity. This whole file needs to go.

>* Trolling,

Who decides what is trolling, and what is a technique for raising
awareness or sparking discussion on an issue?

>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting


Why should this last bit remain?  Any literate person with access to a
dictionary should know how ambiguous the word professional is.  As an
amateur contributor to the FOSS ecosystem I am more than a bit
offended by the decision to use such divisive, politically charged,
and financially discriminatory language in a project of such massive
technical importance.  This entire file should be expunged from the
repository and replaced by well defined minimalistic guidelines for
maintaining order on the mailing lists, rather than a set of ambiguous
codes that force maintainers to take politically motivated actions
against contributors for undefined reasons.

Using words like professional is a distressing red flag because it
doesn't add any clarification on the issue (what was the issue
again?), it only raises more questions.  I can't think of any reason
that word would be needed unless you're trying to push out unpaid
contributors.  Why should someones employment status be held against
them when contributing ideas or code to a technical project that has
benefited greatly from amateur contributions?

I fear for the kernels future now that irrational politics are
beginning to creep.
