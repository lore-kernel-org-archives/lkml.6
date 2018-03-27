Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168794-2-640629054165537703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168794; b=rFzWGQ/n3sL+ZBQcjUV9J1Ab5OG/wLl5lqtTORgdWqskesB
    yXRT6SMESLiOd3QPtScaSk9V8CBWvVT35UBlH8E9u3U4zYTZmKUOxWfl/9hd0xhZ
    ShgpiikOpEmZwbPnmLHBvaD9voOOtDDzYhBjhrWJeQ3eKQNC4LUBQS+h2W83RdN9
    JmoGIdFje2VQ/p8z2JFQgZDsEkdpGcAanimfIvn7196QCeiEsFC/dXuTkJZrSED9
    3CsfWaVTOtzfAdOz4S3dgPXwq7wFzCz48ZtXYQn0QQxg+ctUnZ4SBXJ5SEwVSLLG
    8CQiU0YjmNrImhwhs16syS4cNl/zaT2wz2OBUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168794; bh=iJXaK04BHClSdWpEwU6jTkd4R7
    MSsVFCc4Hb238+Hi8=; b=WYezDRkr7Ad3I+zt1lR9RzgXOsk69tJUkoESujCNSK
    G1MwG5xtJaaKRtdrsiPcINc2Qs7qA/cwI0dmsIHCYH0Is7M5TSWSnhEO+sEJImWh
    3kcWsJIFTHPY4w+asM7P/Wid0ilMAVgEIZLjvI48/lE20AwIXizNI6U7iUR22hIu
    G8iMrcx5vpDQvnNE7piijiCCMm4a8bo86Xla0N/OnH3rR+AvaWTDU0JhgBgbLzvV
    BJyvmDxze0AGpw6RE9v3zXrgZWRutZrdql7FwEHPA7bmu5sON7kE7o3WAc3wV8PP
    gwQOeorMgep4STOCYnsZPYTT5cW9noldr3XWvJVUpHJg==
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
X-CM-Envelope: MS4wfL3DqWW+rHy0hWt8zDGODxwZBdv7YPP7BzFoqhRr4tEo86SLncXTvWhEOF/awuZRiYfBdUKzsG9qSZnlLPsme+LB0ZHqe2OkR/YREMcOVPZI75qffSMA
    A7at3cX05VKypzjcLiSsIRpB9dB8EsaS0fT+2PEZd1d37au+9c14eUsowxD3MiGMpBhU+p2UEsZwB0KqERXSXqBQPfUy7Q9hQENiMcxm7gs0zj1Pwdw4j52H
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=mK_AVkanAAAA:8 a=WPyIoOwQAAAA:8 a=Vxy2kpnnAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=nMMflWAxvouxslZPM44A:9 a=QEXdDO2ut3YA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=mQL3ssppXrSh16SuiSjD:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeC0Qjq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:39:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeC0Qjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:39:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 003/105] MIPS: lantiq: Fix Danube USB clock
Date: Tue, 27 Mar 2018 18:26:43 +0200
Message-Id: <20180327162757.965016021@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit 214cbc14734958fe533916fdb4194f5983ad4bc4 upstream.

On Danube the USB0 controller registers are at 1e101000 and the USB0 PHY
register is at 1f203018 similar to all other lantiq SoCs. Activate the
USB controller gating clock thorough the USB controller driver and not
the PHY.

This fixes a problem introduced in a previous commit.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18816/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
