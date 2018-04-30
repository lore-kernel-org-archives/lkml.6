Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq3mI69LJ8AX+Is8yD8QFqtvJLJ5yel2e+UcqpwCUfgXEiNDV80iCXmJyJG67BSZeGVBStw
ARC-Seal: i=1; a=rsa-sha256; t=1525116397; cv=none;
        d=google.com; s=arc-20160816;
        b=RbR8PCxb9B2KpgOm24rjb8cAkRq8unmLXyBuUHa1p5K0Jli4wFyyk7RqnM9jErh8l/
         9gVeclAxN9PSlu+O+h9cxONufMg0Rhnf49cVIiGjTmGYbIRa2bWVUskHGEsiEzdlfP62
         +The9iLd2xipds8uCEn7QQBreZQWMB5IaIFg2FIr0YMvss4NpcLEXwuxbHa42MGIGXiM
         WHkMPs6pE+BjNcU39fEz+XvVyTJOX1S2+PoZplqn4n0Npo7y6BEM6miGqoplel8BO7Ph
         F/sRtYV95ZoqvHSpaKp98nYK4dnm8BAV4tjqe7VUOgYRH7prDRdVQzG07IQBlcm5cA1S
         9lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zblw5X5E4FMPQXso6RcYuFnEnbZnfpvzJ7h1wOO/t90=;
        b=NejA3eyF9RpsS6CHjo3TV6Qxi3r6xAhfa15LCM/jG/YLBYJWHFn7oEGtyIfwYCzEmq
         KG+gGvF3kkHfOi6RlFmUphpyi0WD94Qum7sK6oUr/Fv/N6rDgtUAY45s69rOixPEfIiV
         uk/aGF4o9w9B6Dju6vQvScys1AQ33T38mbUryQwkgaWJrWi4Yw1+TlsZBhnzjGOX06jg
         oxaaiDPWnxgZnHDuFu1pg8w9IJ7VGuXMhssggpcoCTDaAu3hb20PeJpYISGAP0ngnOEL
         +UjjclXJuocwSJZlEX4RIVxobR66KgZlXgCc8GEztudSeeki4MpW7Uebv7lZtDc0cblq
         3nnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C422DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 08/61] usbip: usbip_event: fix to not print kernel pointer address
Date: Mon, 30 Apr 2018 12:24:11 -0700
Message-Id: <20180430183952.029390304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200451835054515?=
X-GMAIL-MSGID: =?utf-8?q?1599200451835054515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
