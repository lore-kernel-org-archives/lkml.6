Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu9BuLV2HrcEvvDFr8huBvOrMCRgfDEyR/dimIo4qPbaYYn/sJhn5AJ/W39Ss/y1NP3VpLq
ARC-Seal: i=1; a=rsa-sha256; t=1521800234; cv=none;
        d=google.com; s=arc-20160816;
        b=SiZiLH4QfrNk6fAw6rx4NoSHCTU2nLCK8KwtSCR9Glqx/NBFlu8UU6/KzLiMIAcwd/
         EGkG+u4RmMv71bD69jWnO2Y7kKHDYNLH++rH/GMYYSn1kev3md61FQjb1r3nucee5Z7u
         2dJ58K/A1DXU3eif/+pAn7++eIZO93Ao3i6ukh713DtGKiGj34xmxyA0fah6A9C19rbG
         pqozE/wH0PCVvoA0+pOEORQ8HKfBmpBjIy6QCO7DU1BAQbp/OoghANs9HQCkHuZKiOXP
         ZFn/bNhxz2lHG8oczc0XWDm+ZEXUB1RAx4Fhp7kBOmHxAWtfL38l3zKqX+Mmu2iu4b4h
         FInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yVVlk4VneENhk/iziiTLmOcFgp8aKMHUEZvqio4nf54=;
        b=LeUd4lCA/vCGdPS/gmWpCr44+TcYK6tykWTSG795ck1lwUHeSSasdn2Ou1W5oz1LTd
         vug4h95rA4rUqdBEcjC9NFL5Gd+dmZBNYeiRPzaZbdX+fixtrhni95MbrPQA8x5ADR+p
         phj/YiPEjEBMvkFftGMmA0toQhoTdM+NQ/V/wKBg6DYl7AIbz1gh04UDEvUBNr3qlUYQ
         0giL4YKs3gmEGKBhAVOndH/8hj2agbRAQd7x/tB3OOCHa44ID0B2zSbe+1wY75CuOsip
         /W1yY5KCbBNQ+ZEhrYD4ehojGhjsXcqrE5pAoZ7IQysiOZySGgAcvnOJdmK0yBrO7swU
         zdyw==
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
Subject: [PATCH 4.4 95/97] clk: si5351: Rename internal plls to avoid name collisions
Date: Fri, 23 Mar 2018 10:55:22 +0100
Message-Id: <20180323094202.778778734@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722065816461272?=
X-GMAIL-MSGID: =?utf-8?q?1595723202181854640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
