Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174101-2-12519211160823437109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174100; b=XF+cPDPNGCBW8/TbQ+/KIiJKnsAQ+Qe68lUoY3Ctl7wM4lF
    QaZvy41AmKzbBFvs2qMiY5k/7M7PD9PgRunIegpH5IYYVAviwzHmIcUbvJ1PCQtl
    ywOOlsupNkJ0AFVwKBMO360R7mK0OVOLbMiRj88b2nIUfu+sgWz5WlpqB8476qnV
    F/JHDOxAMXqahAlC1U0KilWQtCtJ12PqWV5eJ8PHoZEsuyR9Tklduvo8axfxO7KK
    ZphLDp5SEPZ2oegmCldqR+G6np4amFNh7bqlJo//UcYo895AomsAQY092qFh4baR
    g5OW2Ga4dnEKxgv/gdR9f5EBDUnZGtGpskKSqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174100; bh=dA/99OfMNj6iuJC1+wRePwZjxd
    KW+Oxa+odA7amWgK4=; b=iHQ4I3iydPGs+8lvcQy0lIXOoZZDKKGgH0uWWyjSs/
    ernsRyB9IQW70PMUIdLt4vvy6Av21l0bM8S60smdbvPnfXUY6IdbvWaQviAHJ9ib
    CzLKdmemVre3wsTeh0cE/okb1Q5L+116r9hwjtJfk56GE6Jk+jVqIDdJRmc0TqKE
    DzpqGygR48LFZ7MEM4PFtSau5Ourhru+T7aNNv2ZWKb4OB4ilyKHCCyaFpmGEa49
    we5BgZXMWhdH42t7MZ/YDoyEFUkXQgsNavWvqmrq8dC6ABr6k5ExxBE8s2n0dkSa
    DqjeleO9XL1MwOnEaMQ9TxaHVsPFsdVwqQGYOpnB+U9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGI8IcT6xuyCx0kGT6zvDNSYIv2zVjpZKK4f2wmNe/2DKthtxLy3a9ROQzPkOFxwkje9pCJa7Ro+Ge2e30DLGxxrohItYeYpm7YkXm860EoH4tfmx3tz
    argnyIzH6AE4v4D/ou2wX1eOJ5YWONI/kJVf05yfDn656LkZrAl3jSBQ4JU1+TU1H7gz1OBvShmaqkaseG5EaXXT3V0jwFXCvj2WL9nBf3lpKEeSEniMFb4M
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=7mOBRU54AAAA:8 a=Mo8WlqgOuBNtBgpS9QUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=wa9RWnbW_A1YIeRBVszw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC0Q31 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeC0Q3Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 08/43] PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
Date: Tue, 27 Mar 2018 18:27:12 +0200
Message-Id: <20180327162716.836117609@linuxfoundation.org>
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

commit 1903be8222b7c278ca897c129ce477c1dd6403a8 upstream.

The Highpoint RocketRAID 644L uses a Marvel 88SE9235 controller, as with
other Marvel controllers this needs a function 1 DMA alias quirk.

Note the RocketRAID 642L uses the same Marvel 88SE9235 controller and
already is listed with a function 1 DMA alias quirk.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1534106
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3631,6 +3631,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
+			 quirk_dma_func1_alias);
 /* https://bugs.gentoo.org/show_bug.cgi?id=497630 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
 			 PCI_DEVICE_ID_JMICRON_JMB388_ESD,
