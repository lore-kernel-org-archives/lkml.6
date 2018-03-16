Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOQoZyCTNB3Kva5/W772UGi5RvLlplxY+OCYWlpCCd0ETCG/lg9Y02COwh5zJ+POxU1kkv
ARC-Seal: i=1; a=rsa-sha256; t=1521213827; cv=none;
        d=google.com; s=arc-20160816;
        b=1F4xYh0Yl44rZhDjahvMnEV2k/yWXRFgE++DYDt9eaduSOiEuUzwWmez43QJERvutC
         f3gIYGHZgE7MF3ZLCxyjpmlZt1n5eRb9+7UEUtGJfiwStm5crT400ntQmTOse/ZUDGsq
         XkCvhYmtsxdapC4aT9DNvInMqofTrr5VYkQ2+BHgbb58RzSve6nBVzT44X0Gns9d02UG
         i7zCGzxhRcsB+M8wPMeKDKP00e7aMHE2541zCYYteN6bqeZ/e/rC0eeZtcg5sZ4NOsmB
         OtwsTVuC/CJomRScFlCUnTgjfgqVRr2MjOClJzoQbz/qpHa7BJmHBSUMvAxrz+kXNnGs
         3yjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qRnzAHCDZm87RVz9UbJQnpmT1QB8NfkuyjOMcYLY5lk=;
        b=zdLy1f3igQ2pJndhke1DefOwsh8FodDQamLbMlEawLW91x7fa22TUZUPzjCHYfqPpQ
         cZ9uunIw5C/XYCTIVafpgKnKDiYpZ9QGr9KBOofMXB1HQ3q0XPZtng7+h8PHU0fAjPy8
         i0vnWXYqgmigCRI4r9DRdT7q5eNa+g6Vak3vxwBLtznkdq7rqXq0Ddeks4hTokijEEKI
         twEpWjsnTxZxjM4HMcEJUtL+uZ5GOW+85P04z4FgfO1lDJFGFvzazOtEydR1tpuR3JeW
         g/CiVbPZVL4HGQmOoMZGcJZGXoXDuQK48DyK4hlOHwMJ+nYaL0JMCIZmvTcIoRNTeuH8
         /FRQ==
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
Subject: [PATCH 3.18 19/25] uas: fix comparison for error code
Date: Fri, 16 Mar 2018 16:23:06 +0100
Message-Id: <20180316152233.529244758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108310839479923?=
X-GMAIL-MSGID: =?utf-8?q?1595108310839479923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1067,7 +1067,7 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err && err != ENODEV)
+	if (err && err != -ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
