Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938452-2-5150781480209046200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938451; b=Gc0T5+qTl7iifOaBQaGBC9pPr1/XlYD5I87DGDS7HY8ghbxnIm
    ykFOLjUuVSNK1I+azk1yz4iebHY8jSSkLvG49F4C9l7/psnYX52r6vMEkMMtzpVx
    Bzc0Eb+J3w2JEjz0e6XaXim8yjnl9D3cGuWLwGQkFpJOsyWhfL0YLp9zYC7GcWyJ
    A6mDpIq+9SYMywCSXZ6WDDFPwl4cCUt33QAqnZr/3aKin/6eTdINs+VHrb74rwpS
    GuNrX572CQ+JSyV0dWPJK48fgXtVabwfW35n+le2tTQSg636cerVSwGzAtcuWAp1
    ooY+wMldGgXJjl3kGUjZurBT+O6mGtiCDf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938451; bh=YVHyisg3OxkwQReBVlGNDJhiIgYd/w
    Ek+FH1q+Gz31E=; b=UgDs68ORp7pu6jsREztdJDHmQi2VDxlwWVAqa5CB88ey4R
    IEA90PCZxRZ0fok8rtDsXJfk+iaEJqihBeBidn6JlMDeRgebHLvEkqP3+dRq7Af5
    mTo2q11NJRA47PCqhQxM2JvHk3YjEyhJLYbuuKnSFTT9ZQUGQVYs+NuiG2vcER3m
    sd6sK/bBnnGDG9xAB8LfWkn/kEYozMipOITEBs2IBpsGDUcaSIHz5H7NGtd+Bij+
    hWtSRCb1ue+bARQx+HoXHZT74L2UUXwtg6mLLHaBR4v96+Y+radYqvVoiDPXj4o8
    F/K6CjXZoTcAqqHHbJLjPDGTXKb7l2rpD94GDnFw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=10U2GHEY x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=10U2GHEY x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFAFOibquIMbtdvVJeCgfuxoWQc1qpBZMTKO1D89035GGJAMoPKQZIvY72k9KDnmjkYYDQ9VEm186AX3Ujl44WbXs3uSDtAdkPUrHlVTrneluTZqLCB
    HPx23AGWH+wUNRFFWjhSPM5Kdon7/N/mgroRU3jra2CmN2yze2hjMAuqgEKYHPaKoAmE1HNmAknHyufstiSPdBBJPJoRvUZDbIIGZXg71dsCvFxBbjCqGDSk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=3OV-j5Brly1SKWfoiugA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbeEUV0F (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeEUV0C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 089/110] Documentation/spec_ctrl: Do some minor cleanups
Date: Mon, 21 May 2018 23:12:26 +0200
Message-Id: <20180521210513.908478454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit dd0792699c4058e63c0715d9a7c2d40226fcdddc upstream

Fix some typos, improve formulations, end sentences with a fullstop.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/userspace-api/spec_ctrl.rst |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -2,13 +2,13 @@
 Speculation Control
 ===================
 
-Quite some CPUs have speculation related misfeatures which are in fact
-vulnerabilites causing data leaks in various forms even accross privilege
-domains.
+Quite some CPUs have speculation-related misfeatures which are in
+fact vulnerabilities causing data leaks in various forms even across
+privilege domains.
 
 The kernel provides mitigation for such vulnerabilities in various
-forms. Some of these mitigations are compile time configurable and some on
-the kernel command line.
+forms. Some of these mitigations are compile-time configurable and some
+can be supplied on the kernel command line.
 
 There is also a class of mitigations which are very expensive, but they can
 be restricted to a certain set of processes or tasks in controlled
@@ -32,18 +32,18 @@ the following meaning:
 Bit  Define                Description
 ==== ===================== ===================================================
 0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
-                           PR_SET_SPECULATION_CTRL
+                           PR_SET_SPECULATION_CTRL.
 1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
-                           disabled
+                           disabled.
 2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
-                           enabled
+                           enabled.
 3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
                            subsequent prctl(..., PR_SPEC_ENABLE) will fail.
 ==== ===================== ===================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
-If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
+If PR_SPEC_PRCTL is set, then the per-task control of the mitigation is
 available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
 misfeature will fail.
 
@@ -61,9 +61,9 @@ Common error codes
 Value   Meaning
 ======= =================================================================
 EINVAL  The prctl is not implemented by the architecture or unused
-        prctl(2) arguments are not 0
+        prctl(2) arguments are not 0.
 
-ENODEV  arg2 is selecting a not supported speculation misfeature
+ENODEV  arg2 is selecting a not supported speculation misfeature.
 ======= =================================================================
 
 PR_SET_SPECULATION_CTRL error codes
@@ -74,7 +74,7 @@ Value   Meaning
 0       Success
 
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
-        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE
+        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE.
 
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.
