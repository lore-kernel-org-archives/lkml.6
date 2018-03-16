Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXuM9oxhk0FRcm+n1WjQEVSUc93g4/A9+V3QkWDJsY/Jx8WaGzR/ezzkcq95X6Z47g7620
ARC-Seal: i=1; a=rsa-sha256; t=1521213825; cv=none;
        d=google.com; s=arc-20160816;
        b=S3yNtdDZmPXhVamwTOuaAgsg25mEO1/ViJ1O4cEcz75yyE8bqkQ2YqhluDkR4P709j
         HyWE9hXG3KCn3DJyuozJtjyGGB4WxPdGVmeYyKpj6QO2Ew4C4SztLhK0Pk8yi0gNQiKN
         iqdgV4sJwUlMBY06yH8GqwmkZ/Kq6JHfXrzt1B+5w03YcQklknd0Ikfdr87+ApcnfOQq
         +j2Ryvwl+fp/90rtDkzPcBiPvIDg/RwjDY0/3gs8iNjJ2TmTo5idnXWsRgYIDC6KOohZ
         Z0fIT5NmpDJ8MQI0d97ELisBpt+Dw35T20eVa+zGhXnSYpQDaoj1lLoybxK5I+L7P1bT
         JSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=recTONOHxz2CEd5XG9mRXIdIFqQhCKXLx7yaYd+vY2I=;
        b=e7jccObR5Rgsxmc6jOZqEX8wrwY0WxpnDoE84IW9XF3uaWxln85HDa24nAnROLUNu5
         j78onoionAGq3xYwaHMlzH7gAFEbhTX32KsSUDcwngAZaf1bkPNY9KDtrAOLYwvm/PtJ
         bJHCPfBIF5Oow8BlQJd8soKA8aLc9dPpMOKYVVU9VAt/0xMHNblnEpsKO1eDKrqIlg1J
         4yHOfj+rDXlRRU4fBL3oX+9v6RjiERziW8tZT4QM++/1fvt2h9rNvSInmV6pZN5cxgUd
         9/WOVBWGWZMoyBL8IMQQg2jF0pofXeL+iKcZh9CvlsfCj5CtIalPTijuplGwf5/mm52y
         zAUQ==
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
Subject: [PATCH 3.18 18/25] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Mar 2018 16:23:05 +0100
Message-Id: <20180316152233.491814104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108308157129909?=
X-GMAIL-MSGID: =?utf-8?q?1595108308157129909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1643,6 +1643,7 @@ static void atmel_get_ip_name(struct uar
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->is_usart = true;
 			break;
