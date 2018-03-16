Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsYlIj4giEvbElwS4P0fWVCNC2kBwqqbuD5mjGTvUwpHtR4rU271yuLF0SmNr1llba7clED
ARC-Seal: i=1; a=rsa-sha256; t=1521214451; cv=none;
        d=google.com; s=arc-20160816;
        b=TlYtIKF6e/KB6rYBbXsVHwFNE3kXjuw6R/27EMD7B25q3mmnc49qssdkuSZLcGJIJ5
         j2edcDHXLD8jrbZesN8ObyD51T1zP4vMeyLbCazE96iNj63QuW8g4VByN2fbEeoodEJ1
         VFGxD1vdl6L9ovJL22iXeU9kj6O9kfAI2aLwmmtfOurugUtafVS6eztaszy42onc7dlR
         zUTtEkBq/5z8QntM2WMjQcGh3wQeQf7IvnoxKaMsNkcuDDPT4m2yzNCHz3XT9GYmwl03
         NBwPApfRk8hac1mlggkUchKkL832ui2/a9t6FoJ4yUYH2TM4bY/c6JZc0VvYxmVRdcvD
         +R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gTG+ss9j6fHZN1nM43YDcXfAfvp3ph4fopCgS8qxDUQ=;
        b=sJJmecRMcFy9pjQmFtbJiJvCGM/ye2TYYfoBD5vRfA+ynFla4wkDe6le57bOjiJTFy
         boKU7MJ3qsCf7l85oG5dJmpHD9YR2/panrnk4XqQeNRIBSEAFp8hcVHP+313E+TwdDU2
         YQtHfbFPV1M0SpzFddizBamcgyuVFaU9xFDYt/ouOR4dVOcTU+gp8GQV6JzYr50wK0Es
         E7uefGSFmS/2Nhr2gYbng/+8BzH7kn41zq4ENuaKvpBCZ2fPvehGofLppaQTGUQ8uyZ0
         AP1OOjMiujmLUCkQCebzEtH4M3rqMDAUYxVkygKqLDrdARE1o1aWJf12EgmTK1Z9j0a8
         40yQ==
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
Subject: [PATCH 4.14 012/109] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Mar 2018 16:22:41 +0100
Message-Id: <20180316152330.531099215@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108308157129909?=
X-GMAIL-MSGID: =?utf-8?q?1595108964964685557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1763,6 +1763,7 @@ static void atmel_get_ip_name(struct uar
 		switch (version) {
 		case 0x302:
 		case 0x10213:
+		case 0x10302:
 			dev_dbg(port->dev, "This version is usart\n");
 			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
