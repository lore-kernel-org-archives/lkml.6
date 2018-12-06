Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BDC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FEA20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107382;
	bh=ZW7RDEIwHRv/ZSb3qKR/AmJFr0GoTT6JjOb3inL6ta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdxKJw5LzQqip3j2S7cHVWdIX5yl+JLzQFs3Ixetm5fyd+yp5a3ln317sV+ACqxJK
	 h0LfuuV6Zj9j5D3mzcSiJYcGl0ErzMDWUzu7TeSA6n26RjcsatFn6Dt3OqEw/NA9An
	 /N67tvwOTXiGkQF2lDwNwjnlVZ5aFnVD297jmD2Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FEA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeLFOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730584AbeLFOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DD12082B;
        Thu,  6 Dec 2018 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107376;
        bh=ZW7RDEIwHRv/ZSb3qKR/AmJFr0GoTT6JjOb3inL6ta8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTQFi/mUpFrj29AaTX1Y1w8mDrSJmeS9GKoX9luKh6QDW0ujctFMnEW0CTKsXo0Td
         bX5whTrxo6XwkKLpUqfoV/Kj0QoYIbwkEiJPCNFE11PZryJhCNSJZ+b2OxUKjyhebN
         JWTUAwnm36TRB0SXAcg6FYcjUr1ed+167I5oxbaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noah Westervelt <nwestervelt@outlook.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 38/55] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR
Date:   Thu,  6 Dec 2018 15:39:12 +0100
Message-Id: <20181206143003.755156842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Noah Westervelt <nwestervelt@outlook.com>

commit ad33429cd02565c28404bb16ae7a4c2bdfda6626 upstream.

Add ELAN061E to the ACPI table to support Elan touchpad found in Lenovo
IdeaPad 330-15ARR.

Signed-off-by: Noah Westervelt <nwestervelt@outlook.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1264,6 +1264,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN061E", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },


