Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x224Q74AKO1UyUxdCA07+ICZoYHRbc1XO20yFwJIV2yFMhCwsaQUPzcryIfCcvttQ5epz5cXR
ARC-Seal: i=1; a=rsa-sha256; t=1518742726; cv=none;
        d=google.com; s=arc-20160816;
        b=K3jwHozT7QZcSiuOsL0p7haFKlLZfn10fJg2UaAvEqpeakHiKJFv+rFt2cakxJyR6A
         B9XMwQKbLOfK/lMnSi0dH/nf8Voupcec9/dsczJYR3DYVEJPKSiMBFAQnYoxQqf2H9pJ
         vpkv9SfA16z+YTiZnE20/vgTqaDVEcjFl5MQYvdFE5yvcFCDUNVHOt5p4oVt4X5D2azB
         13vDseM5JULPohLMWdieaC6mhS0rY4fPCpnabYmJ9QG9EMvq2JBGult3szizXhECsQ4X
         wnAZYek8oDnLBHjjTUmTpc6fH6DFqLdhFukieoUfUFJO/JawrF0VC2tDkmfOdK3sLsY4
         zOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:dkim-signature
         :arc-authentication-results;
        bh=Hyx3IXCKaxao/+OPIvsr4Tq6uPY5NaMqG61WGQJUVj8=;
        b=l8MSEzzY7wU9B2URjU4GhYI/F+CV7Bw8TlLwmUsNF4whxaV4FeTW7lgw4N+cswwQY9
         gcIuN7ghSAJI2gac3lNID0uA3+YPB8ab4Evhx2C/hnLw+tH1VNoMtHV8gSsdscArrRsM
         +1XkpZmjDNFD8KPxWat98tduWn9cVWvhfhjJ2fc9SPkFSKxXIK4e3WI7XNJHpst9JGp7
         JAK8Ew3BEUgKOtuwbWmeljLBUeJ2q1xt4mIv5IBW+eA9UIQrGNu8Ixzu61RHjWcD2wR4
         yde9qsdmhHuD9gGOL1NPZHAusFh3/cz2cBWwMkAWeibYmvpehxcF2UcRIQ4xMotaZpp2
         87yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=c1q0ivgn;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=c1q0ivgn;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
To: LKML <linux-kernel@vger.kernel.org>, Luis Rodriguez <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Fengguang Wu <fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] lib/test_firmware: add header to prevent build errors
Message-ID: <d33eacf8-3440-3ebb-12bd-53c50ba07935@infradead.org>
Date: Thu, 15 Feb 2018 16:58:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592517173580789766?=
X-GMAIL-MSGID: =?utf-8?q?1592517173580789766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

lib/test_firmware.c has build errors on some $ARCHes due to a
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
v2: fix typo: s/vfree.h/vmalloc.h/, reported by "kbuild test robot"

 lib/test_firmware.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-416-rc1.orig/lib/test_firmware.c
+++ lnx-416-rc1/lib/test_firmware.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/vmalloc.h>
 
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
