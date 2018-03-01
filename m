Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2663868-1519898812-2-2029771912548632648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519898812; b=Ol7Uio72sngUnemvr8/UB4hemAj+9MzPaNFAdkoL3WP12Kk
    YrU6SeVaOTQu6Wr0eb/ejgYDMIYRRIf18BboOIIdfJ/ANC6ZC+ijozvAj+Wjnh52
    XKXKLeHNjSi8KNS7H92Lm/+CL9A0m9WZNvzzTUqbO8T2IF00/ffC+S8Rln3Q/5yW
    muBqcUBqjSQonRcjXYbrwt/L2hHPb2+0VtfTWqOcI6KpagUvOyElVcYmhMZ6KNKq
    2YcN7z5NSWXyMgCbeVSeED1QZfWERvHFvsOjWoxqYMmu85RHD2AhbMPzyyx+ndG8
    7rJKEqLaxweLBc0kpMndOGHyLKGccadrdlHitfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519898812; bh=IHhIIeqSwYo8RftaynS+VT57dM
    TTrOUotn0DbQNerjg=; b=XKyJtT3uKRzIlMcGpoyQw9XgsKv9hym3yUahp4HSCN
    GBEh3oVVGUR4d4nA/goEkmNeX/+OJSkR2/MSdLP5qAxtu10ocPVz1x0JtMzVqeBf
    3t/l2pYaQNqDwjQtqq6bENrURo4WHCJ2pLrGURCUJt7vbow0CiF7qdXxp+zHAsXD
    fd2sn93jIFADOR5NQNVkODX8rYCOzUCWvQUrVK5a8nD85UfDeR76cb5wQKQl8V+W
    ydX1XtLcsFwgOAVCaATy1BdwWvUe1zy8kW0Bun2H604XqYwDxsZxOfmRtpjijZSi
    no/fpDP67xmIouLv2lzI9jwDxUB0/hOsHlIPmcG2/Tgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967381AbeCAKGD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 05:06:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967232AbeCAKF7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 05:05:59 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH RESEND 2/2] usb: dwc2: fix STM32F7 USB OTG HS compatible
Date: Thu, 1 Mar 2018 11:05:35 +0100
Message-ID: <1519898735-10319-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519898735-10319-1-git-send-email-amelie.delaunay@st.com>
References: <1519898735-10319-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes compatible for STM32F7 USB OTG HS and consistently rename
dw2_set_params function.
The v2 former patch [1] had been acked by Paul Young, but v1 was merged.

[1] https://patchwork.kernel.org/patch/9925573/

Fixes: d8fae8b93682 ("usb: dwc2: add support for STM32F7xx USB OTG HS")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 03fd20f..c4a4749 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -137,7 +137,7 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
 	p->activate_stm_fs_transceiver = true;
 }
 
-static void dwc2_set_stm32f7xx_hsotg_params(struct dwc2_hsotg *hsotg)
+static void dwc2_set_stm32f7_hsotg_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
@@ -164,8 +164,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
 	{ .compatible = "st,stm32f4x9-hsotg" },
-	{ .compatible = "st,stm32f7xx-hsotg",
-	  .data = dwc2_set_stm32f7xx_hsotg_params },
+	{ .compatible = "st,stm32f7-hsotg",
+	  .data = dwc2_set_stm32f7_hsotg_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.7.4

