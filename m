Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250KuyMAnLqzEfw2D5N7fUlkRTYG4KuydxLcn90gfkoyhsNleLRhBp0s16TdyZOUNf7Euhg
ARC-Seal: i=1; a=rsa-sha256; t=1519217156; cv=none;
        d=google.com; s=arc-20160816;
        b=Uy7wIKz2euMIsDrRXSeobwZuu0nUtFcRzvmv2dCOOgOeHmPFMJtbojfkkzAAgToakt
         vXMzfdBpC6r/xaqZSFll533zNhTpBqJ6eRI4fyXLMU0iXFEL5h2CQ+fxEfjXLT0/Ox9K
         Db5guY0xQ35wp9wW53qsFQ2mHGAGm4GTf0c7LHn5O9DCOqyiFimzSACm1l+wXMQtoo5v
         Kyosa8sUevM9q50M06hEhoZe4A3ulIFxlHkwz4uiiY7pZ0fo8SNL+1YJxTH5Zks5f9kQ
         44sCSD+616/cDX7PSRTMuDt2RMpVlFCzxbSFKGfKYv0IDJMpqt+in3UtDETOC4+8nBYy
         8ooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=th6odbLbQoM+Hx386OcI/w0BCzsHtzu80yhJohqFzo4=;
        b=EIToZu/M+b6fFV3dJiucEMI4d7UuItX2QHtCao3t9ovWEKW9wlGhJv0yQDABn/6Q0j
         yjQaE64ojonSlH3HieosWMKpo6aRAAuWErPKsohKg/YMNcQEiRG9bJBGkmaO+vdLY7lo
         gXoLAVoE8+hn9FaNBtEbAEG44i5peSSQn+MpiUzmdFtxqsKxbQHyisU1SKseFvDoK3su
         vay9B+Sgyccx8LLqfFqoBFib2/5It9Tz/vRVvr7HcdeWbZZzDGs+mf1SIojVIlLgg/6K
         OZMzRD+wQOdpoz+BvAEuSFQwkHGsU7tynrynK+FknFBNW7/Z3vb1rUTJ8EL3dWa4jq57
         qmIA==
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
Subject: [PATCH 4.4 05/33] arm: spear600: Add missing interrupt-parent of rtc
Date: Wed, 21 Feb 2018 13:44:48 +0100
Message-Id: <20180221124409.811649221@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014648939162547?=
X-GMAIL-MSGID: =?utf-8?q?1593014648939162547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
