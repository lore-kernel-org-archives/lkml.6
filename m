Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226U7kWt9xJiaV7BfBft/C3+tNRBR/pJgZBy/qClFkLp2HjyEjXsr9fF/R4sRLmaAZbFkGqm
ARC-Seal: i=1; a=rsa-sha256; t=1518708876; cv=none;
        d=google.com; s=arc-20160816;
        b=DBPWR+QzBk+QfUSuIfO8UJWV3osmwguT+xrvh8f7UKyd4y+TQ12BDVEP5zcW3vITbA
         0s0mbuFhEA1gQ6jHRaMMjHbByGwC+eQxA1qxtg2RVJU0v4HSP9cedFMjKalkdMF1Nm6W
         u2VZPhbSmnybCIkskHs8e1mKf0Vy7YklMztIymyrnvr9BKEVhm4yI6+mObTNjvd2n57g
         BBK1IkJNg7SJaMBlRdA1tMr5O3mFFas0pkDtahOgzJjcgL12lSwipAS7IkS7/v93W20j
         RUXgDXCYyTLapfhxByGe27/OGLNOfPFO+9fVCTy4Jgc4UHR1XJ72ox6zeH+7rWhQdjMS
         gXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ITVtWQ5NIxi1ctAehMm1pKUC9IK8OZkVPGWbAXMLlSI=;
        b=KYYr9P2tZzp5lTjMk7YmtQzVA1bftQPWsdtYaQyMBlErvfLbdS6yMtfpX4/I8A9Cmg
         22GedokQyuRtseaaovrMcL1f2Kzn/P/O0RYhTxGDuLnvfXeb+mEI37DFkVTNKTd2uhmy
         2eQfLX0hDlMy7gfebuBUkKthLxMESXrrSlzZrTIm3CzY5/VoCakf63bNM/DssJ2aao/E
         fPGTZgb2Fj+wCAt5Vh7g2NB03QRQd4ipdgdfe99QNDGb9p7Vhlb08UccmcmWniG1eCHI
         pxCPixWtwpA5vMGSJzGt2HwkhPfNOL1AO6gOchSirKk6DH/xLkOKmZJydS/gIzHcFPeL
         Q2IA==
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
Subject: [PATCH 4.14 112/195] ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
Date: Thu, 15 Feb 2018 16:16:43 +0100
Message-Id: <20180215151711.300590648@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480988459081410?=
X-GMAIL-MSGID: =?utf-8?q?1592481678180754986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -385,6 +385,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* Apollo Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
