Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/bTHfN/QIKxp0qoHqd9g6jIvKCKYvn6BXzbV7fuYPdaY81rq1L3tRrwVLyfVZOUDD8t1Q
ARC-Seal: i=1; a=rsa-sha256; t=1522168789; cv=none;
        d=google.com; s=arc-20160816;
        b=AMfWbrPJy8qXTAPwH8uJHbICDLKgonOXihrE+2A8rlab9g4TLYSZuY0UgRTGXw05Jz
         sPK8DTmEbAgT/7JQo9fI3iR5iS3dQqlHrrG/vDLz9fjM8NqAHy5cCphZH2RJHY1BceQR
         JNKWppIZpG/zCyjUrdG5j6a0eBKMActGH1/JoOrzRGk1OB3BGavfqZfydlHKPgxIdx52
         9L/EMFtyU+m0kdA/YynMDm8KgOu/e0zvl9fNZDOvGX/ouV7nEepiYJ7nafSJLWdMIdM7
         c/CC3oGzMJXed+RpNyD3Lrd8XfEEN1zYkdYCTzrkWla0Gwq/MkUZtOqy9ekIocgim+2G
         1lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pkDl/0JYxyCThWH33XILU4ZrlS9lXvm70lv/Cz66pT4=;
        b=Ubj/k9eW/ESI0xlfF/hQs0Tc3bVX+nJeH39rLdsoe7uj46sDDNX1x5gLbx3IgA6f/H
         I3zStteXUH5ZfGMW+N5fCtQ0Bp6fU31r7wUJOHP9iZPqRQUcwZtY/NfY6+drek8eeuqj
         E3IxQH04Hp1AEGd+TagPgQXgidzk6r+LqNKwlDdwXR+de7jwSQiaPP9aeuK7g1uhTczQ
         FqA2upYhaPUvtvu+zQTV2xCqgj7n8Bef8D5hCD2ade+kFSTotba5GGKrbeqrcOi17WKh
         BizgYbA8iF0DknXq9mmuv65eTHZMg3Z2HUOK7BudjaiIGK2AEj74LtfxtVjn20lj93KG
         kIug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kevin Fenzi <kevin@scrye.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 031/105] Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table
Date: Tue, 27 Mar 2018 18:27:11 +0200
Message-Id: <20180327162759.272790558@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109351480551547?=
X-GMAIL-MSGID: =?utf-8?q?1596109660482796077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f0e8c61110c2c85903b136ba070daf643a8b6842 upstream.

Commit 1fdb92697469 ("Bluetooth: btusb: Use DMI matching for QCA
reset_resume quirking"), added the Lenovo Yoga 920 to the
btusb_needs_reset_resume_table.

Testing has shown that this is a false positive and the problems where
caused by issues with the initial fix: commit fd865802c66b ("Bluetooth:
btusb: fix QCA Rome suspend/resume"), which has already been reverted.

So the QCA Rome BT in the Yoga 920 does not need a reset-resume quirk at
all and this commit removes it from the btusb_needs_reset_resume_table.

Note that after this commit the btusb_needs_reset_resume_table is now
empty. It is kept around on purpose, since this whole series of commits
started for a reason and there are actually broken platforms around,
which need to be added to it.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Fixes: 1fdb92697469 ("Bluetooth: btusb: Use DMI matching for QCA ...")
Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kevin Fenzi <kevin@scrye.com>
Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -382,13 +382,6 @@ static const struct usb_device_id blackl
  * the module itself. So we use a DMI list to match known broken platforms.
  */
 static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
-	{
-		/* Lenovo Yoga 920 (QCA Rome device 0cf3:e300) */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920"),
-		},
-	},
 	{}
 };
 
