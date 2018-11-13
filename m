Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BD7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3362251E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca0rLqwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3362251E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeKNBPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:15:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33255 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbeKNBPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:15:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so9090273lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8f4Y+bYP0IHrIhe0KgEhOVgrFrseLN9aiG8Be9nh9K0=;
        b=Ca0rLqwqrfJFHLzxeOt0Lh60IFDYKhfytuYDW4eLnJYivRXKrpyLk4VE04A1/kPV+F
         zq2vEEzvfykQfIieWzppPyboTTtu+Xz9QUwA3t19zVcVMBtfGjJ905GVo4f5imna9vG7
         iHDBo8mBMJ91LMZJAXQbeqnDF/bTF1CURnIN0hVFdrkE+95TUznxX16va6JMrmdpbDDc
         SG3MQb12P/X/aNWgUg0vqzag4rITXd/ThDFNa+wt4InlvRPtFn/ZCPvMJ5D8RY4+58t9
         1NGJBFXJOXMCNPT14zoX+WtFZGTuJxrA60A17Z50K33puUiUfNJE20+ErIWAfb/BHDRM
         v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8f4Y+bYP0IHrIhe0KgEhOVgrFrseLN9aiG8Be9nh9K0=;
        b=F1cvAS8tx718nNOS+DYYJcsC5aYSPtVzSDKK38PUcWWjZ+yyxoOWsD3mP+9cj+T6Do
         w6ZQ4jX7Voi6PesuWphgwa1w2qzta2KmM8Ubead46OeP1gLme0XjUwo5btRloMiLNtg/
         +nf+d+9Ti1tazNUD80Mfu37Ocedoz4zbQQhbkVATAk02Y+UbN+UG7mvUx6VbVibqIsaH
         Ngot9aumZQPZNrMioFtWXJXoZkcnTBygjZDzCx7SCFlLqDtRNHUeympaioiw75rHA/Sm
         nYSLwut5JGambYmXJ7qTI6/nqzUDkY8nBy0V0+c5oqewdoUrV3EFb9T/R8roZmyVFzsR
         93Rg==
X-Gm-Message-State: AGRZ1gJL7/rxexdHTcQBGS9Szbqu5cwQQlrYt91hMfHbuGovobZ/B8OT
        9z2i0dGDsaZP2mNg7omvrgWM6AbU+Dg=
X-Google-Smtp-Source: AJdET5dLxG3QbphVgGXCANZq6pBpCZ7/rb3WmI+OmEqNB7CyGOQdyexaSir5UTBmqwUIXYaFpTHVCA==
X-Received: by 2002:a19:2395:: with SMTP id j143mr3073136lfj.107.1542122201983;
        Tue, 13 Nov 2018 07:16:41 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id p91sm2645825lfg.4.2018.11.13.07.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:16:41 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH 0/1] test driver to analyse vmalloc allocator
Date:   Tue, 13 Nov 2018 16:16:28 +0100
Message-Id: <20181113151629.14826-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As an outcome of https://lkml.org/lkml/2018/10/19/786 discussion there was
an interest in stress/performance test suite. It was developed to analyse
a vmalloc allocator from performance, stability point of view and compare
the new approach with current one.

I have explained in the commit message in detail how to use this test driver,
so please have look at: vmalloc: add test driver to analyse vmalloc allocator

I think it is pretty easy and handy to use. I am not sure if i need to create
kind of run.sh or vmalloc.sh in tools/testing/selftests/ to configure the test
module over misc device or so to apply different configurations and trigger
the test.

This driver uses one internal function that is not accessible from the kernel
module, thus as a workaround i use kallsyms_lookup_name("__vmalloc_node_range")
to find the symbol.

Also, i need to mention one thing here this test suite allowed me to identify
some issues in current design. So please refer to the link i pointed above.


Uladzislau Rezki (Sony) (1):
  vmalloc: add test driver to analyse vmalloc allocator

 lib/Kconfig.debug  |  12 ++
 lib/Makefile       |   1 +
 lib/test_vmalloc.c | 543 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+)
 create mode 100644 lib/test_vmalloc.c

-- 
2.11.0

