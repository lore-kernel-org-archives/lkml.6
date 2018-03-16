Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvZo18ff5ddSDVy+J4zSZgC/s3YYj6XnJzdnjE/cNefFpIx01Eh0i7tLeVtyZdymVpK1A2
ARC-Seal: i=1; a=rsa-sha256; t=1521214386; cv=none;
        d=google.com; s=arc-20160816;
        b=uuU0NjNI/7qqG9oOuKikyLeqgWgxgtfne/HnMLR/BbNqT/s2aZQaJ3jdb5V+A2xQxR
         ZjeLlj75ghEzW8ebjXkstuFMlB6IFHKPR+jecKvcpPYozeJawvTsPJ/LI6DWlHUeBSle
         cY6eB1wG1SQGODK6/vESwikX7AOJrcf1nPvSURDLNjOhlKwG6j/BNKrvAQTd8Cha3qjX
         LfOI/uv1Dk0Vt+j8mtBRnek45gPzGK3+SNnwx4pUCgN4o+a/pVuZEBol6jZEFbYelkod
         ZVLtXXAbVQCAvY5CDFdYG0I1qkbRVPEqWl4rtTgL16vlfjq8XaIpoiS35v/vq9MZmI/L
         H1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xO+mhNWsTgdkbuneA+aaa33VFqpObuGA1nLTLohTxlM=;
        b=hOceLJByLYkOqp9huy1sxn+HlejH8N0eJl9HhRnJl5CHSpRgPU7Mqge5vDysA8o8J+
         MHvlM6WmjczWlyibe4wNHC4swDcd12+Dn4ZjCoBFN3CxWAG6Rz5gA6jK/VfeDG1zyhKg
         LQaPZNgiKGoZMORRiqPVgvtboTbOst4d7vWsqPdvcjxfjm5gdj/13/UvHn5sQSleY9R8
         ZdSQR6eKI2ik20leRlvQS2F4+s1tcZfTL75bOGxJlxJoSIWuV5E7tdLxqXVviLRQS+uP
         VxT4LUpe9X4ZzrQbN+L/eO9NJznf1uVm8I/h1rdzpVwfEE8EiWVDcUg5coAbfnEG0r5C
         2P4A==
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
Subject: [PATCH 4.9 74/86] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Mar 2018 16:23:37 +0100
Message-Id: <20180316152322.355218175@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108308157129909?=
X-GMAIL-MSGID: =?utf-8?q?1595108896590938786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1780,6 +1780,7 @@ static void atmel_get_ip_name(struct uar
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
