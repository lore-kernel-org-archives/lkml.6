Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvvIW+fnumVMm2yk27jzDjZOt9XGg07Ab8V5DVZa8cayP6iNNpgZsoIlCz4oqvzhsABDj0O
ARC-Seal: i=1; a=rsa-sha256; t=1521483979; cv=none;
        d=google.com; s=arc-20160816;
        b=pUn09e0a/aa8iTPIKb/UH+YMatrbYFGMH21vbjbzXShDwRgquGWpyt73ILVxdk598O
         ai6McsVtJCYxvyAufFNeT+H56CQ0s8d6hONBF3giBWtC59IxEb5sVVRu5rRxicQshG0F
         MMS7JUyQPshRZ4fJCDBBS9IPDONHqkq9GCCzAqhSyKxe390W51cCIhMncKcRr0eS82OX
         ARfr2IXQtYskLItL61RdFWSRuV+MD5Gat+cLL09AcTknfKuMCmQ6ehJYEXdVKJjE9AaE
         og6qyBvJA8b1rGUuCNelaPUImgAAClPT9k5HBYjd6kz9gpi4xTjY3EgC8sT55omTfHlU
         XclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7naW6t5R7JHyLCaRYViUP1Ac/JygR78PzlEXyE1vwuo=;
        b=n0aTVRWsOBUaTTTHmduvIfRborWhFl77x26zflf1yNryVnkOqbwRDLcTcFFITb7zot
         RUZFKzp1Nc1BJwIy+KfdMDyK0kZ6+15muXtMbOmCoUd1kOr8P9iu5uan1UsVj4dH6Y2u
         CYUH1tlXbcyHzmY3RIH224PVar/2jXXk6+bu06ojenNmz7uGylpXlRHI8055i7FzUfsb
         Rx4iGzC8MKrnnpoIJKqkWGyTQek5MJxDQXrEmCMBY/fcRT/T5djFzVb5PkRurI7HeFUm
         Ivg/Rewk2xV/2qqfcVqcyStv89piLuKn4eZIHYm1wbSxJsoRF+MQc7mpcU9ePf2p1C/9
         TVgg==
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
Subject: [PATCH 4.9 188/241] clk: qcom: msm8916: fix mnd_width for codec_digcodec
Date: Mon, 19 Mar 2018 19:07:33 +0100
Message-Id: <20180319180758.931083104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390930256471292?=
X-GMAIL-MSGID: =?utf-8?q?1595391585334779517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
