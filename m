Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtX431UJ5slwAxk5s8mt/bgZuSS3jlQmUBu1aODIUqXgSbAHD8CmujtBd4AmFyM4mG17JWj
ARC-Seal: i=1; a=rsa-sha256; t=1521214634; cv=none;
        d=google.com; s=arc-20160816;
        b=IZZUBOjmoKazgJluAfR7hNK54LCXVzHeXuRFNH/rwgSLMK0nk20TfvSzo1Ayk2Yv+u
         DQqZWAWAXunj8btt/JDX4Okqy8yceSi6roq4/LSG+RmbP5dwTN+gZyQarJH04i9PrDF4
         oAUOyHgjQBgjhVDGkjsTJlVMWHeISZU0T51I4wwuFR0+5ZXaAHGH4RLsjbI6dPCBuXlJ
         j9IE+9+qoOr1iwivIpoRgyDNG/jkUq7ShAmK94kHVmJh8zilriP6qWG6xYA+F3dVzaVB
         /RaJj/7HHFxKPnRC7V5gZJf0NRsKgqBUQVzwCoqC6qq3BdQh4WDqteAs3I19yxjnERP0
         zpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FTixEfjeYvunf87pW3WIH+MIrJZ3i/BzS29EzPC4YVo=;
        b=tW9OvFJwaAMTdiOJvKN81KnnLhGNtk1yaBXkGP0aOjjwScdkmPihYPyWWMtGREneVQ
         pD377YOmEh/UNcnPB2B5BhPNU68NeYSaOeM9d+iws0G2YGsrKV4UZG4MD+MFMgpdpnpz
         Zf3jgTsFjZaAdqgw9MBFpVj0rZzhEz35Mi5wsH0yu/20a2XTy+f6c5WGUB19F9i0sZ5x
         6RzFp19QZLjwAvzzG8S2U2yG0UBuy2X/M+n1a+9t4CtdfDtQtVcB4G9R1P6DaF5qR8rR
         XYDU8MPLNtK33L+IKfRQmViw50OAuBRPR3q97tOcmhpt8XJ2QcN+UAmWuMChJReFA5BF
         Rseg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 076/109] clk: qcom: msm8916: fix mnd_width for codec_digcodec
Date: Fri, 16 Mar 2018 16:23:45 +0100
Message-Id: <20180316152334.107955167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109156723385177?=
X-GMAIL-MSGID: =?utf-8?q?1595109156723385177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


[ Upstream commit d8e488e8242ecf129eebc440c92d800a99ca109d ]

This patch fixes missing mnd_width for codec_digital clk, this is now set to
8 inline with datasheet.

Fixes: 3966fab8b6ab ("clk: qcom: Add MSM8916 Global Clock Controller support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gcc-msm8916.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1438,6 +1438,7 @@ static const struct freq_tbl ftbl_codec_
 
 static struct clk_rcg2 codec_digcodec_clk_src = {
 	.cmd_rcgr = 0x1c09c,
+	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl = ftbl_codec_clk,
