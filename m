Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Gwzg/j2KL/hfUcElRZaxDd4J8b4F50bA/zFGVzblmiXJFOMzOwGatZrhf4GoQcicCD0RU
ARC-Seal: i=1; a=rsa-sha256; t=1519217833; cv=none;
        d=google.com; s=arc-20160816;
        b=dwKmuBldy9A20SGOm5Yhw4NGTdt+0PNGYyuETVCoecORrXSzR0FoUqq73y8viYRGgQ
         IGleFlSKp2htCh93JJ3ZYyr60wa7LIMJJ1DCHtpnIeTfrjgDV6xMeBcnpihFA/d00LG4
         ANNu064REKt/xoBpytwU12hf43/wpNiTFdn1axI+MrjqDLcesFDZOHLrgrpsxrTUlJo6
         6vyzJF3PSoWaLjWw3qcIIhQRFcNIvr2W1q8RX4ojqor2SFThfSEBOSHaNARflhWANXBA
         AM4m2CLVrMegtSzetjQRjO55r+iAXzIy1EGELQwyXhbQRzWxa0Rq574cXr8ng80flemi
         I3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HiYEy4EyiLnV8BH6GixENYakWkXRli7Jl/rcv555U+o=;
        b=MkHI4kAUhcqcIJhAP880dZuE78Ks2Pzwgd6xhRquk8npgsAh6SDP72hZMYGbIReqyR
         idU19g5Ixqdbap+1zvH3z8qXmwow2NIFJ9wpFcnbCvdmP4EiigGstGvnsz+BlQ6QCkCJ
         F8tk4HfPbATRQiLNEZz5KzfmA0e+CiJ2Rw+XD4WBjyIIsv1lfvlF+0NdgcGyWQ3cN490
         jn/6aOUypYLC9486VIn3I8+iGWBk8n5JT3pldnUX+LDPMBxaRQWMioWu23415Fa5JKMF
         3mFd36RMHY8JVBkAiJsd3cnpDl68IOWN3QEhhbfVvPyQoA5ibF+r6kFfClvPALQYmC68
         gPFg==
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
Subject: [PATCH 4.9 71/77] arm64: dts: msm8916: Add missing #phy-cells
Date: Wed, 21 Feb 2018 13:49:20 +0100
Message-Id: <20180221124435.184173618@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015359329892951?=
X-GMAIL-MSGID: =?utf-8?q?1593015359329892951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -796,6 +796,7 @@
 					    "dsi_phy_regulator";
 
 				#clock-cells = <1>;
+				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
 				clock-names = "iface_clk";
