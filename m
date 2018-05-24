Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155376-2-17019623606199407434
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
    1527155375; b=l/O1w/awlNvDbtXCd046MGxVNm7hDFc0KUALB8zHbFfMfDg3qB
    HFgkazGyfkYh8VApbXKBsCbqvKMnYe82pCfnhgxTbUk57Hq4tdS0i1/hb0ZBsN/I
    JRalesD9mjdz7KxRG5zTqCa5mkXpeSegeETJmvzBBBAOzuNd7Fgg4QQ2vp/3sA14
    vdFTvhZcmfcIl5JZtDTcR4Egvyg37ca4/EolKyxbAo3W34xZJt1QvxAJLPDfbW8w
    rRQ++NZ43khRA5vM3+7CEicO5qG3wK0j3KGS0GMroFPzJbXvvyNYEkvS+lwMIPy3
    nOdBDsbnqs4hujXL7JGFxrYTZZzkkzDELAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155375; bh=YAAzd/9adddi/jxpflj8fDwwy6Pahh
    VswdYWxEZgPHY=; b=T0WraaSqR3dHw6D1LFzXWJBtfstvnGKKaTZ0Nq2DNdkot5
    UjHSnLGAVCnmgDCdRXsLJ8BFI5QuijgYulvm+TzflFpIb63hn729JsUnwRETRzxB
    X02sIaMt3xiL9DVujjtuckG22iVCa5D6BBiDs6/QOj8we9T6fgoXSPJiMYaKavS9
    f+Lg+VCzErGDo1DVW/XkOSM127ob3W4Dk4Irycl9x4pSKU78QXaSpKDP8I0CjyFj
    Odyypq4zDD/EF/sO8DL73ayT++MPR4d3CwiV1Mu9XqCGjZzkKOwKenG9Mq9umFlW
    SOhgVF5Y/AHJa294+mlDWnJ5Ig3ZBiCffUZ8N6zg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mYZWFqnt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mYZWFqnt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJCh/VDf5DZp1hQoftP2RNM4BoaUdKeKReDE0WfGJ9P2Gip8IOC7jT3wSkoeD8kHJFjl1j9M+PPQjkMVoB4T1fqAwrfb6UpE37q07RB3qi55uiAxq+JS
    FaDVx6mUrEYcXT9dn/Gkn7VHtJBqFEUPPP2Y4VrT74BM1CzhA/dmWcJsFvMsHZEwSDsTGN6DD5L+qhMgW0/xaY/GSMQc6Hcy0V5HhAGf6nha8gCmCU/s+acW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=uBuKx8GwAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=XjZB3Db1R4rdm5aNK6sA:9 a=QEXdDO2ut3YA:10 a=wZgZ3yaTFkxMEWn-yT5t:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967350AbeEXJta (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967384AbeEXJtZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Dave Carroll <david.carroll@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 58/96] scsi: aacraid: fix shutdown crash when init fails
Date: Thu, 24 May 2018 11:38:41 +0200
Message-Id: <20180524093608.811627745@linuxfoundation.org>
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

From: Meelis Roos <mroos@linux.ee>

[ Upstream commit 00c20cdc79259c6c5bf978b21af96c2d3edb646d ]

When aacraid init fails with "AAC0: adapter self-test failed.", shutdown
leads to UBSAN warning and then oops:

[154316.118423] ================================================================================
[154316.118508] UBSAN: Undefined behaviour in drivers/scsi/scsi_lib.c:2328:27
[154316.118566] member access within null pointer of type 'struct Scsi_Host'
[154316.118631] CPU: 2 PID: 14530 Comm: reboot Tainted: G        W        4.15.0-dirty #89
[154316.118701] Hardware name: Hewlett Packard HP NetServer/HP System Board, BIOS 4.06.46 PW 06/25/2003
[154316.118774] Call Trace:
[154316.118848]  dump_stack+0x48/0x65
[154316.118916]  ubsan_epilogue+0xe/0x40
[154316.118976]  __ubsan_handle_type_mismatch+0xfb/0x180
[154316.119043]  scsi_block_requests+0x20/0x30
[154316.119135]  aac_shutdown+0x18/0x40 [aacraid]
[154316.119196]  pci_device_shutdown+0x33/0x50
[154316.119269]  device_shutdown+0x18a/0x390
[...]
[154316.123435] BUG: unable to handle kernel NULL pointer dereference at 000000f4
[154316.123515] IP: scsi_block_requests+0xa/0x30

This is because aac_shutdown() does

        struct Scsi_Host *shost = pci_get_drvdata(dev);
        scsi_block_requests(shost);

and that assumes shost has been assigned with pci_set_drvdata().

However, pci_set_drvdata(pdev, shost) is done in aac_probe_one() far
after bailing out with error from calling the init function
((*aac_drivers[index].init)(aac)), and when the init function fails, no
error is returned from aac_probe_one() so PCI layer assumes there is
driver attached, and tries to shut it down later.

Fix it by returning error from aac_probe_one() when card-specific init
function fails.

This fixes reboot on my HP NetRAID-4M with dead battery.

Signed-off-by: Meelis Roos <mroos@linux.ee>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/linit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1203,8 +1203,10 @@ static int aac_probe_one(struct pci_dev
 	 *	Map in the registers from the adapter.
 	 */
 	aac->base_size = AAC_MIN_FOOTPRINT_SIZE;
-	if ((*aac_drivers[index].init)(aac))
+	if ((*aac_drivers[index].init)(aac)) {
+		error = -ENODEV;
 		goto out_unmap;
+	}
 
 	if (aac->sync_mode) {
 		if (aac_sync_mode)
