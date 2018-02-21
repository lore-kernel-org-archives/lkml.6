Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227e4tTky3R/MdWZ3zNslorxmjTV21nbXKYy0504zy+goT6z3wRKWoQ7nG6uXrdYxrBaoFfy
ARC-Seal: i=1; a=rsa-sha256; t=1519218501; cv=none;
        d=google.com; s=arc-20160816;
        b=uuAqWZtRXpDCmMSf7l9zxJad5EFJyWcVpMfFBIEqtinVQXxqKOW3pdrAh0hAIGG0Uc
         BDcNoow0Ka4ItZTco71Nupury+LlZyfFXBA9V8An2w+V0lr4KJ2ceD3he5IZgxO3R09w
         27gwbtnt3lx8ARfgVJh8usWl4foDJ05aw6PA5ojl+uQXj1iJajf/DkFRMl/swrm+9orq
         5qAYGsn5UnlXONbL+bIWZXcPUC4ulvG13wiAhLIEufrTRRVFN7nT0lbrI0K20YWcIBPU
         dzzIPRRLYWNS0fMMIj0gJCGt8fJU31XKyRa0nH6CU2zSFklIOA3gGdT/aD4Ur2pmkIiA
         m0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TF0bpf9WHdYt7ugzLaaGrq8B4JV7SPdYAv82qTmAhzg=;
        b=MR6aj4gWYYE8FVzW3g+aF9E6+oMU1SHhilTR96sTdakvsPm5DdJsbIEQbUbaL7aHdW
         NmQ/Es80W1w3jA+S+t/puMvP/qHgrYhc1Yhjw8Fh8IHIsGNLaJLosS3YDYiPVSR+DZfa
         37lvTdqp7fz7PSx4nsGWpulPrydre30krUQ1qaqOOuWeW9Z7ncYGNRPqmrfyNPZ4zXUb
         FSLmuF76Trld2xSWcLFjaoc6tBBhfEuuXArtFFSBx7KQf83P7/L89PLwVpdYMoEvfm+b
         f1rLa6s8dlz2bwAOCGhSF7IoM6+IYeoRsMF/EH5nobfwGHEtp8zQY9C4Aw0wDe/QhBPN
         uLbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ramon Fried <rfried@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.15 027/163] arm64: dts: msm8916: Correct ipc references for smsm
Date: Wed, 21 Feb 2018 13:47:36 +0100
Message-Id: <20180221124531.720774015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015280077586216?=
X-GMAIL-MSGID: =?utf-8?q?1593016058859484129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 566bd8902e7fa20bd412ed753e09e89c1c96939c upstream.

SMSM is not symmetrical, the incoming bits from WCNSS are available at
index 6, but the outgoing host id for WCNSS is 3. Further more, upstream
references the base of APCS (in contrast to downstream), so the register
offset of 8 must be included.

Fixes: 1fb47e0a9ba4 ("arm64: dts: qcom: msm8916: Add smsm and smp2p nodes")
Cc: stable@vger.kernel.org
Reported-by: Ramon Fried <rfried@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1435,8 +1435,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 0 13>;
-		qcom,ipc-6 = <&apcs 0 19>;
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
