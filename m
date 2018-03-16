Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUWkrhgkwll7/lk7Qi1f73tlhKSmFdkt+xYct7ZlPkzkjXTft4rbCBFJfO2wCtyrVU+vy+
ARC-Seal: i=1; a=rsa-sha256; t=1521214897; cv=none;
        d=google.com; s=arc-20160816;
        b=kF1ppkjLucSpseKllZ37AMwby1tbZV8YiKNnuvEG9e0oXvETkQWsymkubfrH35pAkG
         UlASSHAKb7zLdj0DGK69RCm61bGmIqg+xj3OQLOsEM7rVSIDbO/PpoE+TVKJJvuiuU24
         zcWqfc54544jD2I96aBObd/r1cpnv2EH4o5GPsd8M1OrpTydFHkESO0idzVg9aUC3I/k
         q5jpyF/gV+fO7ZC9J2jChJaOXBcNaimHsq+Q1R4W9B3RC6FTUVO5H8A2AgHra6A9l1Uu
         7HSadkOWo3H3Tr4Uq6JysWZUsj1dlVZUqbx7941pOzanlfdMSqsAj9jcT/DpiUNqxLe8
         mctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hq+ZMqW39npB4NL/kiXzcCihXjXaS3qXsC9zkbjulXM=;
        b=UMTAAEdaxBmyNN2J20dxemVxfpel+ifr9I9NqadJRu1dExSlJeI837+Nzdrw6UWVaM
         uHhZmCYWZU9pE9u5IXxTCaOTziNcPd/c5rhShMsVCEHZ4DpQsRDKnORxymVNLjkcw5Mx
         ApRVWo9LxgYwJeAwSzkwDphBHYPeZfwFz9KCqCV9T78lYqvaRexOIMtTxgZVlmyhk8r8
         5FNSQyAekFybmlYvZEmXsxSRdlfRp+vnU3eXo7Dy91OZU1FNNjMI4WsIlsI0SJq2eejy
         rTMOBXWrsVpf5/WqxIaT+92V00F1WuF63t86SsI2D8TSAng6HchyQy+N/VdJ1R2deOdU
         5HKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xingyu Chen <xingyu.chen@amlogic.com>,
	Yixun Lan <yixun.lan@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 039/128] clk: meson: gxbb: fix wrong clock for SARADC/SANA
Date: Fri, 16 Mar 2018 16:23:00 +0100
Message-Id: <20180316152338.654185961@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109135350374663?=
X-GMAIL-MSGID: =?utf-8?q?1595109432269228766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yixun Lan <yixun.lan@amlogic.com>


[ Upstream commit 75eccf5ed83250c0aeaeeb76f7288254ac0a87b4 ]

According to the datasheet, in Meson-GXBB/GXL series,
The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].

Test passed at gxl-s905x-p212 board.

The following published datasheets are wrong and should be updated
[1] GXBB v1.1.4
[2] GXL v0.3_20170314

Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/meson/gxbb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1386,7 +1386,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_M
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
+static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -1437,7 +1437,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge,
 static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
 static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
 static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
-static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
+static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
 static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
 static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
 static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
