Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225+StsUj7iMY00h0+ZCyt9cfbbkNMBXjImkktmO/Uw5Si8vi491IRJPwQqXhr6BmRWYwuBQ
ARC-Seal: i=1; a=rsa-sha256; t=1519218074; cv=none;
        d=google.com; s=arc-20160816;
        b=kS5KyDwkz6PJDuLTE1s2SJFSgqp7QDGtGk/VAIhyq2Ajq9LZGiFOxJVogLjx1gzwW6
         4WshFGpw/Sxm/a8BzCQGyVB5AiYFPp7S0FGlp5VuuT7iaUAy2RwANuck8QKABG1L1u1J
         YuO6y/H6hCCaxO9iqxwVENCM1swZX7RYgegyxQ8j0T+QKTv3Tp8vP3ckqIuRCrhWDaNB
         Jbj4WKewVNJMh9vGG8s7eLQSdYHh4hQ04StXtWw4gaHtXuTr/P6N6FEWJJoPiN34fCwg
         05Zqsw8OmpBMhUSPziafxuKohzOcTa8bcOyz3XWGztizWJ6Tj2scSo/5q+yTyhBb2XmD
         c0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R09VEhQjgBEy+0hTVRqXIZi0sk8ctZmVIw21bdYi+5M=;
        b=MpU1D52gHb6G/7H7HrQ4IABzSHwqbohEaXzeMyVy6ttab0IDTojEkgVgEodXVeRwsQ
         +7P9r5EDUmFWzgEvVdRp9RWHqOh8uf5M6rfbEoMw9H6Pj0S6AIOVypCuIpzgFsb+xQ2B
         nxVC4hpHWQVE3Xki9xLigwibZYE7qR9XdVNVM7x7sG5kq95z4upALUQ1/uLuSbOh7eUc
         U7OD7ZRzhq3ZTiG7BRZu3SaWU50cRy170ohpc6FzqE6liZOgz5jACBj4+Anlv+Xv8IWL
         MfzjC+jVsL6WpjROTU+6uAxDHKN3OmBaCf9viP3yI2en4NhOv85FWZsZFHmvu9+5DPnr
         gZfQ==
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
Subject: [PATCH 4.14 031/167] arm: spear600: Add missing interrupt-parent of rtc
Date: Wed, 21 Feb 2018 13:47:22 +0100
Message-Id: <20180221124526.286308472@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014648939162547?=
X-GMAIL-MSGID: =?utf-8?q?1593015612299407459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
