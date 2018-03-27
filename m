Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8MDJmRYVmXFbP1MCHgDrYBP7y2u/gt8Up8IMprTtUhVliBL5fR258OXAUfXI095bmFcJi
ARC-Seal: i=1; a=rsa-sha256; t=1522168494; cv=none;
        d=google.com; s=arc-20160816;
        b=Xs563Og3wCKOYGzPHDD9WDQzFdtJNLGJBKvL9+1jTGmxCYr8kHzfRZ8x3mtJsPX6AN
         xIMa7avM2cQsDEsbHZxf0JZlnCtBRcWKFZtnAUR2BG8K9JMXSBhq0+YMS6yCi//E4NRh
         jIjfIzVQuHkn62RDE8zd/LukRhtbDNXJ6G8Oj0mycoTZ1nOUkRl9RuAV/q0zW1zcifz6
         W8wgRYlZtSoW/qVIBZIkJqpc3hgN9doBllmInnN27XW38URB4WvVVR+4dTYaz8bRj01A
         zMxSNvbnKgXvmGXTuCikP7eXXYN7a26ACmltgXSSkmSgOikDcU8EDVDOx7uKzy/XhFup
         4Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h9N4qGBgRE+Tbpe/hfDuSTFSf+i1/0nxawyW220UkEs=;
        b=R156CFE5QnnPN3mIUiYlmxqW5O2iaxjU2p78XbRZS7k+Sg+Oi8lpu3U5bgbdJsHNhx
         7CtI0n6MQxHJgZXX7dwOInRR6oC3MKlQdYZ2ooZ5fnrM0YQu28oeAJKu1NNf6UN2xU3Q
         Ls+kgIPKBv9N6zR31en4mKcehIW8mbU0Cc1Q9KN1RXBQOqf1JbY7LtzO+OMOg3yDnUCg
         wQGNykdgXGc0KAQe4qbKdUR2ueEfSjidYCyOIHxrcRaHfEmSGXn05SJiipYtQ8yjD6ra
         SKD3nJy7b7aqdDW0nBKnumIFSM6oXB4uvi4fVy3OhQi2UO+L/CstmkUiQ92McnTvyTHP
         x5yw==
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
Subject: [PATCH 4.14 031/101] Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table
Date: Tue, 27 Mar 2018 18:27:03 +0200
Message-Id: <20180327162751.895989881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109351480551547?=
X-GMAIL-MSGID: =?utf-8?q?1596109351480551547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -387,13 +387,6 @@ static const struct usb_device_id blackl
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
 
