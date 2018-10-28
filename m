Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17066C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09E32082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VTtRwMz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09E32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJ2HjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:39:22 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:53058 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2HjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:39:22 -0400
Received: by mail-it1-f178.google.com with SMTP id r5-v6so5402158ith.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 15:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r37inC5qCJjuX3ZK1ggDKstZdXL9Ux5p8XYNwMEUViw=;
        b=VTtRwMz4Gqtlh2XhPlMm+SItEavcOWjihCFY4fytwoJBmy6VElJ5h+pqMxVuMQqzRX
         GVyzhOTYtjeKboyj/nx5RV1PFJs/w53MPHOGaORZIuKyQ+lQzeKZZEmlPN2QCuh59sjK
         /1G0g+UP+YHFE1MGYFwJUD8Ky8uDk+l2bMnUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r37inC5qCJjuX3ZK1ggDKstZdXL9Ux5p8XYNwMEUViw=;
        b=q2YKnoVlWe+JgejAuRVmqGmPLXuQsmbSY8MYDmaRINqEpCApvYsXMSPQCLf4dssgSm
         FnFrCEe+Xv1oxZOuqku8kicdTBrJLYTaqWyEyou4OlZa5POuqqCLWCQF8Udp5aYbM8q4
         maYWW+UjjYIx1KHaGxiudhAPIKCk1vfpTJeyiDjiPsjmMACBN0wSlCzxJS2WPBDOSDKE
         o66N3ip5UtMlQDhQHheCSXkfHu0GSOtbnUsPyDtvxLnSynsMT2FZZvQnnXoWACO4HT6x
         39GEO90lI17PTeac5dpdEaByGzU+rd4mdYEBReMnIa47CZ8HXx+l+hCKuu9Q0NLyfZfA
         pNUA==
X-Gm-Message-State: AGRZ1gKpYZcK0F6zD28UJ+KkSFo0dOPe/aThWnFKpiHlYDvIsssSDzdR
        jkxj0UQe2gUxntpGRBnUqtpHAX3XJT7+DSakj68QQA==
X-Google-Smtp-Source: AJdET5dYGMyxc/XnBQ0a/XHARCR4D4UwzAbgsc7Uif4o1UDbdbi+/Dhgoo0LmZUGGrpr5tkgWdE0TGGGcagzVwRGyuU=
X-Received: by 2002:a24:ac02:: with SMTP id s2-v6mr8307357ite.105.1540767198038;
 Sun, 28 Oct 2018 15:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181028220927.56227-1-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 15:53:07 -0700
Message-ID: <CAADWXX89jMiTp-Nz887tv+6YwWkrWF8qYfpuTkmk2OE3_SqeGA@mail.gmail.com>
Subject: Re: w1: coding style and checkpatch fixes
To:     post@steffenvogel.de
Cc:     lkml <linux-kernel@vger.kernel.org>, zbr@ioremap.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is not about your patch series per se, only about your email settings ]

On Sun, Oct 28, 2018 at 3:20 PM Steffen Vogel <post@steffenvogel.de> wrote:
>
> This is my first series of patches for the Linux kernel.
> I started by familiarizing myself with coding style and
> satisfying my inner OCD by cleaning the 1-wire subsystem.

Sadly, your DKIM setup is wrong, causing all the emails to be marked
as spam when they go through a mailing list.

Your DKIM header looks like this:

  DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
          s=2017; t=1540764601;
h=from:from:sender:reply-to:subject:subject:date:date:
          message-id:message-id:to:to:cc:cc:mime-version:mime-version:
          content-type:content-transfer-encoding:content-transfer-encoding:
          in-reply-to:in-reply-to:references:references;

and the problem with that is the "sender" field in there.

A good mailing list will not change the contents of your email, or
most of the other headers, but it *will* set the sender field to the
mailing list.

End result: the DKIM signature is guaranteed to fail after the email
has gone through a mailing list.

In other words, putting the sender field as part of the DKIM-checked
headers is just wrong. It's a somewhat common mistake, but it's still
wrong. I wonder where people get their setups from, because I think
there is some DKIM guide on the internet that is actively spreading
this bad behavior.

You do have a few other oddities in there (the duplication of the
common fields), but they shouldn't matter.

                 Linus
