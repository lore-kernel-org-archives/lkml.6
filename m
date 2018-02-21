Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269UAisWikbGnRzm5F4leZZ4LquJ3RCoc3hH2l0iLDG29cw7KWQMcp68iR+YX+twO+5gIDi
ARC-Seal: i=1; a=rsa-sha256; t=1519218183; cv=none;
        d=google.com; s=arc-20160816;
        b=IJsUh6brGGq1s9J0P92KkF43nevf9GTkqXCCzErnRzGCqXnW+SVYwHb+xRAcFcv/lh
         5C8dhcvjWydnOa3OK4/7d63PUSQMypOE7UqGiLppcldAZv3dqLvExpe5WysRiQ/QeVtK
         7XK3Sm00PnC1k67acOtnp7irzcVRrXf9vrXVDRe9k+8nJhZf+wq0wytGIx/FngBFgUPH
         euV2lMuNEm7g+A/gJ2WzgrDdN0o7d9IaLbCRe4Z24znr6tUlNlzEuxpckR3H4pI5vaOg
         bUmypWZf1r7HTUaYEr1tR/E+A9XXYYn536SbnsWZ2XVQmtWBElhK+oknI/LaynUNueLH
         nA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mp4QVQ6cWc0zBV+I7JI/dVBqH89bXCj+T+T+JRHSYpA=;
        b=ivdyS9TKe9f9sQ5WOcVDyGtYn9lIhZWoSgviRhS3TIjFJTjFfmJ6sxZuuQbVDai4gY
         DoKnF50nlF2myPG/zS7+XPP9SY42ghUpu77XXtkDAIXt2yHrPIzKXilZi5ByHXsgxqxk
         QTyqQ2bO+80QpFYlCGiTMMCYIR6qv5eg73r+fDPvFuNo9+KeJZlbnxTAiC/WLa+RxhgP
         KbsiSEcZZujUTkTc+6vfmB/IOcuPbiPnIgmA6tB4aZ0ghWioHPBDV3pC3pIBiKMCf2al
         7k9McFmty09R4hd5YyiufBS63vwEXvW25Nrr6gm35O6iiWVbg8MgbWm4vptSZxVbJ5JG
         GnTw==
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
Subject: [PATCH 4.14 117/167] console/dummy: leave .con_font_get set to NULL
Date: Wed, 21 Feb 2018 13:48:48 +0100
Message-Id: <20180221124530.830303095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014631678388583?=
X-GMAIL-MSGID: =?utf-8?q?1593015725663591965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
