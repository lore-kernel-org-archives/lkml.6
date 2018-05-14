Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrplMEprivQpnc/jvq4ObYGy/fbM3vpJ+PH/AeuXsZqtk4c/IJGGxbnEKlXQo/86FSQ074i
ARC-Seal: i=1; a=rsa-sha256; t=1526280714; cv=none;
        d=google.com; s=arc-20160816;
        b=NIr7kQ8IZ0TC+s6z0Ddo1ZMG/3W8tFrrxHx+EzPwJnyuKAKIQcfkDQ4GvZxzOdj/7Z
         JE5VGMHKAgn06KjyCi6noxqRS6+FjYpTCluga4/4lScvzzn6/QUluavYiAvDlr7ILpe1
         VoLWLQuThwdbo/oXtUpNl/kyDDNuDW64rQ4vlyFBYT0OBbPnHkYr+2TfWKg9zP+JFPQN
         KhnlNo7h7hG33j/k1Ixl7S2FvRNUie82FjmdViFx2LmXVIzkboXMLGk3u5ZFBBlSdL4p
         krSBJFSf2oLwzvob3g25qdVVViLn0R9HG/TR9KvVfT5l5rvG0NMYZLE7StlMf9wHE6r4
         kGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1u3HpUOfyocUJ6sK6A0qNljBEWxPdQwakBUjwQf8ZW0=;
        b=JNHPq6ceKiQpkQgOxp1mNzMHhaMsujq0OWMPfuttazPP7vb7LHXlM6zZ4E7sxja3nA
         Y1OV+n2fItO5+O8w6y+UVjXP3d+3xxyAaMgIFXjgccG9vGAr+Qe1hU856QHlowBU9aoy
         KcOsqzS+duhFrppcXWZvy1rG3wzhcB64E0TuCyd2TNM3EOFVkpd3QeBOUsWcXjW2xc2z
         ylC7O4icLfyFBGt7KgV3MimViSf6t2aJp3gHGeUy6uQ+fHK7/YvKYqq1Z7QFbJaleYWQ
         M/l2eH6WQbEwTgk7eNINUNbmV9fo45VIPzT0awyeDx3AO+H/7gAsE8KZmVQ+s1WmEJ9G
         fw2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iwDoMn3u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iwDoMn3u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	kbuild test robot <fengguang.wu@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 04/56] percpu: include linux/sched.h for cond_resched()
Date: Mon, 14 May 2018 08:48:09 +0200
Message-Id: <20180514064755.288558149@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421199031631180?=
X-GMAIL-MSGID: =?utf-8?q?1600421326720017694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -68,6 +68,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
