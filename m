Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1492FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31B92147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="B0okpa8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAGW1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:27:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45550 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAGW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:27:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so2366314edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrGxqPyrYsMczaS0NRVkwlKlTFxe8vaoBi9sEVLBFL4=;
        b=B0okpa8BcEEoEcN8M2fp+1rE5JbQIjaRiSQ+ULBwHlq35OLe19VpSzs6Zq9LLr4hS8
         NrxbsAH6bnYHcLynVf/xcSEeqNDEdyGr/ZjcO2YxeAcrmBWeNl2FbvZiuPQ4byviuGHE
         SZbGi+fZqghjsq6nNqRakDzHvBC91jPoFPiNEyQsCAwVZMPhhd75zLGEmVEme8L2ZQ/R
         6Ukd9a1O5n833wnHbgxdo25WKtnIFCSt3iBs6V9hBELXzNSEZ65Ngz5raoijAWG7dw1d
         iNVCJEiWaidEb9XJ2/6SmNPOMCvxUzcnB73gacIxwkEL/5bcD2dnivNW8XWlCPOMgJM5
         G9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrGxqPyrYsMczaS0NRVkwlKlTFxe8vaoBi9sEVLBFL4=;
        b=ZcrVi9P4gpXtH0kzZ1NQ5B551tqty+YbqadvOuqnVI0syawwZz2VWR44m7RlHHsAtw
         +LwAaaMK2FDe3Uht55PA7M+k9tMDNt82i+IRC2OsYRPX4B2rPWie9TMR2hgCCROAWifJ
         3OS/6wiqtEu4+8uLZKmI1azHnpEe68AzixoOVMmBJ+U5nxpNihIJJy7wfBApXkTMRypQ
         ZDkZGZyJBGGvA9rZ+85Ly4bzsBMOrcYpHBi+CigILWToZFhRH6q+saLuIXrjylSMPFLd
         8qbGdacLpKoGy/fZoxUO4o2xMJlR+3Zuc7Hp1ZSFG/nKeNe4mOo+edFedb4K+oTv46lb
         Tz/A==
X-Gm-Message-State: AA+aEWZXHkx9+/TNlvV1BY+IyHZq8CfiOzYaFjUWSCyCVOcW9v6Dy9sr
        0pv6bFgytm3KFZmiqsDZCe7Xw36VZQY8yQ==
X-Google-Smtp-Source: AFSGD/U8hTumKkFZDU0a5r7KZpMK+j/zqumGXdu6MOa5TujdBqD4G/NPEhWZ2lBpCeDo5js6tLY3kw==
X-Received: by 2002:aa7:d597:: with SMTP id r23mr58129095edq.51.1546900032973;
        Mon, 07 Jan 2019 14:27:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id e53sm30826227ede.90.2019.01.07.14.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:27:12 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Date:   Mon,  7 Jan 2019 23:27:00 +0100
Message-Id: <20190107222700.15954-3-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107222700.15954-1-christian@brauner.io>
References: <20190107222700.15954-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system.
This commit sets the max and min value for file-max and returns -EINVAL
when a long int is exceeded. Any higher value cannot currently be used as
the percpu counters are long ints and not unsigned integers. This behavior
also aligns with other tuneables that return -EINVAL when their range is
exceeded. See e.g. [1], [2] and others.

[1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
[2]: 196851bed522 ("s390/topology: correct topology mode proc handler")

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v3:
- unchanged

v1:
- consistenly fail on overflow

v1:
- if max value is < than ULONG_MAX use max as upper bound
- (Dominik) remove double "the" from commit message
---
 kernel/sysctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 06df9ef138e3..11378a59af4b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -129,6 +129,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1717,6 +1718,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "nr_open",
@@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 				break;
 			if (neg)
 				continue;
+			if ((max && val > *max) || (min && val < *min)) {
+				err = -EINVAL;
+				break;
+			}
 			val = convmul * val / convdiv;
 			if ((min && val < *min) || (max && val > *max))
 				continue;
-- 
2.19.1

