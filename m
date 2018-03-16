Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuikcHb88Dbl9Yx3hv4d2o2D5x008WWo8h0VHLTi0eWnEEMCJXCi6sddj9gI39Fkgr2wP0y
ARC-Seal: i=1; a=rsa-sha256; t=1521214135; cv=none;
        d=google.com; s=arc-20160816;
        b=sClGqIj6Q5Dsq+4IC9CvS2XW96c2gjaVlg4XAvv1VuOCFt2Jq0SdI3cfe0GW9YjbGa
         TyS2ZPlQzS8l/dsyEmDPKnlPQmV/RyvfVvDacRokvr03n63PUNeLq+yKXNDU5Z1rTqKC
         DLFFCyL2fXPlFVbdu/27lhb/0khJSXRutsci0Zq1/8HRh6NY+EKRgQyG2SXfbYFaSZuz
         C4NMqAiM1GBJ1k7vKqb8S5I1lr/vKcb/zoSMXYA7MK4llwAsM0RAlu+bS55mhZyG5ukV
         kQU0o1AoykXM8nR6RKpbbU56w+7ImNKVPlotuFsEAc4YlXldZshes0HYS5u08NejCMhQ
         ootg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F2VYcTgibuNylsGby8T3ykZLuX3kT0zY4eiQULnVy00=;
        b=nGaEIWpnl0Eg3MLzqM/4NdvA0Am/XHKqp/f8vPEvsHO3KZvOe9XglL2eUQt1ICLlcH
         1LLf//1wrWzEWAwU1CsUxEWbWgOu1PsTtxdGcnDRHR3MALy7ukgx6c3VUWNNO7HFuJCo
         ybhq0f1j2ZY09Lnwt0eb8g6rBtRUF/POBK07VJZUngKRLyeaAsY56JNbltE/9CDnNULk
         8u06OGRmSuMaa1TyAGddrcbaFGNfPjOAVHechaPruPUPPrAA5Xa5hhvMNo1/z+/sMo+V
         Zr3ZKjY3HISmoV18d0JMyebv0qH/lLIKYk1b5sfXAzA1UGA1+vYmYQYecBZcNiGhhyr5
         dCGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jonas Danielsson <jonas@orbital-systems.com>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 4.4 53/63] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Mar 2018 16:23:25 +0100
Message-Id: <20180316152305.778116438@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108308157129909?=
X-GMAIL-MSGID: =?utf-8?q?1595108632772350701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Danielsson <jonas@orbital-systems.com>

commit fd63a8903a2c40425a9811c3371dd4d0f42c0ad3 upstream.

On our at91sam9260 based board the usart0 and usart1 ports report
their versions (ATMEL_US_VERSION) as 0x10302. This version is not
included in the current checks in the driver.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1783,6 +1783,7 @@ static void atmel_get_ip_name(struct uar
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->is_usart = true;
 			break;
