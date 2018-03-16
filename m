Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdowmI1xDbRwltGEXnzIf6XdMmqW41/ykj+HpkyQG0+/QSGuPU6TILrbCmDfvhiZJoW+UW
ARC-Seal: i=1; a=rsa-sha256; t=1521214723; cv=none;
        d=google.com; s=arc-20160816;
        b=XJLeFfhs+ENOYt6e2niF65cIqOcClmtsHwimroh7JkjTbOjIjyShwWLuoOc6a89Vkx
         aLEzx9cXOhM3YL+2XxUeGkuMGGnpgUujdTtpbmt8D5o8yB3HkvefgRpGD5IRUlP/7l2Y
         Mn5OVOr/ZcMoBZhdkfbulRqRKIk6hwJNHIGKYmDjn63QWAneE8IIjo4/1p2i4TAI1FDc
         H47vdg/pehovx4peoEJNSQa3W4MUoAAXWYY6y9jBaPqTwL8xHV7B+YiJ6kx4B2yx34Ui
         aENjqVRQPqEfR6YtMdOG56KTSpiVIhvxXS+dvXk7E9GtWe6gE3TirJGdvAR3Y2XySCBG
         cMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YhRP8hXNTlfsHigBTUZHPpmN2ajqI/0r4uan94uCiE0=;
        b=lHgC+xWO7OBWPbcyNI3oT/KaaChumwR2wxm7f5SPQyleSTWp34IhRXGUquDEZKontQ
         S4ZsRJEszRei1ABrwNGR7Kx31pzDsL+lC/nGzE1xGDYKD5hmIrsgUijfLCq5W5o5Ny0f
         8+1pIkkxZXKRc/bfjj89qnkoH5Qa12NwsOm+59UmP5QBStxVwckfxMP2CwcWwhtU3XIP
         VDZqQUUh5BvJ+FtfXXlvUxn5pvpzb3QjEIsz7WqFTNfn6mdvUzb7h80DU3e6kbZ4PfMT
         oxxYL52b5Wx3+JGvTqIvhL0bcBP0YNVgfs16RAylX5iRvKIG7W0rkvSQuvP4d8Gjo9Vg
         tW5w==
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
Subject: [PATCH 4.14 070/109] pinctrl: sh-pfc: r8a7791: Add can_clk function
Date: Fri, 16 Mar 2018 16:23:39 +0100
Message-Id: <20180316152333.799246058@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109249726392128?=
X-GMAIL-MSGID: =?utf-8?q?1595109249726392128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
