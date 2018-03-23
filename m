Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805794-2-3805551994162201042
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
    t=1521805791; b=EauaU/N2D4IfM2XHUbNUDQlSwHXH+1EWNYdhUp/3jirZs1m
    25RSoxnLSqbgwLphifPOCVCkNBjdYnaUJaCr7/nPZBjcrLoo/ynZu0ZMcHEQFjuS
    jjWJJrLVin/kqzeYUnnx6rElFeKRriJgLO8xORJBV3EjQpKnk4/hLeJXGjeYrpBb
    r6NLKqgHEwB9UHzhKkZ0pKfeR0XcqkwcxNTZuZw5yBttOwWwpuLU94/5ZOAJg68M
    LriBwnsjQlkFUob6jwOTMdlaOeJqe61p24BdXIEp53pWF4r1v1EYxK+IMIkNvRLv
    0raN312mAzk00kOjUXWUG94wRhtglIxEZfpmtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805791; bh=qytAUEF5Wbo0E05ZVqTc3F6KDF
    aqL8TbQ20lkpjVQ6Q=; b=YMQxnoHaziqE20Av1xXC+qz2Glc+rf6qcl2m2zMZrV
    jdVEmQCi5eCffTTxBsFnoMFnBwYutw6IrmnA8GwLZryJ9RBfjZDvVY54Z+W1jh+r
    RCBvsJxxdqCs8X6r6vcctUd0qYHM9ZYFOhkoQcUg06vs78hxBQw6qIVaguavZBNN
    OoUFgRh8V7ILzSKbiv5KecvBJ8TTcHWrA96ti7cQonjdtRjM4BwHgl2RznPNIUgr
    cN0GVoBiVMri51NRN9LI+zsCa+kUZq+eaq4epr7WdmwpyYMEZqf2O54EJzYqx7Rz
    5bN9OIr3Ee5Pg1tYkJRsEC+tOOKRi1c2ZJPhgilSWryg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeCWLrD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:47:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbeCWKCl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 57/77] scsi: lpfc: Fix issues connecting with nvme initiator
Date: Fri, 23 Mar 2018 10:54:31 +0100
Message-Id: <20180323094146.100817848@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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
