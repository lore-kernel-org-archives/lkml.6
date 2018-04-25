Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx48CcE3rtp2DLU8xDXZZiNt2IcyDBT2O1YOvol2o01d7PTtQRRaI5GXmR5IUlTJ6ZwJ1LHn3
ARC-Seal: i=1; a=rsa-sha256; t=1524652438; cv=none;
        d=google.com; s=arc-20160816;
        b=Yh55ckXvVkCgGyd4mvnOskMZsPrMyz5lAhxGO5SjL280HLlxpXiBkvQPKD8vZfbPIT
         iAmjzbpagUmf4x7AWIKH+N9mPNQc0/cmJRvIKHcil8bM8sXX4M9/TnznWIYv6KkcqvT2
         ffPGvYfpSGVBvI+FdDWLOcOPm4NsfBAAyz+32Lf8UwONCg9OTLlCk7OjSe2YJP8jnpA9
         UakPkUotlcCVSBGovvdZmFjnkURuPE7SHGfT1ZaeHIKR4L8VZ3+CRw+TIwe5F0gfjduV
         yLe+7Ic12KzhVl9DIpp3T+hQOedxIRUIDvbsedWz2I1D1WHI6hn3bVD0XQvTxjpvdO+H
         dcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=WM8wUJrzKC0u6yAAINhnNQ5TXwYRICn65cHYxaip1hg=;
        b=YA6Z9e02tOYVRSRoQvvXj9Xpv7tnY7hf/yhNT9iz42PO7upLBjgQ14iMVfJ6wI63Vz
         oFWbW/yOdlwCZk6Yq7KSir4LkoGkhrC9XNzIx/X1ECiBpHBSiKqEHZ66g4DWYVaZZCFD
         wbDeC3cTFrjs1k2nK7Od7CMnS2HuIlOSxk9wqYgPOZ7lHcv6n3Gpq2N36DutdADZKzhs
         3O7PBYWqeCb0BbEtMHpYRTBVdPjD1wS3C1eDL+tI6PzkxLDtFU1+LXIF/W88rI99dZFG
         OqoEUCt1rX9nsP+Tcu1oe+g3yLh9KUFyKA+TxFo3aYGtjNqrb3CIJn5FBTd1e3l6VPSA
         Lswg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <hpa@zytor.com>, <gregkh@linuxfoundation.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3 2/2] x86/mce: add CMCI support for Centaur CPUs
Date: Wed, 25 Apr 2018 18:33:40 +0800
Message-ID: <1524652420-17330-3-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
References: <1524652420-17330-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598713954946471832?=
X-GMAIL-MSGID: =?utf-8?q?1598713954946471832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Newer Centaur support CMCI mechnism, which is compatible with INTEL CMCI.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 38ccab8..f9a7295 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1757,6 +1757,8 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		}
 	case X86_VENDOR_CENTAUR:
 		mce_centaur_feature_init(c);
+		mce_intel_feature_init(c);
+		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
 	default:
-- 
1.9.1
