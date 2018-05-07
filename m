Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655614-2-12675351055067068981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655614; b=ieavh/e/4cKYBJnm89/1OombLeS3erSKL/AyQLl8y8XBVgaGOZ
    vHZwKMpFbAdg/huUweJ2wjrJ9Dhdgp4298NBiHKJjDJSWvJo39CYGi0z+B1xuYQD
    Y/n8US2YyVEfOnmpfzl5EO/FF9oA6Tre1WMnXdBA9ph3XS5dHDdvUUFpvPntcMe4
    7gWGbK3uX+nFK+mUoPk9/YZaNLHm0RI6kKiBprbCKwJH7fGaiURWSjtwh3gYZPXI
    aVO3PyzWvciMfadnNEuvSfSd6btcawuV+KktfbgD19FRJFa6VIKDnuT3ncenxJlz
    EKRtr8uVSJVijGfBOnmAgBeEUeaxXxALTEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655614; bh=mT6j5
    NyDv/K4rCahOa/kFWedCXFQHZ3GvcrOxh8r2rw=; b=lcCmyhsLUlBKdvTLCfxeM
    Zo8rWsiUvmhp/DHO1cIJjB/PwK8jaeusim1EzM2lzEsxH4KIyd3eo1rp43wmzdq6
    uDLA0y++XGy43pO3pOMEv0STTQ0LKVJ+VAQNthDvrQK5/JXSjlg/hEcscrK5qjLz
    wO7lJvHCwJRj+1wBzCHealhq1PpF7JWUCHqda7QUP2PSg9bg1wyRZG7PaYxJHEi6
    cLBZy+I+j0SemYN0M4d8WZO8ZLz+vE1b89djybTZKlWJSMKcnwLbzhg+6QdV9nP7
    ZTVn2NbYnfrWlQgZdGp1kJlLzy5Y+FAUgqJGs3ZMNFsNhVWvOvaqOEIZ0Apbr9my
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=TUZZjm6B x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=G7UVWGUh;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=TUZZjm6B x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=G7UVWGUh;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHqrUBR3M6wOd+8fWJmu7Oe96AeyBfSEvLjj+Om/QC99bTv99jsR8O7jt5WuVpJPGqyc45QS+Yuy9irvBh3xUqz6G/NgEN7MDdq0j8cCmr5KQwgM6q8
    VpvzMZEH8vtjwYrjc3FUgKdQaV8QtN59bQOZXkuuYgyk9Wjq7xcRmvuLJAG3CmXibwzje7dvus9bKDpTbqopf5QE7gY8w5X18u1UCVVYgVBHWDOVLVcf6ZXB
    5+jHIOgyle2NYg4lFa7ztQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=s2nohfGutZ3XZZZy17oA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZo1LxBlmF6CxkOd2GIeK5/onQqrEMBbmTotF4fQ2DR32/+TYEH3EGWQIl9dvIjMcC+UCB+xnA==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 1/6] staging: android: Kconfig; Remove excessive hyphens
Date: Sun,  6 May 2018 18:13:23 -0700
Message-Id: <20180507011328.11982-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes the following checkpatch.pl warning:
"prefer 'help' over '---help---' for new help texts"

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/Kconfig     | 4 ++--
 drivers/staging/android/ion/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/Kconfig b/drivers/staging/android/Kconfig
index 29d891355f7a..17c5587805f5 100644
--- a/drivers/staging/android/Kconfig
+++ b/drivers/staging/android/Kconfig
@@ -6,7 +6,7 @@ config ASHMEM
 	bool "Enable the Anonymous Shared Memory Subsystem"
 	default n
 	depends on SHMEM
-	---help---
+	help
 	  The ashmem subsystem is a new shared memory allocator, similar to
 	  POSIX SHM but with different behavior and sporting a simpler
 	  file-based API.
@@ -18,7 +18,7 @@ config ANDROID_VSOC
 	tristate "Android Virtual SoC support"
 	default n
 	depends on PCI_MSI
-	---help---
+	help
 	  This option adds support for the Virtual SoC driver needed to boot
 	  a 'cuttlefish' Android image inside QEmu. The driver interacts with
 	  a QEmu ivshmem device. If built as a module, it will be called vsoc.
diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 898e9a834ccc..c16dd16afe6a 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -3,7 +3,7 @@ menuconfig ION
 	depends on HAVE_MEMBLOCK && HAS_DMA && MMU
 	select GENERIC_ALLOCATOR
 	select DMA_SHARED_BUFFER
-	---help---
+	help
 	  Choose this option to enable the ION Memory Manager,
 	  used by Android to efficiently allocate buffers
 	  from userspace that can be shared between drivers.
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
