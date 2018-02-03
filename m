Return-Path: <540263207@qq.com>
X-Google-Smtp-Source: AH8x225/jDhR2ILdsqeD0YqMlZu4P5/hk1m51/BX0QZhK+6Wv1xZS2KUZGdTloVetNpsg6AXD3ju
ARC-Seal: i=1; a=rsa-sha256; t=1517636963; cv=none;
        d=google.com; s=arc-20160816;
        b=gQ2YqEW5DmOuHHqiDr7XGOLxsuDC5lsoVHR/QPfnFtjQwrLdn/91Jp6TaoK8ThxRyd
         ZFYSKNweK7kT8tRhxgW1ocpxQApjYGXuxxVthOzOEu+QS3+msGrY1Vagkm0kikvSvLIq
         /EvoH1FfCG51kpXG01jKgQeXFNi/V4zUlhFfDl+ZlU0z1aMlQtPfO85vuoYB1QiKdHBw
         r2/HH+RRs2dSyqPKa84tG8KolxqBq1+qZ+N+yvZQjC/x2PTmFnR/6OixBHrcK3AF/bEI
         GQmTffITv8jGhXgWGxPn9zRg2fTDXSuXl5j/QrGnvXPicUykKF9M7ewY4944SJJqzm3x
         /XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=feedback-id:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bioQd/W9FYMwZAtUGCPg/Kq7sP5SnMShuQOIaFSx0UQ=;
        b=Y/AijdE7+MpIxAgod62ODn0m+9aQPDyAZ3e+HD6zDjasTgAyLhPSiRG0lVDKh//bab
         /FsGo02yw+bw0Y6sn7k6RBPZ4VKawBxF7n4XwOyieQDIc3k2T7w9Gu84T1r6X9GQNA8g
         yxGeEY7sgDmmRE2JYPR/0C4kEdKN63e5cAgsJYBYfDk2/elTBb2TGKbatTU3IJoZATVU
         5GEVkEd2ucEojEX61Ym1f9Z+EkNlcMNpK1tx+7y83tJEfNa5LH6tbtRCBAU/ywmtG+Ia
         JQMWnz3TTIuJDAlORcgj0X0zplLQ9AhFSf2Y7/Ed+idy3Ki8Uxu9aq+zVtul5YdJuHO+
         GPcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@qq.com header.s=s201512 header.b=MelfbE3i;
       spf=pass (google.com: domain of 540263207@qq.com designates 103.7.28.233 as permitted sender) smtp.mailfrom=540263207@qq.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=qq.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@qq.com header.s=s201512 header.b=MelfbE3i;
       spf=pass (google.com: domain of 540263207@qq.com designates 103.7.28.233 as permitted sender) smtp.mailfrom=540263207@qq.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=qq.com
X-QQ-mid: esmtp31t1517636956t94ig8463
X-QQ-SSF: B1000000000000100F100F00000000J
X-QQ-FEAT: /A5Igf99+LQL7KWTkWlzKXjnqcStAA5jcrKCL+LGtAhqBJUncnKhAdiY0cXJt
	EmNCxsw8yOeIk+r5kn5CSlM1cDEKlo5lnNyXfxUxYAsVhaKGE/pqrktO7TYnwJxHmG5fR0r
	v3zZnvHrXN1VBLnl7sulkHra2u8q/X2orKAVMmTvN88z470YZn9JdDqtTros1E73ZvEkB8Y
	coKuJ333meDueHFhKGQuGT0vYn7MAeHdjGMbcX0YEkphSCWJ1ZeY4P8THfSQMGsJhJ/x3Tx
	PqOfOP+US8Y3lg
X-QQ-GoodBg: 0
From: 540263207@qq.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Laura Abbott <labbott@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	qize wang <540263207@qq.com>,
	stable <stable@vger.kernel.org>
Subject: [PATCH] remove raw pointer from printk message
Date: Sat,  3 Feb 2018 13:48:19 +0800
Message-Id: <1517636899-5676-1-git-send-email-540263207@qq.com>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:qq.com:bgforeign:bgforeign1
X-QQ-Bgrelay: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591357695929879269?=
X-GMAIL-MSGID: =?utf-8?q?1591357695929879269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: qize wang <540263207@qq.com>

The set_real_mode_mem function always print a raw kernel pointer to the kernel log
at every boot. So just remove raw pointer from printk message.

Reported-by: qize wang <wang_qize@venustech.com.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: qize wang <540263207@qq.com>
---
 arch/x86/realmode/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d101058..d76a138 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
 	void *base = __va(mem);
 
 	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
+	printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
+	       (unsigned long long)mem, size);
 }
 
 void __init reserve_real_mode(void)
-- 
2.7.4
