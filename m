Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31525C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E066D20C0A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OLHYiKp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E066D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeI1UhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:37:00 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9299 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1UhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:37:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae36bf0000>; Fri, 28 Sep 2018 07:12:15 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 07:13:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 07:13:01 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:12:59 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:12:58 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 14:12:58 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bae36e90000>; Fri, 28 Sep 2018 07:12:58 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Jon Hunter" <jonathanh@nvidia.com>
Subject: [PATCH V2 0/5] Tegra xHCI genpd support
Date:   Fri, 28 Sep 2018 15:11:45 +0100
Message-ID: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538143935; bh=YyNLn38+xiKOA47fA0+0tlaVKocFxTUMPMVfBC0c+wc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OLHYiKp3hbrrXlHxgEtfzMGYxukHMOuoCSlqSsUmZkiQIUukVq6FdRDdhXp5aIsMF
         kJgKXlpV1rzEJN1v5gKHDktTf+DTeKyWz5W7KjoxoAfhcdNhK/CjNxL4kvvze3zwC/
         fpOeY6SGb2IIRcBDMyzjpf0U4vr5beO62EndIYc0rdOWJ9INFgdocMdDRSsx1MPVYH
         M2BR0hJtMOHd3NVZlVlXt8Cr3DlJOZEf6kyK8I4Wgev2u6gW0RusrA/Nea8uIS4zsc
         Rdueq4rXmGVfFgJyhCTfZ7b6Rnc6ThMj3S3w41KdMrcePqou07aNk7dNeS0k5AIYzK
         Q51ug643lTvng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add genpd support for the Tegra xHCI device that requires
more than one power-domain to operate.

This series is making changes to more than one subsystem and at first
glance may look like a maintainers nightmare. However, my proposal is
this, once reviewed and people are happy ...
1. Patches 1-3 should be merged first. Patches 1 can go via the Tegra
   tree and 2-3 via the USB tree.
2. Once patches 1-3 are accepted, then 4 and 5 can be merged via the
   Tegra tree.

Changes since V1:
- Dropped unneeded patch to export symbol for genpd API
- Added patch to power-off XUSB domains
- Slight re-work to Tegra xHCI driver changes to simplify clean-up path.

Jon Hunter (5):
  dt-bindings: usb: xhci-tegra: Add power-domain details
  usb: xhci: tegra: Power-off power-domains on removal
  usb: xhci: tegra: Add genpd support
  soc/tegra: pmc: Don't power-up XUSB power-domains
  arm64: dts: tegra210: Add power-domains for xHCI

 .../bindings/usb/nvidia,tegra124-xusb.txt          |  8 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
 drivers/soc/tegra/pmc.c                            | 16 ----
 drivers/usb/host/xhci-tegra.c                      | 92 +++++++++++++++++++---
 4 files changed, 91 insertions(+), 27 deletions(-)

-- 
2.7.4

