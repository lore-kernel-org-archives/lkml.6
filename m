Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtMMqAbqNGrzT1yqrNGan68f4BKkeL9UN2vTBXya7bhfNlhvfgXd0Irg2Q6LmWn9R3fS1vU
ARC-Seal: i=1; a=rsa-sha256; t=1519411138; cv=none;
        d=google.com; s=arc-20160816;
        b=YTPLTi4xvJwEnXh4Fhsf01YKgWCjvZQWxAldj5LA3MaX5TnEhtt+mgxDhGvu0Fw6o/
         cVaolI57pwb+05sfwwu8sFHF30LEyGcun5DDbvPWE4TYBrSFYbXGN4jrl8ULS4lWa+Vj
         ETEv4DuuPc27oxbJB3odsz2hI9WQdK2fAbs87m8KihUvHH6Z7j+ElmkDWfysHyRz9R2l
         3C91OJ89V0BZ/lH+HvnwCJH8N7bt1dmpE2qZgElvhybk4uIO9erHoiNxFN01EsIbRLMW
         18/0kDqXHOSl+JlCCky+I5DKjnqP4Lx2NkVDJQr1mizcwMInOZu3qa91MH+fWGQB4Ig8
         Uocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3xWuqhobklHI9s5kC1NIJaZhuldwIxd4RBdtEh4dA+0=;
        b=jCydPSY0frrPVBg1xueXIwkbrCfM4iXgcHfBiDbCKyNMkZqiHipyqfYE4xC+IFJbg5
         zqnjkZLc4L3fUnlE6sobPDZ7jG/6gTxyToZ8l3WBb110SRwZFdS+4cyscDtRQpvG/r2I
         M/sQgqlzYPb4FABN4+wM/oMeRfh80GtFGxj2cJq22gBBceIZ/G9ZlyeD5+MPnAuuLo0Q
         uOAoJhq7lVpMYuaAF9u0U9FCSkY+oqsK4SPH03SOdPcFlVscVU/MHqjUF66HgvFM1k5e
         +k1l3kDOoeHkM66uwqk6MKXj9Pn2KRx09BPBYh2KN3te2u73aqSUNm22psaCbr2E0jz5
         YDUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 134/193] [media] go7007: add MEDIA_CAMERA_SUPPORT dependency
Date: Fri, 23 Feb 2018 19:26:07 +0100
Message-Id: <20180223170346.823910090@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218054101846199?=
X-GMAIL-MSGID: =?utf-8?q?1593218054101846199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit fa6317eedd6341f2144ed1097706d8c34f18b6e4 upstream.

If MEDIA_SUBDRV_AUTOSELECT and VIDEO_GO7007 are both set, we
automatically select VIDEO_OV7640, but that depends on MEDIA_CAMERA_SUPPORT,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_GO7007) selects VIDEO_OV7640 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This adds another dependency so we don't accidentally select
it when it is unavailable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/go7007/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
 	---help---
 	  This is a video4linux driver for the WIS GO7007 MPEG
