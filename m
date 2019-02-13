Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820C5222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083590;
	bh=aSPFxL8velRpwUa2xkj8tij54F45yWHTC3th/0IPJ3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2WEPnT8v3EkHVibx8F+fFEkauEO1/PYockEjbuQsUZKzEkkbq0KvaCE2C4oiUMJI5
	 GxwaTm8MsQOX4GyBfQOBE2YUR1XeP/MBuG5fBta9ItbXC2c49ZAdhETVuKWCRZbAIO
	 wu6s7Cz9onxjwg0qYtYMaLir+pLvBjc6JNZpSS4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406456AbfBMSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406438AbfBMSqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CBB8222D1;
        Wed, 13 Feb 2019 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083583;
        bh=aSPFxL8velRpwUa2xkj8tij54F45yWHTC3th/0IPJ3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxEiH+QqOgdT4aKqSoUHni6f8xD47A4kx+dW46AW14tnR1qlsTww7sfPLLbUDuJQI
         KTv35nk2F/roQUX4cBJkIlELCHHMecIhQOolXrLeUrAaoIGcCBjzuU+P0HQQOx+HmV
         1yBHucYBV7IMeUtREZ7vMCeADLR1JnogrMMPUcKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.20 40/50] drm/i915: always return something on DDI clock selection
Date:   Wed, 13 Feb 2019 19:38:45 +0100
Message-Id: <20190213183658.845302330@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 2a121030d4ee3f84f60c6f415f9c44bffbcde81d upstream.

Even if we don't have the correct clock and get a warning, we should not
skip the return.

v2: improve commit message (from Joonas)

Fixes: 1fa11ee2d9d0 ("drm/i915/icl: start adding the TBT pll")
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190125222444.19926-3-lucas.demarchi@intel.com
(cherry picked from commit 7a61a6dec3dfb9f2e8c39a337580a3c3036c5cdf)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_ddi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -1085,7 +1085,7 @@ static uint32_t icl_pll_to_ddi_pll_sel(s
 			return DDI_CLK_SEL_TBT_810;
 		default:
 			MISSING_CASE(clock);
-			break;
+			return DDI_CLK_SEL_NONE;
 		}
 	case DPLL_ID_ICL_MGPLL1:
 	case DPLL_ID_ICL_MGPLL2:


