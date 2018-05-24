Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161777-2-8887292772176169738
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
    1527161776; b=YN3qZGC9nJdymRaEjZTD9EtB7co8CZwBrYm7qh6KxxkGpVhBwq
    aIRzZbiVwpWhO2bi+otI2VO3odvkz4BQKXg66GxrbMRxdC1iNKUJdhsACPdw4vGT
    RbDi0OtbXLBlXwCHPb3b+7kpVAvkt8R22+iFd4PRZONt3YQT+SPFPQWG42SQMkRp
    tbLlH64qpb0cis27ll/laCwR155pLbR2uL1Eu78zLLU2n0KwuCtW/dOX7OZ74UO1
    XwmbYuhwiABDZadyma44ajt8TFwIWkqDdpz0GmbuveVSVT5nmmrwpgUcjVsccXQh
    VyGsxDZoFxoyGXKq2ud+YSOQP9grOGtxQDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161776; bh=/pP7Crt3JE0sQ5sb7YzULT0Y/+Ug/D
    eLsyUATcf8pOw=; b=KoHanGNGaroWVcXcjX+H5YcCw11gLVFgEccVvBZT1oBjOo
    JQvSfRNEao0u5yuWtwns0qXpuDJ92EY+Yw2z/uXmeGFlWzxtXfyF4rVvGYHljequ
    QRABBnJ4+5yx5eg/mdEmk1eiAf4GAq/HAXv14ypoQ96voWFdY3CHtUhz3Y6yjrv4
    RLN/9gzOEAqmHwlqZXi/gnCnXAytQ+vMNRqXB+C6xIzhp0C/YkBqDAYeeo4QS0xX
    OWeK314TwVUa3dew5yXU+Zb7A9EIiWQp0ryw2ZSDjJuIotviXQkqWHu29PV69cCx
    2PXDasByI9rD7Mz2JkksW77m2yfYLYhj3qF+Zceg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=m8YqvnT7 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=m8YqvnT7 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNNlQc/NwPMBGe0o6Dp6KjL8ZSCIAYiiHBzNbDMtIx5OJuXZwS1znA9gmnlZ1nFxpYZZSVfUwyZpWF16dwPh4cqYtPP0FMKME9+ICM6NVz/aoyMZUP7/
    5hgku5UHOiqGoAfa6Ft2jIaUN2bvEVFk6Wi80r549Sv5rWaEOAlbM+2Aon5TNaYGC+m2ktUELgpn6QIXuApQYhDldZtRkoT5Le26cZuiQakCCEyBy9MeC31w
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=fJIh7McZu9Cm0UNqPSsA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967502AbeEXJt6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967432AbeEXJts (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 60/96] scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM
Date: Thu, 24 May 2018 11:38:43 +0200
Message-Id: <20180524093608.904820655@linuxfoundation.org>
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 864449eea7c600596e305ffdc4a6a846414b222c ]

The firmware event workqueue should not be marked as WQ_MEM_RECLAIM
as it's doesn't need to make forward progress under memory pressure.
In the current state it will result in a deadlock if the device had been
forcefully removed.

Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Acked-by: Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -8853,7 +8853,7 @@ _scsih_probe(struct pci_dev *pdev, const
 	snprintf(ioc->firmware_event_name, sizeof(ioc->firmware_event_name),
 	    "fw_event_%s%d", ioc->driver_name, ioc->id);
 	ioc->firmware_event_thread = alloc_ordered_workqueue(
-	    ioc->firmware_event_name, WQ_MEM_RECLAIM);
+	    ioc->firmware_event_name, 0);
 	if (!ioc->firmware_event_thread) {
 		pr_err(MPT3SAS_FMT "failure at %s:%d/%s()!\n",
 		    ioc->name, __FILE__, __LINE__, __func__);
