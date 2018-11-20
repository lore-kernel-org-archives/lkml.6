Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8680FC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CAE20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yd80cvKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CAE20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKUCIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:08:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54799 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKUCIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:08:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181120153829euoutp02e0dd7cca195ca4a5f1e57eca11cde683~o3zlWGjAi0094000940euoutp025;
        Tue, 20 Nov 2018 15:38:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181120153829euoutp02e0dd7cca195ca4a5f1e57eca11cde683~o3zlWGjAi0094000940euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542728309;
        bh=qtDsQpuOAa0B+jT7yZqQ6111FY3WWKdUBvv+o9zQNIU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Yd80cvKad9D1hvtMdnZJPl/guyW9tjQp4LlBx8KMFp8lW5O7dK5Yty5vZbYtWTYxF
         avnaCxowfRnx5tjkrEtvg3U+QhDc/1NiTUjyYxRz2XBDRQllergTQ57gKDiyZZUlY6
         Ysyz83w0tMMba9MWIjKLWQPkvXqL5/CaAwhX8cb8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181120153829eucas1p13c97981883a8faf2b53711fcff55add2~o3zkt6nzm0686606866eucas1p1R;
        Tue, 20 Nov 2018 15:38:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 56.B1.04294.47A24FB5; Tue, 20
        Nov 2018 15:38:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3~o3zkAHncL0454404544eucas1p2P;
        Tue, 20 Nov 2018 15:38:28 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-52-5bf42a744e0e
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6D.C9.04284.47A24FB5; Tue, 20
        Nov 2018 15:38:28 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PII00KH40S09O50@eusync4.samsung.com>;
        Tue, 20 Nov 2018 15:38:27 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Date:   Tue, 20 Nov 2018 16:38:15 +0100
Message-id: <20181120153815.31897-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7djPc7olWl+iDZ5dNbDYOGM9q8X8m0kW
        zYvXs1k0/trLbnH+/AZ2i8u75rBZzDi/j8li0bJWZou1R+6yO3B6bFrVyeYx72Sgx/65a9g9
        +rasYvTYsv8zo8fnTXIBbFFcNimpOZllqUX6dglcGRM/LWEs2MRTseL9G9YGxlVcXYwcHBIC
        JhI/eoy6GDk5hARWMEpMWcAJYX9mlHi1OBPEBin5/ugxWxcjF1B8GaPE/xt7WSCKGpgkvjRw
        gNhsAoYSXW+72EBsEYEEiRN7t4M1MAvMZJKY9OoXWIOwgJvEkgNdzCA2i4CqxLQzq5lAbF4B
        W4nXHbNZIbbJS6zecIAZpFlC4C+rxK5Zt6ASLhK3brQzQtjCEq+Ob2GHsGUkOjsOMkE0NDNK
        tM+YxQ7h9DBKbJ2zgw2iylri8PGLYJOYBfgkJm2bzgzxP69ER5sQhOkhcWM1P8RnsRInXh9n
        mcAosYCRYRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg9J3+d/zLDsZdf5IOMQpwMCrx
        8CYIf4kWYk0sK67MPcQowcGsJMKbqQ4U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9
        sSQ1OzW1ILUIJsvEwSnVwBhT5BV5jntf2+66WuH1+qsfPxM7+6F83ZPEm9fZDqrwmfw4V3tr
        yuFKxuxFK7i2vZp5PdwzXqotJkn/jMe8SY/3f4gXzjy4tyEnpSKXf/+8BzPP2R57m3myzXHj
        aomaC0Hzzad2WRy/ssWz9oF4hx4w0rZprzyz5etUFduZ3/buvOU07Ttjs58SS3FGoqEWc1Fx
        IgA1SELjugIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsVy+t/xa7olWl+iDQ7uYrLYOGM9q8X8m0kW
        zYvXs1k0/trLbnH+/AZ2i8u75rBZzDi/j8li0bJWZou1R+6yO3B6bFrVyeYx72Sgx/65a9g9
        +rasYvTYsv8zo8fnTXIBbFFcNimpOZllqUX6dglcGRM/LWEs2MRTseL9G9YGxlVcXYycHBIC
        JhLfHz1m62Lk4hASWMIo8bxpLZTTxCSx8XUbE0gVm4ChRNfbLjYQW0QgQeLixpmMIDazwFwm
        iYvTM0FsYQE3iSUHuphBbBYBVYlpZ1aD9fIK2Eq87pjNCrFNXmL1hgPMExi5FjAyrGIUSS0t
        zk3PLTbUK07MLS7NS9dLzs/dxAgMk23Hfm7ewXhpY/AhRgEORiUe3gThL9FCrIllxZW5hxgl
        OJiVRHgz1YFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUa
        GDk7nlVuOvGaXUY/W+fp62PVzWfzjRzYTP8FzhVi5V/b9cBV4Q/DyyPHFFbaSohuq5ph0iC0
        82gnl/K6b8ey5zRzLpqze8e05tJ9jislt9/9J7XhZtT3f/e6rbkyHh7NMVoUUXe396zd78NL
        Kti81P34FvnuiGQyXPX25xvVLZNjnxctbd1277USS3FGoqEWc1FxIgA/8ECUDwIAAA==
X-CMS-MailID: 20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3
References: <CGME20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power down feature of DWC2 module integrated in Samsung SoCs doesn't work
properly or needs some additional handling in PHY or SoC glue layer, so
disable it for now. Without disabling power down, DWC2 causes random memory
trashes and fails enumeration if there is no USB link to host on driver
probe.

Fixes: 03ea6d6e9e1ff1 ("usb: dwc2: Enable power down")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc2/params.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 7c1b6938f212..266157ae179a 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -71,6 +71,13 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 	p->power_down = false;
 }
 
+static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->power_down = 0;
+}
+
 static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -151,7 +158,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "lantiq,arx100-usb", .data = dwc2_set_ltq_params },
 	{ .compatible = "lantiq,xrx200-usb", .data = dwc2_set_ltq_params },
 	{ .compatible = "snps,dwc2" },
-	{ .compatible = "samsung,s3c6400-hsotg" },
+	{ .compatible = "samsung,s3c6400-hsotg",
+	  .data = dwc2_set_s3c6400_params },
 	{ .compatible = "amlogic,meson8-usb",
 	  .data = dwc2_set_amlogic_params },
 	{ .compatible = "amlogic,meson8b-usb",
-- 
2.17.1

