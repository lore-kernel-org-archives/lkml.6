Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXHo6ImvWh4mHOi2H4OdlR5Wo/Ioon5l8adTPEwIgZhCPHjpmu1a/5eXZLKAC13TpUgB6c
ARC-Seal: i=1; a=rsa-sha256; t=1521483985; cv=none;
        d=google.com; s=arc-20160816;
        b=nxH1WweOi2Rjuqz8JDwokHRPXzVx9altRYUav9tJUvYFn5L+g0RYhqGG59Yyo71zxM
         TzW1EZbxWWzpDHNG738EBNzwxEaXUmHCrmp3tU8ZU39itlzyHcp2btgbc4uJHr+0MZ3x
         1zIsv7R2t5Akz3cZESMiO5VsCyIRkph5SHFkhVo0YOYFndVgf4tRiSFjz47nn4Gk1LKi
         1bPi8heto0CcGR4HPMTWevUNL3jxLdKQQDCf8fsMocUOJLRJer8vWv42k9HjN2arzaXO
         /dSSiZlNe3QL4yualjtH88BnVO1li0eWCIs1yUDasgPnrEzVICfcb6Kf3sOiD8/NhShB
         48Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/rDQA2Cnuy3pV7T3XUjICdNduPdm4CauCgSXtB7POEM=;
        b=HSdG62YTWPkP/qLGw0AbA/UNGxtmnzNvabgmPEsTVKAnG43LOpD1MpF+IjBT1sK+ga
         lo3F0DIAqbx94W1050g3d5ekfzG5P5u0O2gjRco2AB5sB9/2D08sS2RioDZBKNK5EIz7
         ih5GlNfTf9XXgUThcxUnhRIQSreY9T3vSKd8CkGx82thf72pKJDhlBPN+uy5FxKtCF2z
         Hu0VhhyxMxrCmSS20ZWqLGMkPP0PKKHEo92ZO3k8MKuCXFsZpvTUjij3Smq8dkheKEnD
         uJvsa4EHFilX2XeuKRVjJlU0evLqkgAobl7ygTRLF8m6IP89oJCRrjVHcSRfT8aOMJly
         TSMQ==
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
Subject: [PATCH 4.9 190/241] ath10k: fix invalid STS_CAP_OFFSET_MASK
Date: Mon, 19 Mar 2018 19:07:35 +0100
Message-Id: <20180319180759.008654033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390933811655032?=
X-GMAIL-MSGID: =?utf-8?q?1595391590954217676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5017,7 +5017,8 @@ enum wmi_10_4_vdev_param {
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
 #define WMI_TXBF_STS_CAP_OFFSET_LSB	4
-#define WMI_TXBF_STS_CAP_OFFSET_MASK	0xf0
+#define WMI_TXBF_STS_CAP_OFFSET_MASK	0x70
+#define WMI_TXBF_CONF_IMPLICIT_BF       BIT(7)
 #define WMI_BF_SOUND_DIM_OFFSET_LSB	8
 #define WMI_BF_SOUND_DIM_OFFSET_MASK	0xf00
 
