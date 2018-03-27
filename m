Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+HA2qRVqfJTA2SK9YINp2NEtmSjTw7CfpbHq6lcph8f1Fp8lssxVSITV2S+lpsC/KEH0Oz
ARC-Seal: i=1; a=rsa-sha256; t=1522168268; cv=none;
        d=google.com; s=arc-20160816;
        b=OuxIo7W8gqeb/GvaQ4/Ysq+FYMksMRpvNkgqdy0bsCDisAOps3lGCXJEUUQspPQxHH
         dmnof7KlhJW9oDOj4SRGEfZvM58s/ec3n7ryPH5qEXVxyqXIUe8eg4bwAzOKnS9eDPqn
         cE1bPeaccvz0es+MCGi2ZsjiWh83WUy6FjxF3ODo0iewJHO0wHNwQI15CZW90sMeibrB
         33F4hopw8Sjvx6Rb2NYLYNFMEdxQOnsW9kOOMuw6tLCYB1bdjSs6Wn1OPB4JFzJmDxWB
         D40VZ1onO8U1eWCB2TSxEQ5LI07iGVdkrBGQYNtnUyPmEaoLCPxg51bK+E2fXrlEPv5H
         dAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rMvBRUZ33rm2uQC2q00lGgcB6xG45T6uxMyh0SzXwiA=;
        b=WHd5XjaUTtHGnBrPDYDVjpYu0VodVBu9chzf1HR7Xy3Wewdo/MzBmbzJWEJMb5hHc8
         JQFRhzS6QJgIzdeqVueKtdiQYEhuGcbBWy3ATxIPdXwfQjsLJ2Z7dT2pMrB93Phs74Si
         y0/NoYa5a3LM6VQiegRHH8GyyorKwrfjANfLeDpb7qYrqw/5UtuHOLszc1A1T8ZYLONa
         S9m4kT6DArMqSHnh8WsrMT5a9F6FIPkoMVD6deRhiegHfDDFioKXhV7eUPlZjpR73ZRA
         jTqVLDgFGCNgIULT9N4yZZiajq18zyv+OxUtZAmhHLtgsg2yMIdWhuL4uTdW+gYeCp/u
         O5Bw==
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
Subject: [PATCH 4.9 09/67] ahci: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Tue, 27 Mar 2018 18:27:01 +0200
Message-Id: <20180327162727.204707566@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109035307512510?=
X-GMAIL-MSGID: =?utf-8?q?1596109114406724015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -539,7 +539,9 @@ static const struct pci_device_id ahci_p
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
