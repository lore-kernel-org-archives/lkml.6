Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48xsWrlrj9uuGIK5X2UdboUjW8ZDJZ0j1Ea3oCKIdzKT9HWqrnHkzUaEBMHzy10NoKUPLwS
ARC-Seal: i=1; a=rsa-sha256; t=1523022290; cv=none;
        d=google.com; s=arc-20160816;
        b=OzHghGuKOsvUJEtjlWOhMRzTZHhAMyM1P5fWnjGj1fFkhTAsQPiIzknx6HXNFcDL25
         x7lIjHWkSImjd5NWr8EGosVakRv90UOO1v6mF1Eev2LMDmE4tttS60WhJcGXu5gO4UPL
         oRBVl6TMgvanvhkGScelNk8scMB/NzHmKuzy9Mk39G3bh2rgnm8EXK1ru1eA+dfUf1rq
         XjeY1dTgLGWYG7AQ2YHvEhQ9aYvb+LoGbonEGPdyPd50UiqICzB69AqR48I6onBvBHdp
         cT3hEFfAfkflb2Gt7BPdxOqd18aNe7jJaFglfGDM8fO3vghEBJZaiFZZpldBRnmZ+9pY
         cplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jMZhnPVr12RnM6N8LSlDXV0Vuest2miX7HRWdr25gOM=;
        b=qOATkbjih5ZQg5BCX2so8L/+ylKl1Gc+lgFCkU1JsNp0eS3hCQn/S69gPkhdhmReSP
         Su1fkUbLRTL1Cgrv4gnQwKy7k5lSEExThooi1CbXwjJb1ualJSwCzjNVGef92BEU+4wr
         AceX+wJmomZj0YHWybyUL5bA1dfUb2ibisUh1+R0NpURpXpzQzLejYS2xuAtN0L/cCrs
         /oFvYV4aewzSWvOxGlnmuTtPMVZnxpV5K50nNQ9cReb3mjh+sfooNxgmWetUWec5JcRX
         v65hGGqzYHuBzHq5n5hLiS9FTsS8QLSQjM83PHJzl9xBA2K+jZL25Q30hU8rBqOWTlcz
         w1eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.16 21/31] Bluetooth: hci_bcm: Add 6 new ACPI HIDs
Date: Fri,  6 Apr 2018 15:24:46 +0200
Message-Id: <20180406084343.878948158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004621037727450?=
X-GMAIL-MSGID: =?utf-8?q?1597004621037727450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 4063cafa3b24ff04635bdedc97cd3e4320415065 upstream.

Add 6 new ACPI HIDs to enable bluetooth on devices using these HIDs,
I've tested the following HIDs / devices:

BCM2E74: Jumper ezPad mini 3
BCM2E83: Acer Iconia Tab8 w1-810
BCM2E90: Meegopad T08
BCM2EAA: Chuwi Vi8 plus (CWI519)

The reporter of Red Hat bugzilla 1554835 has tested:
BCM2E84: Lenovo Yoga2

The reporter of kernel bugzilla 274481 has tested:
BCM2E38: Toshiba Encore

Note the Lenovo Yoga2 and Toshiba Encore also needs the earlier patch to
treat all Interrupt ACPI resources as active low.

Cc: stable@vger.kernel.org
Buglink: https://bugzilla.kernel.org/attachment.cgi?id=274481
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1554835
Reported-and-tested-by: Robert R. Howell <rhowell@uwyo.edu>
Reported-and-tested-by: Christian Herzog <daduke@daduke.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_bcm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1080,6 +1080,7 @@ static const struct hci_uart_proto bcm_p
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E38", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
@@ -1092,12 +1093,17 @@ static const struct acpi_device_id bcm_a
 	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E72", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E74", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E83", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E84", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2E90", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2EAA", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
