Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C07C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C17A21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgFRS465"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C17A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeKZVu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeKZVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:50:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DC620817;
        Mon, 26 Nov 2018 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229801;
        bh=ab0vwbTuUnenV19EYmo2+NDSaD+vItpw43vUJ9WHVDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgFRS465cFz0zDKO8cujUBLH4B7zl7BSihLx4tIzxpEQPhPUIBLXG4k1v4hYr533T
         gZ/4Y+tGpWZgTYoTQh14d72tgJp1iBncfyKEtpuRCr+TWceLqEev+MjSIOoyuk0kIS
         DaqF8R5gukROc5tO8JziI1DtFDiXFZnnATnmfhxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 44/70] platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307
Date:   Mon, 26 Nov 2018 11:50:59 +0100
Message-Id: <20181126105051.276790702@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 684238d79ad85c5e19a71bb5818e77e329912fbc ]

To fix:

  acerhdf: unknown (unsupported) BIOS version Gateway  /LT31   /v1.3307 , please report, aborting!

As can be seen in the context, the BIOS registers haven't changed in
the previous versions, so the assumption is they won't have changed
in this last update for this somewhat older platform either.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Peter Feuerer <peter@piie.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acerhdf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 460fa6708bfc..3c4b107aba78 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -233,6 +233,7 @@ static const struct bios_settings bios_tbl[] = {
 	{"Gateway", "LT31",   "v1.3201",  0x55, 0x58, {0x9e, 0x00}, 0},
 	{"Gateway", "LT31",   "v1.3302",  0x55, 0x58, {0x9e, 0x00}, 0},
 	{"Gateway", "LT31",   "v1.3303t", 0x55, 0x58, {0x9e, 0x00}, 0},
+	{"Gateway", "LT31",   "v1.3307",  0x55, 0x58, {0x9e, 0x00}, 0},
 	/* Packard Bell */
 	{"Packard Bell", "DOA150",  "v0.3104",  0x55, 0x58, {0x21, 0x00}, 0},
 	{"Packard Bell", "DOA150",  "v0.3105",  0x55, 0x58, {0x20, 0x00}, 0},
-- 
2.17.1



