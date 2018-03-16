Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtai4XHG4G4R2XZE6NX6OM/CPxLd5C02n1Prdb7/N6zN7bpcb0VHl6MkM2jsUH52c4VzQ9/
ARC-Seal: i=1; a=rsa-sha256; t=1521214137; cv=none;
        d=google.com; s=arc-20160816;
        b=eKTRgub5+keoRBmHZKt7AfWc8cDI0b28Km7lcQ9K4akGkX9XrGivPWLSsGW9fydtY9
         KFB4PtuZIo0HIXEBvvMR6ZXeikMFwnq0k4/xthXrlNTzt8pfzh1os1jAjLftsTTYXhKE
         O9I0D9utsnx6p15k5JNonohXKii6fYMHya9wLM82wEktLfsICaK+uroF9WVt3sVmKOYl
         V3JguNXS8TQz1C/TpUnIOomzgj3tKUk59bviKKsNeU3ASL+T6HcNc7U0oAShKPtrzrCm
         uns+51D1ozvV+vhKtwxPfXrfuiNV9VLOeOQZ+JKxbigGx+DO1ceQ9D4WOJhpNWWbgQWT
         FfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pg4WZBqVnFdQ+o7/USlwZIzo9yI9FsTFxhJO0jCWdMo=;
        b=C2bv/8AUTjmA8HQq5Vo1IbOOPGl2Bmp8CBk6kQ+WEKcdR0I8Ry6u89+sioWECKd3sP
         5OxsUxOYL/CLRo54B+cSv15vOMPJtMQ7PRuQdOPvTAcqTvQ4n4A9cXzC8BmAixeiWVW3
         4YrHZf7zdc2xJHSTy/aJRVhE8SAdq3ESK4Ncp2YYVnQ+wd3J4ko1hQW/CL5ehf8n+yFT
         TvQL3UxN1E2eHYSaDZogZb+vgt+x0N08fm7GgR1cnmEfVM1l0YAIfKKl2bfVbFRy81/e
         ufbMICvYkqFopY0TJp1peib41lHamWExRmyPUfgUyI8QPZZjjjESlYvIzlTxHZu43fAY
         BVvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.4 54/63] uas: fix comparison for error code
Date: Fri, 16 Mar 2018 16:23:26 +0100
Message-Id: <20180316152305.882197844@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108310839479923?=
X-GMAIL-MSGID: =?utf-8?q?1595108636245155000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 9a513c905bb95bef79d96feb08621c1ec8d8c4bb upstream.

A typo broke the comparison.

Fixes: cbeef22fd611 ("usb: uas: unconditionally bring back host after reset")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@kernel.org
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1052,7 +1052,7 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err && err != ENODEV)
+	if (err && err != -ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
