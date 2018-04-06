Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49f1hb5g+LAMHbwgOYwUK7VuZwKiF09eLuO59E3FoV6y3vST2d4AIwh/EexbFsuvh92kXGX
ARC-Seal: i=1; a=rsa-sha256; t=1523021496; cv=none;
        d=google.com; s=arc-20160816;
        b=m72xwCPCy1o6yJBKkjHregMuySheNPyPKrwvRUH94BKYMUCAf2HEwjlai6ccmfZLrC
         eVnmK8jOc5QfEo4dzmw/uZ0OduZBPy5g8sAjqhluZ3HwmT0qRtnj/nuqNrN+9SwAhYCf
         p+OptiIbGf4USM5SsWYOsFHiLEksD5LRcKF50xx3LnOXtU7x8Y+qalOsJzLhRloxn8D7
         dyHYUgla5gztEbsFP36Ue9Mj9z8z/N9ZW+VSQXe/QlpucnbVDcpCdU6D8ZRUZ9Hcm5nZ
         VtMRDdheOkFRSWCCsJ2gSlXIkC5TZoC5PeM0U2SC5+xXECczDclEG7ggqRh5wnjXV6Iv
         VSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vXZussCnsSmg2mcUh6dKFE49h01bySwXmzwPizqh2rg=;
        b=Bubn6LFu5/C+kCnVlInE3b4C+wHK4thfth+b1e4eJkc0I1OaX3JqUdrRwLWkpq6xyG
         o6WAWwJCUEGOGkIFRlEJr/oG2EkpGJffKGf+PYaHTFEceonX0dBTbo38Bq3mJCONrkmq
         8JU3KD/e1VxJSEPwvahaFzsF1/0LFm1/xX3+Jcv3ahuWDW3juibf+aULeHEyiFuLjzcs
         fpNlfBrXFmEQ5ELp+bB37iejc1eSqF5CuTIuvPVkQXT7lHF+n8RQyxqCSyl35S4Mu61m
         aPzIVmTGHZNULmbkIWzX6emcBfRaUSv7HlIdHlgutyumsDxb1vORpoWLBkyIkKr1g0MJ
         l3eQ==
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
Subject: [PATCH 4.4 58/72] Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
Date: Fri,  6 Apr 2018 15:23:59 +0200
Message-Id: <20180406084310.219318148@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003635732460305?=
X-GMAIL-MSGID: =?utf-8?q?1597003788664267387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
