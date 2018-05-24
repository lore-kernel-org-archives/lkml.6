Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163753-2-5812041521067005821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163752; b=a+xeeTvjvvXgYxbLjpdB35/qnbDD31RiSLUoY6SRSzVV+0C3tE
    KAVgMLJ9BgCmKVv5DtJalVC1bEWVs/bF0shELFEK496VABsdK/OEHnykvuR8xahe
    5WWoerG2+tS1gry8cXsvlK7M/adEMFrK4XJHRLcuPaUVch1xuXlGiSLNyolA8YeD
    E+QJAkWRcM4rBriVyNbL/SG1130EgWT9YuMiQdqTC52Ag+Cup0VWDz0aCBvp7RC9
    urdwXbLTCUhSxFErS3QoemVsmnSk07yVAw8vZ5DPPIKuNlB045NqZrrs2HgXHUWE
    vsjtoTLn5BYL3m8CrErH3OVsfFbfD5tx/Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163752; bh=K4gfc8QDThRcqW/J9bzMVoUnVRcVrS
    WRzfhivSIAoDg=; b=dX50zsZTjbkIormn5WMKHuoRZQfgSC6wXLVfggHWJpN6o9
    X1cj55UWiqD9xRP6DjoZ1M1KfRrPfnuZ/0l0iFFu4Z2dwdbD92xbumFkxxRspBwd
    x4Ns9HezjVeZVMKavSYM6Bky3SeyHcUsezoY3jYlwof2vPZVyqawGJjhiIEHjB5V
    nCtBVrxN7Wmljqyf4GjJbeuYEDXJx9L0MBk2tLd9v4915N6BC86rV8odbKDdTFGb
    /x7EQ+CTwC8kINcEuUHi1bMd9RUEmiLapyKEEwcjiaVLi/0MCOKjzGU/odmLRhJ1
    w02V1UJvUFH6K7bkr8F0NmIGgry0Pe0hfOyI/Dqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gRV3PFKW x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=gRV3PFKW x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCYuceHO0X/VtIUi/dpMx/O4jeKJAZDF5KxBC8NGrpUA33vkKHis7t0P/o43fjKnPPkSErSEMw0UnMZaZV0PtKMTSFVLsYwZkI0bwJJNNO9rFA7dYV0g
    IPv0caqeiAHiBbq92lDENqEHCA/0iX+wKJiHptMIuu1LFtuoKydg9IIbfS4rbu/8TDFEdpRjjtqKCIEHvm8O3ihdkvF4BA18YELisBagdaWp9Ytkl2bZzkaD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=cL7Fm0gwRX7DZRRuklwA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966518AbeEXMIn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966353AbeEXJnh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 07/92] net/mlx4_en: Verify coalescing parameters are in range
Date: Thu, 24 May 2018 11:37:44 +0200
Message-Id: <20180524093159.933798620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit 6ad4e91c6d796b38a7f0e724db1de28eeb122bad ]

Add check of coalescing parameters received through ethtool are within
range of values supported by the HW.
Driver gets the coalescing rx/tx-usecs and rx/tx-frames as set by the
users through ethtool. The ethtool support up to 32 bit value for each.
However, mlx4 modify cq limits the coalescing time parameter and
coalescing frames parameters to 16 bits.
Return out of range error if user tries to set these parameters to
higher values.
Change type of sample-interval and adaptive_rx_coal parameters in mlx4
driver to u32 as the ethtool holds them as u32 and these parameters are
not limited due to mlx4 HW.

Fixes: c27a02cd94d6 ('mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |    7 +++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -967,6 +967,22 @@ static int mlx4_en_set_coalesce(struct n
 	if (!coal->tx_max_coalesced_frames_irq)
 		return -EINVAL;
 
+	if (coal->tx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_low > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_high > MLX4_EN_MAX_COAL_TIME) {
+		netdev_info(dev, "%s: maximum coalesce time supported is %d usecs\n",
+			    __func__, MLX4_EN_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS ||
+	    coal->rx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS) {
+		netdev_info(dev, "%s: maximum coalesced frames supported is %d\n",
+			    __func__, MLX4_EN_MAX_COAL_PKTS);
+		return -ERANGE;
+	}
+
 	priv->rx_frames = (coal->rx_max_coalesced_frames ==
 			   MLX4_EN_AUTO_CONF) ?
 				MLX4_EN_RX_COAL_TARGET :
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -140,6 +140,9 @@ enum {
 #define MLX4_EN_TX_COAL_PKTS	16
 #define MLX4_EN_TX_COAL_TIME	0x10
 
+#define MLX4_EN_MAX_COAL_PKTS	U16_MAX
+#define MLX4_EN_MAX_COAL_TIME	U16_MAX
+
 #define MLX4_EN_RX_RATE_LOW		400000
 #define MLX4_EN_RX_COAL_TIME_LOW	0
 #define MLX4_EN_RX_RATE_HIGH		450000
@@ -518,8 +521,8 @@ struct mlx4_en_priv {
 	u16 rx_usecs_low;
 	u32 pkt_rate_high;
 	u16 rx_usecs_high;
-	u16 sample_interval;
-	u16 adaptive_rx_coal;
+	u32 sample_interval;
+	u32 adaptive_rx_coal;
 	u32 msg_enable;
 	u32 loopback_ok;
 	u32 validate_loopback;
