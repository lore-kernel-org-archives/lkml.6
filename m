Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVbNWZT017aSO2PhzZeYY9jZ9+eZzuSGsCLHvHg+BY1P7PWJcKbBJ1ClrfB0lF5ylLOFBH
ARC-Seal: i=1; a=rsa-sha256; t=1521214611; cv=none;
        d=google.com; s=arc-20160816;
        b=VEUNLQnUeYEF0g59iKXD3hojc5E4zxb7THivg15NbG6jJEmW33cyplSOpqJuYuoG9q
         Vxnh9SoutcuZOTkrpRbBCRMIXjSuNs7BGNW5qikIscSF83EcTQTxwsnk3JHQwVsKvONW
         SUYDDTLrdya8gl/cvTo7f3h1j4V8ksnwtZZybLlSjCCcTjKDBuHDb167kHGfiyXaiADW
         XzhHV/2fm8inAJAlePydd+I01vRk0BMctJCklp481G7CgSFK06sPWxhhHDvORRH3xhOH
         pfACAnGs+4WMjGZYGoOjVxPpOeTi2jBSYJsf+trpsMOhq2+knFiqlANhSCs4Bk/7Tb8j
         cyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ggOEnT9TVVhga6Tp+bIi4M+L0k+FmLjtTdykb37Nhck=;
        b=JnNxqVBRV1//Ycd4HV4cMxJudYYIvgYjq1lCPNP8gQOw37JRfTX4zcU7spnUJvlmMS
         dCx3EpPGZShgEAYe4zC7SP5GPdCfvmsgdf2oSoHC9h7VYlS/qsXEjQzvW0t90vH+myvw
         sunDNvSoVMvpamAgM6ETa9ce4ezIz/+ifrQmZ5S1+Zc6Uw6YqbOaNESyV5FL6C+yC8HB
         7pYG3bSQi5XkPHxnkQF4wAitz/f5x5rPGn/PDLktHdOE7o9kPCtJv829G5hKoBcOt6Lo
         Ce940j/1tFeHUIDhTrC8OIUaHMqrkae9eRLITWskjZMPES86H/r0GaKDJ40DizBE9chz
         GhYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 033/109] ARM: dts: koelsch: Move cec_clock to root node
Date: Fri, 16 Mar 2018 16:23:02 +0100
Message-Id: <20180316152331.762985823@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109132377182024?=
X-GMAIL-MSGID: =?utf-8?q?1595109132377182024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Horman <horms+renesas@verge.net.au>


[ Upstream commit d72f4f03854d1225c72d682bf0e01377e7016419 ]

cec-clock is a fixed clock generator that is not controlled by i2c5 and
thus should not be a child of the i2c5 bus node. Rather, it should be
a child of the root node of the DT.

Fixes: 02a5ab18d366 ("ARM: dts: koelsch: Add CEC clock for HDMI transmitter")
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -278,6 +278,12 @@
 		};
 	};
 
+	cec_clock: cec-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -642,12 +648,6 @@
 		};
 	};
 
-	cec_clock: cec-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <12000000>;
-	};
-
 	hdmi@39 {
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
