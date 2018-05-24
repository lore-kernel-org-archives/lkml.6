Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159540-2-11799210942003890130
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
    1527159539; b=RlyHfnaRanX4fT2+B8OC20sQwTzhd/8QFiUysK4wMx+598lTyr
    xIzu5AZ3vZ1DszyxijxgWKfbjeXy2QZg9i1uzU5xYXSUQf8yxOiYjJZSDCzAekrH
    LtuV2i6t70jB54XeYJ2z+lakoXad1xu031Fi5YhuyuqJiNIHUkuJKkGDKccOB+sg
    rL0zRO/RhCjcpAbouQSiSNpAKhc4rEsK2mfmC4uMfwAqRFzs9t+2joF8TRj5o7i2
    6UgY6Tr2j3vhvwxQSgB4YC9cXYksCl+ntf8olWoUvgpRZaxVkdBB2AUD9WRQOy39
    X6URf7PySpp0j8Hf9Zf50iFI3/KoY1UiQDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159539; bh=qAWPfylwybBxvLTgshJD9loJC6aEzx
    rI0Wj8mHw9Ibc=; b=ksOjiqEjq2lbCyRsbmBUAwCjG7aIIDlkvkMwk3bVaYar5j
    IZUxqoc1IwZLAGCFa0FkOtntKBwJ8hz2AqLmfqvG/NSN/NhxqjtG8BE40AnrhpAf
    wyBBxIK7nSp/2VJFYe8nxURyi3+zjtvAUn2X2FljjgTA/lBuCikIQ0zEnM7Cmrns
    YgWKH62dMEPCor1TsqSv5xBs2Py8ypUpGf3xTT7SCepRyMXsfA0wE1XnGI4LBfwY
    +BO3+CtWHZ9+GmhDd5xvifiYoBRQbHARocJ3GB7Or+vqS8CNm9hJsaVInXWPUyKb
    GmA+NxcoKoCrK3hIqMAYLGzc7QHVN1jTFeTrS8hA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=E/E8KVMO x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=E/E8KVMO x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPpzRcCByOIetaPVUCGuaCorBM7miGBFaxcCC2iwCr26wh1s8lrD9BdpdVxOwSdhIlRSSLH+WXpbQRrXhRUxGnADyE3HIAXZC/bE1T6absaE1xYjlgjf
    O6qumcAgD61BhpOB77/QXlmI0snBiS2243Dz77BzRsHdb7oQkXSM+U6uwy1XkOn/F+pfh/1/utfE0ZpcmMIrBPLEoGZYpilW6sgphTM2utN9KlWlh3iRdd0M
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=zuh-aFpa40O1fhjOi1YA:9 a=QEXdDO2ut3YA:10
    a=4LA4qAFo6bo561LpWNDU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030208AbeEXJzx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030199AbeEXJzs (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Dupuis <chad.dupuis@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 102/165] scsi: bnx2fc: Fix check in SCSI completion handler for timed out request
Date: Thu, 24 May 2018 11:38:28 +0200
Message-Id: <20180524093626.145961914@linuxfoundation.org>
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
@@ -1865,6 +1865,7 @@ void bnx2fc_process_scsi_cmd_compl(struc
 		/* we will not receive ABTS response for this IO */
 		BNX2FC_IO_DBG(io_req, "Timer context finished processing "
 			   "this scsi cmd\n");
+		return;
 	}
 
 	/* Cancel the timeout_work, as we received IO completion */
