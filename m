Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrTCXfIHaN6Ct1o6UDaPhc3ikulRUnTEvjsyMuYAUaLSFMFrrwmctSe5MbXP3yDtAE5KUpy
ARC-Seal: i=1; a=rsa-sha256; t=1525116414; cv=none;
        d=google.com; s=arc-20160816;
        b=ctdHAMER/OwmSOITemsJAFHGzaiswjZXatbzz7brB79UxQpJaSAYQFL5k97rpy7oTv
         n7XuRp+HKntRoLM71kbJz6JnIsCZbpKTaeY0UmPqwnQMmI1IbmOv7OQJmWTxEIuVSfTX
         BVo+iNFMDjjlLHA250Uwgl5gKbsJPtVXhPu8GJTNva3hezQ1pYH4IOMv2yUdX9HiVSYX
         rcdJcDiAz1jQXG1ctfS/aIa63O2evPj84690LOIUf0PX8RWLfWor46U1QcMn2g4uLP76
         suiaO6iQ9ctyRSua7UT6vluooODjAoWN6dUfrDbt39SXW+3RKMv9G4fzE3VbwtyP+56c
         F8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=nzdf+xBcTKbLt+OZLmltrxW9UspAb041uhFkSSb1z/M=;
        b=v8X6msHbhNoppYq3sVTDPyYviePDgzPMnrZfSaIYbfq8z99TSFgDA6jiB58KLQWjaK
         RLLqSXfYxwktf0KM/NyIBhs+LwJRtY/GGroH9MJwzN7Boke0hfjwiEPMJuG+BCA1z7zl
         D1Ym4CHgAf6uggJPDmN/RCLBCsY6kpIIuk588GK9QUL9/5mYqlRpc9wlmcXUAQu9z2xq
         2H9xXwjA9aY/ggPTjWREovnKQ8f+GlzjhS8XayrMXGYUo+c37rtDbKAZd0uxfVhyCSg8
         4U3WAnYoIeLI3hy7vSrD+nRBtY3mHiloJiuFSR3KmTs04xPCtrsIuoI997QkBuPTyigJ
         SQ5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C382022E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com,
	syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com,
	syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Subject: [PATCH 4.9 39/61] kobject: dont use WARN for registration failures
Date: Mon, 30 Apr 2018 12:24:42 -0700
Message-Id: <20180430183954.632232883@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285796531709?=
X-GMAIL-MSGID: =?utf-8?q?1599200468898218575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 3e14c6abbfb5c94506edda9d8e2c145d79375798 upstream.

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -234,14 +234,12 @@ static int kobject_add_internal(struct k
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
