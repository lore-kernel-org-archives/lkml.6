Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161390-2-9183732726382758521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161390; b=TbhlPdEJ2YFlEKnVeXxQViCU8n9qK0wsUo868aTuF5dcB8j4Yk
    k39Qg9VrSCWrhTVGpGl9J6rg0/+Ut4qfoP3fET/67xY7d8KMDUg1J1EPPZy59W7C
    BzTatygGVUiUClVUC/gArQM+Mj1vVha4/RIQOWv/j9GgexKMT9AdvioG0lSfYy+n
    Dzpc6W+QKBb/WcDhAVtF7/OQU5pxoUdpLcZKddMFXaJH78HdI9uOJ7uzlkFTvhBN
    079qS/B+wbkFlO1C2Rkr/lXUZuRkqvSSxgTtxq0hSjsUv6IeniifjTyZAdZSRgzX
    hpSE5SBLfKioTBKYrlzY4R6vJfLDmhN4Jeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161390; bh=Dqeh+8JD4nODMJBeMBDvOL8ZFdDHxy
    7xysyf90PUjJI=; b=OZzsoiXkFwW+7f9fc0EF1sDN5vlGM76kPL7mATZ5tksb13
    polFtITEBksgMU8GV6ZvI5kJaEK24msFpaiWYaY9JxQHxcTmj7KW5uT28gOVgpQf
    DzfEg6BupJ3IlpZKsiVSj3LqKTHRktj/fbvETtNQ8A/zeL0SvjMt+OxgRnzbgMYE
    IxAVVcyyMj1ril4eTAiAyBLZmQrKJMQlFUEFX8btUVA38TUrXfPFMWYX5gDmdClI
    X8cWN3byX6XYt4K8cyYh+LmTyJpsRhdsTmpwggCxqZTsb5tb0+eOvCwzW5d/QkZ1
    pCoRWSQOzOwx0HfdH0ksi++nzdjYOhAO9l9D9Esg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=f6nHhe7Y x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=f6nHhe7Y x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBPuDof77J6rC44jOb1tmISMzHqajTrfGnCypra0SO8+u6AFbcS7QSZjCoilAWMH87NVuOYOI072ZCfXLv3Dty6P63TeKmcz1pGDMtZcpywA4swa8US8
    6YHvCwRVcS3flcBLb7fsgZQuAZyt5bojmxLtO2sWSqQP7PFD5fr+hZp1PL4vPt+q6bOFgFaAM17J9hTuY1mRWCAjwGfT3TBCEnHqeTqPdI0KxxPdrTWh0TG7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Gwzxdhi8TNGVGMJkNx0A:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967853AbeEXL3e (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967662AbeEXJvQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 64/96] scsi: lpfc: Fix issue_lip if link is disabled
Date: Thu, 24 May 2018 11:38:47 +0200
Message-Id: <20180524093609.138725997@linuxfoundation.org>
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

[ Upstream commit 2289e9598dde9705400559ca2606fb8c145c34f0 ]

The driver ignored checks on whether the link should be kept
administratively down after a link bounce. Correct the checks.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_attr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -635,7 +635,12 @@ lpfc_issue_lip(struct Scsi_Host *shost)
 	LPFC_MBOXQ_t *pmboxq;
 	int mbxstatus = MBXERR_ERROR;
 
+	/*
+	 * If the link is offline, disabled or BLOCK_MGMT_IO
+	 * it doesn't make any sense to allow issue_lip
+	 */
 	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
+	    (phba->hba_flag & LINK_DISABLED) ||
 	    (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO))
 		return -EPERM;
 
