Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161945-2-14002343529875365967
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
    1527161945; b=boHWYznrKbfUbjN5cd5lU6EYcbphUG/nTEOXW3XPILy/0Ypoiy
    V1dYpr1Q+TfptbomBXm4whjqXLWT5LbHuLDyRzb01g4M9BtrvtJnOL7xyqu8yt3F
    C3H8KxPL3hkYGBgYDd4s0cfhDP4DXhCPitWkYm4J3iHzV20nYW6CS/l+MUHMH/GG
    a8T7lYGeQRek3it5tIF5Gp1Cl8OxdcWovV0Anz1Z86Ed807yPStSs5nnCsPCiVJo
    Ut/1HeKa8K1mTo7wDYVi3nD4Szq6cbHM6DAMKdTYtzLPls7z+v9C4rN9ri3/alD5
    OyzmCmDkj7kSnfzl+UadNyo2WsgjLIOvjXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161945; bh=OtnT9EctqtAgxPRd3Di8YKbvUiSbUY
    KfLjLfTwCYrqA=; b=b+Z3zfTe4fjLFwDYR29ioRkoVyuf45K23LC6GYve7Fm2uV
    9YEdAh/jZ0Jmcv0Xo2/gKLGYl7CXRouYhu6QVgCiR4BHm54UZA1bnKq9WwgPE5E0
    yQhBSV8NzK7IR+NUvVF87dpVpbH9hp7H8Lx7WOLNB0IQMQkajMSxJDy/gcJUCrSy
    /lWHdDtYYZ/ENM8TiIFwMR1c8WaIqSUAO/glXm4YTsTtaFJnIdpSBBcDVhPItv3J
    rbWDYgWL7klbUQZ+L6CYFdN4mOnx7f8FyjJCBzI7X/6dvhljs5z6zbwIhnBrKTNP
    YmjxJvsxDe+U2egs8wCeOd9z6rF0+dlMFJTPewtQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d8So+MTp x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=d8So+MTp x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEMKhQSP6rt2N9knSriZ2B5Hj428xzhtH4xsSaCL6s6vrC5bd3Wh8RxlC4vYgUjNT9m9QrL9CxrKC/C+R7TvMLrB7zotunt9zOCdP81i0mfddECeI5zI
    +2ZxnoRhCKCijfIHlIa0jQSymRCfDV6E9qSodcdhZk4XxVkz7pPjk3gR84n+HKsJI4Fpoh1NAorqZDltc0IONh0z+l4HuMfvPHZunap8hclPyCimWevAJiWa
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=zuh-aFpa40O1fhjOi1YA:9 a=QEXdDO2ut3YA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967335AbeEXJtN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967308AbeEXJtL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Dupuis <chad.dupuis@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 53/96] scsi: bnx2fc: Fix check in SCSI completion handler for timed out request
Date: Thu, 24 May 2018 11:38:36 +0200
Message-Id: <20180524093608.545099158@linuxfoundation.org>
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

From: Chad Dupuis <chad.dupuis@cavium.com>

[ Upstream commit ecf7ff49945f5741fa1da112f994939f942031d3 ]

When a request times out we set the io_req flag BNX2FC_FLAG_IO_COMPL so
that if a subsequent completion comes in on that task ID we will ignore
it.  The issue is that in the check for this flag there is a missing
return so we will continue to process a request which may have already
been returned to the ownership of the SCSI layer.  This can cause
unpredictable results.

Solution is to add in the missing return.

[mkp: typo plus title shortening]

Signed-off-by: Chad Dupuis <chad.dupuis@cavium.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1869,6 +1869,7 @@ void bnx2fc_process_scsi_cmd_compl(struc
 		/* we will not receive ABTS response for this IO */
 		BNX2FC_IO_DBG(io_req, "Timer context finished processing "
 			   "this scsi cmd\n");
+		return;
 	}
 
 	/* Cancel the timeout_work, as we received IO completion */
