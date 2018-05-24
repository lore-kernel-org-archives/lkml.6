Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzQO4p7PLMVwr/1JvYJpx+s7lGOJ8xoJEKQKwMMxLZCTEcQoiOgu3mELJh7fdaiH8tRYDZ
ARC-Seal: i=1; a=rsa-sha256; t=1527155639; cv=none;
        d=google.com; s=arc-20160816;
        b=F3UYQOwUkryFjAZdhpv3u13YtS13wGWDnDi3D0O+vLLrcMsL7YNPlRQBVCfTEIgqAd
         nr2yGndGGoWE/P1GxwWwEA6TL8jw5ZugmhWH5MXuJDYZFCtznwutO2krIeJTROFGp2p/
         GxmBud5i+KiKnCL4vwkr983z42B9tenxse84/nWQFMHhWJH9b2JMEsXAW+Kr+Zk3FhS4
         SSMEtQIxuIGmPnP9nn8bbdVksryBqwTZ7tnCBHFzT3jGpcMjMM1CEWL5UYpQP4POLDIy
         koYcfQD1mt18/eidFJF46VB6tNcliW/aKOLSZwS+XMXzyshuQdRpTfBNv1WOT0qnHCsh
         BJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+adEIoncwfqtlDDu+bR8PuPfBstenlLq/QGJ+vAIZNg=;
        b=EnxvUqvcPdWSWIxXJ94j1bRXBgeczYy0SFKr1GKiraLtsirD5W6MhUzUeB9YW34Azm
         5yOReIGXa62T5qmSxCcMrieAmjkxdd1dMAuQ66bKIXhH8m9tsElunqCa8tT+rXVu/HdK
         7vuy/AUAwPLB3vCb/twms77HKS2kbSnPOyuF6t87lCQqtuFKMLKmxuBUGJsgryB/tvLA
         U4XE3HxqiXZzrH0JSdz7xOgZWHGmxL1W+dotSOJ9/9rY5uoTEajRTaQwaBiW88Szj6Vi
         ZhYo5OHN3Gk9/PAk5ur4/Xj52l9ushwqKVjAy7JTLUjftit/qA/FhmxinMh0Us+1CdzA
         uLwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0g4AgEgv;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0g4AgEgv;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leonard Crestez <leonard.crestez@nxp.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 062/165] ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name
Date: Thu, 24 May 2018 11:37:48 +0200
Message-Id: <20180524093624.532661414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338751390392814?=
X-GMAIL-MSGID: =?utf-8?q?1601338751390392814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 970656b3246d30955894951ed16bd658e42d8c24 ]

The two usb-otg regulators for imx7d-sdb are both called
"regulator-usb-otg1-vbus" and they effectively override each other.

This is most likely a copy-paste error.

Fixes: b877039aa1fe ("ARM: dts: imx7d-sdb: Adjust the regulator nodes")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx7d-sdb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -82,7 +82,7 @@
 		enable-active-high;
 	};
 
-	reg_usb_otg2_vbus: regulator-usb-otg1-vbus {
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg2_vbus";
 		regulator-min-microvolt = <5000000>;
