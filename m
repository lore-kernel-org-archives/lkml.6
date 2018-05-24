Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155356-3-17263930381142994850
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
    1527155356; b=EBoOJwfDRqPTk5TEOrBhTnQUurprGctIolknesTqel2qlosszc
    VpoijWYRQmOzMHkcKlyPmmvMh3Erwt8BbNZeSX76k9gBgbgAVhQoUFKiKJyzaWBE
    7jcUCTQqRa41Hnv37XvmMhyn2Pv+wXMRYBkaWbJZHgTPak7REsQtkob2oLEgbqv6
    aTEzvsdXBtaeDr6Wk6KnS2Me/tVY4WBWfpRxiBoF2DGqmi4a0jXb9pQMqkXSkbwy
    A2dp4QF0nEjOwi1iS1LtLBNX8MLkwZvWilIR6l4JrMa3qe4YFOccxOxWY4dIopFr
    FbwVlU4aKoxAg+pjlq67szofxRqoxtmDg7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155356; bh=CT0tinMCMnHAlpsUo9SjcWizbEklNs
    FLyIRj/MRZc/0=; b=SoXCM7e1Jm3pYIpvvjL4JRE1mFhqqjnKHxx6cM8ARQhIwc
    GHMAqpkw1kmBhu/8W4MTI3KZJKBH57FLCb3KFzuOK96K0HKxdMrIaSJsY+cQxdVP
    ZoO/oTZsBPEimhw6MBdAqshQbjSgCBqIL5gQzbUyDvaOJ4vNi6VrqMUkS5h41BEK
    dBwuYJ2bYuS7UGPCdEFMsBIl+RGKOuyFVpuzEf3fKjWH6SRyB2+rGH91Y9IvUGje
    k5CjyFYIc3oEpHbkjr5rhXrilLw7bvYCrHZwbgGBqwYrdTyy7mD7bm81Es03rGus
    jSWgQqYy0aJ0aOGtkJXPz2FTQMqZ126EU5uSA3dw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cA/w39QI x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=cA/w39QI x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCMXfpW5OsdCJGHOWBADKRnsjxvMhLk3AaKVKSQUIBJmI6889ZGUNz2y6qNm70ne/ptsjM0zdqn+gJqXh95hRWiywa27ZLSCEx/K9fGmFSGijO1OUn1D
    ch8uUNvgPw+4W4pdptKSrhjyF/XJlsomS3m0/37I1JSKO5KnYQSeQO3PLz4zizKYrZ+v/jzvJTQbeY9d/nsIKGD7JrxUj066E1bKityqD7F11xXDdNmc44bb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zobwxN-apzL_bq59u2oA:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967333AbeEXJtK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967316AbeEXJtG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 52/96] scsi: ufs: Enable quirk to ignore sending WRITE_SAME command
Date: Thu, 24 May 2018 11:38:35 +0200
Message-Id: <20180524093608.465897980@linuxfoundation.org>
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

From: Sujit Reddy Thumma <sthumma@codeaurora.org>

[ Upstream commit 84af7e8b895088d89f246d6b0f82717fafdebf61 ]

WRITE_SAME command is not supported by UFS. Enable a quirk for the upper
level drivers to not send WRITE SAME command.

[mkp: botched patch, applied by hand]

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3338,6 +3338,8 @@ static int ufshcd_slave_alloc(struct scs
 	/* REPORT SUPPORTED OPERATION CODES is not supported */
 	sdev->no_report_opcodes = 1;
 
+	/* WRITE_SAME command is not supported */
+	sdev->no_write_same = 1;
 
 	ufshcd_set_queue_depth(sdev);
 
