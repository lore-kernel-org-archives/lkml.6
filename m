Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/6GnsZ1CDLgoIktNm37QsvnvWNBScm99tjAl9C2d3qu3V3fe2ElFR1rMpE5/QLn1yylimH
ARC-Seal: i=1; a=rsa-sha256; t=1524406810; cv=none;
        d=google.com; s=arc-20160816;
        b=X7KOoyhstKPIqWf3FiM9dBdNV1DM0D9r/+A3xtgTn4VtBHSuZdNSkFuVpRk8oGi4/j
         5ES8q+dwzC1vB+4ib3WGeLFC2eW3BLQSAgvqdRXw/zK5PHe/yfMMp2vB/z+TjIsxv6kg
         DzfuadJEr+0Sk20N70SUnxqefJvzt7JhQjumQNLhDt9e5NsY/7NN7VXau0gh+0H+eutp
         eg+f/7AYkeRpx1BkRGGIyC6SXDJQ9EuIrlVVF/8CeZPmV1d0AmAqaTdzF2WSRcauAxkg
         dmBNjWgLNWky7osnkLFThBi1TKFv+pjy24oHPw8vi/B9x2FZTaT/1TKHpq/OsT4UZC6p
         WnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gzk6t0bAKmq8dt1LyRS7zFBVMijQV8v8E4i0u9e/cqk=;
        b=mjHr+iHR0yJBdMk17oe5UqRfpKZT06+D+YcGGmto/GzaSp73Y0LcIshftnwexOc5ev
         lVXQMxGgYOiHq9mspAIXNxClWKgTDb2/DGvOULl0DgJci3KqA9zAdRbG3nrz99rrCIWW
         iCDlApAVaKJhaidtyt/QuDkLwRbITR1h/r+FwPH1nW3QGDsgLisktCOn0Fq2nvDy3478
         KnrTTzhzXE5ONLOVO7jn0GoCD8zIAjqCgIXMzmYpSxaE2/PuuMo2iIJ2rJ5l+VHms59P
         oJR9tVk2NVuLUJtwV1Hj9xOMGnm5IDk1D41jHfri58kBcFOkitRm9Sq6L55Ei+WYUN1X
         bozw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Sieranski <marek.sieranski@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3.18 13/52] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Sun, 22 Apr 2018 15:53:46 +0200
Message-Id: <20180422135315.873906729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454833728898463?=
X-GMAIL-MSGID: =?utf-8?q?1598456395629257913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Ferre <nicolas.ferre@microchip.com>

commit e8fd0adf105e132fd84545997bbef3d5edc2c9c1 upstream.

There are only 19 PIOB pins having primary names PB0-PB18. Not all of them
have a 'C' function. So the pinctrl property mask ends up being the same as the
other SoC of the at91sam9x5 series.

Reported-by: Marek Sieranski <marek.sieranski@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/at91sam9g25.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -20,7 +20,7 @@
 				atmel,mux-mask = <
 				      /*    A         B          C     */
 				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
-				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
+				       0x0007ffff 0x00047e3f 0x00000000  /* pioB */
 				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
