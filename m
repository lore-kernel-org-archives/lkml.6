Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtsTwDrh7PTXvh8QBPCoHAcxfj1V95u/LuenlpEYV4xwPnYKEkAsDvp8eWDBmKispFi7CDW
ARC-Seal: i=1; a=rsa-sha256; t=1521214146; cv=none;
        d=google.com; s=arc-20160816;
        b=N2doI5fe/Ekc7+lM0yeIBHhrm9gd4sCBNtbcarL+yOL4u22UncvI5y9xhDkkTItaz2
         i6TUGiUoOWhmLKjjF9aPkgIWFvSI5Qr+30orEMT6udyOoDc05B6ibYbDWNujD6qP7y8C
         E+VcDruob/vooWngR4ZDu8914AYTReU/jKpytGO064MEFA3dzfuIAFGq8udyntH8ahFW
         OtwiE7xOy+Yn8/3JzZNIwjcnJPO7dJxP6bE8yKghqCP7t964UCKEpj0fqX3omtA8OnpL
         Fht8J3ahMRCtHT9J+vej7M/zsZEFXVUYQWURN8j4BXjPROyCrvSeTJUNkE4ShazFYzK/
         dMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LxVwDSfGaqIO88hu5STh2JYZ+0do6evMhIVrew9OS6g=;
        b=px5OgWZz/+anepk5t2aHb4LUdASjc9xkayxUwx3wfqU7hh6CXMEUIaJc0J6R4yPIot
         ZGom10ceh9+28hbQuGTL5cOpkRsQAnLwsL/bbISf529HRIjddqZrPZ6kulwLLtngLpC7
         gL4TEA+w4PvbpihFzfCNDfddlPBffZqEvA6olzSmqVtXVUXaORKOt3WVRkE22EieqT6w
         +qFSKLuCVrX7DacVEDuII68nR8WAW4H41TCuzbMKdNrU5M3od/XA8+3QnqfjFWsg1P9E
         jCs23k2ZPDfgHmJ5Cbon+tpgRjQbmk7119oyC/aUwvtY06EWp/BtZuWx37jfSnTmfT8S
         N9VQ==
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
Subject: [PATCH 4.4 57/63] USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h
Date: Fri, 16 Mar 2018 16:23:29 +0100
Message-Id: <20180316152306.269013669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108644866552778?=
X-GMAIL-MSGID: =?utf-8?q?1595108644866552778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2142,6 +2142,13 @@ UNUSUAL_DEV(  0x22b8, 0x3010, 0x0001, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY | US_FL_IGNORE_RESIDUE ),
 
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
