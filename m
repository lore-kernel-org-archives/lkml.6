Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224y9YNsK3wz4vBXk5KjSUpMUah3HSUsKg9k0Gg+pTCOIpf9bpYJ1+wfAeg5Q0ZdoCuDLwxO
ARC-Seal: i=1; a=rsa-sha256; t=1519218416; cv=none;
        d=google.com; s=arc-20160816;
        b=Q04ZnkZCRmFB66pcXuKzUdW7Jd84p95wfasbwwXF5l10LxF5WKJuBM/pLK3FwUZ8vJ
         Y6WLY09F7Y0IrY2BVFu4SSOWKQQIg0cvYkViLjrKDjfRrJTRlSt8+wMfRI21kf+lVuaT
         S4o35ehYjsOXquqHUKhkJG7QFgXmc6/AKt+PsIEABxmY+oAlJnId0Nkem+JpreEUx/dG
         A1uVryyl7ZT6jgYO+AxDma5PcbMVJfSh9n7gUuWX06Od+f28W932IMkNon6W/wqzpuHi
         L0oSEO+Hgc1YelWfAQTLovr4QdIzO1UKn/nVTyUP4sbRGxLrpOqXVqhk75cdgHjGqSHh
         DhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=glmKXja3BbLcie7TtX065BLXEkvKmFzaqloHJni28jQ=;
        b=GnsN1OcQq8LDNVjkCplb/juG7pLYuSyknlBjLtAaxyiGT3wd59Tgi7yDAB98ATiu7u
         wFK+RxWOjk3eOZj26VXVd49GJyLFCUaujvRIqA0EQ+MxEEoNFvEf8GfPbKyJ6BcHx0Eq
         AXkJSehdHt0wn1iu2ewP1udlEk7TGEdS5hLWBE2fYHKjUdr3QFIaIl9S7S/dpmUsiuPY
         6O3XfCSWayJ2UZM+BWeD5i5TaQ8FsZIk69havj0KUdLE70sX9fvSE5OCg00lPtZDb/kw
         ADC3WITpkcQXwdeTRBJ8fG6Lm16vDiKGngO/F48nxfp54eBYcgxTLn+wP/VLgrB9YMD0
         /8Zw==
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
Subject: [PATCH 4.15 032/163] arm: spear600: Add missing interrupt-parent of rtc
Date: Wed, 21 Feb 2018 13:47:41 +0100
Message-Id: <20180221124532.013240306@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014648939162547?=
X-GMAIL-MSGID: =?utf-8?q?1593015969388505711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 6ffb5b4f248fe53e0361b8cbc2a523b432566442 upstream.

The interrupt-parent of rtc was missing, add it.

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear600.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -194,6 +194,7 @@
 			rtc: rtc@fc900000 {
 				compatible = "st,spear600-rtc";
 				reg = <0xfc900000 0x1000>;
+				interrupt-parent = <&vic0>;
 				interrupts = <10>;
 				status = "disabled";
 			};
