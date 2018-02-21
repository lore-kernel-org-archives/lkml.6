Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224alAyX3Zn5ANg8kFudL5dkoRi9kHSoxraCLPw66sJklPimPZnho/KwHp+dcp2RxmEqneNq
ARC-Seal: i=1; a=rsa-sha256; t=1519217841; cv=none;
        d=google.com; s=arc-20160816;
        b=t3XZosgZujFae+6xow7Ev9+m87+DXho47sAaFAsIY3ZI+LqSvwSZgorg0HYmWLS4DF
         aBvux4rVi9EHBOtFsjf0j9HnArXHoQavDJKCz3esEvj7QW7BSrGCdUTiSjoHAAEBIKL0
         y8eaK3Da3wQDcblkczUtiVVR0n45G7m72wyGXxDXLKju4dceNA+jdqySYiafja/9nM/L
         Fdmm2Ajcyno2OIT9utgDIxNRyLandqAmE16AK6ghKanDgrFvWfQDZv/dhR82zaYXmxHZ
         vQ5z7sstTwu3jaKSF0EQE66GfqNnOa7rhZmRfX7TwO7xNbyMT1lyvce84XW7SaXJ/HB0
         XFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5ULFXQt2w3WDgdTWLFSp4PDakBpKhWjDKS141W0P+4o=;
        b=v55wy75+bJxtk2M0jbWh3oIyVxuIP1QXKuPxayN8ZFI26LOpoydScSpzkcOstyOdJ7
         WyFLsB2sBSg0mLHH0EkzVsz7kcogzLLNfpSQKS2NlP3jHGHGUYEAcZ1he8q4pyDAcHUb
         q5CkmtoEqdE93NlMUJsXjkWKcqQnm30XsaU6RYppIgAsakAB6RP+0ktejUyRGIgBSRMy
         kCaRyiR5M7h9QDRBmivnHYtyjZWvuHuAhOSJXvFgTT1ghcj5YwP2Xj3hrHy9AjwdULBI
         aRsuENo3M5s5aVdvPW/nUjWb1tpqvtDVF+mD3X3CGaZbkGsLVOFLOe9fyUIwsBOEUqZC
         7w9A==
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
Subject: [PATCH 4.9 47/77] arm: spear600: Add missing interrupt-parent of rtc
Date: Wed, 21 Feb 2018 13:48:56 +0100
Message-Id: <20180221124434.160926293@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014648939162547?=
X-GMAIL-MSGID: =?utf-8?q?1593015367992881568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 			rtc@fc900000 {
 				compatible = "st,spear600-rtc";
 				reg = <0xfc900000 0x1000>;
+				interrupt-parent = <&vic0>;
 				interrupts = <10>;
 				status = "disabled";
 			};
