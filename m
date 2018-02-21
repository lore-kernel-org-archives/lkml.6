Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yDX8OohGj/IjY8B62MpICQI6aUsXByXwq249por9Yhmb/SdG177aQXcLl+2GBaK5tjB20
ARC-Seal: i=1; a=rsa-sha256; t=1519217173; cv=none;
        d=google.com; s=arc-20160816;
        b=AE0EfGGaPUmxeMFJe0GLJX0ZiiO6GKir84N8B48i3Y5qWPftn3tGi1ndum6IQ33xUv
         WcG7rUOi/jTdzYM4JoR7LlWoVDAbstvy+SJdgpv/QIVc3/dE8ZcK35zOk4iYVpcxLIZL
         KIs6om70LY37qlBgQBGt23P+hrm2MK9zvPOik3wW2y64LeKPdkZ3vlSQHW61Hy7TIP+m
         R/BVj+fhGXpeZ4ujMvZWPcD/li4maJhza+ft/fOOrS1lscvuI2dArnnQdNEtr13X29sD
         YAEO3yL37WiTTKs1/u1xyvdNRVb0G4L7gfl/YsnRhBzerMFNknGEbCNLOSSWXXGebiU0
         vX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/CuKOqVdhKngZ/qDkLWkFqM7iOQv54txb3z20f0TofE=;
        b=rmDtXx65K1pFXENmryRNzOh4ksZenc5IRAbQVXjyeF/piaLr15xC77aHZtwiECuC61
         KdiHTO4r80WGl0imOvQNW5zga8BtNZOFw4OXK4DknTcjbrupo2JwWrVduQ9Zp6PPw/TO
         xWrMx2+QWGQmARLrDJ/wfxxV2T8bEJYX0uBMBAOOzMIzeHjdklJOZGWYNWZAPA865WoM
         P3xoMdN7bPEMox1updqBLz2VlSdUHHXWetK28iAZG0d3bLXJe9BsuuBM5noTAar6jhZa
         5Vp4hw5qZZaTix0C++Od7Lgpj1liGV/7j1mBjFwm1J9KsrgfKVpvEvGtRIOIt6dM9wWy
         ZEcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.4 07/33] arm: spear13xx: Fix spics gpio controllers warning
Date: Wed, 21 Feb 2018 13:44:50 +0100
Message-Id: <20180221124410.022395334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014666669772873?=
X-GMAIL-MSGID: =?utf-8?q?1593014666669772873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit f8975cb1b8a36d0839b6365235778dd9df1d04ca upstream.

This fixes the following warning by also sending the flags argument for
gpio controllers:

Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi@e0100000

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear1310-evb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -349,7 +349,7 @@
 			spi0: spi@e0100000 {
 				status = "okay";
 				num-cs = <3>;
-				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0 0>, <&spics 1 0>;
 
 				stmpe610@0 {
 					compatible = "st,stmpe610";
