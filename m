Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++3J8hRLMy4C689KlF5V97i/bFB3oP5fMvy+z5GpR/5XH6Fa+w0FnHr53lFJyzKPq5A0mY
ARC-Seal: i=1; a=rsa-sha256; t=1523021785; cv=none;
        d=google.com; s=arc-20160816;
        b=09kGL5ChZEu/sPBIrdzY9QS2G+9uD7ulM5QiroL10YTLCZXe3Lh2/0JNwOEEsd+rHn
         tRwoFL8Dg0ukbpk+rknnxjGBN9YjTYNw+w428QJjL9Fi6X+qGGT0FPEKnytEzCZiXbdG
         xI76iIuTQ/HvNMxMlenHsse+52EHs8ClTXek+s4KQ7y34Pe/NBtMIUO04S0eUAeIWOKV
         MupquxsFTf/1I1vXNcIAZnl2TaLg14958wiN7kua/pAILlzDiL/qRWyaoSb6jdYagZfe
         zHNEqCzPai2+3Wwtzxd8enRHLguRAfkqoXJ1wyiKl36qgzlE8sxUSJzm1zeTxRSuAxAL
         g/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WIzXaMrGan7tzKbWidnY4R9PpaSw5caYSTikAl16OuI=;
        b=x5cOq2wqCm7sWxNo3aGnsnmhMtb/HAGWJIq7Mmqmsi1LvcG5kfufycQEookunotFK0
         RtO/+wo+mBFn1CVze6D33QigU2oKl4HjkLmd0kBWGQUe8IYxaetsiACSTD1l+2SuOQa6
         qsSZd6YemAIXMyUTV7I226bGzGq7QXr7L3Qpn0UzQaCpfDPXOQ/+8IWm2BZhikZvcR4m
         GuK4PfKxB0qcPFw/VAoApgHz2i1bpOme6u9cbEaCJ7/hUgS07qvxMsCLRcrbiyLYut3M
         JXf3QEhTKwqnQnrIVeTThPZJh5H0geSK5RqEQoXMqq1a1JPJNdMtuVa6tJ5d6/UY0F29
         gOpw==
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
Subject: [PATCH 4.9 090/102] Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
Date: Fri,  6 Apr 2018 15:24:11 +0200
Message-Id: <20180406084344.145286052@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003635732460305?=
X-GMAIL-MSGID: =?utf-8?q?1597004092254057114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
