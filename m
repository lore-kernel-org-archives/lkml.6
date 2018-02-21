Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mfZ+2H4dDqaIS2syLLS0HUu4P2NWSsWIQKukwUIJfzJUlQ7q3kCa65PcW3Ik1blPWvhQP
ARC-Seal: i=1; a=rsa-sha256; t=1519218674; cv=none;
        d=google.com; s=arc-20160816;
        b=mN65QNB4px9zdB3njMGJGzVOut/7E9yn+VsxHPStEITxlFIlDdvoFXhPQKO8Q0vBYL
         tbQrYll0vpJRGyeRTjORBQD4ji+JmLrkADE7jbgTYqCXCoA9QuJR8XyGBjj6PVpc8hHr
         CSJpGNKw/wVcG5Yoaio74ctmTwbKT1ECbT/BtyMsJyWpjTnyU2HEvg0Y9lw95lEuJLk2
         it2fZ9c/cx3tm+RiviATTMm0ehNOCs6dDV0HLYY4E4uHaNZtTP24VoWBqq6UkjpVPbrz
         oEqS5zwJYYrZnU98VdAXIm4FivEjcEz1DrgrpqcOKDVYw46TBtij7od+GrvNVvW0InMi
         IdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1HyUWJYhV6/RechYEDNuijiHyw7wFyng4FzmuvfZbtM=;
        b=iNKlGEWbu0val7R/zFPzPqfzb3faeA8CiwV/iADqEDotg99+QLKmvL7XevL37eY7Ox
         JglqlDMFv1ZDlHsS2MMmCFha3YbEaP9psHcmorT3LSMikIvQ/8uu1m1e4caw1MTpkC+k
         I5vPPuJB2lhmDkcCmZaj8N5uaIulr+hmdGXCaZY0zVdRMxkZETHQs2O06joHARUULEiR
         7GtUuqVGi4TxU+2b9tSXdmKdOR6w3fwcqXovx04PlUygyEnOv0iwpHg2fNKVpiFI6N4o
         Ru9g6jpru9YlmPBUHihJYcT08BNK6OAmptsqg3me0pZFydZmXCBaCH+eOxFblTwWAGr5
         QVyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicolas Pitre <nico@linaro.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.15 120/163] console/dummy: leave .con_font_get set to NULL
Date: Wed, 21 Feb 2018 13:49:09 +0100
Message-Id: <20180221124536.747679607@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014631678388583?=
X-GMAIL-MSGID: =?utf-8?q?1593016241413508955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 724ba8b30b044aa0d94b1cd374fc15806cdd6f18 upstream.

When this method is set, the caller expects struct console_font fields
to be properly initialized when it returns. Leave it unset otherwise
nonsensical (leaked kernel stack) values are returned to user space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/dummycon.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -67,7 +67,6 @@ const struct consw dummy_con = {
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
-    .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
 };
