Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGYeukTYyXDwDOXh5stt/80cXMWNe+DBmJ2zw0wNBA6Xdd8znB/wS9qzV1TfLh1TPy4R0H
ARC-Seal: i=1; a=rsa-sha256; t=1521215079; cv=none;
        d=google.com; s=arc-20160816;
        b=xbV86/jy38Q8dA/GjDGbuxIZDPc5onM4ShAuS05Y8t5NXoyA68ppZFb0pQFSSA6792
         srQKFKhtL5D+7xIDze7S3CK+XQK2Dw4ccKmYWlyX0vQHm8BlIF6aN6TsWJjJOZxMqf4Y
         PBHs7l/n3NrrIBBHGIhIpKtEOso3VrZGags6t1BuXNGMivoCA4XnZmPo9ZFeBrpXxeRz
         9dSlNxfF9KaQjmrX6O/fI0iFIwtJv4Z/FhO4MhfZz1H2AP8HWhmYbEko27KMD7cSkApN
         kqxSerRAPmdWXPHyPJB26sj5AVvkF7Ne3X0GSyjZaKfcoo+p9DN81bwynm5as6yxlHS+
         9R3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AKPCuRi6eL6o0umw3HUkTW/zBT5fgDc1qVWFLOeZnFo=;
        b=DgaowiiJHZSm1qb9mjFaUHXfHBBNtBUDaxhsS43MDcZkwqWcqhf+QQiH07zjWzt5Qb
         KEuTn3n+fa4v6QM2fkzjXonrlKtbMG61GDWdfQP3BqrHpbVuTj/MsXpIO+fVQ1LBXL3J
         EbS15BVQYMBJinaDAcAXTgYsW/Oo37xDqEYm0smb/s7oLXJOQpb07AWXIRc3OdCbBP6h
         VwqxMqpOe/2Ht6r6SB2GODCFR3ljZAfN75tHa1iTyNkmYwP63jkrm04jgrt5czjp1Un9
         f+72y4dBKuMHAsjUEz5WWukY+jvbudN4SmR5Z8HC7hRiQc428vCkPSiND28neb6XiT2n
         MwGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 085/128] pinctrl: sh-pfc: r8a7791: Add can_clk function
Date: Fri, 16 Mar 2018 16:23:46 +0100
Message-Id: <20180316152340.835750008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109249726392128?=
X-GMAIL-MSGID: =?utf-8?q?1595109623167857299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>


[ Upstream commit 57eec02caee60332b8052615e7257f932ae07abc ]

This patch adds can_clk function to r8a7743/r8a7791 which is cleaner,
and allows for independent configuration.
We keep the can_clk* pins definitions from within can0_groups and
can1_groups for uniformity and backwards compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4826,6 +4826,10 @@ static const char * const can0_groups[]
 	"can0_data_d",
 	"can0_data_e",
 	"can0_data_f",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -4837,6 +4841,21 @@ static const char * const can1_groups[]
 	"can1_data_b",
 	"can1_data_c",
 	"can1_data_d",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
+	"can_clk",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
+/*
+ * can_clk_groups allows for independent configuration, use can_clk function
+ * in new designs.
+ */
+static const char * const can_clk_groups[] = {
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -5308,7 +5327,7 @@ static const char * const vin2_groups[]
 };
 
 static const struct {
-	struct sh_pfc_function common[56];
+	struct sh_pfc_function common[57];
 	struct sh_pfc_function r8a779x[2];
 } pinmux_functions = {
 	.common = {
@@ -5316,6 +5335,7 @@ static const struct {
 		SH_PFC_FUNCTION(avb),
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
