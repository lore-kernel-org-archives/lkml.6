Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvucjuwikqW8djoUdtNrN/EYPCxMdJPcu4wZ8XTspu0iQXbrehaQMjmZ1Lwx5WzM9N6cTf
ARC-Seal: i=1; a=rsa-sha256; t=1521214763; cv=none;
        d=google.com; s=arc-20160816;
        b=d7LOVjj2mGuMarXozwlLUwHDEgRiGBgc20nuknFyoRhmSZP/c7U8qZFS+LlOr9KFtG
         QJRsgqAp4eIy5r7CnO2/qZc7EyEv6XoDMO0ptr6HSyDjvzoJfU6C5I/dvLmuyqJ1o+cO
         2piphpFP1CG0V/REvaHiCQpcFGfn6ZSefPsXcToALrmAIXe1uDn8KlTcad0QZG7AD5K+
         4b31EvEEXAPYOj0C7NtJs8F/zHavzsie80pI6UGB3MT+SwJI5lARfdWf28U0Bqlzhq8E
         W6qrD32n1YSttLGKkq6Zj/0hJiHR63Tf7bdW3zPYUNRIr9fISEm/f8nmRrq8V3yYAKi6
         VHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2FUxA/4xNRsXTH3jEnvWWTofKyOEcDQ+LOM8VdMwfQE=;
        b=brNx+WnKyF9xD7VkrFOS8LyB5cyhxOE0xkklbFAZS0G7f6ibK74Nng3CH1MH0SOHxp
         Sp2oBa7Bmh2eSgV+x5PVo/bcJj5CcoIuj4UkBj6/sCWgtdg3Z4W13RJF1jSDFfbYLvbG
         VRyQ8X5LNnaKZThm4k+3Ep9q8uPXc5tWhCk2ZnOzTEnSMapQ+jdt56DOwO1sBok5axhn
         vLh6KyeasPuQgP1dkiR8YiPopKMxWWwgqHLJ3134x1X7Dnyg9MH0MJjfIse/gm4MI9pv
         +2YR9MsR0Ai8nSVfWTJkndMPmNxZmrzY3ZSpYU2JI74ogB5SL9YSTVtxEd62xJ6pWBHb
         VdrQ==
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
Subject: [PATCH 4.15 011/128] uas: fix comparison for error code
Date: Fri, 16 Mar 2018 16:22:32 +0100
Message-Id: <20180316152336.799882282@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108310839479923?=
X-GMAIL-MSGID: =?utf-8?q?1595109291996530259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1076,7 +1076,7 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err && err != ENODEV)
+	if (err && err != -ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
