Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938470-2-10434671115372992477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938469; b=NKk4Vhs9vIVzCmkraqgYZTk8E7Ze+QE2XCFchukAgCU5lP6Mff
    sIvRmgM7PD+m/DUxvOOGQFYWts7OzuAtaBx0oCiZ7LMZ6PHCmkEZoVsWSWtsGuup
    GV3gwu7t9uTMB+E/7skJC++1fwh5yccZ/r6Vmcow1GfiCOmzaDX7j3FyIzXECQNv
    upbRMs1We1jpU5k4KLpaQtfAt4C0XVyJbmarwHpW6vGIWKgEpDcxuO2FshVKJuay
    m/vU7/WzFyEL5gT4j3Rl3vGM764nshLZwBysL+jnlH9AzzJKR93Z/uvEMIdJYGXB
    9O7cesfirzngrTrxNKaZFYnUjfMBlDaId4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938469; bh=VWd7V4hL2waJz75jDHywMpUS0IktWC
    CgL3SLnPiVdfc=; b=abLkWl/IWu2Uxd3HcHOLadLiBcxMEGxteNU3RiCEHziUBN
    xbtcfArKlu/qCDjYx2YeLAdt5WaxE/0eWMGCmj3t/6gtGZot6mOOOLa7nVJn8poM
    zGLPR3opJR4Mrt1z5flajgBcrnnKtKWf42KYZHx0CKiactTexs05OBTdf0/xZiyO
    tj533P7gBqpVswHMW3Nc6qrMIhz9DknAQPe93YdPoZK0WqPwqogtej2GjBnLCl6G
    nqz5JYrbdDdAhMg6yOZBM1DsYIiRKf6vPkpcoou63GlvmYLjSPiF8Zp28nMgJsIK
    vPP2kUoWR9ztd4fmwJ4Ai7uHLDi9IEy5QvTSsxBA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xdm7n4MW x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xdm7n4MW x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfC4jgMCtZUHdkF9u2UmQuAAmUU2zI2/KCOHg7qtV45aHZAN35zhXQ/eIKToISxfhGt7exf0p5PJG9ypnw0u1tV935ftz4HIzY+SUQ/dz7/jHF5EddV+j
    87qVeBLmjkeSVnhSb8jOQhKyJRsi4c7TE3R2TWADtJgRHT6BgTtufol5PY6VldiYyUmd3UY0C1s6UEbxU8mAx0B5TCsyL6Lx2+00il2Ojgp45ugwnzY9wSj7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=_hPQj-9b_kpJJmlC3esA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeEUVeN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754427AbeEUVZ7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 088/110] proc: Use underscores for SSBD in status
Date: Mon, 21 May 2018 23:12:25 +0200
Message-Id: <20180521210513.865615681@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit e96f46ee8587607a828f783daa6eb5b44d25004d upstream

The style for the 'status' file is CamelCase or this. _.

Fixes: fae1fa0fc ("proc: Provide details on speculation flaw mitigations")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -348,7 +348,7 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");
