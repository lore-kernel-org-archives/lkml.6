Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv9ynWUJ/r3rNDPqKvCRSbc1hBwNDQiCJ8CoK1d8urmqqIwzzl7bvvMARqZulA0G8T38rXG
ARC-Seal: i=1; a=rsa-sha256; t=1521483357; cv=none;
        d=google.com; s=arc-20160816;
        b=z9TSnLVhDPo+rEXaC71YM9YX8oL+WIzX8puiBG54yHuEgc7ED2h0gYfH+kzXI/G5Tp
         7rtCYArOCIg7bngr2k28vmkp1IAuEGweuljWZHz8yp7a9HUaQ+zkWaV880RS+QMyvb+c
         RWLQEMO5mmutPXj4tznSUWdQaUfsBugCTCOXluItIFfzSrMwzanYaqRSmHglNGPB8nEi
         Srs9/5UN8tmUspnsIC7+HpY63N8JT1ge6aKD5RE+iMygEgL9ZPx6nxoG6gmi/Jp5Vj8Q
         INRGF2nqQ9s84dF6+otsWbR7U6OAGWpwqOR8lT5I6oNMa6N8Pmr6BmsyyxjEDkTajbyK
         Z9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YkgagwdzN5JasXKdQ61Luh4KdKRWoFXEvtdVTwMR/H8=;
        b=Vzm5dE6xmGMfzGuYPG46DbMeQ1SxpF3+ccPyayyyF8z/Pqn7jtT635968VI1+IYv82
         iRQDkQuI86CVAJKfJBFWS9MTtVlR1pqdh7dIspbYZUi12oL+og6oNQTTGrn8ADzpdWB7
         rvWfy5OhFfyCud6kxoPzcd/9HI3arVGAR/4Z7/fYLwJqnG0Lza39yqe+joins4wU27yZ
         j/M8Kr5ujo04ZObtmzJA7a3ar1EeiT0NS6AMXREXKJ5sYEllz5dq8K5T3cXhqD7MLJTz
         SvgHD+OKi2er54cPUbFzs8RSkes9omNHixDAX58bD8noT6e4X98uFU44ysmETmfpK5hQ
         k3Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Greear <greearb@candelatech.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 094/134] ath10k: fix invalid STS_CAP_OFFSET_MASK
Date: Mon, 19 Mar 2018 19:06:17 +0100
Message-Id: <20180319171902.877771095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390933811655032?=
X-GMAIL-MSGID: =?utf-8?q?1595390933811655032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>


[ Upstream commit 8cec57f5277ef0e354e37a0bf909dc71bc1f865b ]

The 10.4 firmware defines this as a 3-bit field, as does the
mac80211 stack.  The 4th bit is defined as CONF_IMPLICIT_BF
at least in the firmware header I have seen.  This patch
fixes the ath10k wmi header to match the firmware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -4826,7 +4826,8 @@ enum wmi_10_4_vdev_param {
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
 #define WMI_TXBF_STS_CAP_OFFSET_LSB	4
-#define WMI_TXBF_STS_CAP_OFFSET_MASK	0xf0
+#define WMI_TXBF_STS_CAP_OFFSET_MASK	0x70
+#define WMI_TXBF_CONF_IMPLICIT_BF       BIT(7)
 #define WMI_BF_SOUND_DIM_OFFSET_LSB	8
 #define WMI_BF_SOUND_DIM_OFFSET_MASK	0xf00
 
