Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4824aJyzihu7Gv/l9NIQvFlV6yyITV4OanajU1FrwghZm/OShzuyFbP7vzAOlTtf/rMMEmi
ARC-Seal: i=1; a=rsa-sha256; t=1523021350; cv=none;
        d=google.com; s=arc-20160816;
        b=y4qnzjJ9Vb3IOG+KrAec2xS216/DrzDuZaH7mpN2w+QzBVI6lLUA/VhFedfOUzdijH
         iL/P6plr9m9zsFoWOWHtehZw3ePHK3oxKiOXYyPyzE7amEU57isDuRa+LUCQIwdSQ2HK
         oPXs4NFCehIk3lPEM0e8Xw0IpCvy4bynMmhgcR7gLdXVB47ZDJ6T8gex15Kkn2sQOxcj
         W8G+Lq0aIIaVikw7Q2fgAxfIN4b88IrvA9OSSRVDSAZf9J4HAmc2EvW8rzg4pWITj9WR
         6RhuNaR4J5tT+yaAmF0amf83RVb4hMxiU4OwjpN6sRQiao6Ush+zME9Hga08OQRZ30v4
         OCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hbZTliT7pfdJuQizrFRewnd6Ccw2GInUIjwDhZ+b7fU=;
        b=Sleb3YlATnfnBWT8DviARunQGVA7+IK23TRICDVXHuriVi7r5lQTnXISWon4Qjohbx
         Z0A/2wFwlbxNTrILREvCU1UrEEFAjQmzD5vfzq2x2pUVSlOW/q+t5h2lJlFUt6Vrvqw5
         2lq7V/KJttNnpxnzb1870zWDQZGUzu/a5xILipP0FygcA2kgphh8ZdJrKszk+m0cPK8b
         ZOxTZYKXlwCLKxr/fV8GTaJyWueVdHp/UvNud5ghHsceYy55nduL2K39Vpf1KNkgtqEa
         5cxVtkT0UZvGISDEDavAnRLP4xLQASuXCCfu+BsAXLDqXha9MQpuc9IiTiEELQj7aObO
         Tqbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 88/93] Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
Date: Fri,  6 Apr 2018 15:23:57 +0200
Message-Id: <20180406084229.023610140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003635732460305?=
X-GMAIL-MSGID: =?utf-8?q?1597003635732460305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 0ea66f76ba17a4b229caaadd77de694111b21769 upstream.

GPIO7 is configured in POWERHOLD mode which has higher priority
over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
bit is turned off. This property enables driver to over ride the
POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
scenarios.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
@@ -35,6 +35,15 @@ Optional properties:
 - ti,palmas-enable-dvfs2: Enable DVFS2. Configure pins for DVFS2 mode.
 	Selection primary or secondary function associated to GPADC_START
 	and SYSEN2 pin/pad for DVFS2 interface
+- ti,palmas-override-powerhold: This is applicable for PMICs for which
+	GPIO7 is configured in POWERHOLD mode which has higher priority
+	over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
+	bit is turned off. This property enables driver to over ride the
+	POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
+	scenarios. So for GPIO7 if ti,palmas-override-powerhold is set
+	then the GPIO_7 field should never be muxed to anything else.
+	It should be set to POWERHOLD by default and only in case of
+	power off scenarios the driver will over ride the mux value.
 
 This binding uses the following generic properties as defined in
 pinctrl-bindings.txt:
