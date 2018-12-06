Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A267C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34A221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34A221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLFWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:09:20 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34077 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLFWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:09:20 -0500
Received: by mail-qt1-f173.google.com with SMTP id r14so2408497qtp.1;
        Thu, 06 Dec 2018 14:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnpOFDQU6TKhogeL5a038+X22pfiNvy0rJAumA4g9sY=;
        b=HJ1RxEQhUSeeGDu+JQ/1g6/dzHcdK1Vk6FTURFZ2Ao9AS6rNRqSNrB+fNdA7+AO01e
         SJa2+gdNlgKZV3BoJLGkJMd9bzrG7URgpnqL6lbyNlV4lfBvuTfAVfCv/szvQZYiFLES
         x4YjJUMwreXc0OgOOSMkebeFWPMmzW0Ej6ec6c3QuprheRDRrjHvoCR1OL7Lq5Ypg0qc
         pgMO8ZxtPecYPMSAIoC+EZrhy944RBH7WlA/zRzoMukP3BwdOreNuwdny2RSc7GHcjUv
         84VTs+qnEbtHgJ23cV3NI7JwbXjs0oj/irhPY+EU0PK/P5vWJ2LLiNnoMVA0dEaZO4z3
         VPZg==
X-Gm-Message-State: AA+aEWa97UBcEehMP4UbQqdtp2JAFdIOByQwlfNycrm+U9dWyP3V4wge
        ucW9gN5bOIKcRdcS1IJFixDDe/1z11nEowx5QkCIfA==
X-Google-Smtp-Source: AFSGD/Wjg3Ru74pzwMJgstHGlr0BFFUYzfwcVMm5W/mz6uliX7Lj9253NtfOOEWtN58DI9f+cVqajs0ZcD5kYY5ptu8=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr28657329qtr.319.1544134159283;
 Thu, 06 Dec 2018 14:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20181207071147.3b41fb5c@canb.auug.org.au>
In-Reply-To: <20181207071147.3b41fb5c@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Dec 2018 23:09:01 +0100
Message-ID: <CAK8P3a1U9y7rHq9GUd-BrY4=aLLyBYZLm8X0JcKU6j2_sYCCmQ@mail.gmail.com>
Subject: Re: linux-next: bad merge in the y2038 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Arnd,
>
> The y2038 tree contains a merge of next-20181206.  I cannot use a tree
> that includes a version of linux-next.  I assume that this was just a
> test merge, so please remove it.

Fixed now, I had pushed the wrong branch after I had done the test build to
make sure that it wouldn't conflict with anything in yesterday's linux-next.

Sorry about that.

        Arnd
