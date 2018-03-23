Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELssmj40LfPjS1SFQTnci4+Gp9nv+Pi5eF/JbjegDIPtLAKJ2leSHorHEDMLoZjN71bQYTyV
ARC-Seal: i=1; a=rsa-sha256; t=1521800379; cv=none;
        d=google.com; s=arc-20160816;
        b=jpfgWGOOKzze7hZWp0uFX+eNgVvRomnlknISCs0/PnG86xSzeXlODS7cHRjJkbu/Gt
         kQeJpipMeSlFqRJwfosq7A7LNmMaaL1A9o/LclUqtsFY9v4OzwPf7XKSqQo3Av9D0OTz
         EUDawUj5td+dBPjda93i6UxNpCl9xjCORe0bGby4GeA19zgneo4FL9ipe8ljjqQwp9N/
         mLtTX6lpWx9bNpu/JrDExQ66gA6IaAzvMiSTOyM9Jn9A9HDEssUbnOn4RxbsXiTv8d6m
         fmQht2bSltFg5cNvVqV8Oa3vCPhgQiQ3oR3AMJ5jVoSyUre+w7MCtQbkBz1tIQAla2ql
         sJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JltOuw0Ot5aSFG+ilQRjN8GyrtaF/UVwDDi/bo45qWk=;
        b=K8Px0GjBucobZhfv83t3W3cb+km6b2CzO7dlBdWw/aFU6Cu067MMq5CG1BiyWagEPf
         ojWP5dqlaaFSuuggk2OCl3/57vsYXcBksv+ZJqZAD6eGLnfWXztaDeqiXMI4rXMPCi+x
         +yGqOcrF9ATiyb2MXIGDzdRUAZA2LxyGSM0yAhSEcMnQS8K+G1K6oibXxeAeQUpZqGzd
         qAHyGuRTlijqR0OUAdbSlisiOLWR48Oa5T/TJ9AgqHVwh2zAjgdMmWTSr3uj4GlW4ql9
         cnyYaC7JCBaroEx/ewtAuwsq+O1U1/scVn4A2Tz8FOV1SBfbj9JdnDg5VIyFATgT+ZCB
         fj+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Sergej Sawazki <sergej@taudac.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 46/47] clk: si5351: Rename internal plls to avoid name collisions
Date: Fri, 23 Mar 2018 10:55:37 +0100
Message-Id: <20180323094250.086465302@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722065816461272?=
X-GMAIL-MSGID: =?utf-8?q?1595723354476506427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergej Sawazki <sergej@taudac.com>


[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-si5351.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_n
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] = {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] = {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
