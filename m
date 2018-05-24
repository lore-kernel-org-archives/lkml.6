Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156241-2-776773235693417759
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
    1527156240; b=eUoRzJ8/ZcwLeT5sodBOSNr5gxYlMPGFm/NXQoqKwuaPVSclo7
    EZah5TEENPvurvQWikM8T0PbtVnUjWjUTLe3XCC+bkOj41kn0mqYl8Sn9ArgHNvp
    Hi3I5Q/VrjguEk6no9+KB6ENjkEZzGAAAop+QFz+6kuQcdNRFYzXCe2bolzCsbLy
    0v9sV/fUFfwda+SDLb5Lg+Mg6iOeR708maExSZVkMhwcPia4jxWt+76zYDFq5ppH
    noRbaPI6cQDtaUQzpuvStv+uQh5ajuVXYoQ4V9ygNbTqFxC1+2qyxzCtLBZA36ch
    07YcqQuChVieRvFH0I/Qz3oPI1jG3uYA29pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156240; bh=+Uu1ssu5Bqutghs+hkq30Dfnic1qzI
    t86uiigDPSQo4=; b=QCa6cOx1p2jZ668pvSpGOdWFBtuFAOxzV/XAGEqHj2zi0z
    v9YY60FdTMXxAu3qInXmNlqGvx1N7CyxhvOZzsccogjt2s06QJGIBqc3mRYfjPle
    Ir41YQ1Ezno193NoNIpkUU3C/rBMl1dvwPxM5x5skKielvSlnmHIKgHeUj7HtbPj
    UO34RB3Pb/z14brdfuQFmUgpKAuLp0aiy5EPNJO8c4NccLsvCJI5w3Grzksc0R8W
    eBwYzFIQmZxev/CsPMlRPWCXA6tp33Ccuo04AFx+qGI5ATWTVuPR+aD19bZz+EJd
    gMjk1xPvhftvyNXVGz/Lwcegb4q+kX9EzFLwnsPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Gsthw2Ik x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Gsthw2Ik x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFafdHqi1HuPQuqrgwJPFk12kzzpbFCJmubrEB+amqAicWLHk4ocQf3mRsxyO3tuuAXP3nc6mgNq0zPLKo6MXTuKuXAuS18fb8/Sg6jdP684NAM+kggZ
    hkq+/3VfIlsWSvfPyehR4PG80Tv9HDI3UVw18WJJA5mdXNWTBqeZNe6z39dSabuZ3Ly3VZl1ASvFaDvwQxMidzVuUrTJqc3RqoJhn6tTB5QaGXKHXfb2wx49
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=r4gTNoEiZ0k_mqKNTY4A:9
    a=WyVPAXH78ZC9RpbK:21 a=X0PaXVIIJJxCzbJK:21 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031346AbeEXKD5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030922AbeEXKDy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:03:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 113/161] scsi: lpfc: Fix nonrecovery of NVME controller after cable swap.
Date: Thu, 24 May 2018 11:38:58 +0200
Message-Id: <20180524093031.879689592@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 815a9c437617e221842d12b3366ff6911b3df628 ]

In a test that is doing large numbers of cable swaps on the target, the
nvme controllers wouldn't reconnect.

During the cable swaps, the targets n_port_id would change. This
information was passed to the nvme-fc transport, in the new remoteport
registration. However, the nvme-fc transport didn't update the n_port_id
value in the remoteport struct when it reused an existing structure.
Later, when a new association was attempted on the remoteport, the
driver's NVME LS routine would use the stale n_port_id from the
remoteport struct to address the LS. As the device is no longer at that
address, the LS would go into never never land.

Separately, the nvme-fc transport will be corrected to update the
n_port_id value on a re-registration.

However, for now, there's no reason to use the transports values.  The
private pointer points to the drivers node structure and the node
structure is up to date. Therefore, revise the LS routine to use the
drivers data structures for the LS. Augmented the debug message for
better debugging in the future.

Also removed a duplicate if check that seems to have slipped in.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -241,10 +241,11 @@ lpfc_nvme_cmpl_gen_req(struct lpfc_hba *
 	ndlp = (struct lpfc_nodelist *)cmdwqe->context1;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 			 "6047 nvme cmpl Enter "
-			 "Data %p DID %x Xri: %x status %x cmd:%p lsreg:%p "
-			 "bmp:%p ndlp:%p\n",
+			 "Data %p DID %x Xri: %x status %x reason x%x cmd:%p "
+			 "lsreg:%p bmp:%p ndlp:%p\n",
 			 pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
 			 cmdwqe->sli4_xritag, status,
+			 (wcqe->parameter & 0xffff),
 			 cmdwqe, pnvme_lsreq, cmdwqe->context3, ndlp);
 
 	lpfc_nvmeio_data(phba, "NVME LS  CMPL: xri x%x stat x%x parm x%x\n",
@@ -419,6 +420,7 @@ lpfc_nvme_ls_req(struct nvme_fc_local_po
 {
 	int ret = 0;
 	struct lpfc_nvme_lport *lport;
+	struct lpfc_nvme_rport *rport;
 	struct lpfc_vport *vport;
 	struct lpfc_nodelist *ndlp;
 	struct ulp_bde64 *bpl;
@@ -437,19 +439,18 @@ lpfc_nvme_ls_req(struct nvme_fc_local_po
 	 */
 
 	lport = (struct lpfc_nvme_lport *)pnvme_lport->private;
+	rport = (struct lpfc_nvme_rport *)pnvme_rport->private;
 	vport = lport->vport;
 
 	if (vport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
-	if (vport->load_flag & FC_UNLOADING)
-		return -ENODEV;
-
-	ndlp = lpfc_findnode_did(vport, pnvme_rport->port_id);
+	/* Need the ndlp.  It is stored in the driver's rport. */
+	ndlp = rport->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6051 DID x%06x not an active rport.\n",
-				 pnvme_rport->port_id);
+				 "6051 Remoteport %p, rport has invalid ndlp. "
+				 "Failing LS Req\n", pnvme_rport);
 		return -ENODEV;
 	}
 
@@ -500,8 +501,9 @@ lpfc_nvme_ls_req(struct nvme_fc_local_po
 
 	/* Expand print to include key fields. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6149 ENTER.  lport %p, rport %p lsreq%p rqstlen:%d "
-			 "rsplen:%d %pad %pad\n",
+			 "6149 Issue LS Req to DID 0x%06x lport %p, rport %p "
+			 "lsreq%p rqstlen:%d rsplen:%d %pad %pad\n",
+			 ndlp->nlp_DID,
 			 pnvme_lport, pnvme_rport,
 			 pnvme_lsreq, pnvme_lsreq->rqstlen,
 			 pnvme_lsreq->rsplen, &pnvme_lsreq->rqstdma,
@@ -517,7 +519,7 @@ lpfc_nvme_ls_req(struct nvme_fc_local_po
 				ndlp, 2, 30, 0);
 	if (ret != WQE_SUCCESS) {
 		atomic_inc(&lport->xmt_ls_err);
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
 				 "6052 EXIT. issue ls wqe failed lport %p, "
 				 "rport %p lsreq%p Status %x DID %x\n",
 				 pnvme_lport, pnvme_rport, pnvme_lsreq,
