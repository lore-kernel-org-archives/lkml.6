Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479199-2-4946608394573140682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479199; b=l3tsv2xxe513ZhvfVEL0I53w66reYogYWerdUIRvjhfLZdOuqX
    M29unXUH3Cxd6AnQMOjncDF5SdNmPGblbq+1DRiMV0rlJfC9HLeDWsS6G+0AGLNj
    9KSeePJdAj7FSp5GsoTIJYaakmKuWNIQwoIX8ECZSIDMrpeDPS0u0Yc9ghjXMoA6
    fOAIHaSxFMOfC/7NVX51hozomd4k4SRJMInioSx6Km4j/653D8owhQScAcVGmh4Q
    xzKcCOm1y4+V0OZrm9WTYD1T6Y5CkOA9E2d1eYvok57vwO+/k9ep9s5L8ErFl0Es
    OJHnMZsIv0uhsqlNj2jLKedgptax/vb7UHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479199; bh=UZ1ie9wu3xFp1WiWOUxtR3iEKExAKE
    hiodiyopmdqKY=; b=EVj0n4agH5m4o7qXd6/mxDjOl1jaj1BxuQp5Hr4hkx26Nh
    S8eOPxVnP+r/mJ/EKCls/bHSQstoKxyQ37kquI12bUAlOW4SvpxyjCxbGR7+Gva7
    yH5bgqQp6R+wnlJ7xNsl4aloOvq5YxMU0LAeYiRc9f5nYfA1GWteGeYhmxB2wO0p
    FAISUSEde1N0ESrd8hBIuZgnTbsdh4/A08Y5ipfgilKFfrNPxgZZa4Ie7f4UYbsG
    K1V8S56SdWcVl3nzzSdREowvb+tMIiMeLWTxlWo74F6d4UKegkuHDiBxpyMK6H7a
    SRERFy3UKLphjYGiIyj93/tQogekrh8XMlmL9YKw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKggWxZ4P9nWEewvfhf9cK0TgWFvpZ+i2go8XoEgKA8E+V4tv8ynGMLj4LW8f8bSaMCLtglr+2EZK6E+612usQ5+4qsaBO+W9QI4ISowgEGlsekEg3Hm
    kw2HeTZCNC1oA8yMH13aVmUIUIRezyecKCLnkuJ3bAwvsK17Mv4oLHzNtR0aJ26KY4Z/Pn76k7jW9vcpQLYyVsYUlArehR0Kqs1qzarAfk8x9OqcBm8weTm+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=tSOLQX0gvpRnjT4dyzwA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbeDKUjV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:39:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbeDKSsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 098/190] dmaengine: imx-sdma: Handle return value of clk_prepare_enable
Date: Wed, 11 Apr 2018 20:35:44 +0200
Message-Id: <20180411183556.285656357@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit fb9caf370f4d0457789d13a1a1b110a8db846e5e ]

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/imx-sdma.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1722,17 +1722,24 @@ static int sdma_probe(struct platform_de
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	clk_prepare(sdma->clk_ipg);
-	clk_prepare(sdma->clk_ahb);
+	ret = clk_prepare(sdma->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare(sdma->clk_ahb);
+	if (ret)
+		goto err_clk;
 
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0, "sdma",
 			       sdma);
 	if (ret)
-		return ret;
+		goto err_irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
-	if (!sdma->script_addrs)
-		return -ENOMEM;
+	if (!sdma->script_addrs) {
+		ret = -ENOMEM;
+		goto err_irq;
+	}
 
 	/* initially no scripts available */
 	saddr_arr = (s32 *)sdma->script_addrs;
@@ -1847,6 +1854,10 @@ err_register:
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
+err_irq:
+	clk_unprepare(sdma->clk_ahb);
+err_clk:
+	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -1857,6 +1868,8 @@ static int sdma_remove(struct platform_d
 
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
+	clk_unprepare(sdma->clk_ahb);
+	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
