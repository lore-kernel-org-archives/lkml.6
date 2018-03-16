Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVrBsSs5vXWrPmS5WQseGBuvF+ZoyIDspqev5dzmnjInVKlCdUZqAzARPtFWidzKSFa0xb
ARC-Seal: i=1; a=rsa-sha256; t=1521215005; cv=none;
        d=google.com; s=arc-20160816;
        b=Z2wDYuNJhywjyM/FtRCowIhYXGGSaSoTJ2bbJ61EW/zAgIvs9E9IBoO3YvPFCSl3OE
         FFfxXFGD9XzWMUcNGrbddRsjP5HyHJ28/+nMVa3SDsCeZcW1FX7sGe+jZAs46q3qfKH6
         kT+0YzURWwyR8uDH/sUAEhw0DOfym+2/AIvCQUSDmZ0+2F7luNxLUFcK9qwrGshBBgUx
         iDQfJmbLraEsvcKlpSGLQRGY/y4r9wCYgyyfJ9LHJeGodLeFq3WmHQW0JNf/SVnhgHLj
         xTOswdAzUTb7Jq5AdPkHeFMfDS/+89C+BUFU+ZO/i0VTodGWva0U2klbPvr0EtqdgDPC
         Gx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pWaMIpk+A5z/IpL2k1e+Wo2QmlSvYgks4CrDktmFriE=;
        b=pz6/s8nuBP1qzp5kqgAkAHCptq88rgMLEixJIAubeFN/8xDW7M3pvVmVAfbzYKw2T4
         AtBL+y5ubiW4yqND2IT6MIaMVgsZRxq7jTMS6NYQyjCy27On+gTKMGSBSpTflU+iZCw5
         GPWXHdU6CZrgWw/xDmL21A924mykNd0Ug+gvd2T84oofp+KaVw2Yx+CGcb8zEV6k47f+
         ZDrmP8kXsGCEhJtfh/RG0p5/HVtXroPRr+QTIMDrL27dFutWxwgXnDzYcuNwaMim02nu
         PmQAiJfkyUybuu/dGV1a2xy64NHKuCQyOl2QvdgHf33AvpyGdLlCETNg3k96+5ecamDq
         dskw==
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
Subject: [PATCH 4.15 095/128] ath10k: fix invalid STS_CAP_OFFSET_MASK
Date: Fri, 16 Mar 2018 16:23:56 +0100
Message-Id: <20180316152341.296178111@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109173131822899?=
X-GMAIL-MSGID: =?utf-8?q?1595109546115179965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5236,7 +5236,8 @@ enum wmi_10_4_vdev_param {
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
 #define WMI_TXBF_STS_CAP_OFFSET_LSB	4
-#define WMI_TXBF_STS_CAP_OFFSET_MASK	0xf0
+#define WMI_TXBF_STS_CAP_OFFSET_MASK	0x70
+#define WMI_TXBF_CONF_IMPLICIT_BF       BIT(7)
 #define WMI_BF_SOUND_DIM_OFFSET_LSB	8
 #define WMI_BF_SOUND_DIM_OFFSET_MASK	0xf00
 
