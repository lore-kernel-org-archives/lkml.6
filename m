Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155486-2-16741556232179608123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155486; b=iJFsSwWPTpAYegeAVbHaH6hY8/BPBWKXzxnO6gcRZcPyfGCiao
    b3oQppoi1Thnu3v34GVymg5txHrQ9jkMJsRWbz1l5tadEUUnqzzM6qwusoSzDSVB
    RYQfgacVXhm15QVO7VV+hMz8nROweDReC5IEMf7Mc3nr3SIBScrSx2PPaTWD/ZSx
    m/p/obmvH3JSGT2pJW+4/O3Om7FK4xltuVuahowd8/oT571ToTE7X23inLz2VVkx
    Y+35K6TULIVwXDVyHHOzLAueD1ywmKp7sZgXTA7U09wD/M0tPDkPaVqlPhN9UisU
    Cq0t5SetuC9GWltx0nkYPMfNrE1XQ/I/BN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155486; bh=GftC1dQCiIBzWcjQd5IrrrpksY0cJy
    ZqcQZK1to5w6s=; b=gtR0xiT73o37xDiaHsMT1QDj91P5sPq01qmmRDaPCF0iqZ
    RsqQ8p/9L6eYhz7zWzFIZld2+jZpse8S9cvQpL+hOz8yxRsbqdJZEpPuBz4issJI
    ZTWvS1s2vu+G1NJS9erLdUGSAUB52TQ0iw5mPn7Pn0cVlNmDYAVSEpyf1P1Z6Xvg
    VoR4NfmyZ7c6EFFAKPldO4bMcSQR3NRlAYnQ5CCtmv9IKKrIPHafZAEjKHQfsMBp
    ZEluhrpAySEEr17pxqTzhEBwJzkbfscKwHvBXyWqA0W4bQ1C0GOe0JKACRxcdqwE
    So2833QxPeUv2LCjXTCdWDMbi6Z9wd220shA8kUA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XF4zNPD7 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=XF4zNPD7 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCkTyev56RYhg+ZsACWY19huUdyyumF3K5e2RSSzO1iYTajToja6nb0hWtldRcr/MZsj8DH2ngf3Kls/wtLIVfZ3In4pLUp3IUI240SjlZlwDJw4hNs7
    0sCkkQi+iaeMRhJ1wwQG29LIUBoPVBdEC1OhTJEUmY63J20Pk5+7faWG2zuqri0ieKRUhg0u825E6vQk7XVwHJnShEWZimHABYGatoU3gDS5y9QPP6n34r2j
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_6RxkvT1u2HRLes4DfMA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967646AbeEXJvW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967312AbeEXJvT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 65/96] scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
Date: Thu, 24 May 2018 11:38:48 +0200
Message-Id: <20180524093609.181789504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 161df4f09987ae2e9f0f97f0b38eee298b4a39ff ]

During link bounce testing in a point-to-point topology, the host may
enter a soft lockup on the lpfc_worker thread:

    Call Trace:
     lpfc_work_done+0x1f3/0x1390 [lpfc]
     lpfc_do_work+0x16f/0x180 [lpfc]
     kthread+0xc7/0xe0
     ret_from_fork+0x3f/0x70

The driver was simultaneously setting a combination of flags that caused
lpfc_do_work()to effectively spin between slow path work and new event
data, causing the lockup.

Ensure in the typical wq completions, that new event data flags are set
if the slow path flag is running. The slow path will eventually
reschedule the wq handling.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -690,8 +690,9 @@ lpfc_work_done(struct lpfc_hba *phba)
 	    (phba->hba_flag & HBA_SP_QUEUE_EVT)) {
 		if (pring->flag & LPFC_STOP_IOCB_EVENT) {
 			pring->flag |= LPFC_DEFERRED_RING_EVENT;
-			/* Set the lpfc data pending flag */
-			set_bit(LPFC_DATA_READY, &phba->data_flags);
+			/* Preserve legacy behavior. */
+			if (!(phba->hba_flag & HBA_SP_QUEUE_EVT))
+				set_bit(LPFC_DATA_READY, &phba->data_flags);
 		} else {
 			if (phba->link_state >= LPFC_LINK_UP) {
 				pring->flag &= ~LPFC_DEFERRED_RING_EVENT;
