Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711329-2-2306368710494452383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711328; b=cpkM6FgigxVwvV1L6tHlHbTBQyDpZiyiGwIY41g3wguPjQG
    SYNCZmhATML2M6eOBBQ+7Wvp/2F6jM6lxX4kCkBaqXutSszHj0VtpZTb/AM7TNYi
    2c86zvGq6AvhB6bvsClfkkjzAk42FCCDd71OPzCoZESn8dBO9WfaaoKGj8b8VJk0
    aLHWIlpmiGCoKY6RgLJ6ClI+W7T+H1EePONpZC/RT3emPaFUEc9kEGaOVJR+TViH
    23zPJbCyVyW1p4xRBpeewF2ywn0y1mftGviLuZPxaRBQ0yhvCh4ZYdYvMLd7Sdda
    y7FmHvncb0it0ZROYN3Uc/JjMIyT0l6MpQQr3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711328; bh=OFuEkDtMaVoBS23I8OMq2CMwnU
    hW+6/tzyebb43u+30=; b=mR7/hhQmwcfycgT6FByL7kAwQBuVAtbd9igO7LJDFk
    Qdx3D8KD5sJHKXQItx5kB80ITriVtKxK3/bshajefnZYFw7L1SOVhg+Ay3sCDoze
    /Udz1mx6RUaj74rz/xpQcGXuyHE+3QFAcsmyWpZpJsgdonAoMj3jiiJB0rJcdw4N
    4k/WugB/f3bLMiYg94tBoCHTTbzeuHHiXNulrevpDOA1/EqOyzVwsTmIWd0Vvh/C
    k7hKScJeI/g3vMUOK6TxHOP4KjvhFVPX3R+l0yhdIdbDPTfI6atIXhFoOSi9+mKW
    z/hR7YexrgpqQyNk3CuwOE/o6gRG+ad7xoF/b6wLkBPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165512AbeBOPoj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:44:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165417AbeBOPoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 084/202] [Variant 2/Spectre-v2] arm/arm64: smccc: Make function identifiers an unsigned quantity
Date: Thu, 15 Feb 2018 16:16:24 +0100
Message-Id: <20180215151717.855351532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit ded4c39e93f3 upstream.

Function identifiers are a 32bit, unsigned quantity. But we never
tell so to the compiler, resulting in the following:

 4ac:   b26187e0        mov     x0, #0xffffffff80000001

We thus rely on the firmware narrowing it for us, which is not
always a reasonable expectation.

Cc: stable@vger.kernel.org
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/arm-smccc.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -14,14 +14,16 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <uapi/linux/const.h>
+
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
  * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
  */
 
-#define ARM_SMCCC_STD_CALL		0
-#define ARM_SMCCC_FAST_CALL		1
+#define ARM_SMCCC_STD_CALL	        _AC(0,U)
+#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
 #define ARM_SMCCC_TYPE_SHIFT		31
 
 #define ARM_SMCCC_SMC_32		0
