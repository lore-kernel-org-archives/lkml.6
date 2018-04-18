Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZqppcDkrgVYUrPXDQkaB0tA/rWaNM79/2YjGGtAY5i8r3e4yUNcPZJPuddn1DKlhj6GP7gm
ARC-Seal: i=1; a=rsa-sha256; t=1524057893; cv=none;
        d=google.com; s=arc-20160816;
        b=DnWWZrqQnrLY7l1TWzqKoX3GCZOTeoDfLEg/y6H4DaiC+XpIxNw9LuPnkV7bRUkYuE
         pH5YE6sbAqT6tQ/NvuZMuS8+x2YY/69LZ7QvUzqOjqAEZzHP6vVfQ0D4t2HNX87j6ODM
         TUQW9wZktKWmfeo3FiLGVl/Tht0jPwN8oBQnnmX17ZxKcVk9En+2yFATfgMug2xl4WKt
         5lUR95QbgbWh5aLOQax1FHbP8DDa9JtNQqqpKNWkVCbLs9YjQRizARF+KQDOz/qkN+PN
         V/Wh2LH2EBcnYOlcocAkIbRWkcy0X36NlOrl5+MG6rnNV4CHKwBOlo+cMtVjsu2ObKcl
         lOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=EYrZlNlBNcMCiwswZadOOwoFr5JYUDiyAAMvEPIWwwo=;
        b=vD1JHka39XvO4muzZUEtIih/UErxdJ6dsZtH6tPX7OuEn09bBjjhJi0P78fbu+LEmX
         gLRe9y7N4P6Ts3mRhpsLE1patPYQXBiUZkO6O3sPTPsUAv2io6zgD3Dhs/v7trHkcNuk
         ShfjouBf2hvrUWe4l7jxn718SUfGvt6Hv5cMJ1vVjnxx7OD5f3w47OO6duB5Ud3NjH8q
         t8TAqrXOuDj3Lz5aHxm0WL8Et8wYwyPpfmj8SQmJR8XB/LMl3Cw5r4diBTOe0cXM1tUu
         jpUo/ylgu+hQmTT7YgDbYVoqR1jZxOkbNQ41CFtFyqn+BNUM3lgNnM15xpXZW6ONK5Xd
         DumA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH resend 0/4] virt: vboxguest: Fix vboxguest module not working on VMs with more then 4G of RAM
Date: Wed, 18 Apr 2018 15:24:46 +0200
Message-Id: <20180418132450.11663-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598090529425549002?=
X-GMAIL-MSGID: =?utf-8?q?1598090529425549002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

I know you are not entirely happy with the direct get_pages usage in this
patch-set, but as discussed that is currently the only way to get DMA32
memory.

Adding a better API for getting DMA32 mem really falls outside of the scope
of these patches and in the mean time the vboxguest driver is broken on 
VMs with more then 4G RAM, can we please get this bug-fix series merged to
fix this bug?

Regards,

Hans
