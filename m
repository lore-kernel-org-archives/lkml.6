Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226fqO8e6qlNjAuWWnDVdDmnmgHbHhTyrd15Q4wDdl0D0PPcNl/oIcPkIslNQjzvdiOFCPLY
ARC-Seal: i=1; a=rsa-sha256; t=1519411038; cv=none;
        d=google.com; s=arc-20160816;
        b=IZPbsw4e+lPuEwnwYI6KGdN56glHNtcMfBeloumjV5IzrC6o0sl8N142uE6RTpTiZF
         Yme6d5CkW1rabAEySlI8IeC536NBIxQ99FqRKCZEy3ubvUmXKgt6INy0PzYQX87WtFSv
         ERx/axDtWhA7RQR5u4wFNRIy8ed6iR4QPD+lv84PrIyOhFtLabkUgd3FGP690Px7Asz5
         X6IScRJo86Bgrxu2D0fM9E16FgNyQrwX6vmALiS592RPQpbrDtBD6nzK9x7G78Kbtq9S
         hCVuIUB8hPbQYcQYfs5sA2wlvcq2ad982Ma4x2ZBcijL/SpOu1IDxT9KzZf9WtBT9XRT
         pY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H6UWWE6pLqwS697KJqIkvISnstSRHnofn+nQfzfqbOw=;
        b=QS1I31T6mvfgAQ6ck7e7uk49LhGeJubOQHh1DA5hR4TjE5KxBx+mhsdC6nwkdT3SjN
         PQ+yR4lHR/bHwJAnjvVOEN2G99CNjRCw1+lKchVYvgC3ELCoj2ekygYbf5hcFpmuZhm1
         7ieysF/NUi6Zze3PMQodYiFmQ2EYP+NRXRh26ltyeHKdvLI2vFAd6zzcioUCboRwGEJV
         mHokKbhlveb7SeRYhgHuKlKx85K8b4mJPcLMNePPPtAC8B+5PfDlrgV1U3QYIQFolUL5
         R3dKzNzrU5HAVS0hWszqC7kuq92reZHJxGoCcKqA7jBG6ey7+02KB/ONu3H5FhSmetMe
         4B0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 099/193] [media] pwc: hide unused label
Date: Fri, 23 Feb 2018 19:25:32 +0100
Message-Id: <20180223170341.503291949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217948443167487?=
X-GMAIL-MSGID: =?utf-8?q?1593217948443167487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1f6bcd011464cb36059e2562f72baf75f98b732d upstream.

The pwc driver causes a warning when CONFIG_USB_PWC_INPUT_EVDEV is unset:

drivers/media/usb/pwc/pwc-if.c: In function 'usb_pwc_probe':
drivers/media/usb/pwc/pwc-if.c:1115:1: warning: label 'err_video_unreg' defined but not used [-Wunused-label]

This moves the unused label and code inside another #ifdef to
get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/pwc/pwc-if.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -1119,8 +1119,10 @@ static int usb_pwc_probe(struct usb_inte
 
 	return 0;
 
+#ifdef CONFIG_USB_PWC_INPUT_EVDEV
 err_video_unreg:
 	video_unregister_device(&pdev->vdev);
+#endif
 err_unregister_v4l2_dev:
 	v4l2_device_unregister(&pdev->v4l2_dev);
 err_free_controls:
