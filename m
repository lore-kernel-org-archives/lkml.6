Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/rhYXxQMSzF6MAYmAJRRQKImBg/Ypz2wcSyr7QrqCDuRj2tbRsR2OV8QWO5OhS3Cf5BwYE
ARC-Seal: i=1; a=rsa-sha256; t=1523021328; cv=none;
        d=google.com; s=arc-20160816;
        b=OA1WsomO+VKnHqrf+KfqXCMy5aVqsHBj1fjlYaJ8+q71VfB5ToaupqHI2LnXG2nUJk
         jCXs5B3IR70YWlf/hHunmwwHL4vInu9Uu+Ke851KJzotw/VKFdjPO9sfXRUBHUG4oOm1
         bDgc58TJkHzfSmURCVfalqKQRp9bEROeje4iyYwo1MLnLW0/rrLU+DVyZcrEuurh+p2B
         3/PpJGozfF18Zmbu+YPRaYwQa6Hg/ermzz099wbRfw+AIToxU2I0+h2TBxdj5uWRmBm3
         ZrFBB4ZnMwXbmpC0P84OL0r32dOtNJZbYlPl8ug/oHqT1UbgfHupegmaUJ80R2l3NAi/
         WyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4zHCXkIvNibqO64503+1cjfh7BWF6NAQxJvy7qOeAh8=;
        b=V3cBOP6Vrgra2v6buQMDLDLawBuY+Csb85M7DI+mNCIleepCxw656sSGfxRPijSPXl
         WkgA7qFaVgDjaxJNohIA3U72qpmATOYJWEKyYUJMFS7GSSEU4fphYoRf4qR9+qypJ1ZZ
         L/aOjYot4Ly5oxtYpyEs5c3vCzJwT1qCkU4CCEKSI9WXon4F6+Tgg7KVLXxypsod/cTn
         u3705jYB5CkxBLoWAGQzvHuht92BIweTOAiRpx1V2F1ySESiJPbb3LZOgm8c256KlASm
         SrvwpDtmPG6mf0T/HwWokZ4BNwF64Vq4/ESG5RjhTYphkgYfZHTF+CYL7Ti9Y2ENt32T
         IoWg==
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
Subject: [PATCH 3.18 91/93] Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"
Date: Fri,  6 Apr 2018 15:24:00 +0200
Message-Id: <20180406084229.148221698@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003612609521485?=
X-GMAIL-MSGID: =?utf-8?q?1597003612609521485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 058645e2f0647c85f2bfd577771546d198739fd2 which was
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
@@ -450,6 +450,8 @@ static void pci_device_shutdown(struct d
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
+	pci_msi_shutdown(pci_dev);
+	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC
 	/*
