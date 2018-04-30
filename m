Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqid0CMU8ztAGbbgVQsayo43b3cV+fw2AYBxlI0KKqeKZRi/LI2+wp9HNB3yW2pMmotgVQ2
ARC-Seal: i=1; a=rsa-sha256; t=1525116429; cv=none;
        d=google.com; s=arc-20160816;
        b=PQsogmyGnAeK8kBhEhl7xbEslVemk+U/AVU6U/Oy7G5zCKV3viUizEIAMl9Y8bHG2N
         ZWXHAlaYtaybmLgzuw32byvKvWywta0z/BVJybe0VOP0k2xXQ0e6f4zxz8+zqSWpTzHh
         12PH6G1N9n3RcyIq0K1SmugFALkLWq4F6Xp52H0bPGQBnRi2MR0vdRrRVmQWZtFbxAFz
         nWgj7SB40GVNdHWxp7eQBL6HqBpkj2N6qBWgvJOMffTFlC9ca9addhNxmCMHHe1vhWLK
         jUi/JORjL/wVOKg7AwEoo8m2QlSmjaxIj4U7/Zo5iOm2qtdWnZNrRp0j18s39cZOBkN7
         EB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=fcnopRmcrE5Pya+4OA+J9UURMfnGj7Sb852HBeuxuko=;
        b=UbaadVFrSS44sBCerX1d4jjOEcjsrokKJh8a2JZqrl3uui3fcbs2jCD0K2+US2+zzw
         xTwk+906N8FswNpmiT8TU09t8hZgISZ/49836x+B+9XPzQkqtYdXif8EMJAYF/AQwpq4
         1dgKogs0X7kNj2aOqqVoUQ+WKKb11yPRf1w03dmYVfUUqV5HUZPDC8PbBblBK4lWMay7
         gHh1cN4zON7fmoRP+0sz0iEm0ebXEuSn1qbkAX8fVeD7onifKKP0o/McMkxdHDlYzeve
         ZB6bHHv/uHZf4Ty9nHXo4ZiRK0OdREbQnxlt/yQ12dX1vKg7EOWKLOgJb+q1I37SvT68
         +xHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C1722DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 09/91] usbip: usbip_event: fix to not print kernel pointer address
Date: Mon, 30 Apr 2018 12:23:51 -0700
Message-Id: <20180430184004.713027025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200451835054515?=
X-GMAIL-MSGID: =?utf-8?q?1599200485299785090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 4c982482341c64f55daf69b6caa5a2bcd9b43824 upstream.

Fix it to not print kernel pointer address. Remove the conditional
and debug message as it isn't very useful.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/usbip_event.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -105,10 +105,6 @@ static void event_handler(struct work_st
 			unset_event(ud, USBIP_EH_UNUSABLE);
 		}
 
-		/* Stop the error handler. */
-		if (ud->event & USBIP_EH_BYE)
-			usbip_dbg_eh("removed %p\n", ud);
-
 		wake_up(&ud->eh_waitq);
 	}
 }
