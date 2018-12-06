Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A3E20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107283;
	bh=PXZBVplUy87ZDQSdp8lIS/Cdpv7g0/n8CxU89Mxh/eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qS8tHEG4uKvHLI/6uLkWKzaB+WdYrtsEKYzdLUifuh1KSIbFewXgFra62s33+65Cf
	 RoyQFZ7p6w2g2OtHKD9iS3rfokOzQIXdEphLomuCJAGa0ec+EbJHYzD8sf8PA+LXVC
	 H1h1MnWlkcS9abHTOOwF/QHGdMmLWPyxVWmVcFfI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A3E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeLFOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730183AbeLFOlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F94B214C1;
        Thu,  6 Dec 2018 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107278;
        bh=PXZBVplUy87ZDQSdp8lIS/Cdpv7g0/n8CxU89Mxh/eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWS7yEeTE2WRds9bsicl3fjgli5ndUOYW6rLTjM0R1sEAVpq//pKfAl3ZD9IRLV3V
         1XJ5Znklalqjbywd27iWSvGoPtOV2DkGfm7v7YBnQ96GnNjgLyytU21NDHdkcyhrdp
         zieD7/LW+Acd/YdSBx4CIfkdybjimj5IRIsOt1KA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Gaskin <patrick@pgaskin.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 35/41] Input: elan_i2c - add ELAN0620 to the ACPI table
Date:   Thu,  6 Dec 2018 15:39:15 +0100
Message-Id: <20181206142953.051994021@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Patrick Gaskin <patrick@pgaskin.net>

commit 3ed64da3b790be7c63601e8ca6341b7dff74a660 upstream.

Add ELAN0620 to the ACPI table to support the elan touchpad in
the Lenovo IdeaPad 130-15IKB.

Signed-off-by: Patrick Gaskin <patrick@pgaskin.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }


