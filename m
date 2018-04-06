Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48c/XvmuUPLstNPayQTFhGRoefxctLJAHgcKCy5n0VbZs6l4wXdiXolS8cK2Ydxia6Uua+g
ARC-Seal: i=1; a=rsa-sha256; t=1523021515; cv=none;
        d=google.com; s=arc-20160816;
        b=j7HseHDsDCA2J4mD8sV2igohUreOljY3sopj5YE7GptBMT0HYCYQOSmiGw38pHqIhG
         xQZ1Fm3eOoSIKeO4MbdR0vcvoVq/mVs/PZ8QjiQ4fnri/G6tKF4aYbKT5XgWtxrcR8qN
         iBwZE5a9zY3nRszyQ0rxKq9itWfXTdNQziEDvJ26Tl7gdlKMug9WHqAEpMrhVpJ/rJQi
         wD/hpADVBbcHsaeD3PgAmHOcx7hYzU2ETScQXaZ1LikusthQeVxCQ6tspuGbTNhyTIRO
         NPRNRrN2r7ONoFxiTmzPRJKk/tK4jc2H1vlzPkjBzo+0eDejBtSQegxUBj6jtSieCZSB
         nF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ugxQsVAlzZAK8VeV382tpsGdcD00lUDSW+9dPFKGVzc=;
        b=vQ37mOsdTK2AtkocpbdolGEo6xvkjnTgB6OfE9q5+j0FwbRDLZXbYuVSJ2FyxN++Vf
         7kX69xXmdnAkuE/sWo9jRY/umw3cLlPcDCOuYX5qQrbYUkPLC4++wa7WX8TJhMdcATJ+
         Hh5Mzt7rsiBN5vdOOn5vHOC55emIZDQJJKH/6OImtQfjlt05BjdFzYg3+URMZpsCcHEJ
         HztZhj80MBlvZ08v7cP7VBC232hNp6dvD5s9fsXHS/bPb4UqYbRLvjgnLI37gqWq2SMp
         LVF7Wi3MQxWoE9b7y88quONHUQthagnF66i2REfRZF8KaaPmM+RVhAz567650QOOpRaY
         qc7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Arcari <darcari@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 65/72] Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"
Date: Fri,  6 Apr 2018 15:24:06 +0200
Message-Id: <20180406084310.911967592@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003612609521485?=
X-GMAIL-MSGID: =?utf-8?q?1597003809015872664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 4fbe422076d36615ec6fe8648d1aecfa460bc67d which was
commit fda78d7a0ead144f4b2cdb582dcba47911f4952c upstream.

The dependancy tree is just too messy here, just drop it from this
kernel as it's not really needed here.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: David Arcari <darcari@redhat.com>
Cc: Myron Stowe <mstowe@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -463,6 +463,8 @@ static void pci_device_shutdown(struct d
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
+	pci_msi_shutdown(pci_dev);
+	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC_CORE
 	/*
