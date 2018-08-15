Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E921477
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hojZuPJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0E921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeHOTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:02:14 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45140 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:02:14 -0400
Received: by mail-qt0-f178.google.com with SMTP id y5-v6so1717247qti.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcRgKuXuKHozQpGstjlqtYS6PhVkd3ZiQFQN5qb3//8=;
        b=hojZuPJxvByVbCh7CGYMIydBUfXSJRislH6nviP38SCtTcbCJ1qPXDJSNF7il8bKWY
         Q6YlK+Xys9WIDGWOgvpT1Z1fKa/enO4WWO7fLH8/vENtUqxVaOzTSa+Y2DHEGBrjoeZH
         p1YvmZoecxJAlvyiVu9ZfqM/q3GLijvZCXYC4rIu0VF1cpo0hd//biEo/vGZdLdiol3l
         ri41b2RfPnXWrHcjQm3KUwxHFPya2p7MPOCbv61C9UylpqVh8JW9ijuz/whykqv1IxyX
         ZRYw24p1jxSl/RRnrs4hjm43oC4fhvoMJKYJLcgtg2C93modvDPmZ85ZGsk1EwyGAF7M
         H2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcRgKuXuKHozQpGstjlqtYS6PhVkd3ZiQFQN5qb3//8=;
        b=bteeFOExzEewMZF1x2jxARY6c8FQ1izMjPe2ItoSRT1AnTI39gRCqzz5v9/ek9b6Sy
         UvYZROkhUc2HLk6I3GA7d7uS2PpuwoLNQE82u8VLPmBjzWfHZcHV8ewm7eDcN31An6N7
         irIJTQfUNDj2c3lI5g85CxERRW9lMV9m3zgevSNBn26EezobVYx2S5rE5/Us8mJhdAQi
         IP2vKJUL37VDocf0rprlFm/0MuM2GkO+qSkT3R8Z2qfM1ij+GRRwMmfM45Fb038cOmJT
         SyhoCkGBEzYMvC85o4bYBIqNs6ROHWuou2MW5sLBNBviFu1wg0lLoFzAFp58f6eW1uFd
         CywQ==
X-Gm-Message-State: AOUpUlF8UCw1wF1tGSoRfi1HiXuTYtQkXdCMuM3QUlIymhjvAm9Xjh/r
        RAt7BYjfpdmpdWhPNl5arVUVVpGwOWs99cOBPGo=
X-Google-Smtp-Source: AA+uWPxqzlhZvWV8nXhvlcIcL3F3dPYRu6i/E+1lGbNfcuowYvnEictS+x6f/mKZvQJH/h/sODSxEYHqRvkbnNFJ3bI=
X-Received: by 2002:ac8:2cd1:: with SMTP id 17-v6mr25670959qtx.360.1534349368650;
 Wed, 15 Aug 2018 09:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
 <20180814173623.GA5117@roeck-us.net> <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
In-Reply-To: <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Wed, 15 Aug 2018 09:09:17 -0700
Message-ID: <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 1:19 PM Tony Luck <tony.luck@gmail.com> wrote:
> My ia64 test box only has 4.3.4.  I seem to remember some pain points
> with newer versions of gcc on ia64. I need to poke around and find one
> new enough to get past this problem, but that still works for kernel building.

I had problems trying to build an up to date (or even a slightly old)
gcc starting from 4.3.4.

I did manage to build 4.6.4.

4.6.4 built git HEAD* that failed yesterday using 4.3.4. It boots OK.

-Tony

* 958f338e96f8 ("Merge branch 'l1tf-final' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
