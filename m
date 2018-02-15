Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226MjBflEZbg/Zlopo/e467yayLA2tzhSXG3aqPU+aQ6iLV4zfvwDVgI+0bCc4TDYdeZMISG
ARC-Seal: i=1; a=rsa-sha256; t=1518709405; cv=none;
        d=google.com; s=arc-20160816;
        b=aef9u/TmYgNoQGa8+sNxg4SIKuUoue2c0tLwxy+ZSnWyMQTDilig0t7fWAR5gO+Cmc
         aPLXPraplI5izh3ZzJUqeDKN85MYVhu5+i4v6ay4OIxn4PoSkYcOZlZ5SqAm2FmPxJPP
         pnjvDKCjFymbGDSN1dQvAHdOf1mHNnT63xNBXEn9xcDpjejOM/hgWJ+h7Wb01TXQKVst
         Vw4HP5BFEtgRwO2fCHxcbEiqFt2VVxxCrTg3N7U9FVMgij+FpHZ37bRzQN0WG5+c4QFF
         RqRE4Y9cbFryjS9MTu7RyRon2PXM7CmdocuzyV8gkavBawUFKXLZExHI6SfZRbLwzfnW
         vQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vlDDBymdWjG+U6o6Jn6t7RZQVRrqg/G/t7QwH3s+LHE=;
        b=n0aK/7DCXSXP9RX5ffTU+7z9BgR8beoDWaPZH/Cq3rzVTvxeUO34Ep/sthaqtWH/So
         6tFFc5Eoy7C3P9kAAafkvSxtC94LB8+57ggqawLbkT16XgWg88WFH6KVwPXq4vX4QpyO
         S7x6Bn2Ylbxq+PXwqPIy3PxRSV408JOvug27gppqjmd9Aak+i53zwrjw7zMbl3IrxcRr
         vfARgTM2J6+v3I7NX7kFoC2iex4/MdsGwXQv91VRop0+MVCHHy+aOFaP5lqagKNqn5Ip
         U52FpaLUfV3EIAyUW8/XnFGZ4XJmLSI6dmr0Oh31XBEll0HCU5mUuOOseMRXeJL4Fvkr
         1lfA==
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
Subject: [PATCH 4.15 105/202] ahci: Annotate PCI ids for mobile Intel chipsets as such
Date: Thu, 15 Feb 2018 16:16:45 +0100
Message-Id: <20180215151718.759253020@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480981385689388?=
X-GMAIL-MSGID: =?utf-8?q?1592482233090449923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -268,9 +268,9 @@ static const struct pci_device_id ahci_p
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
@@ -293,9 +293,9 @@ static const struct pci_device_id ahci_p
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
@@ -304,20 +304,20 @@ static const struct pci_device_id ahci_p
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
@@ -358,21 +358,21 @@ static const struct pci_device_id ahci_p
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
