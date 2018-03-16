Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6J+WrB5vi+MGM9I1Ww/NlwBITbH2yTOv7liRIHOLtVtZlYQ0lf2Kb6eiaCAhgf/gZ9ljc
ARC-Seal: i=1; a=rsa-sha256; t=1521215000; cv=none;
        d=google.com; s=arc-20160816;
        b=AyDe/yKHxXl4ckpyEZ0TXpuxhhGxwGn9CmTNcFIIjzO1BNzA5Rt5qwnos3GOW0KP66
         ZBwPWg7ffXcPO3CgBFUvspZRTvINLOy9XbFnTO2B2lpTam2ozDYy7PFDJFjpu31UNBtN
         AhtMvki4HaJGEoLOANWNPR04TBGRpQzjcHqRSYvjBqlQrEeQQw2jDQPmWP7bcijN2rxa
         DviFbByDfvHdERVp9SlohUrc/yiq7cVJLTWd/ZrXALGcPUBqKgutZ+xZqVwqTYe//KSC
         UfhVGyA4W78ffWoox88FxVs8LKSdsGpkBLFKeZqSh2pNIh4qnTr99NtaAYl0tEwieRWd
         9hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LqYdWgp1sS4yVwatn2NWUIgd6huE8d8NchwHJaqyNwU=;
        b=coKaDi+wzSdJoQRkz03dbKSUgBLrVr48dgQ0exE3yu7eTjnRInytgXyvlzAp4o4d8/
         ZOIrVDpnVnIOTonKVBha2Dhfbp4JffE8hleUU/56Kmvam+7OP9BC0h6olVv6ch/vaz5E
         ga7dIRFs0ONCYIV0ON3LxvkaeJd9cvO5JH6Lglj2qJMDIRbE25iUyh34cgusyO7dqB3l
         gLS5Qby2R0Fao1DKSsLik6w2xjUrGSYuc7zKyGanvtXmdStWcjJtrX2/x5t5eHUVVhJt
         B/Lvyn52dbBjwdlTSPqtTYSvm2SifmNQRFZGm4C/pz787hHKvGww0z+U8YdiGUmMLvcx
         ZKLA==
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
Subject: [PATCH 4.15 093/128] clk: qcom: msm8916: fix mnd_width for codec_digcodec
Date: Fri, 16 Mar 2018 16:23:54 +0100
Message-Id: <20180316152341.189191757@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109156723385177?=
X-GMAIL-MSGID: =?utf-8?q?1595109540241611037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
