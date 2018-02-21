Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227USmTm0lyYr7mqkrztT2B0XqOP4Tq66ZaRV3BFFK7dpIPX3eiqp9oewyDcPXFaWD8YJtj4
ARC-Seal: i=1; a=rsa-sha256; t=1519218305; cv=none;
        d=google.com; s=arc-20160816;
        b=uz03Ju8JSlio6R9M2m3ed1u5H0KhYHvBoXVOYOs71csmRvjj2E28EuL97Py7p0sloT
         F0W4D6LIMKyR2Cuj2MlvoMcA/jMWvsjDyw0fTV/cVAeRou8iLMM+LUI6D74ItfuJ5/IF
         R8HRjkkhoGy9jPOevj4PnI9X6WIZXu6KguJq6jLVFiHI9DLsLL95POYWX2KYjCrKs2GO
         YRWwdSjE6pImu1UGQVzvjQnVqiE2L1oreb+sceZRH/eRwpIr67O2RA/7YBhM9WkIlbFF
         rWGGAzUpwFYv6adzYjyRDobQ6nFpRRmgWTBmbohorD1SomhWmNnUQsXFvZArebaDPnF1
         s0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=epSXfZkD9iPfCZ6o4oq0vnqe6Ne10nfUg8Rjc6MC0GY=;
        b=B80ALGKPTry12xtws47XcNCjEvxX6g8zYq6ZXZ9WcptNU+QbDslBd8Yez+1gGBDvB+
         pEwT7r8K4puC52MQg7SQOYelyiVSzWurz0S4KzY2IPCN1HT1vrrlxo5zjc1FCIvNVJ/A
         i4l0aAmhCc5kEMeHQNUga1uM7f1b30tVwnDej2Oq3AlJlPP4z340NAmdzLzFj+xPaD52
         zJPtaFIu1N4Zd4okfMBnBmsrCf8boJ42Ppedmzb15um7vqxbHzVBUxu+aOXYU7AvLpc/
         sEgxYHEL1d+GQ9l7eIGBC4ikm+iPrJfFPKbJ4luFdNzgCpaKcw5vUbOzuHa5cVZ9Nebj
         qGDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.14 160/167] arm: dts: mt2701: Add reset-cells
Date: Wed, 21 Feb 2018 13:49:31 +0100
Message-Id: <20180221124533.596161798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015364888704673?=
X-GMAIL-MSGID: =?utf-8?q?1593015853502939584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Brugger <matthias.bgg@gmail.com>

commit ae72e95b5e4ded145bfc6926ad9457b74e3af41a upstream.

The hifsys and ethsys needs the definition of the reset-cells
property. Fix this.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/mt2701.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -593,6 +593,7 @@
 		compatible = "mediatek,mt2701-hifsys", "syscon";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	usb0: usb@1a1c0000 {
@@ -677,6 +678,7 @@
 		compatible = "mediatek,mt2701-ethsys", "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	eth: ethernet@1b100000 {
