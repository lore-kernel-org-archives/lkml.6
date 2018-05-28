Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164457AbeE1Kz4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164433AbeE1Kzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 287/496] drm/ast: Fixed 1280x800 Display Issue
Date: Mon, 28 May 2018 12:01:12 +0200
Message-Id: <20180528100331.926346718@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Y.C. Chen" <yc_chen@aspeedtech.com>

[ Upstream commit 5a9f698feb11b198f17b2acebbfe0e2716a3beed ]

The original ast driver cannot display properly if the resolution is 1280x800 and the pixel clock is 83.5MHz.
Here is the update to fix it.

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ast/ast_tables.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/ast/ast_tables.h
+++ b/drivers/gpu/drm/ast/ast_tables.h
@@ -97,7 +97,7 @@ static const struct ast_vbios_dclk_info
 	{0x67, 0x22, 0x00},			/* 0E: VCLK157_5	*/
 	{0x6A, 0x22, 0x00},			/* 0F: VCLK162		*/
 	{0x4d, 0x4c, 0x80},			/* 10: VCLK154		*/
-	{0xa7, 0x78, 0x80},			/* 11: VCLK83.5		*/
+	{0x68, 0x6f, 0x80},			/* 11: VCLK83.5		*/
 	{0x28, 0x49, 0x80},			/* 12: VCLK106.5	*/
 	{0x37, 0x49, 0x80},			/* 13: VCLK146.25	*/
 	{0x1f, 0x45, 0x80},			/* 14: VCLK148.5	*/
@@ -127,7 +127,7 @@ static const struct ast_vbios_dclk_info
 	{0x67, 0x22, 0x00},			/* 0E: VCLK157_5	*/
 	{0x6A, 0x22, 0x00},			/* 0F: VCLK162		*/
 	{0x4d, 0x4c, 0x80},			/* 10: VCLK154		*/
-	{0xa7, 0x78, 0x80},			/* 11: VCLK83.5		*/
+	{0x68, 0x6f, 0x80},			/* 11: VCLK83.5		*/
 	{0x28, 0x49, 0x80},			/* 12: VCLK106.5	*/
 	{0x37, 0x49, 0x80},			/* 13: VCLK146.25	*/
 	{0x1f, 0x45, 0x80},			/* 14: VCLK148.5	*/
