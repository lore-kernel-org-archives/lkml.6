Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBoDNaVkQM+Bo6WoxitvwjqFkAGIrk2mOlziKZd5nm9EHpYP/Y5sHd2RMAiAFGsFtbax/i
ARC-Seal: i=1; a=rsa-sha256; t=1526281017; cv=none;
        d=google.com; s=arc-20160816;
        b=i+0pGWE+XK4Kp1wVmlADk8aRfMcM+7PgMw2dm+SI3mwLWxjVyE6kW+RbbPKZlvMIRU
         8r8aYeH4PVjhhkkn2zAfzfL2YiAnOdKwqJyq5x7NZZooVqoLGk2UObIRCf8u7vGmJlai
         24u5564cGOQE2JjHUL/ehPleCpTKg80e6b0SHxL5XWlVtLgx9pYL/wYqgwKpuipzik1k
         KxNGE3xiRQ/d6Y1QJTJVRFGn2dBAWzxS07VS1Wh+7sQ4qk4jaIVdcxgEHIYBH4vC70PT
         1fs5j/uRrDyp7Q3L5hhZHF9TkVsRAnkW4HRQ7iplxudWihcYTsv2MNItZJFdz81YjYmG
         CDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mQEfvsgX29vxGUx/RPul0WAponmgNVFTK6pa3gRChX4=;
        b=PfkuFiGZbDffTrkOtgsINFLzuApOKgp0h/5qkplpNLJrfB4gbVQrcVld4kiNibpaPZ
         4boS6r/Fw/StdlxJQ6PsG6lFkBDlOLYHZhXRI1kVQrkDvWFe0rXF9qtHn52aGqbXaQNs
         m60dnbiMZxjQ5iSKGQ5DBU/CfoIM7KkS7r1t6+lblnT384CvVOsW3DyL0esVa3rf7QaY
         MagQF/SpSXwLaq0ep983GboBpO8lIbKSukqYpGilX8NMR5DM3ZwA5bjORqSjzmnK7LSi
         8LytENGbyzjCfzTNuTbUMZ4rSGn3UQJLMNMSwhm3C7ivKAnjDj9/5PVPBKD4UpKJQUlG
         kdjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tzYpe+zc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tzYpe+zc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Garrett LeSage <glesage@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 48/62] Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table
Date: Mon, 14 May 2018 08:49:04 +0200
Message-Id: <20180514064819.175269991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421644617814119?=
X-GMAIL-MSGID: =?utf-8?q?1600421644617814119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 596b07a9a22656493726edf1739569102bd3e136 upstream.

The Dell XPS 13 9360 uses a QCA Rome chip which needs to be reset
(and have its firmware reloaded) for bluetooth to work after
suspend/resume.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Garrett LeSage <glesage@redhat.com>
Reported-and-tested-by: Garrett LeSage <glesage@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -395,6 +395,13 @@ static const struct dmi_system_id btusb_
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
 		},
 	},
+	{
+		/* Dell XPS 9360 (QCA ROME device 0cf3:e300) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
+		},
+	},
 	{}
 };
 
