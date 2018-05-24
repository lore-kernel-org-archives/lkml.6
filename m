Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158959-2-1243518943308794081
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
    1527158959; b=Se2r73gFIB6cIqepLODz1MjScHtNRgSTCDmUFO+qeSrV+KSOFU
    BdVJXnzLYv0JNqij08TnUZ4Ct3EnoP6BQZJ5ak9ACDmv7DdjlOdNF953rXOPugc6
    buccP2ZavDQ46U7qiiGK0wBbMn0J+T2C00nLrBvLBvGbki9t4uPNjBRK0zJfLvbR
    rdqzipoXaKPiN7SrxyhQnJanfguKwlzCJwnx/pAfvq6lXOHTsEgVkY+gkN8397yV
    EBln4gvC5TAf+2eq/Sl5TkCrqrxCxdVMEvUcjXLcKMMcAoPDOCxykXDIjgxuojcl
    A4EuVGIJHka6IRMUmxnwlQZCQyIxAFQilo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158959; bh=6zMc5lU4cU131ij1jcfM4RpfDWWp7B
    i5PCbVDgpQF2g=; b=FGxbuYf6GVG7kq5A16iyTavKeE4A4QZwUiz4CR7vac0ceJ
    1yBNFKsB+juNgqb6z7vCpXiHGhlKXeHXrsRd3ltF3t3mhXQvOpE0Wmbndjz59KoT
    BIjEnkoNSEZNJIvtbDxiXn8TFzzodBuEaIiYWzJu3GkSYsmnNg5LE5fkHcBX039h
    G4tEWtyQo7qi5Fh4GI+UPSjj512OEMu7jE9X35afovec/yQ9ETCRo1lXsbr0VWkt
    2KKgUbkfG/xzHYe5jwho5yzb+UepHrbPrP83O7Yxm/D4SAPtdqooX2TY6NhG3yn7
    bA66oDD+5v6XKZ7YIwqN3Ny21HKY1lpGMdnz69rQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EJF7aK7y x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=EJF7aK7y x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfANxYzHwD8wvaG5S4/OwvR86VTA5T/cEGCi7Qdk7PBJnwCxOeeDh4N18Ig0Hs2lrd6gds+6V/dgkS4SyNNxTjTQVXzGlnv2i649J3wj7noV784110Oh2
    hj4I0xABNvxfM/gn5RRkMtTQs42q/pdgydKXUlTVYaWSOqq2pgQodkp+NrKAWvhZgoWpaiPPWgLkbRrjBf9JZtuAjZgsU7G861zayoLM0U2NFSgEpWK5I2qB
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=NCkSHYsgAAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=eB84WoSJkZp_eLTphZ8A:9 a=1g6M3btWGvSlz_2M:21
    a=PRe3NNIFlJ3LI6ge:21 a=QEXdDO2ut3YA:10 a=AnMw66Xr5OuzjdxB04dI:22
    a=xVlTc564ipvMDusKsbsT:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032375AbeEXKqT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030500AbeEXJ5k (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 116/165] scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD
Date: Thu, 24 May 2018 11:38:42 +0200
Message-Id: <20180524093626.712206816@linuxfoundation.org>
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

From: Douglas Gilbert <dgilbert@interlog.com>

[ Upstream commit 1875ede02ed5e176a18dccbca84abc28d5b3e141 ]

The SCSI PRE-FETCH (10 or 16) command is present both on hard disks
and some SSDs. It is useful when the address of the next block(s) to
be read is known but it is not following the LBA of the current READ
(so read-ahead won't help). It returns two "good" SCSI Status values.
If the requested blocks have fitted (or will most likely fit (when
the IMMED bit is set)) into the disk's cache, it returns CONDITION
MET. If it didn't (or will not) fit then it returns GOOD status.

The goal of this patch is to stop the SCSI subsystem treating the
CONDITION MET SCSI status as an error. The current state makes the
PRE-FETCH command effectively unusable via pass-throughs.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |   11 +++++++++++
 include/scsi/scsi.h     |    2 ++
 2 files changed, 13 insertions(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -857,6 +857,17 @@ void scsi_io_completion(struct scsi_cmnd
 		/* for passthrough error may be set */
 		error = BLK_STS_OK;
 	}
+	/*
+	 * Another corner case: the SCSI status byte is non-zero but 'good'.
+	 * Example: PRE-FETCH command returns SAM_STAT_CONDITION_MET when
+	 * it is able to fit nominated LBs in its cache (and SAM_STAT_GOOD
+	 * if it can't fit). Treat SAM_STAT_CONDITION_MET and the related
+	 * intermediate statuses (both obsolete in SAM-4) as good.
+	 */
+	if (status_byte(result) && scsi_status_is_good(result)) {
+		result = 0;
+		error = BLK_STS_OK;
+	}
 
 	/*
 	 * special case: failed zero length commands always need to
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -47,6 +47,8 @@ static inline int scsi_status_is_good(in
 	 */
 	status &= 0xfe;
 	return ((status == SAM_STAT_GOOD) ||
+		(status == SAM_STAT_CONDITION_MET) ||
+		/* Next two "intermediate" statuses are obsolete in SAM-4 */
 		(status == SAM_STAT_INTERMEDIATE) ||
 		(status == SAM_STAT_INTERMEDIATE_CONDITION_MET) ||
 		/* FIXME: this is obsolete in SAM-3 */
