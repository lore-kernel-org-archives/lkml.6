Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2960132-1522805464-2-3586363181982756993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522805463; b=TFUhaU5OI9IvY28Fzzu5SMNWplvZUqTN2LX9MUsu9Y4sWMV7RZ
    BVwSMYv9KWuOdXzRSfH3nDkuZ4vWe7q8DA92yxDnq8Cv/nCImnEZPh52W8YzNoy0
    txxUNENPueU62UOv8u9bqvaWrDZm/wZ9XJV+v+buJ/vOuITnyavyv89pA5MEyWUW
    MErEe42j+9MvoamKTD+QI0GU2JwY0PnfMqpQGlHtmcg9W4/VL9ZeRnXLgQpnAd34
    9Bx41L4k4A8h57ItjBiTjm1Z5Ilsh4A/ktapC52l1jR1KJri2YgsuOydnmrx+yJz
    jTKsnxiElrvz8wmhGkWJyFS2rzavSEr6QK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522805463; bh=Wxvpk
    MCKstm4aA1GaGh0tWC+zNiiVDDuFkDsbzfVFiA=; b=f9MgpwYbhYAPV1zRMyYqR
    RGbW7mm3jW/7dlG1IcxPnDL/vQwSVdD8GHw6RZkd2Y4NIgquvywTnkWdVjYXs63Y
    845bYpRycgv73K8b+MpH+zxBF4WeqIvwgCjraYKraNFOsIGt5iuMggNBYXQ9B1Nm
    Z5GDH4aNdWl2gQecBcgxCLs5BpLxhOrYFL6+iRrrjFC/veV489xyVsX+fiOrPMF9
    jZjU1IH5qcOrlBDJFrIMDfs82Kp1ztDt3C/i6V2WxZP8iEcpYrbckSLigRAjq//7
    82bcKPTXsPRBT0R9neYfb/4cEIZUfUXnmLFIcipqD3Rlrbh8ec+ChjMzaSWDcYWb
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ewXol+if x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciuTuj+5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ewXol+if x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciuTuj+5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdJXFK59MQpRHMros8OD7GNifXi6lHH5uuylv8lHjV/oVb5ry4YHsGwSIQzFIbBebysKzuieaRgldeWKtI9G0gnu9nAPwFCKngm3EMRnZsvnxvrl4sx
    wk5qFwATG+T56d3RKwRGRs6n/FVbwb+M8I207pgH7B4A+o8Py7ACmZ4e7kWqfCfXrwzS2naprXCqbhVQadDLiXA4Fvz+gLnY/yIuIFFKfwW5/cS1xoMF7L/e
    zCbHsLIynLMy71Z09xNeOA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=hYmUjySZVVQA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=ebSz1K5H0lkh_LnaBu0A:9
    a=9EuuYhcozYrM_K_i:21 a=PIGTtmBwfBpZAOCA:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+RG8yXGXdxnwAUKOIx69CO2h/8WzzNzA9Zum5G/MGHNDbwq7nS1cbkShPBTJHKPqYUX9Ywrg==
Date: Tue, 3 Apr 2018 22:30:50 -0300
From: Jefferson Capovilla <jefcap@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: mt7621-eth: fix line over 80 char issue in
 mtk_set_link_ksettings()
Message-ID: <20180404013050.GA31356@jefcap-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, , linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix 'line over 80 characters' issue found by checkpatch.pl script in
mtk_set_link_ksettings().

Signed-off-by: Jefferson Capovilla <jefcap@gmail.com>
---
 drivers/staging/mt7621-eth/ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 38ba0c0..e9f4092 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -52,7 +52,8 @@ static int mtk_set_link_ksettings(struct net_device *dev,
 			mac->phy_dev = mac->hw->phy->phy[cmd->base.phy_address];
 			mac->phy_flags = MTK_PHY_FLAG_PORT;
 		} else if (mac->hw->mii_bus) {
-			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus, cmd->base.phy_address);
+			mac->phy_dev = mdiobus_get_phy(mac->hw->mii_bus,
+						       cmd->base.phy_address);
 			if (!mac->phy_dev)
 				return -ENODEV;
 			mac->phy_flags = MTK_PHY_FLAG_ATTACH;
@@ -62,7 +63,6 @@ static int mtk_set_link_ksettings(struct net_device *dev,
 	}
 
 	return phy_ethtool_ksettings_set(mac->phy_dev, cmd);
-
 }
 
 static void mtk_get_drvinfo(struct net_device *dev,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
