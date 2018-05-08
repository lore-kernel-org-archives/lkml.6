Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrkNkarfuC6ysilMaIuQJfvr/MvgB+beNcFWmU8fVTT4uk8zzDYwOuAdrePHdqzd07/zZf6
ARC-Seal: i=1; a=rsa-sha256; t=1525767263; cv=none;
        d=google.com; s=arc-20160816;
        b=AU4/WxYscZBRstbTT9erMkM7eG8SQqBt5rjJuzZvV2xGJANwiuR4OiiEZcmzqBT2Gz
         QsGrDjl9LPZPqFrl09voLUZ6mP08+p104WEnZ87zxEv7HEmDAtFaxsJN+9PZsLlVM0YE
         BNV1ipadY0dOVNLm1debnZ6LwBWYC0fGhNdAUhgojQzptv1ufHHY3QoRGvgmiriex8d1
         DFj6lNYOXTS34A+596d0UO0vTyjM7ccNjI/x3oGALJO+8cERW+PNI1XB9tmKOV+uVnQS
         7Q1fka0iEFQgCMWdp/JHp0xnR7iFUsd1j4Ah9bJ7/oDoHctONQnnELe2pN1BdVGGkt3P
         cy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sb0pj5HSWiKSFj1qsnxs9FPQjwaVQeeg74ZpAmxSfIM=;
        b=PrbSAwtHxIISILsAm9XYLO8WHV2Ixp0gbVeUTm8VDhwL2TpNuY+l6QwxE6lEq2w/P4
         UXPNJqwiUkkJwdX6rGUum2Ck0JWtw1Elxq0rR4aL0p9sr6uzkMZwMV3/HY7Je4VJwZOV
         3oFLOWO+sb+htER5sWGDmWiOeKpWx+b9jXEfcusN8Z9FLiWX8TOHJXYrw44EFfUzPi4e
         jyFi3jsu//DbupQ//mGw3bTJh0+5hEfyr5kS2IBaMmeSqnLgXEdue4Iq4GFWDMfpE78U
         P9JfoFXpUX0OPmia85kA87MmhhF3zyNwviiLcyVMvP5KVc55anDr78ZUUPARxuMS/aEa
         5A3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xy2YNgbI;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xy2YNgbI;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 03/43] percpu: include linux/sched.h for cond_resched()
Date: Tue,  8 May 2018 10:10:22 +0200
Message-Id: <20180508074004.543289003@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882933726573493?=
X-GMAIL-MSGID: =?utf-8?q?1599882933726573493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -80,6 +80,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
