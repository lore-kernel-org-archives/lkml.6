Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZrzR1bfdCmIjesbNvWsdSE53ljkCOeLKmxwiHHuW13RVMoH7xfSoZ2S7d/4GduqHNKUwN85
ARC-Seal: i=1; a=rsa-sha256; t=1526350976; cv=none;
        d=google.com; s=arc-20160816;
        b=zS1evjSmramZRgsizxEQi6UIELvxUyRL3Xts2fIoSKFF6bCVli3xUZ6IsFo6iUrVeE
         xQDLU6KrJDSVpsRzf/swV6skDPVT8sFamEktZHGuyaLBSA+zHabE/+zvew6I1eZbuhrC
         7WykA+zUga9mffcTKNaGXv8XOIJ378Pw7rAOYZ8WW66+QvIDbN4zChcd8haIZRxFGibu
         RqNo9FwY8JM9kfWl01qB/AzrGxruPhcNu5ckZrctQvzNbSRg46xSsDqU0xvoCfhVcfc7
         8V00DBICb+K5e6uq2k6rQVRsx/+qPmazDid6cJaPl1ykbMxYCM79SM1Q53O+zA2gXW+7
         6WOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=UF+Gpa4q4xjQvULts7NW+NpmdolTsyJ90uLestxfclI=;
        b=NSFpoOsGWE6iBWla4sHkxqtSFlKNUJJRWtZYFfxxPXULPxT1RhgCbYb/00vUFNB8R6
         SQSQWkNSSMy2AxXe1y7X1bXpKSeoLPERl/kqU+4otaXoeOEgpF5rarg59nWrAdGwTxq5
         s2yrcvpln5de+Ly8Do+HgEFs5y6Q5Y2Zrcel2tP+sWeIOzWmE28Cck9/VTV2TEkwjAVt
         3ZXqZopS3kVtmEkD2nKgxCuGI7PEKhxjnnOrquH02weriL+G6q4RQvNsEylsx+4f8quH
         WRI2WL7EW+7toV3B9TWVYraNwZ64d+lpcOZShjzMDYodtISwMZ3l6cFVGBNlIkxaIm3v
         gFgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ZoJFuJzL;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ZoJFuJzL;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4F2M8PI020933
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lihao Liang <lianglihao@huawei.com>, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] types: define aligned_ types based on uapi header
Date: Tue, 15 May 2018 11:22:04 +0900
Message-Id: <1526350925-14922-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600495001042384627?=
X-GMAIL-MSGID: =?utf-8?q?1600495001042384627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

<uapi/linux/types.h> has the same typedefs except that it prefixes
them with double-underscore for user space.  Use them for the kernel
space typedefs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index ec13d02..be15897 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -115,9 +115,9 @@ typedef		__s64		int64_t;
 #endif
 
 /* this is a special 64bit data type that is 8-byte aligned */
-#define aligned_u64 __u64 __attribute__((aligned(8)))
-#define aligned_be64 __be64 __attribute__((aligned(8)))
-#define aligned_le64 __le64 __attribute__((aligned(8)))
+#define aligned_u64		__aligned_u64
+#define aligned_be64		__aligned_be64
+#define aligned_le64		__aligned_le64
 
 /**
  * The type used for indexing onto a disc or disc partition.
-- 
2.7.4
