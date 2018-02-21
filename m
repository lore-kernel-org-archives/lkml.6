Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224gqI24mLm+5HbjJrOkq2jbBUxOkLSd8ReqnyZtIJ0530Ira0BN+pKzreheV7Avk/BhCWDb
ARC-Seal: i=1; a=rsa-sha256; t=1519218295; cv=none;
        d=google.com; s=arc-20160816;
        b=uXdTc9OPjULFPN7ECHH9SdB84gvMNNazKB9lIuhpwsyVSb63ph4MbjmOXffwoxxmRI
         VX6yX9z+CILr8Ncf4Ygqo5LTupA5WuNRX4VtBf+eX8jEtYoc2Ep7uz4LwYsdrE4r+P2r
         F6vP/eStgN6uESxcan3C8XkSAudKlJKLbw/b65/ff0Qe03yxxMZ9VjmUQLq7RFMtPUoG
         Kt07j9b9WsjIBCBelhovIxzAvPnCyL4ONBFCuVyvC8BcAUI2tZPCW9CUvrb2/mLGus1c
         1RUrBZ+fLFb0TnEHOBELjeUBTn94PmKlByMxBMueLAQ85fYWgrbG1wku1h00afPrsJM9
         GRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c38CRXKJ2fNgLDpf6fF1VJCYDTeXk3ZOS3G0rXGbWbo=;
        b=u1G5rOFpNTeUX8WhKq+TEXDiUjyr84jgPYlFPsPX9Pi414W3lgAwYSO+IvnUGP12d4
         Dg7PmMBObRlFA76d1vO6oHad6q1XGp/HyKBtpbo4LKaLNjB7a/MWooe3jpx2sCVCRXEG
         lrBhSC50xK7Hm/3Hq1sf0gpp8W2onDbd15bMlkhNIW+3JNqvDywCoI5p1vobpgYXPVXN
         UR3q67F6TjRryjvtvmgASYRrOLAYZvo2cNRxmpI1YHh9YpbaPlWiplEWBdCS9DkE07iW
         Zo1lG1H0LAlspVP3sHehjfBdbxKswFMBE6x2t9hIVR0waHl7Xlfxm/B9JrS1W/S5tQR0
         uOmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Archit Taneja <architt@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.14 157/167] arm64: dts: msm8916: Add missing #phy-cells
Date: Wed, 21 Feb 2018 13:49:28 +0100
Message-Id: <20180221124533.437490178@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015359329892951?=
X-GMAIL-MSGID: =?utf-8?q?1593015844124791478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit b0ab681285aa66064f2de5b74191c0cabba381ff upstream.

Add a missing #phy-cells to the dsi-phy, to silence dtc warning.

Cc: Archit Taneja <architt@codeaurora.org>
Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -901,6 +901,7 @@
 					    "dsi_phy_regulator";
 
 				#clock-cells = <1>;
+				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
 				clock-names = "iface_clk";
