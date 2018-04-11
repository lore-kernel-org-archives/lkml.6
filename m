Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477878-2-18211711027831762168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477877; b=FG8SeuEsBE5EJkz3shNVlxbTCD1Hk1r6hW88zqTYJ1cyJ+qDbW
    gl/eD3ZJyQrgUuof05ZjbMWkgIxgdt6YTMfnnwYkU+OxY02hocLxfc6OICX4/qIE
    bMNGbsKbnMFT5NaxSpf6Fy8DdF8SvVGkO5ISga3NNDDtLxk02O/IDBjbcnngV++4
    jRafYhwBEeZbE/h69ebSwiSNHBdBym9+4bE2uJMTvZ84dgxGDB3qZwCzkOqguLn8
    rTSKDTVB+8g8RJ453tCRWbOmqPH/kZYWdy7tyIplE613NI/yhC8xaCJBhsgbAU/h
    X7eCgraNCteU+jgb3ywIq6W64WirjmQmPlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477877; bh=//nM74U98c7D/HExvCjSdst9jdIhVn
    44Llx6Pofv13c=; b=nft9YKmZHf3EN40j0ariAsGeCacF/bOFOB9nONrUu9oLqY
    8DCeB5YYZlUhuVyi3s2kBxxSNFDRq1Jq4KxVIWSh7ZNuS1y0aW06aS6Lts2256bK
    2oUdwwzDztogd7njn9Y4sW7buaCijTwzbXrgU+XRvbNlTlM3PJgCnB2qAhzeGagL
    JkbQry+y/g1wrg+QQ8bgNKEvBrOzX7zK6rpL5dPpaled6/MvN8tZsIuf+Zl0XJhn
    zfouc8MbB+lPkuQd7LgMtzlNwmPp6vopiIFX8h5P2uUbv3ALFU87RRdyGYEZO934
    C9kY6MOKVRZ2jJD4v8rv3LJU+thmQXx+R1YDHVQQ==
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
X-CM-Envelope: MS4wfNZYwpSewTtpNXOK3vdDNoS6tRL6wUicgb1az66PznLEEJ2p5fSBAaW0LfL96VQnQDT/WiamtnyM5FObgxYdkZ3P1ujNx8R0R69wDEt4bedxvQoLqIOD
    gB9mLQuxaErivneeT+EsPJhNqDH0QLEl8PmtJ7LESJKoF9IQc1Y2tgmQ9/dDn7UcgcHHlH5N/F9R1/APxqvQ5lAfjmoFx/gS55OiGu5HwtAU+OF4I912zHGv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=lezMSzkynHcXg2P4JgYA:9 a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeDKSwm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:52:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933116AbeDKSwk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 001/310] qed: Fix overriding of supported autoneg value.
Date: Wed, 11 Apr 2018 20:32:20 +0200
Message-Id: <20180411183622.365116317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "sudarsana.kalluru@cavium.com" <sudarsana.kalluru@cavium.com>


[ Upstream commit 34f9199ce7b7e5c641b96e928bd60e086bf7f278 ]

Driver currently uses advertised-autoneg value to populate the
supported-autoneg field. When advertised field is updated, user gets
the same value for supported field. Supported-autoneg value need to be
populated from the link capabilities value returned by the MFW.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c  |    3 +++
 drivers/net/ethernet/qlogic/qed/qed_main.c |    6 +++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h  |    1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1628,6 +1628,9 @@ static int qed_hw_get_nvm_info(struct qe
 		DP_NOTICE(p_hwfn, "Unknown Speed in 0x%08x\n", link_temp);
 	}
 
+	p_hwfn->mcp_info->link_capabilities.default_speed_autoneg =
+		link->speed.autoneg;
+
 	link_temp &= NVM_CFG1_PORT_DRV_FLOW_CONTROL_MASK;
 	link_temp >>= NVM_CFG1_PORT_DRV_FLOW_CONTROL_OFFSET;
 	link->pause.autoneg = !!(link_temp &
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1240,7 +1240,7 @@ static void qed_fill_link(struct qed_hwf
 
 	/* TODO - at the moment assume supported and advertised speed equal */
 	if_link->supported_caps = QED_LM_FIBRE_BIT;
-	if (params.speed.autoneg)
+	if (link_caps.default_speed_autoneg)
 		if_link->supported_caps |= QED_LM_Autoneg_BIT;
 	if (params.pause.autoneg ||
 	    (params.pause.forced_rx && params.pause.forced_tx))
@@ -1250,6 +1250,10 @@ static void qed_fill_link(struct qed_hwf
 		if_link->supported_caps |= QED_LM_Pause_BIT;
 
 	if_link->advertised_caps = if_link->supported_caps;
+	if (params.speed.autoneg)
+		if_link->advertised_caps |= QED_LM_Autoneg_BIT;
+	else
+		if_link->advertised_caps &= ~QED_LM_Autoneg_BIT;
 	if (params.speed.advertised_speeds &
 	    NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_1G)
 		if_link->advertised_caps |= QED_LM_1000baseT_Half_BIT |
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -35,6 +35,7 @@ struct qed_mcp_link_params {
 
 struct qed_mcp_link_capabilities {
 	u32 speed_capabilities;
+	bool default_speed_autoneg;
 };
 
 struct qed_mcp_link_state {
