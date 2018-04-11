Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477700-2-2122761544750155951
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
    1523477699; b=lXtkWPFs9HyJDRpnzcMeLsSdf2eJrKnQSzEPc2mSJiHmjePcZk
    aPbViFKb7linn/z8CCLJmoea02hvnhvQiV9gcCt46znK+i35ZBmwsH2A2Q/em/Xb
    q8Ld5wOelHZ69wl6nBJ3uc63/BG4wRyADnUvywlrEq3ghrHw4xuo2l7OCO2fXMAh
    m0C5KxsIPuoGvZIvAWw85q5sWbHdZeRTVL6HFt5KpFk0htZoi9tHyz9RCteQwb/e
    nbHBwIoZNJwZcpfEn09ZiBMKTjvqC7GZ17GC9X7kipvQFBc2nTc52+2dOPOe9uB6
    V7A5VkaOLsntrF9yux3vgNLvHUCKJS80sqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477699; bh=vVaB6iEOWtGearkxD6y0pvrDBH+UXr
    W7qyNmjsCZeKE=; b=ir94clgUbHfEuREwILyqk4IHap6Qz5R8tdIEMYFy0JQuNP
    JMTGnqO5mrCYheb3jq6Dl9gmmub6dHnEZcnqgJoL4W3b/M+FmujshKZSEJnDr5wd
    WbL/Mk+c0k9ELvChfC9rt9dThpMM7pIcDJQkxoh/aB5PpQiIQivQkq6Ab6TkL7fn
    GeD3793DdRK4SWyvo/K1Oo9/7izffEZltwvJLq9WUqQeQ1ZeLUaAPRdhfhh0PfPw
    VwWZT8NOqCFiANy+gggfpVi0sVU6ngX+McTH7TtO4CYEvc9XQ/mDE5xIBNmhwVIj
    yxWAzqxavreX85WhwMQvtJkvNOOKaO4tcnvwySEQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCe5bUsaTghvHNs25OMpFweo8wgGzLGUh9mnQ/QVu5Iw0G2g7XIFyf0A8IN634kYPAdneJgaJZAxlHG3ZV3YPX3GWgGvQrmhhAL62xlM4CUoMltWs3XM
    fejZoXw2pw7KATQnq2Rt8D/oXxpyybyUegEW8pqzN3DXn6Nm4H0dPNODTJyQ+8tHLY0s2o0QnCPTyXUEMH4PPc1jMFO4uDoycal1dN3HfZw93EL0XMPUWHvF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=yuwuEI1SGWcJDh9a-ekA:9
    a=VT4FaIMkBdwfcL0B:21 a=6jVcS_BT3GI9St7v:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeDKSx3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeDKSx1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zvonko Kosic <zkosic@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 023/310] s390: move _text symbol to address higher than zero
Date: Wed, 11 Apr 2018 20:32:42 +0200
Message-Id: <20180411183623.292064200@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>


[ Upstream commit d04a4c76f71dd5335f8e499b59617382d84e2b8d ]

The perf tool assumes that kernel symbols are never present at address
zero. In fact it assumes if functions that map symbols to addresses
return zero, that the symbol was not found.

Given that s390's _text symbol historically is located at address zero
this yields at least a couple of false errors and warnings in one of
perf's test cases about not present symbols ("perf test 1").

To fix this simply move the _text symbol to address 0x200, just behind
the initial psw and channel program located at the beginning of the
kernel image. This is now hard coded within the linker script.

I tried a nicer solution which moves the initial psw and channel
program into an own section. However that would move the symbols
within the "real" head.text section to different addresses, since the
".org" statements within head.S are relative to the head.text
section. If there is a new section in front, everything else will be
moved. Alternatively I could have adjusted all ".org" statements. But
this current solution seems to be the easiest one, since nobody really
cares where the _text symbol is actually located.

Reported-by: Zvonko Kosic <zkosic@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/vmlinux.lds.S |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -31,8 +31,14 @@ SECTIONS
 {
 	. = 0x00000000;
 	.text : {
-	_text = .;		/* Text and read-only data */
+		/* Text and read-only data */
 		HEAD_TEXT
+		/*
+		 * E.g. perf doesn't like symbols starting at address zero,
+		 * therefore skip the initial PSW and channel program located
+		 * at address zero and let _text start at 0x200.
+		 */
+	_text = 0x200;
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
