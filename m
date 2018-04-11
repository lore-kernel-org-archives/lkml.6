Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479869-2-13027370670784880958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479869; b=qqKtClTR73mWDY9vKDPnyp3pl4y3baCw1CIk6FS4dOvBdRNsjS
    0g8NzaKJDP7/NdXHbl5tv0yUcPKnQGa1n1bKvL9/od+1G/jeMHGU3qiEL65FI3i6
    iUVLYgCFBto66+DKZbxKZ9tLy+MYXSybSkKFswryV9lSxEgxzdnxnqnltonRE8lF
    QRqecXsJlA938kRAJLV7rMdKApIPqKv/BC8lY+tqrRt2JW/fT18ceDuaDN6vMPfQ
    PzKKE5DLstJnsc2h6NYYeKKy+3tFH1OnEoMGWuolaVHepkRS2mbx9Zub1GhXXUgM
    CYmB0Xm28lX8FPckgFXgn7rBXRCk5UgdYHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479869; bh=M+c3tt4+80N+BcnaW3Oqg87HWxl0iH
    qWzHUQSOmjXVI=; b=k3gwULWG0sk74U1b9K9k8/Y0urEnZ7YQRHuOvM3FFdztjA
    +ZfxnlKEWNyCUwOMOKNtGsifgTnWOFznkvybiVcfXdJ/MiiDy6TJB9OOSbQPaHOB
    qHJomDJ7NO8LLnU0sqAJlIpBxOaCddLV+y1bTIgB0AeuTGIXDwU+cw0HgeoZZT5h
    prfvZzj2PxOcrnGOOg4u67xgQG6Wlv4kvQzChTnqyBpV53TFCNqB8uwaKWLfTDYa
    OOFuFNGTNlbsPm82qaQKHFQ42PveFItZQTihOQru8cvTckT624blq8fzQ4VLajE2
    tkS5Wy0Hv9PC6IA/d6FcZc5REtznlVqD025K/9Qw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIHHvbkjs+vp9X3J1g2qtkFODdEc0EKKvVsIpEamp+E3ygudXOjgbKm3K+s+3DntNaSnJlwzMwR/Y6xpZI2Etre/R6W44e9dXRSoZgMH1Np+8SPolOhy
    g2dNLcgMx6wrjKhbezdsu4KDsZy1b6CC8mqPG/5trO4fkNQ4Fz0rOR0C7VDk65Ykc8Si3c1ntx7HInZ6DDY7q+7IIgV6091vv6/6yQL41wfiqxMzOQ+fqyEC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uAS_uZ3KAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=LmmgGHosWJ0mTfuy6g4A:9
    a=QEXdDO2ut3YA:10 a=_KzJdI3Ai4rueFdl_XLO:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755836AbeDKUux (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:50:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755591AbeDKSps (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 053/190] selftests/powerpc: Fix TM resched DSCR test with some compilers
Date: Wed, 11 Apr 2018 20:34:59 +0200
Message-Id: <20180411183553.414119907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit fe06fe860250a4f01d0eaf70a2563b1997174a74 ]

The tm-resched-dscr test has started failing sometimes, depending on
what compiler it's built with, eg:

  test: tm_resched_dscr
  Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test_body: Assertion `rv' failed.
  !! child died by signal 6

When it fails we see that the compiler doesn't initialise rv to 1 before
entering the inline asm block. Although that's counter intuitive, it
is allowed because we tell the compiler that the inline asm will write
to rv (using "=r"), meaning the original value is irrelevant.

Marking it as a read/write parameter would presumably work, but it seems
simpler to fix it by setting the initial value of rv in the inline asm.

Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -45,12 +45,12 @@ int test_body(void)
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-		rv = 1;
 		asm __volatile__ (
 			/* set a known value into the DSCR */
 			"ld      3, %[dscr1];"
 			"mtspr   %[sprn_dscr], 3;"
 
+			"li      %[rv], 1;"
 			/* start and suspend a transaction */
 			TBEGIN
 			"beq     1f;"
