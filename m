Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1443453-1524500532-2-1808486545562132942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524500532; b=lPje7r5K7OsO6qbffTpSQ6rtwT4Ga0GAFO4ynYRsCOxEVXIJk/
    2SPy2LZt54RFl8MdZ3L0wjDnsr6B7M2i85egt59CtIOs0xhKeAaebdvxn/nQ9pmB
    7Jo8EksGR2akts31xOZLhX+jMDNF09V2kWZxu7oMfr056up/rrbO8+OJ0D8iTAdD
    qN/KX9KJhmyONJSSqQw9rX9i+uN89LQ1FG53C1fJOOaGnQeHHFBrFYHTT4qS79L0
    2pxijzA2YyGYuLgx3TR6/+V/6jNSUMzBHMuXmsoF0e/soLS4FecNKRFVZy0AK7f6
    k5CD+I3g4VxF0dTQThB4Op7s8Ur64UB3Z9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524500532; bh=dlolB
    RLt9AxDK6M5yzE+7OOViNOnyXj7z6CjDDe6rtQ=; b=tQtD4Z3fmDSx5XT9MbyRP
    hmcpLtH8Jtx32IrwzhUx3J3IbhiQL4QbXJtPovBF9fbGviq8sF3CzpeQ0njtoq8k
    BPuRlVtK6ntuBY0FC3XzJf+dxWajRXnpw34JrSlojXNrwZhLkJ7kFO67Ukq5WeBc
    JrS+ltT6Z41KI/wH3yX6YFu1f3aZO+7UKJbvGXFZTUR71NPo4rYel75AJC/iLGIG
    w5jjpINTHNnMKzsUyfP1vIP/VwSKIOyEYPPBnBTF1gQwj4xIHeVwFLWvAbGOab+X
    G+sfV422xO+zx/r3GXtlUBJh1n1gTdjBdzClu3kXEr4Y6jtY4Odnx8GQkTRIuFkn
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KdfBywc3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mA1ZTufS;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KdfBywc3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mA1ZTufS;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGV3H2nlV1lrMum6HixxzDLlJfBtMAucTIwYwPiqrQzCojgCcvLYwOrXlE7MsTLgznL2dlcsWbLQnk8wPU0cZ1bpa15YsrV5vthHGenpsmyEyfSuFRzb
    QanQw/hcp1GD7UE0uSD0fiA2LVOVTfUEsePWtwF/u0Gn9sqk2DnLuNL+HqO9KjPBM5ITnfw71rqXyAp2JSVqFFWUchyfVXWJ1P69S03VyTVCXo52GzLnAfSq
    79kJEXp/QrV5I9krdZ42ww==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=TjV95GAluLwA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=8zPXO_9SzBPc6EREmFcA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx492mvk/VdCXckjIDn8I93rpo4F1TiWhcRG+GJz+HAwG85Tv50fg7b1SAOLMbHcaeGe+j6kD3g==
Date: Mon, 23 Apr 2018 21:54:00 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, willy@infradead.org
Subject: [PATCH v2] android: binder: Change return type to vm_fault_t
Message-ID: <20180423162400.GA4018@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler in
struct vm_operations_struct. For now, this is just
documenting that the function returns a VM_FAULT
value rather than an errno.  Once all instances are
converted, vm_fault_t will become a distinct type.

Reference id -> 1c8f422059ae ("mm: change return type
to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 15e3d3c..65be4ec 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4671,7 +4671,7 @@ static void binder_vma_close(struct vm_area_struct *vma)
 	binder_defer_work(proc, BINDER_DEFERRED_PUT_FILES);
 }

-static int binder_vm_fault(struct vm_fault *vmf)
+static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
--
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
