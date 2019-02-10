Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDCC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC742145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ETFQ05Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBJUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:40:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:40:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so7736401wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gd0X/pPHaRmk4zM+4OwBFtYmxrEvI5yQT2GBozgmedQ=;
        b=ETFQ05Cy+b1wOvADdSHP+4lGeT6wzTNIj6tSbfLGEJXQV/1ZsGEyoKpctGGRSkfIGj
         s1DydIBgKYr35tfWjOuR8IsZ1q26xO4CVxVTHzq/h5ani7witVR4HKfDo77z21/IriHS
         0fVER+geAvrVUSXIuzB8aqMAh03XRqzE7t1Nv+67AfEdzdIsIyENWL70Ps7XIx9URJEp
         mCF0OnItbNO4O0xhK+R35zZyWEfj8DwvI4JUTkH1C7MkIsy8gUM7XuZdBaE5n1re8ebZ
         lekH1AhhvPSXjFiNp/94m+eS33UIJWX4gWNsQqV3hlNM7LNtJQFRsblFvBqW81yaVPxr
         BdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gd0X/pPHaRmk4zM+4OwBFtYmxrEvI5yQT2GBozgmedQ=;
        b=J05tWU2qD1vEW4E6H/N5df44Uc+z+g0qtblGVK7PjqArq06qT5vt3OC5XQJFaglPLK
         5x4/lHHFIo3xvlrBXnxOJwihC//Ym4KUMPQW0wrBXOOPBhbskEHLgxqIXpO7a+toTX3F
         NRQ320LWMX9nCx9AKVwhJ75cajCq/II/L4siv/kg0nJGGmssYDgHZ9u5nR1F1Y2OBG4k
         Xf3gz6O3Z5XGztTuunzgG7aUWYe8EkDmr2+355la8tsqcpTQd63JRV9lDL4XtRNTstKG
         yEfERFiMX/+XdC92GXYxQ5cmYx1Zov6fvw7FBIMf0WErvDP86wBvmUOpYldB03m2hq5L
         jWRg==
X-Gm-Message-State: AHQUAuZiNPJ1UehnLBeXOlSScePS2GPYN0MNFVEIDgEe0fa6u5qVFcah
        4RHIauflqKU8IkIscv4Ipk/jbw==
X-Google-Smtp-Source: AHgI3IYeEVeO0LUwFzUNJkoyUryU0QEG4NxYn2ny15gvIkWzyHYFPhoIX0QkPmpUrZDMn+7WlEOw6w==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr6045502wmj.63.1549831201406;
        Sun, 10 Feb 2019 12:40:01 -0800 (PST)
Received: from localhost.localdomain (p200300EA6F14665209EDE1AF663E9C0B.dip0.t-ipconnect.de. [2003:ea:6f14:6652:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id l20sm16469784wrb.93.2019.02.10.12.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:40:00 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v4 2/3] sysctl: handle overflow for file-max
Date:   Sun, 10 Feb 2019 21:39:42 +0100
Message-Id: <20190210203943.8227-3-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210203943.8227-1-christian@brauner.io>
References: <20190210203943.8227-1-christian@brauner.io>
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
This commit sets the max and min value for file-max. The max value is set
to long int. Any higher value cannot currently be used as the percpu
counters are long ints and not unsigned integers.

Note that the file-max value is ultimately parsed via
__do_proc_doulongvec_minmax(). This function does not report error when min
or max are exceeded. Which means if a value largen that long int is written
userspace will not receive an error instead the old value will be kept.
There is an argument to be made that this should be changed and
__do_proc_doulongvec_minmax() should return an error when a dedicated min
or max value are exceeded. However this has the potential to break
userspace so let's defer this to an RFC patch.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Kees Cook <keescook@chromium.org>
---
v4:
- unchanged
  The prior version of the patch contained a generic change affecting all
  callers of __do_proc_doulongvec_minmax(). This part was split out into a
  separate RFC patch as it nees a proper discussion and consideration
  whether this would break userspace.

v3:
- unchanged

v1:
- consistenly fail on overflow

v1:
- if max value is < than ULONG_MAX use max as upper bound
- (Dominik) remove double "the" from commit message
---
 kernel/sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70581ade3555..c4a44b7ccb8a 100644
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
@@ -1724,6 +1725,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "nr_open",
-- 
2.20.1

