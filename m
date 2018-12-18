Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76068C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4310B21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151467;
	bh=RMGm6UpwFi1cNsoVXjGjVirKmwU1Q/PrmHuQAq+7J8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DcBPGehbae3tYn+LqqyAT3zY1ktWJG6l174+ku0WAv/65kX6RXyRdfu+BO6hvpyE+
	 Z4dp5r7rWBRPJ0bz7BByqjYMdYWFulR0x/jMgSUWZMcdv4yNos4uZEFxe495H7h077
	 fhAbrTfuW/+ffK0JbyqdhiVnMh37O1blFhoEu0DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeLRQoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeLRQkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F43A218A3;
        Tue, 18 Dec 2018 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151220;
        bh=RMGm6UpwFi1cNsoVXjGjVirKmwU1Q/PrmHuQAq+7J8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmNf8J3ZKbjV2y2+B38d221dC0U/wwqqExkD6S5ZfznKo1YV5ZkRNntQczBKpUtSl
         QQZmvefZmnoNbxiWp35rPP0PnlmeCtwv3stBmg6luDU/lJgvno89LUv8m4DBz0mHxg
         E3bMwZ9nqnofkZ1RsKdkm8vd7M8En8diEAT6gcps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/44] ARM: dts: qcom-apq8064-arrow-sd-600eval fix graph_endpoint warning
Date:   Tue, 18 Dec 2018 17:39:18 +0100
Message-Id: <20181218163927.871563872@linuxfoundation.org>
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

Upstream commit 972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600
eval board") removed this file because there are no known users,
but in linux-4.19.y, we still get a compile-time warnign for it:

arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not bidirectional

Address the warning by adding the remote endpoint that makes the link
bidirectional. This is the same property that other boards use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index 76b56eafaab9..f714a20649d7 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -387,6 +387,11 @@
 			hpd-gpio = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;
 
 			ports {
+				port@0 {
+					endpoint {
+						remote-endpoint = <&mdp_dtv_out>;
+					};
+				};
 				port@1 {
 					endpoint {
 						remote-endpoint = <&hdmi_con>;
-- 
2.19.1



