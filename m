Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D8820824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khHj0URO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D8820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJXRsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:48:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38930 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeJXRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:48:01 -0400
Received: by mail-yb1-f194.google.com with SMTP id j9-v6so1820495ybj.6;
        Wed, 24 Oct 2018 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skgAQdNTud5R8BgsUDGBxk9yiVRnz0ET6ePAbiX8/vY=;
        b=khHj0URO3fX+GZa4Ucd4ZUJJCYbinGjTTtXqmTkfHfZl1UpGU1LcxpS0rJlHF+sZsL
         O0plda2wvzK6XOOWz1UtR4WaBzXuvKlLGjL5vcc6rQupCo6CHF/Bb2J/KpX8RjFT63KR
         J1J4g45w6ljWjMtvACfJX1X2ra8vSFq++rjvp6mEc1pgtiFAyL8nssXfFoYrxk5nRkN5
         WWY+dDTdYzE5q+bf3PuQMIi+LwiN1Rd//GrNqzeghDyT07wR5DvWTNdYF1F/jXBYfx8S
         Hc3ZvE9JZML7yrezZkJXxSPTHPwBTcDeSN2NFIFNkUfgZJASwViCnNgcWTefN74gbqsB
         m44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skgAQdNTud5R8BgsUDGBxk9yiVRnz0ET6ePAbiX8/vY=;
        b=bM8v9FaPLFRpNZfdn6iD01Olzbu67RD2egOohxcDTog265FWMrisLTXst5C6Sj6/Cr
         j+PPY0Rxl9jsQupc4FW7oCgrN3Z10nWfyGkZf0giJyBvw0yYzSMpwsMW1EKLmaQHM6un
         ByZmx74a5nteoEszQIUklRmlC/C7sam/+4KJqf9Rk24+axhoHubPUlxFpOwjjGGHeEAy
         fY5KkzK8zp+sedaW3FowMUj9abF2mI3O3j/ksOeDizfoLdgiJKTAPiU3g+TH0kUUZX4G
         ntWQgIypbwWZbTIWRA8mMMZNftVU/FUEQhNaxeaLSdNOCW2N5hTpgPgvvGz4p8CixHqQ
         ffzg==
X-Gm-Message-State: AGRZ1gIvssnOG+cKKyP03/6y1ckxDEExjf/PhC5BL0ityiNXS78AQZgq
        MttGjNL4xSev4Mtmwn5oYUUcKakg4kQv7H2gZrI=
X-Google-Smtp-Source: AJdET5cfk8U6QPBkCcn9VAiPIgl7oXT/TIJIaEx0bAWwBt8Ik1+iPsnAONppJuIu9glBDEErIZvzitLm8cSXBLHFMJg=
X-Received: by 2002:a25:3a82:: with SMTP id h124-v6mr1398545yba.32.1540372841872;
 Wed, 24 Oct 2018 02:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201953.GA15687@pathfinder> <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
 <20181024082134.GA14565@pathfinder>
In-Reply-To: <20181024082134.GA14565@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 12:20:14 +0300
Message-ID: <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:21 AM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> On Wed, Oct 24, 2018 at 09:16:20AM +0300, Amir Goldstein wrote:
> > On Tue, Oct 23, 2018 at 11:19 PM Phillip Potter <phil@philpotter.co.uk> wrote:
> > >
> > > Many file systems use a copy&paste implementation
> > > of dirent to on-disk file type conversions.
> > >
> > > Create a common implementation to be used by file systems
> > > with some useful conversion helpers to reduce open coded
> > > file type conversions in file system code.
> > >
> > > Original patch written by Amir Goldstein.
> >
> > Looks good.
> > I guess you used 'git apply' or just 'patch'
> > What you usually do when applying someone else mostly unchanged
> > patches is use 'git am -s -3' so you preserve the original author and
> > original commit message including the Signed-of-by line.
> > You can edit your patch by hand to change the From: line to change the
> > author and add
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > (you sign below me as you changed the patch last)
> >
>
> Dear Amir,
>
> Yes, I applied each patch manually to my tree, fixed it up where needed,
> then after rebuilding and testing each one I committed it and regenerated
> each patch. Thank you very much for your advice, I will take it into
> account and make the necessary changes. In the meantime, do I add other
> tags in the order they are received also (such as Reviewed-by:) and am
> I safe to add these in when I re-send the patches with the changes you
> and others have suggested (or would that offend people that have
> offered the tags)?
>

Reviewed-by before of after Signed-off-by.
I prefer Signed-off-by last which conceptually covers the entire patch,
the commit message including all the review tags that you may have added.

Some developers add Reviewed-by after Signed-off-by signifying the
order that things happened, so choose your own preference.

As a reviewer, and I speak only for myself, if I offered my Reviewed-by
I expect it to be removed if a future revision of the patch has changed
so I have an indication of patches that I need to re-review.
But if the patch changed very lightly, like small edits to commit message
and code nits in general, that would not invalidate my review.
When in doubt, you can always explicitly ask the reviewer.

Thanks,
Amir.
