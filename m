Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRFU1Lp9kWoCzns7b1gLS1hfV9RNOZyb4tGmgB5Uyy2i8gNZdEbt1a/xiBFnXyzsp0I6R/
ARC-Seal: i=1; a=rsa-sha256; t=1521483354; cv=none;
        d=google.com; s=arc-20160816;
        b=SdXlNCOgQ7aLPECwQ40znL+N6NZR9c+h2ALeW7UYv80pOlQRglk+LgsAVeh3xrgKoE
         kyvWDyOZWWprnXjt4DGk7KCZLsGMhM/5CccuhzDdcQyIc7ITcCXUU2X22yhuVpp7upFu
         ZmPZJTiiEKDHhFygyKi5QXeCsE6x8TfCjICRB09VRxDYCUk+67BW88J9hvcXjuAzLsUX
         t3dB/L835SUsZsd+1ouHWeJQXj9yvXT6xS/Qcom05EGC3QCNEui9mFIJLjSq5K9V1suS
         wQZyl/2i2fPgqvJyw+AvSfZIOS9fBh1b2M5N/besF4fZgDM4TUQWwkoo2OuSj8Tf2fgP
         qXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3cHwTE7JuE9NcF4/opsuU1vUC4AFMLfizF3EvCIHkKw=;
        b=fwZ1m/guYyDs+5c7V6XXeXH88j/bMDlY5DvYkyVgD1viAB6edVOv2sK+Ue2c6HwdBD
         pdQ5tNDISLk6SzeKt/2keT04kn7NDNBygUlrCz1877nOVgZZiqmdfkis8df/X2lYX1jg
         OyG/ZrRJGPqe+D7YIJcVozK7ty1AN5V4xOYz+dHP560n9v4+FebQgWj+/xUFyPr1Y/Ga
         2ZmR2F6MwfpoKE4TmbWQ4VXaRWX1pPWKdW8cHnYS8ky4hxhIdVydjKLzVqVwSSRZO5dA
         8GyoG5Cs/XNBvhpI+zSpUHk50LA8+MbHzXe4NchRz23UQHQ1yXOLXKg6be0LY8+ujuMk
         UarA==
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
Subject: [PATCH 4.4 093/134] clk: qcom: msm8916: fix mnd_width for codec_digcodec
Date: Mon, 19 Mar 2018 19:06:16 +0100
Message-Id: <20180319171902.717573470@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390930256471292?=
X-GMAIL-MSGID: =?utf-8?q?1595390930256471292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1437,6 +1437,7 @@ static const struct freq_tbl ftbl_codec_
 
 static struct clk_rcg2 codec_digcodec_clk_src = {
 	.cmd_rcgr = 0x1c09c,
+	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl = ftbl_codec_clk,
