Return-Path: <kernel-hardening-return-12292-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtht1ZQYVTmf80TeVEyCA7FD9LKORO6skOxn4HTheB+tSn4uOV3cxJfQbsWoNyGAmsbVZtx
ARC-Seal: i=1; a=rsa-sha256; t=1520571513; cv=none;
        d=google.com; s=arc-20160816;
        b=GhLJ16ueobTcfzmkuyR6Vd9n9kp7t4eaWPF3m7O3vNvf+IzZKTeqQgpDfn0ErjGfPh
         T/RtlBQRlVqGd3D7TzfWtEEIo2Ix6YmMmAFYMiFhK+aEGRVwywu78aqTxlchw0M1MWv3
         CnQHKZR5mATnW8LcGDT/xttMh5E2bwb+eHeOcUF+j+PNEISOH9BorWNpKWSO2+uR96uZ
         UQm6NXYG6bjO0NLBHZzdrrmeojgpgvZZ1wjGMwD5KsSyyCtSX9w9Id+gIZSZPuTt2/m+
         YspEQYq6z/DDGivzOwNklXVh9MMFNu2hodPea3ZoGxfTdcZNdwp6ee+fl15oTggcS4r8
         s2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6vFLFqJvk1ZYZdauxsvBLtT9aqOn6FPXOziAxl6e9xE=;
        b=OvbkF0l634ATUwfeD3zTPIjuv6oo4RWNHj8J9JTaFkaQaEW3+BhttB6prPUVWHThZR
         66vFD/ZYWAvn2YXvpJZSWZCljK+AvkxUo+NB4v0AW8hYbaZi0yo8Mqe7IlLrYb++POkX
         aTcraJ9OpSVkTsexa2IUw3BHjlnstpl+FLDmqtfDCTTxedUQL4OW9J5LanPGhQ7HgYbA
         qXeomU7d+oUOLdNtTTv9OTA/FdtgrNCKsoDt3FtpLL6GVDWpszNHzvJQGDuCO/5eL1OT
         7nnEdSENSTktAe6P2GFg+A8SaGiYl/ommybrh9BtUHFxOwRIef3FMGksG9XR8nyax0Oi
         /Hww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12292-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12292-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12292-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12292-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 22:58:13 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] power: supply: da9150-fg: remove VLA usage
Message-ID: <20180309045813.GA11964@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euA6g-004IkL-IR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:32796
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594434794789187138?=
X-GMAIL-MSGID: =?utf-8?q?1594434794789187138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA usage and replace it
with fixed-length arrays.

It seems that the length of array 'buf' will not exceed
DA9150_QIF_SHORT_SIZE bytes (2 bytes). But a fixed length
of DA9150_QIF_BYTE_SIZE bytes (8 bytes) was chosen in case
this change in the future.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/da9150-fg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 8b8ce97..96893be 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -92,7 +92,7 @@ struct da9150_fg {
 static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 size)
 
 {
-	u8 buf[size];
+	u8 buf[DA9150_QIF_BYTE_SIZE];
 	u8 read_addr;
 	u32 res = 0;
 	int i;
@@ -111,7 +111,7 @@ static void da9150_fg_write_attr(struct da9150_fg *fg, u8 code, u8 size,
 				 u32 val)
 
 {
-	u8 buf[size];
+	u8 buf[DA9150_QIF_BYTE_SIZE];
 	u8 write_addr;
 	int i;
 
-- 
2.7.4
