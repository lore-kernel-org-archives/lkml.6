Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955652070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBVUww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:52:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35290 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:52:51 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gxHoQ-0000CV-3V
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 20:52:50 +0000
Received: by mail-wr1-f69.google.com with SMTP id e14so1488525wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4VJ9JmshK8eifbcs0LbzgsfhsoR86SEK3Zw3F0Q9Js=;
        b=WLifDAwhjpINyF5eDbuMO0XBq3VS3wY9PWT7Bfz5nyDixYBVRofcpY/H/XBPP6CqqW
         C3MbpyrhxgzVvYTeVHU92PUrOH3loG/7lpFwiJEqj+RUaVpU+m9t9K2i1davb4zpvJZ1
         PYjs4+31MZTFZoXSwWvEZjR4LNLWD/T/H1y/BWbx/5jY2s8NHVl5YZH3IV/Q8BBtljiC
         0fuD8v1b04RxBiu+wmUgPJ/ShtuoLvTki7JaCQbni1ag1pUYS3YicQuo2WAeR5k8Dsiv
         yXia9vejLqGD54r1PKR6Gs3ZkdeZBg1WUoUaNHaNoz8ICxUGfbrGLr73I5qZuBwv1631
         KEWQ==
X-Gm-Message-State: AHQUAuYMsGD+odm1SQxIN0KlD8rBzV1tcfqcFHYo2+WImpvGzw3EfFz1
        lkISwyzzNLi6ZHZ4rkYoFfsX8Frra/j8I6k99Xf3IKJdHA6N2mH74K0njJICdeiJlNQsnl1Fz84
        fyWvhQuKEdLTa1uypRY4G0IbAHtuMkQvwy0czpQuAtg==
X-Received: by 2002:adf:e603:: with SMTP id p3mr4140545wrm.104.1550868769588;
        Fri, 22 Feb 2019 12:52:49 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYD1Rw+5BP9utRCeXc2pWfTkisnK8pPH/QGJXTRRDuEKwCyD6B6rc3LhcnQkm8hnKgiFC3qQA==
X-Received: by 2002:adf:e603:: with SMTP id p3mr4140538wrm.104.1550868769385;
        Fri, 22 Feb 2019 12:52:49 -0800 (PST)
Received: from smeagol.c.hoisthospitality.com ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id a8sm1728962wrt.79.2019.02.22.12.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:52:48 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [RESEND PATCH v2 0/2] selftests/ftrace: Make ftracetest POSIX compliant
Date:   Fri, 22 Feb 2019 21:52:35 +0100
Message-Id: <20190222205237.606-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222091021.10178-1-juergh@canonical.com>
References: <20190222091021.10178-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shuah@kernel.org and linux-kselftest@vger.kernel.org.

The recent addition of colored output introduced some non-POSIX-compliant
constructs. Fix that.

Juerg Haefliger (2):
  selftests/ftrace: Replace echo -e with printf
  selftests/ftrace: Replace \e with \033

 tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.1

