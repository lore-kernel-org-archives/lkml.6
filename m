Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93232C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A020645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571347;
	bh=s1cAvDVAscsDKAfSZICoq25tShFlE2OLbgwYVChGvQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LqDlk5P/KryOdEbwnfoNHYR5D2npW4SrC5pl8OZN6Wt0KUhZ1dIVkn1OyS8Ad6vWL
	 AFeZn+5aQcd+ZZl5UypYCHxF/HdOiTNlNLMh6ixz0BZ+gHR32QZ3zz6j3Y5e/xwRek
	 AsQBTq4cAEu7n7fqe8sj1pxOsDV/laDTDHbnekp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfAOQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbfAOQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD252054F;
        Tue, 15 Jan 2019 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570528;
        bh=s1cAvDVAscsDKAfSZICoq25tShFlE2OLbgwYVChGvQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6oJkmr1sTj0QOA7sKENqIFgwKMNIID3DjsDtF4laxxfuPlB/Z7wZ2KzR7Uvs8gZy
         GpRxMXBv9vgqwFAQaXenjZT8vaB+xmSvrgJsYtmFSnsrTNjvZAjnsthbIlhVLRqyqh
         k+Qq8OscWSFZ+spTnd/TB134AlY1zq0KaeoU8DeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Liu <leo.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 27/50] drm/amdgpu: Add new VegaM pci id
Date:   Tue, 15 Jan 2019 17:36:03 +0100
Message-Id: <20190115154911.526709045@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

commit f6653a0e0877572c87f6dab5351e7bd6b6b7100c upstream.

Add a new pci id.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -753,6 +753,7 @@ static const struct pci_device_id pciidl
 	/* VEGAM */
 	{0x1002, 0x694C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
 	{0x1002, 0x694E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
+	{0x1002, 0x694F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGAM},
 	/* Vega 10 */
 	{0x1002, 0x6860, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},
 	{0x1002, 0x6861, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VEGA10},


