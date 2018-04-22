Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cUuGU3DtiXt9PR9H9RT7rhbID+jwArfbA0uIDywFT+51ekt+/bdPBeezfoPGFc7spQbgk
ARC-Seal: i=1; a=rsa-sha256; t=1524405862; cv=none;
        d=google.com; s=arc-20160816;
        b=xNrtVWO/DzlLgHSpfojopzk6gvw2eqW+sNOW4ViUW0zlb4np6589qngZBHBJFNkCIA
         OU/HVvqGH8dBi1pmrM1BqfOP6FbKqn2j7iACq4BDoqZJ7fZKDg9R6h79FPg47ZwerJ+F
         gbArYddb28ycN2o3IEpVxq5s63lAxUY8egdFEKSQJPSn3sULZa64MC//aILsD88VFE44
         4Q81FNSkYKboQBaIPWyU8OkYRl2mj8UHwcOtM2RPqsTFV+Qi+qM3Krin/x745dZ7vW+r
         uJ+RxZFUL6fHdtt1o9Df4AVx9VwVNCWjliYr3nxLNLEn7xbzEOjyBo5qfYmY79nBa8iR
         lp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DgDR6/0QeOorZ81VWE5At1gFpQQKIavmagYDSontd+M=;
        b=WcejcpY8+YhVmpLCulqCln1fzAKuhxc618PRs+Bc3CqAgNpaQA7e36FlIJtSDkZINo
         KXKEveilaD3dvqcZniGHaQ9ypCU/9uCnk0KPZ+O0CWfluP72mIdBHJR7exz4PTTKzkzF
         SVYy5vtgwTznCpEZJtkCVnvYtfSu60Gyld7TNMwSAvgtlTsQY+7N52k5XIZOCiyBSpii
         s486HA7AAX3e9OhN82SWIZgLV2QY7QeZwhpU5hdrFIevzWef1qkha+vu4XkLckfIILGX
         c51kfEXHOR7SX4mvojdR1Iolc7wsbLud9Qpdz0dJHSP5g+FAtRgAw7GQZCxsEaxJib+n
         9kGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Santiago Esteban <Santiago.Esteban@microchip.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.14 025/164] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Date: Sun, 22 Apr 2018 15:51:32 +0200
Message-Id: <20180422135136.426791082@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454842841403828?=
X-GMAIL-MSGID: =?utf-8?q?1598455401999180194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Santiago Esteban <Santiago.Esteban@microchip.com>

commit 9a06757dcc8509c162ac00488c8c82fc98e04227 upstream.

The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
it's the appropriate compatible string. Remove the
atmel,at91rm9200-pinctrl compatible string, this fallback is
useless, there are too many changes.

Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org #v3.18
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1365,7 +1365,7 @@
 			pinctrl@fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
 				ranges = <0xfc068000 0xfc068000 0x100
 					  0xfc06a000 0xfc06a000 0x4000>;
 				/* WARNING: revisit as pin spec has changed */
