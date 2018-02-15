Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224O+bfsN9zD7nNhuT85VPqtnwcsoh19H0sWwa3bIJB68gn6a8hp8ug1AZ4iu8VWeQW/Ggg0
ARC-Seal: i=1; a=rsa-sha256; t=1518709408; cv=none;
        d=google.com; s=arc-20160816;
        b=UpSnV4Qfe06FiStjbFfV5UW8QCk623fWno+U5Ws4S9o12zn+htp0u7I4uZ6IAE17j0
         XvDAgaJNwjkvDgo8DYWcFMhVgjvBfQ6dZk+aPySMwr+A3Csw7vXtOcrvMHbiK8dl3eAa
         gAMbYN3jH1cGal9Z8Ik75PTlGqYyJxDVc6DoV4ehmaeSru506f3VwmSiP2EckujkEzzH
         +UjEmjUPVPIw72Czi889BP3lbiWYb1xJitx4bN50suI2dK1YxHzEA2us5bHRLNEpOGef
         Pe8UGJA3cMIJxNghrtQZ3+hixR+U1xa+1Ox5b5pf8dMuV7ReJQ2Ktks9OZIq5Tw9BG6t
         tPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bsa4FA1T552Jhc6ZXDL5UehKTAKVszYZqSEMeLCTTk8=;
        b=uhZiD/rxk1NRDA1wmZBS0YbpYGsO2XI28YHaIDgMSYw29jOD84/+8E4/sRBWReV0fb
         UqeDARPHaDoL4ShSnTbG1ywHhFLxOMbsrtrycIUprwiu5SkdN5tgt8mu5yjT6QSvKnOX
         CN7TcyD3rIXMQYKTdUbWGbTpedgloqUTpvb13AREkpfNa0r81VRfKdELbXV2KCta0nTl
         oI0dK+91+LIKGs7fM6tj504iinGhKqpuE5gJMjewFJmh5ArSrms18j9zQqN/kqpgWRdh
         B3OB6/EP2qHoDTDVB/7DeG+vNjGTvAouJ70d6Oqu7J2nw08mEbXlhFJfi/8O4O3I61gC
         ss4w==
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
Subject: [PATCH 4.15 106/202] ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
Date: Thu, 15 Feb 2018 16:16:46 +0100
Message-Id: <20180215151718.804115929@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480988459081410?=
X-GMAIL-MSGID: =?utf-8?q?1592482236429554645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 998008b779e424bd7513c434d0ab9c1268459009 upstream.

Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
SATA controllers. This commit is a preparation patch for allowing a
different default sata link powermanagement policy for mobile chipsets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -386,6 +386,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* Apollo Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
