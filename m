Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvBbcHxDF/gjm1Z6/jx8Fl1CphMeHWSmtK2l9txC7R0yxciDdwr3jIhRmxlG7ghdjI/jHNM
ARC-Seal: i=1; a=rsa-sha256; t=1521214760; cv=none;
        d=google.com; s=arc-20160816;
        b=ukCs4H05bEYlsuH6u7Pekoj6royLL0OsIC6iQu4wQZIW9bppxLOY5AoggmpckVSC+1
         PGOdjbcQSVQ6AYrMabMQo6iIbl6BJ1sBbuZQghb7+/nfPMkvdGWo0mriT/4QvjfvFsad
         AInCEhT1XlcxxYdl8v8dBVpCkmFUN8GL4fiZ+VbrFGFzleEyJPsl8ITD6yVzZI8Vinw8
         gAMMiRL+nQdlaBhVurWg53qOcWULu/cG0M8p43Ff+M5SwSAedDa89pJESdekMtcSo2Ql
         7lpDp/TiJRwAyeywmtIqF+xKoNt7OeHLtQI6uQ8T8V27hSC54GeGmXuHq17imkPn565O
         QJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g/8uKwkASSH5efnACdmKVuXav/gpGlFJbkS/7tibMDQ=;
        b=sDdnNLTVkBVuWgC5CG6Dh/DxBsJn6okreT50NT8PxWrqvr43zmzM8BfI/0Vu0F5j23
         iI+0S0DAkKZA/w76LXoETSypSnsTMzkKABxouCd5qbNTUSONXIpVDtBl5B67pCNEIRJ7
         wyAFYZ7B9GKYHghEG4nqODJz5F7X/qGEG13BLjB1XTJOivJueH5dSf/zNTYfG24Xxz2B
         mIoCmwhxUEPFSYrUCf+v+i8sDAFXgJw9nAWjgDcE2xEAzO3NB40UTvPW9VzTAhIwsF0S
         KUrn4PyUMAc3Q2busPVuhQO75eSUCNKG5qnPob7AlVAVoOi24jiZuCPYsbI0KcleJJV8
         tqRw==
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
Subject: [PATCH 4.15 010/128] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Mar 2018 16:22:31 +0100
Message-Id: <20180316152336.734472479@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108308157129909?=
X-GMAIL-MSGID: =?utf-8?q?1595109288869607681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1734,6 +1734,7 @@ static void atmel_get_ip_name(struct uar
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
