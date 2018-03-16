Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsO59XhYThqjLrn6loRzR0crcnaunk5GCromYlXl6XKDqrp/UuGLUIcKb/IKQRr1pA3oYJp
ARC-Seal: i=1; a=rsa-sha256; t=1521214650; cv=none;
        d=google.com; s=arc-20160816;
        b=TmI4suMAhhQeeKlAw4JGqo6G9RzvmbzxJCxo/E3wkt3QM86HfnsaeKbh2nCtEn+DuS
         KBOWo/zjwtf7Rv+tCTIgunQIzxgWDaQYmoFDg4lXCBvcAoJDV1lBReVX3lb/aLqFhN4w
         aWzrhz2mV2TJcSNfH1LbNyFvGcTGNJPBTj1k+tuGuTm8cIp+mniNQmcsqyg3kdPzHcrA
         NzKtKshDYes43GYLgwOAgm+h8r8ND8xTObDFU4WZ+cKjr2C4WLm6ptnostM/YMCavqlT
         NaU/3ynDek6NfmfTslo5/0Qr7IVUMbksFqNBrs8/3IFujjQoYaEDnCt/uHVtgh/hYfYQ
         KvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HBEhu8WGDZNudt/sUhn+0/Kf7WSrxVx8ZWmZRAq6vzI=;
        b=Vy5JsA51vRPaNgvmgEFn5ujX9SJEHH2qoAhuettAKgoZ74GEQiRlJLjDh/A4qP5DkS
         Uur9fXYjfxNMRt0cNh5QdBlL+gqGFVkm0HG+ZyG+7DXcsbDXW1GUfPRgder/ZuHJH75F
         GSD8XGZwM07rylOEyrI/uF8OPK7bl4SMT2yX3iHvEi/RbJIn3FNf+YFcreTjz5mJwrp0
         WO0Pe5OxbxecpcdbovliMgtfJsy1+SslLXRos90aqQ8MVLhg4d9hg9F7qwYP3rjTcNPC
         doYHgw4hcrQM4MIem794nMFsKbv7kk5aQT7GrpBTA+PinHpaGKhe/Ak7Fdzmi+p4tDJ9
         /5jw==
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
Subject: [PATCH 4.14 078/109] ath10k: fix invalid STS_CAP_OFFSET_MASK
Date: Fri, 16 Mar 2018 16:23:47 +0100
Message-Id: <20180316152334.206742347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109173131822899?=
X-GMAIL-MSGID: =?utf-8?q?1595109173131822899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5235,7 +5235,8 @@ enum wmi_10_4_vdev_param {
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
 #define WMI_TXBF_STS_CAP_OFFSET_LSB	4
-#define WMI_TXBF_STS_CAP_OFFSET_MASK	0xf0
+#define WMI_TXBF_STS_CAP_OFFSET_MASK	0x70
+#define WMI_TXBF_CONF_IMPLICIT_BF       BIT(7)
 #define WMI_BF_SOUND_DIM_OFFSET_LSB	8
 #define WMI_BF_SOUND_DIM_OFFSET_MASK	0xf00
 
