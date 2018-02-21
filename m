Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VxVH1lgk5JI3FWV1XKMwpJBjmiiA4o87guYe8dIMbXjcEOLy8o/LbPqZ4oljbgGY1Pg9s
ARC-Seal: i=1; a=rsa-sha256; t=1519217924; cv=none;
        d=google.com; s=arc-20160816;
        b=anX14G0zHllzdaUgOuK8hf1mcsp8IwRQvlVzEVIest+zSceBt4MyBPuAFSrxzrHsF6
         bth7r/kEbj9M9Ckpgu9sayVGuhnXZO3/4hnBcdiguBkGFozDA19bJHVoB23sufLdnmqH
         ozPmiTS+OtAvyfb3Kq9nYeODSbm0L82mBDdP3YYnjd71Re93JmhRJUBem0ETSW5YyaWH
         aSYzDJ68O7tUy3WUX6bDbTEyDNeM8G46s9LE2oZAzYjOnR7u7Ihue0aXNeBGAR+AtMgG
         vXlArAtspL3QanQx5RfRimtxsPVbp8bL6t6SRSiJ/BW1F+5uZkbN7vvczrxcpCrhNsoy
         XfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eLUhO2vEGx1EUr6FGAjDoTIfr5JnnJ+0p42T2V/7oSs=;
        b=tIIMJY1eOy4yf4eEe2zh791WvTx0GIm+eh2+ALmYgM/+0LUXwOFQn20tZaDrIao6Ut
         HJhOZYwgT7pYQZ8lGtnXRAHDyvsio1NRsftWGT5Edl2iBBhAVfpevOjPCnPY4DER71wL
         Eq+kBJhi9ABErX9uwVK9ma39LRggEfRDVU/rGfmrEjodR9PqtZZ7CBgA1oTMmAHeyFmd
         RuGPxfboo08UzoIj++gU2EOPc2qU2hRJVlsZJI5m2HF35fSQZ4LdFAL9yKrLMakymylh
         hEoCBzXHBwFOXicQQRqfWlz3IdJxzuohRBTBj80+Vj7oeVxW37NWr5zkcxPK4HB+v9qB
         KHPA==
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
Subject: [PATCH 4.14 026/167] arm64: dts: msm8916: Correct ipc references for smsm
Date: Wed, 21 Feb 2018 13:47:17 +0100
Message-Id: <20180221124526.030604592@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015280077586216?=
X-GMAIL-MSGID: =?utf-8?q?1593015454950402325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1430,8 +1430,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 0 13>;
-		qcom,ipc-6 = <&apcs 0 19>;
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
