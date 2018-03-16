Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2BlrNAQXVlGRMAOEl6sIyu0UpmeNEtrKdu7sUrT4X1SNkwFMl09xzvpEb1dof3SV3zpr0
ARC-Seal: i=1; a=rsa-sha256; t=1521214774; cv=none;
        d=google.com; s=arc-20160816;
        b=gDRGxANczh611ReY3SyK/oEuYO+CFRnUxQtYvSMEx51jWulBJeDIokW1itE8b1BQvB
         bkxG9L1hNx+fAKRt8SNzQloGQdjqZCMSoDSsS9kXH6WT0DyPTYMC40qWIj+Za+ErnyfT
         p0EvcJ+OVO6xjsGkBgAjkgFVJykIjlPFcg+bxXHe1wd5o5v/xPE+mZUjDBnwtEN2HwlB
         0cv5M7mEL5kQE0tNGV7Oq+EwJdkPnMCJzhThr3fzxTmj64rIhKM1KVjcXZiiqjXmbFM7
         cicRessQ5IIAevVtPbvo23Y9XZOsAOhvzWuYFrzzvBVjdNiMQIScOFrqc8mBsKomFzFW
         +lzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KdxdUt5yJSQU5STBcsKGLSb2KRg4e7wKMPZC+v1zgGQ=;
        b=rzGJXnUgkB5UXqrKBZ0ydKyZiUqIzeFWovzLyybZqIZtSWJbUmwaUTmqi7hl8sI2qM
         SB0IXbLXiaAu72w9TtIqLg7TF/I7tVX1DdO9XXd2XJIbaJbOi96Mi/e9Vkobgei6CYa8
         GyhXW4vJOLdKxf+CKcaMOa2bdDtBx6PPsVFuYNu+C2lIOg/eaAxF/KUZcxlsEJGzI7Ko
         10hiklXA3ePrAraXIm9mUN5/FZGlDIgvUbMXF2CjrWb3lPgbDTqj42dReQGpIXvsapok
         pze1boSLZj33WnmPcL42y75tOwauubIEXtfusUTKLC3BCTAczUXYJOFoRpuGjxlpYAh2
         bfIg==
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
Subject: [PATCH 4.15 015/128] USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h
Date: Fri, 16 Mar 2018 16:22:36 +0100
Message-Id: <20180316152337.144888382@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108644866552778?=
X-GMAIL-MSGID: =?utf-8?q?1595109303799528716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2124,6 +2124,13 @@ UNUSUAL_DEV(  0x152d, 0x2566, 0x0114, 0x
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
