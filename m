Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vWOsrYw8wGFGV/QLGk6Tg+B8bvXHMy0d3FcCGXprKYpBSjl+R1jfLg7Bnl8BE4DX8f7k3
ARC-Seal: i=1; a=rsa-sha256; t=1522168764; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbR2sk8Yf3cpbHZP15SZBlqHfJQSBajBEoVi+yEDaO2SQwlresOtrT0tdXZBv3rzLA
         MICeTHBrJlN5Nu1FWx47A7JujmwfBZx1YxRbrBasCQtIKJqarkOXfVPoFU7K57j/8B9u
         dIXLols6fvTm7JudvYzFrc8oB+hO0Tl8CRj4VMbdq5xz2dR8cHR0+/gaVza20Ybjs6/d
         W2CVvc8CbSk4yqz5ck5FnsIMwtpQZXmeYw6pXE06Bu4Szo9xJZ9LLbEGDHzA0gq2tG/a
         kSildd5q5Wh+JEbiZoI+PiArhlRKRcVVPuywe8ELaoRdu8nIhaez6oG3RxMXs4azOjFp
         +Efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=frb8sTGWqniIoenhIZ3C/8kkvsqn9ExVF2RiiKFrrgI=;
        b=McVCmLlA7bVWYENJ0lp0+G53k5j/mN7hEfxcPNab/BVhZCH51wTRvaJDKVkBq44dx1
         yyqh1plIcp02PWoBE8L0c857jmyx7hTI4l0N2hoQxdWPZSyQn2eFSDZ/iC92ihGINXLP
         pLzQVV8jbbLTKGVeGj5IhNX+vbqXx80d9FUQ8MB37LQCZIDHAuHTWyZ7rfxvNhxGLcMt
         AsPkDENf8qbeqj994KR/y5l1ueR5a/4KVOR+fS0jJ/osHjn0PBZlgyWT/VLY6xi5E6ra
         vVdfX28WAC+wz6sBztH2hOsoAAuJFlkkMB/imfPlhMnr5UIzsGzEtw3mHHyCpkyOLhv6
         vW/g==
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
Subject: [PATCH 4.15 023/105] ahci: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Tue, 27 Mar 2018 18:27:03 +0200
Message-Id: <20180327162758.845208276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109035307512510?=
X-GMAIL-MSGID: =?utf-8?q?1596109633863350209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -542,7 +542,9 @@ static const struct pci_device_id ahci_p
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
