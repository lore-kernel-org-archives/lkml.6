Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522173799-2-5879607021649987501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173798; b=SFQQqXwnOejPN8ng598xh1zFVTCtAevwWgljr0sIRgLcUpj
    m69c7NJHkoGrBkjCJljo2ZX0RnhIerAQjmubH2UMo7wSbIz5XmVdY0s2vPYwg+1K
    3240OiBXLzYeR3qNYKdjwHpWHPk6mxQ3+wCeFayYypDgSEPurL4YnmTHhQ4RlK8+
    1SWxF3GCUHDeGtfWv8S1O6g404Rc1RLYc0UDHjeQCivrcvVDRLdv2/U9n9t50qHU
    oLq41seVYSJH1Nhd4xMk+MAvgBd5P3jpf2U+1+ivWrJJB/jBwNoz/7c+oDvkEzM5
    ah3Yddhw05n7W1g+M+cbMml9SmRBQjcOtEiwI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173798; bh=f+yKPbIb8bcNPGvYqs23jbg1uw
    RDc8Vj4TyNkrP3yok=; b=eJbRgKm6Gof+DPwH/qOkrOZixcLyheeAoPcR5SycoF
    U8UfXKV8uYVhz6eNTDPgAPQ6xQn3WL/iWiUqYyzNsaF58yDhlrInHIHUSDqo6POV
    +vIBdUMJOgf9VlU9XMHZtfFJEzNK2eI29l6njNqi91e9VLs5NVxgT6al+UFm8ISI
    dYaKIbt+AsW7B0ef4Txz+dxXeO0d2HU2H5WQAnwp8h4puNWyaYY5ZEwJOcRfUmoh
    K89UQ0pSCEHwJfQ5E6gD+tF8uvN+mTeNlbDMwKK4VL/8VkhN329T3r5G/kxCNOwX
    h5WvPz1XBXyXKp9igD28rkdxfVpZxmKOd18MBQaE91JA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN4/62HFme50s1s0SwTRrnKLIBBOzP1LBw+QJwXslGzCY8GLDbJPlaqRvlOO+YQ58BkoX99c9L33UVH6s6GRZx54CkUdMnOwTL3CzS1R7BgW8Z4/GnKI
    yn3dmrfyzrS57vVEIgrkxoeOoJBi5mc/4+Fdq7jc0KlFJRpGenWPgaUgv3KaVnhBu6IPWykGC8+apsrf/1P0CmwlW+Yk2fykQtv7fnAQc6HikZlZp4lun35V
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=T6KdMzPhkFrUmFEsvBcA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeC0SCm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:02:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeC0Q3x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.4 09/43] ahci: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Tue, 27 Mar 2018 18:27:13 +0200
Message-Id: <20180327162716.883952957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -538,7 +538,9 @@ static const struct pci_device_id ahci_p
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
