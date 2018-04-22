Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406034-2-14637089678867099089
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
    1524406033; b=de8iiPbaSob/aKIVftPLH0TeQI/9L/nHHcWeEzTZ6C6MsOp0lh
    u0yvDlcZ5/KTZlfKBHCFk5wmkcGFCW9WAOKmjI9VynrDOYq6fVItiYvsU5wOUc5D
    5tvM4fAY9LjUiCEGM8y4/3z5MTS0hz3BT0ghD3PFQ+Ah/AuXJguQguemJXPNWNVJ
    FEWGJWKVbBAyt69gEJpoPbcVdB6BuNHq9ozg0N1rpVJLf7U37AvqOkyoJCCkUIzJ
    QvZ2ijzzBtE+juOOsMwkBwUw1MtIrmvq1vcbqpg+q/yTJORWLZnUW/5lgulpZV3v
    TqyEytNXo1aHCU6Y7KmDwWzqisnO5JThKWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406033; bh=r0I1JtfBFzUlGqwVsA8sVzawZYel5b
    3PcvGfgXRTq1Q=; b=ItRZtcaKfAFhfCi1iwVe8ZNAlyVkgmlPNe2QiT3IhD9vfk
    mW9yoVw3z0e/5oo5eJPYhOF1O7vH9xz8xYdQNCgDDFwjU0ghTu6eBOO3YzhNtNVc
    EAbhL0Wmf4xMmwCmh5Ohf/onVKJhtOhHyRzab0Kbh7O4JAwzZCtQhryL9m1kqWut
    NkDMcDZ2NOh22hqEmEas0pY/Bzq4WMd49HBwO3OBqselp34iJ09QX8CvsMoqJ6lZ
    aTFuG0MI+oPWP0q96DOFlzs1I1IQHbSfKH6vogWtwYDOcxsLhBZwHREPl8wNtwDP
    CWZZLCL4KLM0hOlEdzkgVT1lYw+vUiohUWx1OwnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEPrZ9POi16+YlYYkxNAHfzLTihqdxAIv2Ts/BhLTKzu2VyXbQTrmaEOqZrrYlNngLMoSXAA77PrlZHyNWSlFJAB+d4DgQT/MxSRejc5CMZHhGaPlxyL
    q5QxnIAxmqYslWH74HPJ94qxMYI1U9aFnGfo4OpLS0KXJ2E0Bytn7y6ckxcpGafoAykL90dWOjmuZe9m5e13DBT6lsxc77kIGJVA4mk4YWcC1/SWCjcZmIZW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=WTJdmG3rAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=CbDCq_QkAAAA:8
    a=ag1SF4gXAAAA:8 a=pRKBuYtNHWmjaJ5dfTQA:9 a=QEXdDO2ut3YA:10
    a=q3NGepEMMmKWaCv8Sx90:22 a=AjGcO6oz07-iQ99wixmX:22 a=cQPPKAXgyycSBL8etih5:22
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755720AbeDVOHJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:07:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755617AbeDVOHG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:07:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com,
        Roland Dreier <roland@purestorage.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 086/164] RDMA/ucma: Dont allow setting RDMA_OPTION_IB_PATH without an RDMA device
Date: Sun, 22 Apr 2018 15:52:33 +0200
Message-Id: <20180422135138.947598551@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Roland Dreier <roland@purestorage.com>

commit 8435168d50e66fa5eae01852769d20a36f9e5e83 upstream.

Check to make sure that ctx->cm_id->device is set before we use it.
Otherwise userspace can trigger a NULL dereference by doing
RDMA_USER_CM_CMD_SET_OPTION on an ID that is not bound to a device.

Cc: <stable@vger.kernel.org>
Reported-by: <syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com>
Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1241,6 +1241,9 @@ static int ucma_set_ib_path(struct ucma_
 	if (!optlen)
 		return -EINVAL;
 
+	if (!ctx->cm_id->device)
+		return -EINVAL;
+
 	memset(&sa_path, 0, sizeof(sa_path));
 
 	sa_path.rec_type = SA_PATH_REC_TYPE_IB;
