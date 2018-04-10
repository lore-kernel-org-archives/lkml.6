Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399651-2-12314879255830671031
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
    1523399650; b=u6mPOocDAtphPEfzKk1SzOwX4vBl6zEeChvmwyfCMo+oS8wwhl
    oC//LUijaRg6HdnK9Bi0TW6NqS3Rh6Tf2+A53kj5TpCK/Y/3eTBRx57IouVIyBrD
    tdGhLNeRajCh51anvvv0YwHEEwLLAzAixxJWfcrlASRFzc0iKT3ENq6fDhtFdCI+
    /nmS4LfT0Ans6wPvFQNNdjvPy3pnbOKtfl+hU/EjMtwBNC0u7zTp1YVhMvBudDBS
    WTj2Y5jB/oj1w/6RGHUoaxxFFgpAsVij48CMDhB6XcZ82D6Ve4HFIxR51xzliEv5
    aiZDJ9XHiOzjynDCDyfJFWh+N9EKibD3O44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399650; bh=+nG5G3jdv55ZqU+o07ZQpbCTFfo/IU
    bdiP7M3Ijrrk0=; b=LJkUi4aC45aaY7zAxA0g7UYn0Lm7ryQqZJzXOzUFiabLvJ
    oOgpSPAiY1f+74lU+e+Bxe3giqp4Y1avKuKOJkwbnyQlWSauz3Q9HalG4MytBHVR
    VAfafY/DX6+euh1rICE2x11CViHxSRtRBFalsV9Aqd4KLOr0/COcrrYSOn1YqHeS
    mwl33zetHYtGd+0rVbLXmAWOgJjWiQrV0IavBdL4JVafsxOVfAarE2OJ48AbBF8N
    s7PbUZ9Ti8S2iZ9iWjVZaK2kuVQ0h6QIF05WSg5gDnxpPX7XAJa7XgwflZB3ZFdv
    eyyI5oNzlMtFGd2xevgGIjDATEjJFmyxXbcnKZQQ==
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
X-CM-Envelope: MS4wfBjVDdWWhR77iEQeK0FgErpMZi++DhyUP4dV6oj0x6iBHmIR6QJkqZcBNrv8hg9BVqxKw8LVuFmkcKb0FvcIuyH87rJMUBoLvP7USlH65n/p2Oyp/vek
    VmWQqz//eOyu2801YdjdHEj+7aPIwtmU98wKxguZYxeFcz/vSDWl2v531WYuGDl3rkL+oW1SSV1h5QbCj8lLAd6+VmhceUuHeMdKnnQ1ib+F16e/jJADnmhO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=R7Tl_P__Q-iyW6jnybsA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbeDJWeH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:34:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbeDJWeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:34:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 013/138] net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg
Date: Wed, 11 Apr 2018 00:23:23 +0200
Message-Id: <20180410212903.684791911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Fuyun Liang <liangfuyun1@huawei.com>


[ Upstream commit 27b5bf49f0924fd62d2b1ef8467b40773973da34 ]

When phy exists, we use the value of phydev.autoneg to represent the
auto-negotiation state of hardware. Otherwise, we use the value of
mac.autoneg to represent it.

This patch fixes for getting a error value of auto-negotiation state in
hclge_get_autoneg().

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2092,6 +2092,10 @@ static int hclge_get_autoneg(struct hnae
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	struct phy_device *phydev = hdev->hw.mac.phydev;
+
+	if (phydev)
+		return phydev->autoneg;
 
 	hclge_query_autoneg_result(hdev);
 
