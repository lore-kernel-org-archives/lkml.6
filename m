Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C411C25CD3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFc6s59E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C411C25CD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeFYPci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:32:38 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41133 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeFYPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:32:36 -0400
Received: by mail-ot0-f196.google.com with SMTP id d19-v6so15502549oti.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJVpcLSXYF/bIamm6FZDQjLx/H7vyNMd2Qxx7z/c55c=;
        b=QFc6s59E5zFti2hHj1j/Ig1VVZva2eHTEGJnsmLieKR+1NRPlc6NPFr+qeWjWCstMN
         oZ4rGa7Ygoxt9hAd/FXLxCV/27waZl85q8RlxjxyxEro6ONQbKFwW67s/jqpXGZVWnkZ
         wjwgWJHf1ooavDTHVc3am/pRp4VQw7huK8TAa3XU4ZODhb5sLyv+tK7soAb+yaZRKJjr
         Pq+b+sHREDJ4PBbMxVBWGYaZWKSfoSa3pYbwJ/UzLH1c17gEObl4FDZsHNJxjHuSfN8p
         mGBtX2YfVaFt8m7qYDRcOtfnYoQ44R3UMPCLu/cN2ijb8KkF4lf8jkhyn9HGQ3YZed99
         hzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJVpcLSXYF/bIamm6FZDQjLx/H7vyNMd2Qxx7z/c55c=;
        b=M5jkdY0paYqoi1YksF1MQTGeR42LPY+E4Dr57YoGCgpWTJXUa7S7t7/xEEQkB6yiID
         pcEC2MPxOjX71XNg/g0Ayyi3ZAWe+KOp75venYElA1It3vB0cf4qh8LEMjFvgsY9gcrE
         ASNOl1ljNfdGojUwDtIkp4LOGXQZx/viGJLk85DS1BfTHTz+/oHpQClM/XzG9BQAH28i
         UwkquV0VYX0J/xRdKzdx/LF4SdfFRhUwMRIuINxzW8jKFKb1YBDOMq04jH1xs/L3KplV
         cSOXq84jZDCTZ0H3l3Xm9h6Tq40RpC9QeizHJLDXlVpcUl5AblNy4UaBZc3EVXy50cxZ
         foGg==
X-Gm-Message-State: APt69E0Wox+2zrLcioURfUKmJjDHkzChfEj0yUI57q8GC1HQwObYkG3z
        Y1GSNTN1z9X4JJyBWQv+xCK01v34+E+0snuoXXPAZtLq
X-Google-Smtp-Source: AAOMgpf1uVxlPj4dPKnwKiYCZVlnIDL7elaQZ+rHgucffpfG4PHG7P7YAka8enoia1n2sZgzmdE2oEwgaiVs60afj+k=
X-Received: by 2002:a9d:52a8:: with SMTP id f40-v6mr7375584oth.0.1529940755856;
 Mon, 25 Jun 2018 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
 <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
In-Reply-To: <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Jun 2018 17:32:24 +0200
Message-ID: <CAG48ez3ZD3+j2oBJ7XHW9ycbi9_H8QsKGg8A84tOTisjeZGgiw@mail.gmail.com>
Subject: Re: checkpatch false positive (IMO): typo detected in truncated
 commit message
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:23 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-06-25 at 17:22 +0200, Jann Horn wrote:
> > Hello!
> >
> > I got the following message from checkpatch:
> >
> > =======
> > $ scripts/checkpatch.pl
> > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch
> > WARNING: 'calle' may be misspelled - perhaps 'called'?
> > #15:
> > Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
> >
> > total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch has
> > style problems, please review.
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > =======
> >
> > I believe that it is appropriate here to truncate the commit message
> > of the fixed commit.
>
> It's not.

Looking at a bunch of other recent commits, I'm guessing that the
accepted format is to use the complete commit message, without
linebreaks, even if it goes over 75 columns?
