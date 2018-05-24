Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159430-2-18244712219260679827
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
    1527159429; b=PYecJN4Yt4yXSMb7pkw2eP/TBocniE8Lug0HNPKD/axumPCW0k
    q6w2e5dHi/wyL2Sg2CpppGyGc3hh3YemqkqCRotlQoa10loDitWIn1eMfO35ziQE
    PKQ5vXQ6gP7+mCxk+F4ramjl0eiQetNOPbGWcLExlchI+hE/VMl4puGjD3+U0x9V
    CcXUFBxjh50K4LQeKy/fD5d6wT0YlsxXN7YYHPUkG68K3vAWuE7gIobmh4+tAX6/
    n3xBwa+eRHlqoPFHWrTWTl10rQNzeh1Grt2Xa6j5tOsoPVjOrt5iTohlAjfnnw+e
    2Bnl2ae3+56CE7/zfIs0n+YcHRlrOZzzlKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159429; bh=ZIxot/qDE3rnTQQX3CSWm7qtcOCND7
    SuWdn6Tvmowek=; b=AzKGiema2Uzhfq0jRrq2TFhH+K/cNhgpXtMmJwceuCst5W
    FGAPyNl2nsnFUJRMmvCA+cF1TOmGcNaRgjQ5ZijVDYUM1OjYUolWu/GkkrXvUVCI
    ItOCOUb0L6+UWOaj+8K7OgcaCIORPFYQ8TbYkNF6g+AcaCZMzIU8rQLMWr6fVmjz
    ZwIznWhf0pJWG23v6wr08vnf+r6B41FDQL8tcM0raO+5sGqvJ9nBMTsin9KbRkBU
    mIQkhpq8Rh5bW2CuEa154Wv6eqke067btMLQNSffZoC8G5nwkLRknoUOMHXvirlf
    cXIsAZH/He+/ka9A+b+YoqDCiwct83RXrynZwW7w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sYXCqmqL x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sYXCqmqL x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPzMN02W3q3rvo2Fgd9lH+bXt4MJajnUe0GpcKE4c3iCXH7xzV68ZgMfghI4nVJX1CPcM3qWKayfwgip3P1fM0uusit+FtCOoOZbTBXpQJPQSb472rth
    Ffk8YT1yxCEfbZGrhzRrD2ObNBXmBmr3mV4faGkwz5RgWfhwxSDpla6NQZZw50jS0pmt6+emCem6KImPUngmI/h32+J4sp2i2K5P72bw5ASDqG/pVmaCYwT1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=fJIh7McZu9Cm0UNqPSsA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030296AbeEXJ4V (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030288AbeEXJ4T (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:19 -0400
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
Subject: [PATCH 4.14 112/165] scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM
Date: Thu, 24 May 2018 11:38:38 +0200
Message-Id: <20180524093626.554550165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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
@@ -8941,7 +8941,7 @@ _scsih_probe(struct pci_dev *pdev, const
 	snprintf(ioc->firmware_event_name, sizeof(ioc->firmware_event_name),
 	    "fw_event_%s%d", ioc->driver_name, ioc->id);
 	ioc->firmware_event_thread = alloc_ordered_workqueue(
-	    ioc->firmware_event_name, WQ_MEM_RECLAIM);
+	    ioc->firmware_event_name, 0);
 	if (!ioc->firmware_event_thread) {
 		pr_err(MPT3SAS_FMT "failure at %s:%d/%s()!\n",
 		    ioc->name, __FILE__, __LINE__, __func__);
