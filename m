Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJbmHD2Q6dwI5v6p1l8lxi3tsLH1CVQWi/SQY+hMc8LF+HgnXNyzfHABY3P/+mZeWzvEZo
ARC-Seal: i=1; a=rsa-sha256; t=1524838104; cv=none;
        d=google.com; s=arc-20160816;
        b=ruQWfQ/DvGsLhbzba4PaV7ik3bfjDWOA+HXsRdhEAVraHmaDs20JdzFIldBTZe7YzO
         fTAwccWyeXhIEHwXWM5QvrAb9SebCLSujf73rJ0hBARFt1At9/wlKhg1OaidOf7Ec65L
         s984n3pWcPxtXZGF6nAMbKyO6zllCDrqpTzdue241ebLdjXwtex+ysrrXWYFE8QtjX3l
         5D3dRDR3XOFDEUwjoa3KW2/V6X5Kqh/0AGydaTwOYcjAsq1dcpDc3bwLDHBS0hyRZvul
         eJu6EphEjodEBCozhQCoqaBmP/WQmHmVpLJjXBThx3wXuLblVyCJ/MDtfQhmzqDQA2ZJ
         VddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ZVrJgzyVz9cCzB4OKtEoz7AZIcKaw1F5qwn/21a/zyA=;
        b=0hj+XKE2jOWLtfpmGjpz25JGKaUIzyjr6rZVwq8fL+EUxbSuD0zUPl5yA/KN1usqtW
         zgKTbLW2ih/xAI5VhFWTuwFbqPptNYtp4FeMDLuoGVkGGqcVxCO0VLK+T6mZs4Tmy5hC
         ru8idi3+rdAFFvZNxOFpxxdkFsJFnkYCzN1pWwtQKTErHXeENx5e+ZZuT6QJcq7LkQYx
         fDxOd1HEY07n+wRxzKkodFjChgyDdOEcBbzBbOMihOA/RHdfvdAxg2aFZTF/2qYtSuGl
         W+V0i/gqNCVxcMYEW7auyM5GjySa95Mpx8O1rFC1bOKZQT3vhwYTwOd8b8w/y58ZEGuO
         1BJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83F2218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH 4.14 62/80] arm64: dts: rockchip: remove vdd_log from rk3399-puma
Date: Fri, 27 Apr 2018 15:58:55 +0200
Message-Id: <20180427135736.104615801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908639969070648?=
X-GMAIL-MSGID: =?utf-8?q?1598908639969070648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Klaus Goger <klaus.goger@theobroma-systems.com>

commit 87eba0716011e528f7841026f2cc65683219d0ad upstream.

vdd_log has no consumer and therefore will not be set to a specific
voltage. Still the PWM output pin gets configured and thence the vdd_log
output voltage will changed from it's default. Depending on the idle
state of the PWM this will slightly over or undervoltage the logic supply
of the RK3399 and cause instability with GbE (undervoltage) and PCIe
(overvoltage). Since the default value set by a voltage divider is the
correct supply voltage and we don't need to change it during runtime we
remove the rail from the devicetree completely so the PWM pin will not
be configured.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   11 -----------
 1 file changed, 11 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -155,17 +155,6 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 0>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-		status = "okay";
-	};
 };
 
 &cpu_b0 {
