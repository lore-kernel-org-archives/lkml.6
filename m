Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Ls63pNyY1Sc2ukTkXBLtdYOgz5JfMYyda5msnufeieLm2kqPFxB0iokm4XjURoeeWUw88
ARC-Seal: i=1; a=rsa-sha256; t=1523021912; cv=none;
        d=google.com; s=arc-20160816;
        b=hmzAFPL4SyGC0UVvCf4LdJg2rRTCHx/vMXigttIdcTkhYxILrhYum7fc1YTeTh2I4F
         eKu/RbIAVKs9+dNcrvstzTq3K53OK0+KaNjzuB+oOy5lRzbx1vajfFtsZysHNzKrmuQK
         ut8I8TABq3W4dQVHRfJtV3CAm2nnQKaFgscuH/OyOMQH1pMjHJ7w76CjNpjcNTLeuWmM
         n/9BL98PXsjs0jHAORRs9SXW+MoQ4ux/ekb/k4aCQ2g2W8ZYYB4iUuoL15LPNegEoy22
         y5XptKagR7m4N9Mr+8PtLz6X5VBcE6VzpiCSaNGUKSElgEMA/hqsE5zPI257WSC9ViQm
         X3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9616sPMVXbm/V0SbHvSvndTFMsEqbLakL6dLbmzLR9o=;
        b=bbi0vwQ4ouRhkiRvQTuTdejX8T7g1k1Ck/MysvKBSd82Rm4kVd7tBATkwI1F6axSRD
         da0xB9AipCZFUgPKtfT+x2fRpRsZ0FWxpaNb3FP9CtM4mCCyaypfr+AonKdc7Zou0Xmv
         f2sj2lKxr6LGYCSrX4GF5hVkBbIo2Nx182ODxfswZ2SX994JLFAJXMsMzT1oQa+4IJwh
         3DVUAMocmxk1huOZ5MN6rolyfUA1DsL2QqD3MWHWaeSJdpfxCqdnjfihKBeEBYvYtrGR
         77GJ3vIjT8Tf/E/gGMV10o3PSqmMa9gCAT6QMu2Zb18Hw+/IoASihW30YDpetBQ9Zgat
         eTuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Rossak <embed3d@gmail.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.14 03/67] ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties
Date: Fri,  6 Apr 2018 15:23:33 +0200
Message-Id: <20180406084341.696740711@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004224780600587?=
X-GMAIL-MSGID: =?utf-8?q?1597004224780600587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rossak <embed3d@gmail.com>

commit b23af6ad8d2f708c4c3f92dd8f82c233247ba8bf upstream.

The eldoin is supplied from the dcdc1 regulator. The N_VBUSEN pin is
connected to an external power regulator (SY6280AAC).
With this commit we update the pmic binding properties to support
those features.

Fixes: 7daa21370075 ("ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -163,6 +163,8 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 };
 
