Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/znO+I6/whEXGDYqVnkrLQBgGy1xzG41/8/krJrbuSwQxjhvpGuACWiHQCUfwwXdnrRDHG
ARC-Seal: i=1; a=rsa-sha256; t=1522168761; cv=none;
        d=google.com; s=arc-20160816;
        b=gaqmKTAoxCKnBExNE1z3BC1CPxnXm58mg4QHf85u1iK/JfuJfnJ9bx7D8RwJJVtaxn
         a1n3rVJ2VwqJWr5Mrmhb6tz6teoy+Tg9h+KJfXDBEUc6unfkoKVDzlqaV5zQBu0WeWQN
         URYf/wC51888GokHLxB+XXAhGzqgJ/rh+jnP3/0NSW12a2ubl79sR3TP6WNPPIo9UQqS
         cWTvwgmgzl9HN6fBQD5rj+xtiil15Is6qTAJqme3OgKGc6bHqTX92MX84HUW91i/Sju/
         UBayuuNqM/q2DSaoKtKnZgnhLfcpNWjjaLeIo5mHeCKLUFpeGlgPV2eBoku1NmLy6QEO
         oPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KI01lYT5HquFbucU0EsZ489Y0DwZXCrqQS/DjxLiHE0=;
        b=TMP+KYtW2axp8IrMnazIHkIPbM+dhfBUzNI/ghPaXh1WyIh6aqEtkEqRqD3n7fOqaY
         YGqo8hWbosTAla6J10VY2m5atHzHI5JMfiOebgKgk8GCoW8+t8K9ODjhFOcyKTEX4efH
         lguxZWGXsFsCL4z0aKhIsw58Wokk3+iiGE199RHC8hrswGuhKS0O71RDrOJbyk4halK5
         mJQp56O+yhDduRhoFOLyS+Rt0OW28BprQswGibNSojFd2zEvM4JTMc6gU++1QRQJsmEv
         Bx1ZQ8GpRew0EjT5FTkzIZfOuoBkHWESK6zspTeuXREpvBjxCLVu5CN4y7KKxnkMwspY
         jH4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 022/105] PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
Date: Tue, 27 Mar 2018 18:27:02 +0200
Message-Id: <20180327162758.795674994@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109005834621477?=
X-GMAIL-MSGID: =?utf-8?q?1596109631206896293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 1903be8222b7c278ca897c129ce477c1dd6403a8 upstream.

The Highpoint RocketRAID 644L uses a Marvel 88SE9235 controller, as with
other Marvel controllers this needs a function 1 DMA alias quirk.

Note the RocketRAID 642L uses the same Marvel 88SE9235 controller and
already is listed with a function 1 DMA alias quirk.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3906,6 +3906,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
+			 quirk_dma_func1_alias);
 /* https://bugs.gentoo.org/show_bug.cgi?id=497630 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
 			 PCI_DEVICE_ID_JMICRON_JMB388_ESD,
