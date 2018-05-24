Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161901-2-14126354982928912027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161901; b=Z9ernNEyn5wtU2/k3hlOb5elSxtcXmBQFaxNt4hVYec2d8qyPe
    q25n3W/XsrVSUmlgpTXCclSI5Be0/UBDY+765T1EBULLIUsvEq+43StaTv9QCEeh
    +hXkeXngZViP0T2521eHnnF/hIKv9rzgz8eyadseVf11Kbc9vupE0D1rNhBoLUWJ
    hOFLdd1gUzC4I5+0MifaXxTbNB5lNGZboR99OADPCRXcQEnPb2Yncp49Ib0f529p
    aImpfnB0mhWpEWjTuoGWG+JSoWUyt8Qjiy990Xr6NLHxgRh7sjV0Xb47I4as58Ng
    aNPdUS6++xVv3jMi2JkEHI2BXknpfj7DQ5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161901; bh=c+UcT6xMKq4jhKV3Pgndw/0DrSmDGt
    vcOxJaOyA3PuE=; b=T/Djy/wW0nEvO7SLxRmLuXEtiFweDPYsNWOykxCzcjT+mD
    4o2nJ20l8bTGoLPuzjt9oGGoQ1KVZequrtasfZk2YafI7hg5tpNzpjvQSo0j6ns4
    0AhQYI/dnivHMLii1Kt5s2182sbrDX/1kYDq8AnqAPcWidvu/mwIXE10hQvybq4Y
    YFsiUWt0Ns2tVuQWMHQr2zZK0+Vzl83JDHaMtWjxAy98uRqhSrPgrb8BU0Ld1dio
    XLRHjqZDMvQTrTJCNzFl/BvBYPVjWvU30UJbFAVuPA+hNp5GeX1uNyg47nhcnAbc
    MVqNfM+ZjPUrGtDWSxrHdj+QZsaWEcq/xgVW/9og==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jI2YTlqF x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jI2YTlqF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN4NLcYWW2+Mw00Ksr0LJtf3miHFr/tByjuLwK3GbxTqt0DFZ7gru57fjIAk2gGjwhTK5476MXsbUc21BeagFgb7PUD9yk+BPG8jR5jETlTEPZPicCbQ
    OdWvKV7cG5VS//jIhpGPaNZWWSW5F1gxN+ZkmJd5+hm2Of/QgncpDHd8nv7mcTcje5+WNvBn12lxxRgwLyuGhmvXKDXl1IAJXEP5BSTYrF37yVgiJ3voxHxo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=vA3e__QJ6ZNYtID03woA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967375AbeEXLiF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966984AbeEXJtW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 57/96] scsi: storvsc: Increase cmd_per_lun for higher speed devices
Date: Thu, 24 May 2018 11:38:40 +0200
Message-Id: <20180524093608.760890950@linuxfoundation.org>
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

From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>

[ Upstream commit cabe92a55e3a12005a4ac4d3954c9a174b0efe2a ]

Increase cmd_per_lun to allow more I/Os in progress per device,
particularly for NVMe's.  The Hyper-V host side can handle the higher
count with no issues.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1580,7 +1580,7 @@ static struct scsi_host_template scsi_dr
 	.eh_timed_out =		storvsc_eh_timed_out,
 	.slave_alloc =		storvsc_device_alloc,
 	.slave_configure =	storvsc_device_configure,
-	.cmd_per_lun =		255,
+	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	.use_clustering =	ENABLE_CLUSTERING,
 	/* Make sure we dont get a sg segment crosses a page boundary */
