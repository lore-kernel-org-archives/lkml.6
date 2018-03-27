Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48F7cLxIsrqtVBZ1KP8YEcvDC4dZGmjWeWbV37FnM3QjSZHAOUH6xULfuurm8ylN14JTxGW
ARC-Seal: i=1; a=rsa-sha256; t=1522168551; cv=none;
        d=google.com; s=arc-20160816;
        b=mGGLaciVDTdE1HGKjqH/0LQY5HnQRtd4rIokOlYzOMsyqQZ1Dq+OzMUZBXCXbEKjmI
         BTKPZBraiVpcKoHS4TLf43QBhRjmVJ1z+t5dxOTP4Tm3Iwv5GnfxYp03tOpT88R6AIeZ
         EDsLPyIfwAYsvcOags/kKq0OUEtM381EAyCnBrd9xFUpjJZtZ0Z+Dge51gQ0LS77Su+k
         4x2z4TiPLekLZ7ah0SIjyJD4ZjUKBRrHrIrZj9z9y7klkbyANrZUUKLXq4jypJ5Cs4YD
         ztrHb8PM8Ize7gVxI7zGxhkaGm6O6jZ2YOhJnwLvlZhmBFAsa0Sn+vPoJZj+cUs3Ux4r
         8zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l+hazNXFG1eq19NvgMoTFViG0o87faAlOdzd+M19+Dk=;
        b=QjhzYolgSHqHZagdH37D3LB3cC8LShRDZGitZmT+fyY2Q2InF83m1jxFwQGQOj0dO3
         zBF91jI1/y0VP1d0dtcsmzBNrRuQY3lLdO4JA8uBdsSdQXGLljTJcafnDfycq1yAaXNw
         TxpPSdFh49RXJLw3rE23Cf7HcNPQY0YSDkynZN4TMzjFOyeQnKzb7DUcofQB1wrNB8YS
         7pTblyLKb9ipz5ZvinjojYDqfrtz2Z8afCpyAagxFNgqHy7p7WYFXhR++MNdUdMR4QL0
         Qy1oUl9C7avkBSV4Bmv7jE5OT2ydIkb14+4Jz8pmrr4QuQNnoRr7CYft/4ScTpLooO2f
         UpjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 023/101] ahci: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Tue, 27 Mar 2018 18:26:55 +0200
Message-Id: <20180327162751.421191102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109035307512510?=
X-GMAIL-MSGID: =?utf-8?q?1596109410676787380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 28b2182dad43f6f8fcbd167539a26714fd12bd64 upstream.

Like the Highpoint Rocketraid 642L and cards using a Marvel 88SE9235
controller in general, this RAID card also supports AHCI mode and short
of a custom driver, this is the only way to make it work under Linux.

Note that even though the card is called to 644L, it has a product-id
of 0x0645.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -541,7 +541,9 @@ static const struct pci_device_id ahci_p
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
