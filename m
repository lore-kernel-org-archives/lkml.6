Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D00B21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151299;
	bh=RyQNUCIVHZWtKiJI4+yNtEnCjULmUvRDDN5z/zc6aOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ml/oA79p4BnVO0aaXoslTRguw04ygZMvVpFyRtYYEwyWxU5XFe9eIT5fMq3ly4fmV
	 PbKR2E1Cy6cHOVwmqJkKQw+D+xmnpzsRc21jrTkeJY0XCi7uMevYrhd64AMMwqdn07
	 EzGMbn2Gj4yoLqvEsZDwkYsGP+P4NXxG898p7c3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeLRQli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeLRQlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B2121873;
        Tue, 18 Dec 2018 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151294;
        bh=RyQNUCIVHZWtKiJI4+yNtEnCjULmUvRDDN5z/zc6aOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmclay5Z1Kn4HEebqv+CjXdPw11erwfCqorwK98xWILJq8VoAo0brCPxdWObxqBKG
         7/KVPvkRFme1Ozvf1Ew7m+tCQDhkD1uvEP9jAKAs0p8IMzaFMuLh+V7pos2M9uGcXQ
         ZYNSSSbIIQQSQ7DU8gM8lLYNauKwhfbXFgESPbg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 40/44] drm/amdgpu: add some additional vega10 pci ids
Date:   Tue, 18 Dec 2018 17:39:52 +0100
Message-Id: <20181218163932.073300281@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 2244b5887c6865b9e9cf14ee12a312b776aeeb58 upstream.

New vega ids.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -761,7 +761,13 @@ static const struct pci_device_id pciidl
 	{0x1002, 0x6864, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	{0x1002, 0x6867, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	{0x1002, 0x6868, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x6869, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x686a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x686b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	{0x1002, 0x686c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x686d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x686e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
+	{0x1002, 0x686f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	{0x1002, 0x687f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	/* Vega 12 */
 	{0x1002, 0x69A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA12},


