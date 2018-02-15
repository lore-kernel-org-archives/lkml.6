Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ySRRjcQGdHlCPmx1Pox5ukSXQBix2ChEygSi6cYH09ROMZ95rRdC91NWGlIdtui9prYl8
ARC-Seal: i=1; a=rsa-sha256; t=1518708398; cv=none;
        d=google.com; s=arc-20160816;
        b=gOR+aranuxvpyHNcQa1ApQ3w2r/M89K7sWXTN7yqOCe89SlJX0Zq7YVgYqzJvATsUX
         zzZ0i3AtSfp8D4cwYW67gU014/w+yAenZgxFgK8uoH67xVhyuQ+YrKtlPy00glQ6DAnC
         AsjbAqkX1OphBLzHWH1L6f0r+u11negi8yuP9LrhzYyBYRotVxxRpz30a7fkJZXEzLxO
         8TtPceuh03rsyG6YiPU45JqQbRvZacB0hi+dvGTUwNPINg2h3vKA7ku/JrdxZcfgqwSl
         Brcyhovs3STnHf0vYkk2BEg2jzlGB/yvFHOkMunwSXWYdgZ+Qdyjq23w58SXB4nm8P63
         rS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l0Xa3h7nD7uAAw3IF1bgaoXDy4dmD+Aa5x2rRM7T2i0=;
        b=bSDBsApdbMCCE19J1hLCI1plq+L+TH98wSayM3B504St9pL8THo8CSujk8FztjADEH
         b6S/AEmXTTrseVuiFULM7ryqQVws8bhYXczTNY2UBJQK1IsktJqiTvUXhmhiPdA+bgQB
         LADF7C1g2BWnlnrFKhS3BjkJ2FBKDn+7JDPMwUb8+I/0PT68i92RX00UZ6tLquFtryCq
         D8EnB67eK7H2tP73daWEtD66mW581EWyV/qom6djLsvOlIOt7PFjznmjkKe0CBsuFuZE
         PoXA/eVeGwDII4Z1Z1PFF96Eu3g2l2+sQpHJWV3WcOAgEA3TkJ94gUqIl1lZ8OC4rnwS
         CKUw==
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
Subject: [PATCH 4.9 29/88] ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
Date: Thu, 15 Feb 2018 16:16:56 +0100
Message-Id: <20180215151226.688685094@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480988459081410?=
X-GMAIL-MSGID: =?utf-8?q?1592481178013258949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -383,6 +383,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* Apollo Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
