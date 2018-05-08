Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo4leyA2mRxck4KQa503R8Hq7/d9gRyYy5ww6uI9pIwNotylBVf9FoXDaYHYYOZNQihCRQw
ARC-Seal: i=1; a=rsa-sha256; t=1525767391; cv=none;
        d=google.com; s=arc-20160816;
        b=nyWkXeSRyVTEYnkWeSvoKbUyc8uaG2P1rEfrRdkuWH6TO7LT82m9jBIO36NjyM9DFU
         n8mxn0tGDEuXLg8Qfomxe+iGMPuso/kZOCV2aA+Tb9U+gK7HJMkTpLeHpuvrGnVPjvTW
         KeUr7UONxzdNZIO1fMYc3ZAoIGTVwK/J//hjpWvVVFaXGv26J1ZiojuWA5EQonAqvnt2
         Q5fBZ4YG2AIbanyGAi2W2PdytzwVWBVN9DlV+wOTtxZuIP+9G1YT/MbDX7Pf3RFA7VQF
         egCc29HQLidsXN5EWZxBynwJD8TUGTMcPCxaPj02vOngDrR31U8nujOAs1ojQzvmJ6vO
         gLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qsRwtYjmmrhLHJrDjF4elgEVOn2HnbE4WzTz9B+ltgM=;
        b=s+unMOITOymJkdgmcgClx21O/WkB2lEyW/flXuKPsZ6GB0a0gZvABU6f85984jLhiL
         3pyu4Ey6XEMeyeguANwv9NM7ShNXjRlNMmuevZ5CBnyxyw9kzx31DOWNYlmSQgYqzXFp
         VpuiihX26X7UBGb2RvdqNfCV7zw+KJqjwiKUPq724XcB3syotk2mUTH95vz/oaHVSmHI
         cOxcPrKXcyQlPgbKTW6qJj8Okyp8rYoS3G7pV5gOya6DXSmklTpzycqFCrBnBmjvpRUu
         Rp6hzzyXl1brnB0V9SIh0/R4blHRQaLeyBUn5BdJV3lPjs6egb9PapiSZS2QK09DAr8k
         tRzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sThLibo3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sThLibo3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 02/32] percpu: include linux/sched.h for cond_resched()
Date: Tue,  8 May 2018 10:10:42 +0200
Message-Id: <20180508074009.103575139@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882933726573493?=
X-GMAIL-MSGID: =?utf-8?q?1599883068486095526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 71546d100422bcc2c543dadeb9328728997cd23a upstream.

microblaze build broke due to missing declaration of the
cond_resched() invocation added recently.  Let's include linux/sched.h
explicitly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/percpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -70,6 +70,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
