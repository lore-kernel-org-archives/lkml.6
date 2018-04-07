Return-Path: <paulmcquad@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523126877; cv=none;
        d=google.com; s=arc-20160816;
        b=nR/r0Dcwx+HODmvSMEUEC9bdHB1T2yrqcenkr6HXxw4x7TTueZffeDivFe+pI0TpTE
         LEk7NWgui3WiwZ235CN7e4N4QAtSCO+taWvHsh5KRkScs3CBfFi7AAfnEJMvb4p8Ylpf
         9MZu/dJYbxVgg4f80yy8EK1+B6qRLg2FP0U/9tNu/Hes15Rw7BRvS6IhMcl+oc9shmOX
         bLR6a3rIfJwu3isXso6WohsJ9pbLLlprg/4rpZ+0R96ub6sJtoA37jYbAKgCFsWqNBzD
         Mr5DSSBvIuQjzemwzdBkdZDmKggGaHvfLzCVjskwXSLjdx+h40x9xpA85VPSXDF+8ynS
         cHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Tk0n3ivUIL2DV0EdS6BGcxzl8dz2f1oeBE5PBBuNSDw=;
        b=VGvCQi/2lZXJ+9jm+DblOAQ3ANSvBkAQiZmtQdUvjnWbOyXjPKbdxSuXJ31lMPLdYU
         OERu22f/s+fW69lMUOSXCCOxLtHODqXSkO2YQYqvVUUUpIGHZK07MTO5B/F7EWw0G4Vd
         HAEVel9oKImTwHVJIVA8fxmiDeZ/xUc/LtHfTqX9oBD+j+mEeye7D+OM4jiFXPWpPiKe
         ZziG1Be4b1ZzPBffdQBTXYTPf/2/7Nqf/1wc/iHkjZsi/HkX5a/Wz6VMvFWRmYVJ8Lg6
         +b7mjjFyRfTbnTQiH4vSxO5GeKzWPbjN2GhAAD7fVYyB4BjiPtbNLK8nFFVnFmJp4Iv6
         +86w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JhMMqw0+;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JhMMqw0+;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48zEsMFmr0fRYSNSW+/Tsql5rIJLI8lTdGFJMQdpa/rQL56QMUA9IV8+pnoVgdxoEA/eIaDwA==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: konrad.wilk@oracle.com,
	labbott@redhat.com,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	guptap@codeaurora.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rppt@linux.vnet.ibm.com,
	dave@stgolabs.net,
	hmclauchlan@fb.com,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm: replace S_IRUSR | S_IWUSR with 0600
Date: Sat,  7 Apr 2018 19:47:26 +0100
Message-Id: <20180407184726.8634-3-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180407184726.8634-1-paulmcquad@gmail.com>
References: <20180407184726.8634-1-paulmcquad@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597114288867822632?=
X-GMAIL-MSGID: =?utf-8?q?1597114288867822632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix checkpatch warnings about S_IRUSR | S_IWUSR being less readable than
providing the permissions octal as '0600'.

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 mm/failslab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/failslab.c b/mm/failslab.c
index 1f2f248e3601..b135ebb88b6f 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -42,7 +42,7 @@ __setup("failslab=", setup_failslab);
 static int __init failslab_debugfs_init(void)
 {
 	struct dentry *dir;
-	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	umode_t mode = S_IFREG | 0600;
 
 	dir = fault_create_debugfs_attr("failslab", NULL, &failslab.attr);
 	if (IS_ERR(dir))
-- 
2.16.2
