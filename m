Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840374-2-5269904048248465466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840371; b=aYRFbOunYMvcmGqnTtuS08isSesTjLhpsVU5tEB40gj8H6i0G1
    S89/4wAJ1Z5AH8zYEhE8NvpoLoKDVg/kHPQ/mCzeV7r7XLxJIo7YtBHnsiFqf8wA
    f/5vot6k+qmj9rL5X9tgMUcWdDikGzt1WUEIJJVqe7lNJAlakoLeUNtA01K1H6yw
    HJ6J1uzCwMDd1SKL6IvLkEIUhF5d5vRwslKukXExkSEOnvMzOqt8lrn4Al2ELuHB
    B0FSGwfoz/2Tsg2rzEJPkbyWdshgpgd/89KFNn1ZCeELbNfWn0X0aYiRjAiL9W3N
    Y3J0769Q+2mZaKcJzU0xhC6XD4bwQ/qdPO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840371; bh=sqdPkHjq1KGTd79Uo1nTDYG4fB6tq5
    qPqfF/7PiNAeI=; b=TiH9QqPvm3E2d+Q6b2QVOH+SXrjsZpnPkXxDKhTPXtv9W6
    K5w4nEXVsgoMkV1YGFEHwF1aKcZ9E43vUf65jocPDmRWAuv5lcYrCS9tiFBW26an
    rpNxyXIv+owv66KkwgKOU9880KxmoNNCuvgEP6+9QU1BQTc41lQcVWxvJeKGui5A
    6o5WLNBhRtEbl3qCr4nF1JvW0fORqPtvPGugQdZrvqY6fDAKz12Y2t9W+1ck1gG0
    i/XEkzFFsVIhq7KEGhMyOi1mFbr17kerCH7//2+UkUHpkYejpn4aG9+QLbu8BOnU
    unBFWMUDtcdYXdm61WPYaatfrUKiPpV98IgzgE6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCER4Aht/w5RGtMnr/k980LepKmaUPjWMkzzeinXKCBSqp0bPs/qW97e9pd7GDoWvk+wcdq9K7iuTQ33VfnNeV9TGc0GrUsyPEc5AHqkaky+FyXLG2Gh
    hDfAVrkfjLgnCSzu22pD8ApR4n2OcYOEL6hoLQ2U2DjdhOLS8VYKamDSajRSSzCdzbTPBQCs+d7sLekuJbuRyVvJHOAx8CV9GM6TTLc4FQTuhMfG6bixJU/P
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=FF4WHPk0oZmug9hKHIwA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeD0OIJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934424AbeD0OIE (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD5D21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Farhan Ali <alifm@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 54/80] s390/entry.S: fix spurious zeroing of r0
Date: Fri, 27 Apr 2018 15:58:47 +0200
Message-Id: <20180427135735.675188624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit d3f468963cd6fd6d2aa5e26aed8b24232096d0e1 ]

when a system call is interrupted we might call the critical section
cleanup handler that re-does some of the operations. When we are between
.Lsysc_vtime and .Lsysc_do_svc we might also redo the saving of the
problem state registers r0-r7:

.Lcleanup_system_call:
[...]
0:      # update accounting time stamp
        mvc     __LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
        # set up saved register r11
        lg      %r15,__LC_KERNEL_STACK
        la      %r9,STACK_FRAME_OVERHEAD(%r15)
        stg     %r9,24(%r11)            # r11 pt_regs pointer
        # fill pt_regs
        mvc     __PT_R8(64,%r9),__LC_SAVE_AREA_SYNC
--->    stmg    %r0,%r7,__PT_R0(%r9)

The problem is now, that we might have already zeroed out r0.
The fix is to move the zeroing of r0 after sysc_do_svc.

Reported-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Fixes: 7041d28115e91 ("s390: scrub registers on kernel entry and KVM exit")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/entry.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -426,13 +426,13 @@ ENTRY(system_call)
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
 	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
-	# clear user controlled register to prevent speculative use
-	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
+	# clear user controlled register to prevent speculative use
+	xgr	%r0,%r0
 	# load address of system call table
 	lg	%r10,__THREAD_sysc_table(%r13,%r12)
 	llgh	%r8,__PT_INT_CODE+2(%r11)
