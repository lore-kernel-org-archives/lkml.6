Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F054C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71005206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217559;
	bh=gjasH6qdMR2QYA99PeorE//4LgWN8t5auIY/hsiAshE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sw5Ea9AMS+IiO6RJdS63MOD3VDo8aFfBYU+ZxuWKEGZjIfWEa6Z+7COLoTNcDrD/4
	 i3wBL36opUDP4FksWbYEADzJsiyczZpk2eu3/9TbphfaiIlhoFI0kPZBGM5/xaE9Og
	 UJwXVVJ0by68QQrp6aur77dGi0mSF4TnY+0FeGug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403788AbfAKOjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390975AbfAKOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC4A206B6;
        Fri, 11 Jan 2019 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217555;
        bh=gjasH6qdMR2QYA99PeorE//4LgWN8t5auIY/hsiAshE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaSnASIyCexYVlVqvxzXphjJ87e9OII0ft8TpBNUvpVhBsCyprCCQCI3/9hnmUug3
         MAZ0fmU3cY77T/qIo9kWcxtWlMG7pfD2ZMceZA+CoirNegq8RfzZsw+EzBQLI1eVJl
         3CWSj9UQbyUSjiOZW+X38F8czyC+tBUnnjKNWSuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4.19 102/148] mt76x0: init hw capabilities
Date:   Fri, 11 Jan 2019 15:14:40 +0100
Message-Id: <20190111131118.305472836@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 0ae976a11b4fb5704b597e103b5189237641c1a1 upstream.

Enable hw capabilities supported by mt76-usb layer
- fast_xmit
- tx/rx amsdu
- MFP
- non-linear tx skbs

[This is one line hw feature backport from 0ae976a11b4f ("mt76x0: init
hw capabilities"), which add also other different features, however
those are not supported in 4.19.

802.11w is supported by mac80211 and mt76x0u driver in 4.19 correctly
fall-back to software encryption when 802.11w ciphers are used.

Without the patch we fail to associate with WPA3 APs, so this is
considered as fix.]

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[remove marking non-working features on 4.19, make topic correspond the change]
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -681,6 +681,7 @@ int mt76x0_register_device(struct mt76x0
 	ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 	hw->max_rates = 1;
 	hw->max_report_rates = 7;
 	hw->max_rate_tries = 1;


