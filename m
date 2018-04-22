Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405610-2-16580954725391868481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405610; b=o1eVL/YdmrVj0DO+2C3DRCwe3c/q545cWSU80UAECZTjoTrS0D
    gYdv14PGLG75PtIgPplDeoIg0z/z46yWT3p9jUpQ3ksCvY2l9ftwp3ariOea/Yt3
    L1pHKSNUhIJpIG+VxqV3nPhGLXfbmfND4pXSVn1haJMe2Yq/fVRoSwBj0ox6TFK2
    fMAo+uXyp26sI1uakJRjGNjkrKAbohRyNNuRSQuUfU9y5zTJOtsGY890VbaF0TLG
    vp++Fi+YH4J/AGLP7LvnrAzCzoaBrMedhHD8Yxw48jFD++sWLXKGgGhVftGw5usb
    eaR/hTzcVJuFsdcIaeZi6UE+mJvsHVvyYCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405610; bh=ud97Q2X8kneWRZykO4SQLjBcJ99LHA
    VW8091eCvB3is=; b=RMALi75RzdjwXOu1JN+p8OMTHT1Mq5wD7OLWHhoKdAPgmK
    Vsn+mIaq53LGQBpS3UPVnrNueWNwXIZK0Wo6ylowqF+hLwAKTUWK+fEmwXI0sAra
    1u4eVxFYeg1quESkaO4q/EKvWedusMfyvC38LUYr2fFCTRrwr98kmtaC7VX6h3aK
    8gCSW2YyI3ruL102gEvifl/91faof8o+oBjWJkfE9myVOTFDii0yS5TeuDxY01Mg
    008QwMtgQk4tMeil4vKNwmF+ZaH1omv/0UnAc61tP2+q9JDJvdhEmqf9/ljPMhm1
    PuH2EE+gFb5VVpc11sx13Pp6YAErccSVkfTQFvBg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGQLvTGulOYizvjAqVweJxV4QJtX0So2TbwAx5+nzFbq4iX37yM2JjM7igdzHM4rRqLd7bxkuck14XVFZLK0886692U6jtinqxSUDKuM4D6M32rxhop4
    BSfQ9ssU+feLIXHnr0myff+sko0GLFA1ptSVLqAvUSxepzzgUXOUVpuQsMWnbh/Koka8kycOznuTelb+QX6Pf3fCwab6NJ9M/9GxsegV9t4pby4vPDocX9rf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=UGG5zPGqAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=6gMf1AXumo1VBV8RC8UA:9
    a=QEXdDO2ut3YA:10 a=17ibUXfGiVyGqR_YBevW:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754464AbeDVOAI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:00:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeDVOAF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:00:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.16 128/196] um: Compile with modern headers
Date: Sun, 22 Apr 2018 15:52:28 +0200
Message-Id: <20180422135110.879954812@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 530ba6c7cb3c22435a4d26de47037bb6f86a5329 upstream.

Recent libcs have gotten a bit more strict, so we actually need to
include the right headers and use the right types. This enables UML to
compile again.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/os-Linux/file.c   |    1 +
 arch/um/os-Linux/signal.c |    1 +
 arch/x86/um/stub_segv.c   |    1 +
 3 files changed, 3 insertions(+)

--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -12,6 +12,7 @@
 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/un.h>
 #include <sys/types.h>
 #include <os.h>
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,6 +16,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
+#include <sys/ucontext.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -6,6 +6,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
