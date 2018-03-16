Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQ5Sheu1+c1+912YFNIleFHJyqy0g34rhkGdf9oYTgfgc0UsnnhmmlkgvnQfdlfPdoIK6y
ARC-Seal: i=1; a=rsa-sha256; t=1521214463; cv=none;
        d=google.com; s=arc-20160816;
        b=zDO3+Dex77/E3ENXuBpv9FCiXMC0pOu9UR7hSinvQzY8RxrsfJLUfkd1o+Hc8s6bOj
         EhqvgV51PzzVOm9Y+6Yy4E4O0LUzOzRpsxt0sZEPD7UW+OFmOvGncwU8YPF7lkIe780m
         9rGPrGYJSZjuON4DbElh4TXNkXQQAFF8CNEtal7PgD899xk3TwFTS07rg6LYCMbO2u/u
         qDgs8VQIlrtrCPBifQvSpTDKXnlvA3JipZzVF6dhqDrNgrKZrQT+EwWy08X084BFDbDc
         8fDpuwh0e6Din5RcwdovCJPA5JbDx/tZDvRrISBtatH2w9jImLS+YzGxKmsvUsUEQTqV
         1J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aEBT41LSNA4vY24EbUotCkb+MJ8SsF9J1imlUVBu31U=;
        b=FAGyx6q3mYIZ8AwPt3Pgxh/Sszy1FD/ZapA7lFD2WvzS/RQ42ja6bcJi5C4uWuk1zz
         O2twYAkGScg5bITpEZu2G25kBTsjK+fsdskROz5XYkAkeGk/xu2gI3kiFwO3qpVzHhu4
         wsKMF5NC8iuz1RBdj34MB18BjYLgcDCKUeMxoB3HxCxworAlCUKuqNRcW/vR6x6BGNp4
         ELWXcf7b4UK6UaX5JRpydPLWQ9ii0rN/P/Fhdn3ze3Vf8nFL7of84oTOgwM08iHBhMuM
         0SyqllDrQCM+LCzOlHorxwujAz6djECMdhZdDLz9DvA0l35dmtLk4DFhk/tF67HX3Iaj
         q7EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Teijo Kinnunen <teijo.kinnunen@code-q.fi>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.14 016/109] USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h
Date: Fri, 16 Mar 2018 16:22:45 +0100
Message-Id: <20180316152330.845413263@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108644866552778?=
X-GMAIL-MSGID: =?utf-8?q?1595108977005601723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Teijo Kinnunen <teijo.kinnunen@code-q.fi>

commit 5126a504b63d82785eaece3a9c30c660b313785a upstream.

This USB-SATA controller seems to be similar with JMicron bridge
152d:2566 already on the list. Adding it here fixes "Invalid
field in cdb" errors.

Signed-off-by: Teijo Kinnunen <teijo.kinnunen@code-q.fi>
Cc: stable@vger.kernel.org
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2137,6 +2137,13 @@ UNUSUAL_DEV(  0x152d, 0x2566, 0x0114, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA ),
 
+/* Reported by Teijo Kinnunen <teijo.kinnunen@code-q.fi> */
+UNUSUAL_DEV(  0x152d, 0x2567, 0x0117, 0x0117,
+		"JMicron",
+		"USB to ATA/ATAPI Bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA ),
+
 /* Reported-by George Cherian <george.cherian@cavium.com> */
 UNUSUAL_DEV(0x152d, 0x9561, 0x0000, 0x9999,
 		"JMicron",
