Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86017C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC420818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl2Yy2Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeKJICO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:02:14 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38922 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:02:14 -0500
Received: by mail-oi1-f171.google.com with SMTP id 192-v6so2790758oii.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDssAm08drwAQQmtJk4raC9wkFC8D3O9DMhoEM9dSek=;
        b=Fl2Yy2NwJ9q3wJmWBR4fu/dDi0dfEhfpIfuKRV8CNn4ESg2Zu4AVukOO05+CZHAejF
         pUh48PCgm62rZQfCXeihpUeaL16i3On2uXMS9JHJPtP3qD5sPIEmaoR7Jt8kPDiWgZQg
         zXRfU7L/UQeFadvmTEhzuFStPyLYHZIFvF8M3MJR59bCOLtc9yL/TsbFjQtkZ9vmU7CF
         aDGV8+BPJVfq/Jo1qAU+754lOFSBy2WU9NoXJEWnCP/yqyqwsvZiAnVClG+gbea+tb7Q
         k/mO3esrkInhylZHsKB+4sWolAo2xCiNHkbW5HK/odGsYRdLVBjX//mnpNh+93f35LQx
         AUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDssAm08drwAQQmtJk4raC9wkFC8D3O9DMhoEM9dSek=;
        b=Es+bZHvx87SlXP9NM9LbG80ScnzjZBHf8tJ30RQ1de1Lmod+96gnzarCwWmXjT5JYh
         jsanLmp5c9R+PGEftWOUGwT4t7xNHegAUxp1g161BZPyNjisfRtlXCNSbl8J6bLdq0+Z
         Y5dLDfePRrAUWHLtEKirS8ekqg2mTEyJNm/HmemXtdqBtiBYVKg6W51o7OCwXskGPOSb
         405b/H/VA27jUKpkO1ELjXZAv2UkROA8NmvEaxsze1sACEfqhW5R3C9P2JhhEeogiynL
         HpTSvW3jwgs986BNkdY6JcWien+Kh75ftRxXqdh+ywRK2mGxqYiuc+6mV2O3vUKatqm9
         qNDQ==
X-Gm-Message-State: AGRZ1gKd6KW0Koy6mzFYIo4ddLe3r4U9HA+y3W53s7G8tV0tnpZ0lrG0
        7SGEdKX8/SXGyZeQMRZdYwudRimL5fOgYSQjD9S6KEZN1Zw=
X-Google-Smtp-Source: AJdET5coQj9YxeoS0ZDvkAStIxm7EqCXt+VTkwgzw4H8g49XrXSKDovwiJhp15l+z8iTKidkAGb6QZII0UUjDmCIfFI=
X-Received: by 2002:aca:3389:: with SMTP id z131-v6mr6264247oiz.86.1541801979585;
 Fri, 09 Nov 2018 14:19:39 -0800 (PST)
MIME-Version: 1.0
References: <d5a534442b1a80c84e7cb1808e5abfc4@redchan.it>
In-Reply-To: <d5a534442b1a80c84e7cb1808e5abfc4@redchan.it>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Fri, 9 Nov 2018 17:52:59 +0000
Message-ID: <CAMkWEXMVpi+fS79QpHrCNmL-APRBBr+4YJiwqjNufiVBxuhe1g@mail.gmail.com>
Subject: Re: On holy wars, and a plea for peace
To:     missingterms@redchan.it
Cc:     LKML <linux-kernel@vger.kernel.org>, esr@thyrsus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You hijacked Eric's thread and forgot to CC him?

On Thu, Oct 11, 2018 at 12:49 AM <missingterms@redchan.it> wrote:
>
> Three avenues to rescind GPLv2 property. RAP strategy added.
>
>
> Here's a case in NY where a Software distributor agreement violated New
> York's Rule Against Perpetuities
> McAllister Software Systems, Inc. v. Henry Schein, Inc., No. 06-0093,
> 2008 WL 922328 (E.D. Mo. April 2, 2008)
>
> So we see that atleast one court in an important* jurisdiction is
> applying the RAP with regards to intellectual property.
>


This is not a good case to cite IMO, but an interesting topic for anyone
writing software for or in New York. If you read the court memorandum and
order, it was about nullifying an exclusive distributor agreement. Note
that the "EDA" contract in question suspended McAlister's distribution
rights of that software as well as all other veterinary software
developed for an indefinite time period (this is the suspension of the
absolute power of alienation bit). I don't think it would help your cause
much because GPLv2 does not suspend any distribution rights.

Though I'm no expert on the intricacies of intellectual property law
and contracts in New York state, so maybe there is a small percentage
chance that this case is relevant. I still think peoples time would be
better spent rescinding the COC file rather than trying to grasp at weird
legal specifics for a given state in an attempt to rescind functional pieces
of code we all use every day.

In absence of the ability to rescind any governance related files from the
Linux kernel repository, The maintainer of that particular file should not
be allowed to propose new patches to it. There should be a strong rule
enacted which prevents the maintainer of the file from being elected to the
TAB committee (empowered by the file) who gets to define "professional",
whatever tf that means. There is an obvious conflict of interest here that
I have not seen mentioned yet. Otherwise, I'm afraid we are witnessing the
installment of a "universal back door". A behavioral one that currently
contains politically charged as well as laughably contradictory language
regarding financial status and being professional. As well as assuming
all professionals engage routinely in good polite conduct, this could not
be farther from reality.


I suppose Torvalds could change it or oppose changes himself, but he has been
eerily silent on the whole topic so I won't bother even CCing him, let's forget
about his O.G. celebrity status for the sake of the following argument.
What happens when he retires and the TAB committee + COC maintainer decide to
start patching in new more poorly worded language and add new
"governance" related
files, or create more pointless advisory boards. What happens if there
is no sane
leader to oppose the madness and all we have are these goofy poorly
worded documents
to govern arguably the most influential free and transparent software
project other
than GCC?


On Sun, Sep 23, 2018 at 9:04 PM Eric S. Raymond <esr@thyrsus.com> wrote:
>
> ...
>
> If the normativeness level is set high, many effects are less visible;
> contributors who chafe under restriction will defect (usually quietly)
> and potential contributors will be deterred from joining.
>
> If the normativeness slider starts low and is pushed high, the
> consequences are much more visible; you can get internal revolt
> against the change from people who consider the ethos to no longer
> serve their interests.  This is especially likely if, bundled with a
> change in rules of procedure, there seems to be an attempt to change
> the telos of the group.

ACK'd, I'm about 50/50 right now. Not seeing the appeal anymore in contributing
to a project run by programmers now literally getting their salaries paid by the
MAIN COMPETITION IN THEIR INDUSTRY AND NOW INSTALLING ILLOGICAL
GOVERNANCE FILES.
I thought it was funny at first because I figured you all would do the
right thing
and clean up the hilariously poor wording of the file, but that does
not appear to
be what fb, sony, etc, want for us.

To LKML at large: Amateur contributions to the Linux kernel have
assisted in making some of
you millionaires, and this is how you repay them?
