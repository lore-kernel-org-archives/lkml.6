Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227cIdu/xIgTFWVfqsIQkjm4Vs8z5bcGlEAHD/20JQjhNe5UzzYJq4lu06yAweCqjmkHpVqT
ARC-Seal: i=1; a=rsa-sha256; t=1518708873; cv=none;
        d=google.com; s=arc-20160816;
        b=pSNSkgRrFfS+53TqPxXxISmroy025I/XpGEhS7nYtnVSLaAdfDhmU5kxwOxoZXjSsG
         50dwjwz3QBM3DOFFgwm4EmsrdyHIo6ktEr2ry4hFVnpTRIfmHa2T0+PT6thtM25q08q4
         JOAl/vIO/f59JG4kU1Y9gTt/5CXEjYEYtxZeif1VrS90TuGosJo8UO7KhfuSs7PsmMzB
         AGd2AIXw9EJk1dg1rj8LvFBNQF9XPGeYlq7PzPRH2gz0Mr2lUvejc8Miw/5UzFgyNTym
         NiWID+0cAnF3R/W1/kC1Bvf8QuojfYlzBg0K86srfMZGGSoRtUVpLaXaycTftlJrthkg
         DHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HAzPiL+BlufYVb+A2PjRMxvKUs5EugVYS+MdS4gj+L0=;
        b=nMj65b5kXYs7px/PcrEBiChqadwFBkb+STOcy6LRdEik1s+ilZKhkDlzG34+DrRsDV
         P3rlLcKjQ6r0EGUWnWBQ75w18MrtGb7zZ+bktLP0/Bgcp7zbSbXJs/+YK/lfVmAfVwMz
         vGFsKXStrW0aygVHhM4s9BQPnq+K6NItZi0i9c95Nvxx1mlh37lor6iVjAAr9gMGePo/
         361SG3vsoiwv3+b6Vcz9YrUDUldhoqkSjvcaw0FtWzzpC2WHvzM301EplHcm/VbrGDNa
         kq1Qa/VZwKW8x516ENvG9jyZlgcVj7LDGmv7MXGFch1CJgsSydUOamfoE5ZRzMmQdCnJ
         z57A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 111/195] ahci: Annotate PCI ids for mobile Intel chipsets as such
Date: Thu, 15 Feb 2018 16:16:42 +0100
Message-Id: <20180215151711.261865771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480981385689388?=
X-GMAIL-MSGID: =?utf-8?q?1592481675816273099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit ca1b4974bd237f2373b0e980b11957aac3499b56 upstream.

Intel uses different SATA PCI ids for the Desktop and Mobile SKUs of their
chipsets. For older models the comment describing which chipset the PCI id
is for, aksi indicates when we're dealing with a mobile SKU. Extend the
comments for recent chipsets to also indicate mobile SKUs.

The information this commit adds comes from Intel's chipset datasheets.

This commit is a preparation patch for allowing a different default
sata link powermanagement policy for mobile chipsets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -267,9 +267,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci }, /* DNV AHCI */
@@ -292,9 +292,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -303,20 +303,20 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther Point AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther Point M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther Point RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther Point M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx Point AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx Point M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx Point RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx Point M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx Point RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx Point M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx Point RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx Point M RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci }, /* Lynx Point-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci }, /* Lynx Point-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci }, /* Lynx Point-LP RAID */
@@ -357,21 +357,21 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise Point-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise Point-H AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise Point-H M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise Point-H RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise Point-H M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
