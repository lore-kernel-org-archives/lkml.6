Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523399458-2-17213337700912896094
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
    1523399457; b=UAQnpINWnddTyN26u+ZzQDXDTIV4av/V2qSc4FeCaUgiS+PVde
    UsNq23WPEvdoz6Ardrsr6KMKLDMLLxQ2G2+sY+1pt69jzEdsYRu37ck2I1LmxaS1
    0w1lfO9DFu0AlSqXN6T6UVmAMN/Dlh6pyXjEgwnqLCGrmJpcjUSNF5ormOU87LQW
    /Rd2crFe33SpD8TntSxd1KNzxXUHlM6hurp1GBPP7WIcDp3+cBlHFcX1fvSpstR7
    bEu8axzsmBnTYH7IsD7zvr5BMvURaY/WqU0AoMy7o+S/pHYFmD8rj7P8NIEoiLCk
    JbLH2kl6gGz3y2XOufmoeQ5TnSRgbT0PQicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399457; bh=+Elct+Py373ddh0UqVGzIEqYgHKdWn
    M/7Clk8vdQNgE=; b=mEmqIcEeDkBiMROvF7HLWJZVH+CG8d4rvts3bpXhFBmwiz
    4vcF11Kd3rZRkCw6EaIEc/l7K1gla7be9AxVqy50FNOWP4QN+ZyS9cSkk5mrxmyk
    KCwqicED3+sOCq7R2XC31gInXDlxKoz+67SuUxArx09nVPScd065Sz8bP7Nrj+Ka
    DH05c8eNJgCs4WDTnCYLe9u/VABBs04mVKKlKjum2bHtOE4LFVaGUAGPXF0kCjIU
    /6cbNHH6I4GvbBIzRqjIcfZd23FxGdPWtSdVTJmrgkJg+YYMAtutZFsy7AjpdErA
    yaC8EiH9g2svd9Z9pSCBq+a0zmIwp+6UbF/DrUtg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfKCadwwQgljWA+5tENvwkvZzhbREG+FqXge2B8eo6tx+Go4ERRZFVFc11/4NjvVPgIBW9RRmWErokl1Mdjgn+oDKc7zdIH4PaRINaMLdJ7SsIZNXVOT9
    R2SvRBwo/F+fqaNfU3FoqUSd4W38UUmQ/GSafi3TpZ7Ije9QAMRZ4wnYQmk0TGa1ksJFsipwLFQQDygFJdigOew5GmqPDp0o0VZrslcpV9jbsSt8d5ZA4sMO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=XdUhXFuWtTDGpJ4N_5kA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeDJWay (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:30:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDJWax (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:30:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 095/168] scsi: megaraid_sas: unload flag should be set after scsi_remove_host is called
Date: Wed, 11 Apr 2018 00:23:57 +0200
Message-Id: <20180410212804.293649500@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
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

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>


[ Upstream commit f3f7920b3910171b2999c7dc2335eb9f583e44f2 ]

Issue - Driver returns DID_NO_CONNECT when unload is in progress,
indicated using instance->unload flag. In case of dynamic unload of
driver, this flag is set before calling scsi_remove_host(). While doing
manual driver unload, user will see lots of prints for Sync Cache
command with DID_NO_CONNECT status.

Fix - Set the instance->unload flag after scsi_remove_host(). Allow
device removal process to be completed and do not block any command
before that.  SCSI commands (like SYNC_CACHE) are received (as part of
scsi_remove_host) by driver during unload will be submitted further down
to the drives.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6822,7 +6822,6 @@ static void megasas_detach_one(struct pc
 	u32 pd_seq_map_sz;
 
 	instance = pci_get_drvdata(pdev);
-	instance->unload = 1;
 	host = instance->host;
 	fusion = instance->ctrl_context;
 
@@ -6833,6 +6832,7 @@ static void megasas_detach_one(struct pc
 	if (instance->fw_crash_state != UNAVAILABLE)
 		megasas_free_host_crash_buffer(instance);
 	scsi_remove_host(instance->host);
+	instance->unload = 1;
 
 	if (megasas_wait_for_adapter_operational(instance))
 		goto skip_firing_dcmds;
