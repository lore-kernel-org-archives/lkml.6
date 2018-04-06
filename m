Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021410-2-4197228116109561693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021409; b=rSPUgNQc9VGnfpXBpcClK5qnKEbflNE/HE/L//v6RLwy1DryKG
    3cGe/ZVj4jXxV4ThHy14sph7JMpXhKXbXQSl86KwPaVe0YqoBpPHe7fiRwBjfokz
    eVNpog0KkRtsN8Htx+AbblEuwTsGKnbmtxICHXhHoQEQ0aXb5KEDWZQvB5NeJszF
    GHaMeneaMvUXO6c+RK8pgjIBBSeGoFmqx2S/dk9PuLb9BM72PWlSmBYLV2rkCTBO
    faQOg8iafGH/mhFvXywhhiK3sapoBvC03y7LcRbj0sFLmUCdLCdYkkPNHXwwKwkA
    F/c0NY2DFd/7AUaf+dTAuNYMik5ryr6gPKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021409; bh=Fg4IHck1ti/jOhHFz4aFJEsB+zSFrQ
    MaxUhLFoMOQ/o=; b=IXKY7pV8f7tNTb5zQktNw8Hoa6uMfBo9Z+rzkGJSJIbIq2
    j3xjalxj9nLLoK9WIwKDohNR0gxseHBxMBHXHt3QWkt8Z8HROwp2bNTnswa8NCo2
    JOjoteaPp6mql2OsXHw1GsN3dHEtwOWZkadv5NAahIlRFOc9/jaeRLUqXypKjntM
    p4P6FHytV1Qgx0deVgXWO+Eao7JfsDe97+Q9R+xkW19t6SzCsklZX40w43ITaDL2
    HKv5U3Udga6eoMml6/+3P7EiM+czVvPmMc+ASh6xIBMnzsg5K/WhBDuUP3adDvqh
    zVdU/g6DoZ+yX/xnuSoIgT0tcjRNhprKY2S7KgSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfH3qAM/eG/d2gqOHNVitW2z0/lVcppW0hGmhP2RnrStzoTuFIsAueEdWX8BL4v0KuOpYIZaQXUorbJ4pMMhNAO6IYJi8/q+4cEwjsCD9iOtrx8agwdPb
    9sI/myhh1h5oVoWRfqemqyC6SbN2Kj36/ZpEPHDGeNdcg4PmZUpeHi2cxfBbGnnf1gCH90vbXoLBRJ4ZDsZvkplmP3cVGu+yCZZNULT8eSUcDGnUd1D5VhfH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8 a=A3xH9LzkBM7WnCX5nYAA:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
    a=nlm17XC03S6CtCLSeiRr:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeDFNaB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:30:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbeDFNaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:30:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 23/72] frv: declare jiffies to be located in the .data section
Date: Fri,  6 Apr 2018 15:23:24 +0200
Message-Id: <20180406084307.092765136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 60b0a8c3d2480f3b57282b47b7cae7ee71c48635 upstream.

Commit 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with
____cacheline_aligned_in_smp") removed a section specification from the
jiffies declaration that caused conflicts on some platforms.

Unfortunately this change broke the build for frv:

  kernel/built-in.o: In function `__do_softirq': (.text+0x6460): relocation truncated to fit: R_FRV_GPREL12 against symbol
      `jiffies' defined in *ABS* section in .tmp_vmlinux1
  kernel/built-in.o: In function `__do_softirq': (.text+0x6574): relocation truncated to fit: R_FRV_GPREL12 against symbol
      `jiffies' defined in *ABS* section in .tmp_vmlinux1
  kernel/built-in.o: In function `pwq_activate_delayed_work': workqueue.c:(.text+0x15b9c): relocation truncated to fit: R_FRV_GPREL12 against
      symbol `jiffies' defined in *ABS* section in .tmp_vmlinux1
  ...

Add __jiffy_arch_data to the declaration of jiffies and use it on frv to
include the section specification.  For all other platforms
__jiffy_arch_data (currently) has no effect.

Fixes: 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp")
Link: http://lkml.kernel.org/r/20170516221333.177280-1-mka@chromium.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/frv/include/asm/timex.h |    6 ++++++
 include/linux/jiffies.h      |    6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/arch/frv/include/asm/timex.h
+++ b/arch/frv/include/asm/timex.h
@@ -16,5 +16,11 @@ static inline cycles_t get_cycles(void)
 #define vxtime_lock()		do {} while (0)
 #define vxtime_unlock()		do {} while (0)
 
+/* This attribute is used in include/linux/jiffies.h alongside with
+ * __cacheline_aligned_in_smp. It is assumed that __cacheline_aligned_in_smp
+ * for frv does not contain another section specification.
+ */
+#define __jiffy_arch_data	__attribute__((__section__(".data")))
+
 #endif
 
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -64,13 +64,17 @@ extern int register_refined_jiffies(long
 /* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
 #define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
 
+#ifndef __jiffy_arch_data
+#define __jiffy_arch_data
+#endif
+
 /*
  * The 64-bit value is not atomic - you MUST NOT read it
  * without sampling the sequence number in jiffies_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
 extern u64 __cacheline_aligned_in_smp jiffies_64;
-extern unsigned long volatile __cacheline_aligned_in_smp jiffies;
+extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
