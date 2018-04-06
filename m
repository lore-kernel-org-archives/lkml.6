Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/XjWUxPDYU2bT06t2we1L+V8s5X1R4GM3ZxrmkQDldLKYeNBXPcIgYU1clbxRLMqyp1194
ARC-Seal: i=1; a=rsa-sha256; t=1523022064; cv=none;
        d=google.com; s=arc-20160816;
        b=biIXuod4vJBRD0EClyN42sipL4+Ez+v+zet9Vj9B1iBaJBB70IbAka5+fUM4tg5CNr
         KLQ9SCOGTIm99np+d+9WFUyrXaWPUbjovVUJeDBojKYEaQ8/XzggPOyoQc9KGadOvTDq
         E4mwKhG6v4nJeAHq3XNgI4KbfvAoyI23iXlZ7lqi+DAXFmP7Gu1+ZvmOdfDj78coIVwD
         xc7MU4J46tWeI2A9r3gqP6nPUuKobJnXTQ7fbbN3HA/MLZacRF6yn+wf5TWbQycq0mz3
         cPzSK4Rc5A6VeU+TbUF6zgvNeojdBAx+/0WdwJS3L3xeEJ/o8Vg7hp6BJ/TySisfqVM+
         azHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=03ZshKiQzwgJYO0tWX2nH2BmKi8Fk+zYUteILP3JmHs=;
        b=DkD0HDFgEnqV8zSRGmQ/BpmkhJx4r2BHEC6QxqRuVWgqs06d8Wy3KZ/1iS/PT8gMV+
         nxhCrfaukOPFAcj1sUJsACF9RSclSBVkh2uJhigZbZrd91AAawkK26B8oXAzFGCn0VUk
         ccwROwJrHutT4kBJhiHK2WnOlGYG/v0/2YU/kjeq+S8B77oAS8DhamUSOPrxEMheHKpq
         8GTEawKWzfUNZ8viCcTMbUQmwlLh71yzYuxTU8szihr9WCBO79rLabsg5o7lfeWoPGrh
         ibtETI6PiNHom/xzGzK7QDiRsbZpYHosLUgE/Y8OhMpkQk+NjaqAM5xrRKlDhX0T89U+
         z0Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Rossak <embed3d@gmail.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.15 03/72] ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties
Date: Fri,  6 Apr 2018 15:23:38 +0200
Message-Id: <20180406084349.733345144@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004224780600587?=
X-GMAIL-MSGID: =?utf-8?q?1597004384005453864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rossak <embed3d@gmail.com>

commit b23af6ad8d2f708c4c3f92dd8f82c233247ba8bf upstream.

The eldoin is supplied from the dcdc1 regulator. The N_VBUSEN pin is
connected to an external power regulator (SY6280AAC).
With this commit we update the pmic binding properties to support
those features.

Fixes: 7daa21370075 ("ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -163,6 +163,8 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 };
 
