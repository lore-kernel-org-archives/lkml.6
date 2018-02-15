Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709118-2-8377777111888229957
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
    t=1518709117; b=j4HHl3T8+4TFb4FBKWdUhuRIQqGaDKwhXicZmGqTrIOq+2r
    O/cdK5BfwflDL2dBtkG8fq8Q6lBMnNwK7qdIz8JMs3Qpkqxb3LW+sop/q2k8g1oW
    jpiAdNdOKfA5UlfeOJQBZehY92Q9mxSVWS8LKgHpjN0JgH0Aij7/dTJbT+o0PVhO
    3+wZn315O+mp/KARcVKviK4CtB62indvd+yzIIEWci4JP3ttS7J5Y9Ix//p14O2A
    VG5Yl4HDPpQzrwy9F9W86yHJURsHNj2YoE/aAJWTReS5oljt4AVeFtY5ocoODEYw
    PBLbj5pcBrfe9VKu8f9nZxpnI5ew+LLGqvnSzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709117; bh=JMmqeCSHQclvXok/LY64dBzAFo
    gYXRJfeBArcLcDQH8=; b=aGYzRyyloRGBXkw/5GwdoPoIwtFa6elG3On5viYYlV
    kjck8MkKRmgtlTBBhqAJrfV/h/ob+PaFqOVLPojTbEReeyyExRYPMSVrphaOjmY0
    RlSfZ0sYBC2dSaTKvDxkPFQEkQUQtYH2SjKGP9cpohxO8dEUg34qmYaER3+ifhbc
    DRkttvsmHj8UVUkaWrQvX64aCY1duQ6A5huJZ1F477WFuNIVTdinI6EWBPM4cRdZ
    3ofZW5oCvVi5ol5pjUGgffjOQSd/DoOAeORAu/h5v/TDyisyX5DBSwpeXznK6DlA
    yfN8GqoLNwCJvHgPTJkNUS31V202OludfZ28F8d+mcRw==
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
        id S1423336AbeBOPie (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:38:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423334AbeBOPic (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:38:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 195/195] scsi: cxlflash: Reset command ioasc
Date: Thu, 15 Feb 2018 16:18:06 +0100
Message-Id: <20180215151716.146947676@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

commit 96cf727fe8f102bf92150b741db71ee39fb8c521 upstream.

In the event of a command failure, cxlflash returns the failure to the upper
layers to process. After processing the error, when the command is queued
again, the private command structure will not be zeroed and the ioasc could be
stale. Per the SISLite specification, the AFU only sets the ioasc in the
presence of a failure. Thus, even though the original command succeeds the
second time, the command is considered a failure due to stale ioasc. This
cycle repeats indefinitely and can cause a hang or IO failure.

To fix the issue, clear the ioasc before queuing any command.

[mkp: added Cc: stable per request]

Fixes: 479ad8e9d48c ("scsi: cxlflash: Remove zeroing of private command data")
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/cxlflash/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -620,6 +620,7 @@ static int cxlflash_queuecommand(struct
 	cmd->parent = afu;
 	cmd->hwq_index = hwq_index;
 
+	cmd->sa.ioasc = 0;
 	cmd->rcb.ctx_id = hwq->ctx_hndl;
 	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
 	cmd->rcb.port_sel = CHAN2PORTMASK(scp->device->channel);
