Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KEoSFDbYKnKPGmW+jzzZ6FtakU3UlMNTGQ3Zks/zNStOLPmtfDcHJtJ6XCL8KCZqyy5RZ
ARC-Seal: i=1; a=rsa-sha256; t=1523021822; cv=none;
        d=google.com; s=arc-20160816;
        b=LlXNcrOl2A7Y7yXJ3BQib/jU0uLd3HNstgn6LJYIEZJBLGO0+DuCqBsH79bJvBZO6n
         ldDSv8cJCKnXATDJZkRes4t0PbjYT6D6kw5/+Zdz5dOvVY4Y6oJmAfe2hTgacI9+wJiY
         xHvS5mh0gDQFkWlx1PqhRD6Cx0AA07/3cQ1GERTS5Bws82fEbmIJueatDaWvv6zLxW3c
         L/aILjgflO/7b0lKcDNiIaUzUuPfWNYVDinXrRVQXJrNBQgcJb3lGc+FMfXObECMfV3P
         1jTuezQOMloXjQXeiDVbhhB4k2C1SnJZGJuql/aDqLZ1bFS6hL/C6dQ5+9SJmaPSiDj/
         9jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bijCXgo2SnSGPoeg/oRxiGfA97Sh1THg9/q5VSeBuFo=;
        b=dC6wuXstTJLpE1G4mhZfAbfU3A2hI2OkIZah1d5kiIuXoCcD9+l+Mloy5p6UXuXkHQ
         tTUZ4e51Q/YAayuYnRb2T5Ha02XVGKSf9/FcM9j4EMFRTwicKMwPZzZQq9++EZwaRhnu
         +hviUP+CTKrvIx0rmvCZm/gcvijFMDOsQXPN9W7kEXxG10cHDf2uUSuoeL9CN8/qLt7Z
         0p4o/rfSG8728V0+60hZ4KyjQ/xNny2XtPyUvBZgpQUbFdm5PhriZDHqEWuEEpBpWkRI
         aE8fo+uFBYbCk+2kL0K1CdgxfAQWoxcJpxwdRencRPqE+QzDVF6UjZzPXJjHcqWX8wLd
         hUPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/102] Revert "ARM: dts: omap3-n900: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:19 +0200
Message-Id: <20180406084345.176082075@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003615276485458?=
X-GMAIL-MSGID: =?utf-8?q?1597004130677788446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit e5ca83f556925b86133af12ef7f17c1a52c39d7e which was
commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap3-n900.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -510,7 +510,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -527,7 +527,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
