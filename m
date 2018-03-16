Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRgxsRLKw5jAEanM8lvFBJoK1h0yB6Uj03leF1m4OsO5BR7JitHo7yc9n9fsLP4LQ3CykM
ARC-Seal: i=1; a=rsa-sha256; t=1521215028; cv=none;
        d=google.com; s=arc-20160816;
        b=ibpRR2dpPHaOVtfSX9d9p2yz4yH/2zATOo9m+z36shcu9VLS2Xm2RTnWsAA9YI9Sa9
         ocWBjBk2QY1tvaiNLmhSzmKC6tutwXoAWEtffSa15kZfgDgs73D6Ui+unBTZb3hzuZ/8
         wwHnBlAJiedfIPAWRMaZJdtkYVRigLb+anaMBzNpRgY+bf4xbx3M2ZyQzEtEvDhOMKi+
         USouSjn5fTqZmq8IDrtcQBwAa2pNkl2hiKMGllwubXnPG9n6lUIIhoXQYl8RWamWLh40
         dVvquyscVF1Cs0T4kwUjxmIv7057ByVsMtTj9X65DP2XirbhEneb5uwfY/+bd4/mQOST
         J+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AUlQcHghYqicWB5ftTTH/FPYLrIhZwAo9JJ/MGA0AiM=;
        b=bc2UsF9mqudHmXr572KMXJrOskO4pAsWa1SPKyznF9612ZDe5XSpbeauhDmI3q82vw
         4yGuLpDrzzW5tvbgJFTTwS6BBmakHeb3hTYRNlxOLIxWkG/J6alMZA+hcomxsOAXo7uN
         dtaGeSxrxjBzNxFw/fFTGtF2ezw3x6/QoDmRn9XX5aqepwkWirQqmYIwOhSqNNzVYRLT
         +YaK1nLb9KBsn+IlVE6D1XFtygVyM7mIayX8wa1R4xoUlmoRBkm/sZeiS6vlP9hch3i3
         X3Mjf1UKCkbn9LNDFnV1u1r9qi/y+v0Fpt6BQNdPx0ANj/6ud/jRfd1P/oMqXMKtfPOx
         hvUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 102/128] clk: renesas: r8a77970: Add LVDS clock
Date: Fri, 16 Mar 2018 16:24:03 +0100
Message-Id: <20180316152341.642633807@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109569746746915?=
X-GMAIL-MSGID: =?utf-8?q?1595109569746746915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


[ Upstream commit 64082568dd1e05d349a0d9dfda2bdf6ace3f9f6c ]

I seem to have omitted the LVDS clock from the R8A77970 CPG/MSSR support
patch for some reason -- add it back...

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Fixes: 8d46e28fb5081b49 ("clk: renesas: cpg-mssr: Add R8A77970 support")
Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/renesas/r8a77970-cpg-mssr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/renesas/r8a77970-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77970-cpg-mssr.c
@@ -105,6 +105,7 @@ static const struct mssr_mod_clk r8a7797
 	DEF_MOD("vspd0",		 623,	R8A77970_CLK_S2D1),
 	DEF_MOD("csi40",		 716,	R8A77970_CLK_CSI0),
 	DEF_MOD("du0",			 724,	R8A77970_CLK_S2D1),
+	DEF_MOD("lvds",			 727,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin3",			 808,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin2",			 809,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin1",			 810,	R8A77970_CLK_S2D1),
