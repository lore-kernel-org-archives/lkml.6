Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806654-2-15942545194796315243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806654; b=GaYa/gWd8nTKc7iwGUjEibUky/UoZWw2KjhSa5vc5Tt8FHG
    lxlb5b8VbNJhcgOCBi0+5obOF5kdFAa7HXEX0FOYPx3P2tpRykRtD7PjPwISMEHO
    +frbMZORWyNG71UnpDVlS/HJm1feEdCRU6dtU9+lRam4hNtMC90M/YPAwNQ3vm45
    uKHpxU3vXeTTFr53ugIJCaHI/Ggr1dhdYfDrHEeSU1t35n53f7ApXzT++VikwRgn
    62l+HPhxfGIYixznoPVWtBfMlIJtAW/HatOCMJrf2IxCUrd9kKOK1S9OwHX2pCOP
    +Xd4Ct7I+z0sljy90g2A2y+lnAiNPHicTxC1bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806654; bh=jG8KSEf5h8hpmXI0ZcB41ceKpb
    EvWCplp4NZ1+6BDW8=; b=EvNRnpvevRO3ZgB2/Ew1++O00iF32XFoYx2iN+kMHy
    4HwtVyTThtjahx0dTz4lgne5l/08eN1Ft5aBg8uP3H62yPH/VHzF9blaVIrSEXe6
    4FtXOB5Cq1ULft2AvMemySKxwGlNSx4obfwQ/9U54ouJPkGNl4L+/Hjv6dtXvTRG
    kTvCBFw8uUsv+zG3vWkhX4ptroXmiYwK4+wI2jvmYYvEnwb4f/ttsv5g3NyIbQl9
    +tMB20Ni2gFm7qrJFEnT6PRPtY0A9TfcSl0E+2ZVl+/VFE9/+EkaIAXlFsqKlMoM
    Mv7e1lja1vNdTkKpQx7K3uzLfc+S9f7xwded11QrvZHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeCWMEK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:04:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeCWJ7f (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 66/84] scsi: lpfc: Fix issues connecting with nvme initiator
Date: Fri, 23 Mar 2018 10:54:20 +0100
Message-Id: <20180323095421.926616969@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit e06351a002214d152142906a546006e3446d1ef7 ]

In the lpfc discovery engine, when as a nvme target, where the driver
was performing mailbox io with the adapter for port login when a NVME
PRLI is received from the host. Rather than queue and eventually get
back to sending a response after the mailbox traffic, the driver
rejected the io with an error response.

Turns out this particular initiator didn't like the rejection values
(unable to process command/command in progress) so it never attempted a
retry of the PRLI. Thus the host never established nvme connectivity
with the lpfc target.

By changing the rejection values (to Logical Busy/nothing more), the
initiator accepted the response and would retry the PRLI, resulting in
nvme connectivity.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -1569,8 +1569,8 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc
 					 ndlp->nlp_rpi, ndlp->nlp_state,
 					 ndlp->nlp_flag);
 			memset(&stat, 0, sizeof(struct ls_rjt));
-			stat.un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
-			stat.un.b.lsRjtRsnCodeExp = LSEXP_CMD_IN_PROGRESS;
+			stat.un.b.lsRjtRsnCode = LSRJT_LOGICAL_BSY;
+			stat.un.b.lsRjtRsnCodeExp = LSEXP_NOTHING_MORE;
 			lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb,
 					    ndlp, NULL);
 			return ndlp->nlp_state;
