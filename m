Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227IwogmC0FPYSlBDqpAoDTy/ifoCpQ8fFeHsXqD508RP+82TyTW+nlY8JNZL1ANyvBZloIw
ARC-Seal: i=1; a=rsa-sha256; t=1519217758; cv=none;
        d=google.com; s=arc-20160816;
        b=Fx1jsQlDg3bwKZ6cGPVqm3n+dEGa1VPxZQQoSMj/MduE2VHqrm/tb86NW9tuicccrx
         1ZFT8eYLoBxgPjN63Si5PTLxaii+2cUgDTKvNevEnqVU/VBEQ/j76G9u9VFtsbLV5DHM
         JG5n+kBfZzs5QPWP/+36HR3XB8Z2LeRh8y4TaZyYXnJggVSg8RlQLn67k/dBHDk/AMfN
         /NZgLkrNW6tCNcHGYWBHyaJsUaH22jst83ChkO2t5d5rLf0NQTG0b0qtBMzaD3edRRfI
         9igbfuo8vCLwz+fpNVI6ZxsGRdTqhvDiwzWrPeDh9Og3apiLXGe/PVObii9urKpx5BBM
         MGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4SOen6Gllw5fJOvYoGKElh2lwNC2vV4/eXO0H6klOeg=;
        b=h41TLbh+0294XgowqItTMHkwbm1QqzpgFDpcBoDG4Su148ylaUK2RtFstrD9X4pw5Q
         VUogDKUP4/NYssuqGgaHs6fCcSTIuX572s/p+iC6MGrECUNyOAFkIoRMX+VO8Sar7sIu
         qtaP8bYo0e4VGs37vO5fROQn8vA5dv5OdARQtr1ath3IRU1Zdb6LjllzGU/evLS1ruR7
         4roQ5WG8Xk1iFAcqkXwoCnBuUyzsIrpRcNjgqg7ClK7oKSVDo09oEMuCQxb3cBz/Qvby
         yF74g9p4BXA9jkCA3hftCf7u7rxbgu/LM8FRt2ZMhimGAK3jorEuqhhNZuwcbVhwXAua
         Jnig==
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
Subject: [PATCH 4.9 43/77] arm64: dts: msm8916: Correct ipc references for smsm
Date: Wed, 21 Feb 2018 13:48:52 +0100
Message-Id: <20180221124434.007064222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015280077586216?=
X-GMAIL-MSGID: =?utf-8?q?1593015280077586216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -906,8 +906,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 0 13>;
-		qcom,ipc-6 = <&apcs 0 19>;
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
