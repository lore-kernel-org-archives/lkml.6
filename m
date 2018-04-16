Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3502703-1523891376-2-11049259307348202204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523891375; b=qoWOalBVkrlLPFM4+RX5Dgty+ukeWnWduq2lVfbSnvHW6CuyN0
    z9RKu/F6Xf7btcLXkE1NYnJ2DwyUho7QKY2KaysUJs6rXeTpdWXaIVrhA+0TMHoz
    P85YYaYcL+4XClD3xAgZDm9BfPb16wfe5YKL832MsV98O98WGhuT8pyUkopZwquw
    GrpfuG83ySsZXqvLGaT8HslzBNPLcDeoJONtd4lsuw73ChE9s/KuiM2XQCYwsfzk
    pOAoV6T7eA6HqUXe1AeIMyWlh4Q1vSz1AToxvR1UhV83Y/MVV40o9ni6lDc3o4sU
    uqI/yi/pB4mEK986AS+9MjXNxuxe87ZsbQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523891375; bh=soyJS
    kZzZJiCNs6HC2oWKjC+vJyUQXfCDKC208Yp+JA=; b=eq7ga6DTd7bgfG5Hd1SMa
    WN32zSnqYpP5AgIPPGanX0Nzem6KMYx0sb/cqAVxX/x6qVm8zM1EcsXvzUj5KpUt
    YCWwwN6CV1tBU/StfCQTXjYjgJR3t5knA9i/V5nPLSf2Wm+GnCzevmLuSjgHvqC+
    3LPxIZEsDUhAssPiv5Jz3J8FEX6qZYXs/dycF6JVuR7+hdK8fzogKjtGYFjPIn5Z
    LbwXM8fGYDfg9rtgkAIPVOzgVtlBNweyjEKrVK8SkBzUYoZl+yBx4v/PpCYRbfRW
    Bq5r8wfEbHEV2aHjtACsvt/3gy25BblQ/8TPFZZPIlSeYtYCRHv8Wyvqb68vBrva
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Hw7hcn7k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h+qHvilB;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Hw7hcn7k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h+qHvilB;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGB0jDcXgmrg+wD/eXM0qnjEYitxAtcHIzPkB60Y+QFXL+RhhaQ3Cs5KPibLV+7Yw8YSy3ApoS/CuQncYaxQSbh7eDz1z3CbEAA+B+k5roB6Jx+OpQvc
    uPxwfvbj2Jpb9kVwK5BAxo/Zu9VGhJpy9OEse4CtUOncZRKkH5zVNzUFMGXOSmpt+LeZId25bzhYzXs4jLb5HRme4YWUUhkVpwybrSyr8y8i55APDU9CBk/X
    yHUGhPY4Sx8Hob6ASg4ZHQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=TjV95GAluLwA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=nKdChVV6WI7Bv_97Fp8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/E6O0XE6dfB06OlZAVnB8wIeX9hDkUDnJnMDiHxCgh/VxvyfISggAzwcE1RqpViAo4G3DX7g==
Date: Mon, 16 Apr 2018 20:41:21 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com
Subject: [PATCH] android: binder: Change return type to vm_fault_t
Message-ID: <20180416151121.GA26791@jordon-HP-15-Notebook-PC>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 willy@infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a 
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

Reference commit id->
1c8f422059ae5da07db7406ab916203f9417e396

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
