Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo/O//KbqgNYRScZEvB96mckkGRkL2l1Ypkii+OmopbScWo2AiUfzrAiz0msdNjyezYiQgv
ARC-Seal: i=1; a=rsa-sha256; t=1526280712; cv=none;
        d=google.com; s=arc-20160816;
        b=hQnLxvCXvciq+h8hpT5KSfjyWYdyr6mAlPibsPbgRm6NoJbJ6BfwqRlx2zI6Vwbj83
         L82bfyxbM5XuxTw0ybTtE10HibZ68YAygf6O4jpuyI738i5u/YqCBFaG9JHStL3vfchs
         zzNYG2uQiA8kz0BbORkEMF0gM8/wgqnaxRQk6CcTU59MwIPer/wSmM3y7oauMph11FwM
         7xrdfzhlXbXPZtxIEzg5BnRpOrlpZnTvbzpdJHYa0IQNAZBabBM+UVixWnyBPXvmzOzc
         NqwZ/r/UoPDhvqRdY8n/EqCQ7zuF1bcrSZcT0b2reF3Z8mPiA7F93X3YyCGh9Qolvfq5
         LJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QFUwpjtnGYATUGIFGIbTtRfRGypHo2p7oYxnzkKWtus=;
        b=Py54wMTvoPUQ5XgyUg6UNnZ5R71DSazutSjCiTge7QKHb+tPR1dYz3iOdK8OelTfjg
         1SLJJuSPLQYib6dV7yqHd7UwQMXHNuwfzMHSya9JeSYrNxzmE5O5Gu0M5qQ/hE+qsf/T
         PbLN8u58KghzLSPQzwRjrMyLQgSmmlzHX+ibLst0ZJEfN83dMOjGqTYao6IJnov8ILx3
         U5CitV9r9/i4gmGAlLEDQ/Z50hVkz6H+gpaSjjsrO+0nWzjevyj6w9GQbXJ9eEK6rfy9
         Hz9BlNI43EfaPosOSso54iB61+dodC6d8dpnKVngc8swfuxlPdD4rornI10AA7Wqeulr
         JZqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XGyd2Ooa;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XGyd2Ooa;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
	David Hildenbrand <dahi@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.4 03/56] KVM: s390: Enable all facility bits that are known good for passthrough
Date: Mon, 14 May 2018 08:48:08 +0200
Message-Id: <20180514064755.186646235@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421324018782851?=
X-GMAIL-MSGID: =?utf-8?q?1600421324018782851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

commit ed8dda0bf74b4fb8e73d8880c78effabd3285fd8 upstream.

Some facility bits are in a range that is defined to be "ok for guests
without any necessary hypervisor changes". Enable those bits.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/kvm-s390.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -118,8 +118,8 @@ struct kvm_stats_debugfs_item debugfs_en
 
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[] = {
-	0xffe6fffbfcfdfc40UL,
-	0x005e800000000000UL,
+	0xffe6ffffffffffffUL,
+	0x005effffffffffffUL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
