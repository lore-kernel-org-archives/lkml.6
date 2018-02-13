Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x226nrdTHOnSutld5zsGiX7AVgfr2oFqGMGPgjbnZc0tAhUjMBCL/FlB+LjD6PqULdQHO0iS7
ARC-Seal: i=1; a=rsa-sha256; t=1518485089; cv=none;
        d=google.com; s=arc-20160816;
        b=FAa5vFlCJPEG2CTBWMBgX8/+YBTwCJgnSp8c123NGbfAp5jL0k5fipmibZY8PQC23j
         ZPLqLJWVP5q7GbWmlOasfQXQ2ljM8oymfLNhwcdy0c/X0D72prmLSGgHeIQRhf54CPb8
         3pxCcO54PMBORBZeV/iQ3+VaufzSPRx2RCfaE0zp5w3S67TGO7lGBQWZCyB1Ssd84Dnh
         7Rggv4mrbqyEtrMNiOM9ZV9nJpczw0sHl+YxWgvDagycm2LctchimTqRmNRWWq+5OK5L
         fL8l/GgqJ7ecscgT7wVsfDC6JfU/TM1c7uBplJjSXRf4KbQeTPUDXQRu+WW+p3KODMYf
         j6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9bnV3yBOKGn6lYwcnCmkqTxobILAmVoYrAelFwjeYlo=;
        b=vqwDSdKc6wo98G3xDiBi7sFFwZkdbbEUmwMzH7aN411kLd5mZi5aW/OGjPuDNb4z6I
         bpgV3/xWf1ogS5VrrDNDl43aGX0LHVsswPxaM4uHI1V+ecj5rYzALpz5GNW0KUfPgmoC
         VdaJ5Wy6sGA+g7wVegRaakg3LPgEjSIiOwwhvPcbcJCBrV37SywGohDQb6FkisGEd47g
         VcFY+nA9Fsw7c8IahEOJfoOtpyH3nB5QuEebscWWgqLBx7Dx8yh2/scx7/eSQ9hFmuNE
         VZqu0yEP1AFUQ6VHUUtMaoQ2sqQl5oid2izBRaNldZb9DTApbWrRcxWOYfljOPbCbEaC
         jhYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Mv9BZueB;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GB7X1EW0;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Mv9BZueB;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GB7X1EW0;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Wei Yongjun <weiyongjun1@huawei.com>, "Luis R. Rodriguez"
 <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/test_firmware: add header file to prevent build errors
Message-ID: <5664ced1-a0cd-7e4e-71b6-9c3a97d68927@infradead.org>
Date: Mon, 12 Feb 2018 17:24:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592247021316003236?=
X-GMAIL-MSGID: =?utf-8?q?1592247021316003236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

lib/test_firmware.c has build errors on some $ARCH due to a
missing header file, so add it.

  lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
  lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
---
 lib/test_firmware.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-416-rc1.orig/lib/test_firmware.c
+++ lnx-416-rc1/lib/test_firmware.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/vfree.h>
 
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
