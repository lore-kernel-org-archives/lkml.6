Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoARBCdDh+ox71994rMpG3KC2VqE/9sZRWb84L2AP7v+1kcmi8ukHDJYtrT1BwYxk4UypGw
ARC-Seal: i=1; a=rsa-sha256; t=1525116492; cv=none;
        d=google.com; s=arc-20160816;
        b=kQS3c4AQ5P9TtaX4vTLZ2yXxCwNqZNxExteXjKHZpnsU7Ve0vrP63A5nfD4ieKN2Al
         PtC4yGfHaPlBm3VFtA5QLHvlYIdXcRlBKWJDdtD9WgUVO1iWRuHt9NMosh7pTyCtk7Qb
         FfuretX5bsEHDoHWBWv4j2AmBKnJS0eZSyKOS1Uvj5gmmHQIWIX71WYXIZkGZHffDZZm
         KOkMFOxyx1dtZJqZjvORoxRJATMGQEqOqYQ8NYA8TCVaaFIhnfhKBv/5IBlHR4kKjEBO
         jntJoJpZfFDQ9zFWEt3ojmFlyFYX/rpJI/2v7WGzUYfpKSEpGs92qEYxQpKj1OBl50gS
         Pp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LWLGOKHulGhYhhnLy/Xt6rzDFB4ZbJ1EsStcH7flb+I=;
        b=C5huRMEX2lGT2nsc45gxCrLi65lNgzFw2xvOstwagkVV5Q1tj/kWTR9hs2TzdFlDDT
         mRoZUkpr+1P1IaU+Uz1DILjY7Y35PLRed+tXs11ElPlXbtMC5cLBC/ctGVkJHfuIUNut
         ZEjPqyju8y+M/lV31FGl6v/GcMKj9f38ICJ1sdQjhZJz08J1kYw1tmPnuhdTMhfWDDrh
         PAFZCyfFVykmGBANWDcBSiVDd1Pu8kKgxHuRxRMgSbJRj/O9XhBj2jCOF9NJnv0t0iak
         mZ8E6pYEtul58plgJD0kaQjPyXybjk+FNwIkRFzVJY7+hlHAZo75LrbjDbT1kOxn5/ov
         ErPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0322DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.16 009/113] usbip: usbip_event: fix to not print kernel pointer address
Date: Mon, 30 Apr 2018 12:23:40 -0700
Message-Id: <20180430184015.467637029@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200451835054515?=
X-GMAIL-MSGID: =?utf-8?q?1599200551732329989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -91,10 +91,6 @@ static void event_handler(struct work_st
 			unset_event(ud, USBIP_EH_UNUSABLE);
 		}
 
-		/* Stop the error handler. */
-		if (ud->event & USBIP_EH_BYE)
-			usbip_dbg_eh("removed %p\n", ud);
-
 		wake_up(&ud->eh_waitq);
 	}
 }
