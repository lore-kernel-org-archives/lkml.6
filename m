Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C00BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88162146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788950;
	bh=xGaBNPbPJbaE32DvLZ7xGKfvTftzvNozimH+hG+LS6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZMLmvM4hUdTYbUEqiEbywJEfji9fQA20rgoVN1CZty34yOs9KnhQNy+G/OfR5pQ7U
	 XI6fARrb90P7rNLdEUWZ5DTmqIFobUzYppwlwY7LaermJB1UvCTHC4FXbO9iU50uAD
	 QSPV1fFcShz+SDm07ckUscGGWzfZMcrfY4GWaDgQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88162146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeLNMC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbeLNMC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292E22145D;
        Fri, 14 Dec 2018 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788945;
        bh=xGaBNPbPJbaE32DvLZ7xGKfvTftzvNozimH+hG+LS6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2Z3rUtKTC1QqbZFLNJWjpRfVJOkD5sOkuH/QleBg+BK5buOEdjbOBDk9CiE6UwES
         gQGbcqQgALf1cSxDy+SLBhAharFBpq3uLn+AmBLqmDcx0FgHgKYNCwZXqST7fqIKNg
         PwPpoPI3K0EmSF/vEgoqwJSbuhTnhjbnYcKG6CPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/142] arm64: dts: sdm845-mtp: Reserve reserved gpios
Date:   Fri, 14 Dec 2018 12:58:39 +0100
Message-Id: <20181214115748.413523058@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 5f8d3ab136d0ccb59c4d628d8f85e0d8f2761d07 ]

With the introduction of commit 3edfb7bd76bd ("gpiolib: Show correct
direction from the beginning") the gpiolib will attempt to read the
direction of all pins, which triggers a read from protected register
regions.

The pins 0 through 3 and 81 through 84 are protected, so mark these as
reserved.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 6d651f314193..6921f8dc5ebb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -31,6 +31,10 @@
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+};
+
 &uart9 {
 	status = "okay";
 };
-- 
2.19.1



