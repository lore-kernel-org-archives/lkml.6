Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66048C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8EC218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmaZ0O1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeLZQ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:57:01 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:51589 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeLZQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:57:00 -0500
Received: by mail-it1-f178.google.com with SMTP id w18so21569820ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=LmaZ0O1BCeWqef2qkgMVPzefM7luUZQI13QN/TrafEjI5kTRHPq5IVa5PeORBTsrOl
         sMLejsu2ckqk3L9rX6VyIKh8i4/jAJJqjQc83GNJy7VRrRwWsbULrEXvWe7FgFmQv0qU
         wkeTlknDdZnNQScjjMTgNjar+qKMXQcSEJpf8TONZXYYDtC3tzMvFAbE1RAL8NKg9Q8X
         2TUTgbcMKhtb2xa/952ft8/vlVI+Rw1f3HKyJc/pHFq0sp11XnDKaJCdUq4Cehx1J8xB
         ocpXcdQFHlorEwQnI6jVmk3L21uPrBSYJgGuU09/AaqAwqqPeJskj64FN0Jq780ItMny
         qbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=ZZOiLNY5izTznXyfpT+XClD/SusPcKTwsvjIC0q9hM+TKa3vWJ6HvWWxXn4AO3dTa9
         +5Vy78UWtr+TD/EQ16Z8iniwkDVLs9OXmlBSbu+cebYWXV3dm9N804uQ5OClbZNRKAkT
         UQ3/aPDlNHcBhBGfzOjd2TwgAq8n1c9BHj7ugZ0e6PdLHaTc9bXqzZe3cLVSXen4qEs2
         LzRDbtA2/XdLbj1hBdCLk0J3ehRUNAdMg0tZA6ajO3guPf05Xsxrq5CnO0OkUE7cQm0l
         JMeJNClviVgN9BZZReknB69WKX9bKSAUZx0JkqhcSYOxWGxjpGMfhLXVmyDlv8r1xqYI
         MyhA==
X-Gm-Message-State: AA+aEWbBwI8PzgKQG2L7+kyMNJIIVkr7R/k9EGcp/8eMroENRaIGn3RR
        qn6t8Fh956bXelRk93NaXE+HSJ/FkS0zRLU/16pnvgegL54=
X-Google-Smtp-Source: AFSGD/UHBSGNs6RmdTA0jFiqjpkw6ORCdl1iZ52LeD3vsMnS4RLyj+p+2ZcyQA1m6n8DjQK1o1wd2iaU24ufZG8U4hY=
X-Received: by 2002:a02:b70c:: with SMTP id g12mr13056715jam.60.1545843419886;
 Wed, 26 Dec 2018 08:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20181126143326.31300-1-tiny.windzz@gmail.com> <20181130183627.GG2509588@devbig004.ftw2.facebook.com>
 <CAEExFWv57CU=FHWxAKby4HmzZ9+8GAt2SniaUinvDdLgc3TKOQ@mail.gmail.com> <7f6d5e82-daf2-a12e-deab-87150d630df1@gmail.com>
In-Reply-To: <7f6d5e82-daf2-a12e-deab-87150d630df1@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 27 Dec 2018 00:56:47 +0800
Message-ID: <CAEExFWv+RiONyLcNQd0zvqmFxc9zUe77MbdrQX5fFS_GNyp=pg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: remove some duplicated includes
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
