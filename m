Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835352-2-16329752324449100533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835352; b=VO1sJHM4DzoEfVyPKKPgHCR4LUUsIjNSuVoqWVSRKid4VUd
    nT+fagp97Jk6F+KY2phS/f+xVFSotvuZnGaA5pIUNYBtB+EPBLr7hHL60Pgwsuc2
    DLp2Krso5dX58DiM03pFgIGe+AhH5TtxVqS+8fQui57Tqqtl+cgPTEYYQwBQktvu
    OOaotNizubzrY/32FsB0lwwxN37Wf9FG5JQ5Ovdkj3slqRtoCGbA3e5nQBub6Rm1
    l2PSqU3xlr6tG3eZWSP455+zFWgbnN4bkaNkt/eLrrBasq58aFyv0+wfHwa8nL/l
    Owa1HEkM6H4eO8xh1m0/30TfGwjr+SWamI5EQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835352; bh=Pf2D18UXjkb+DlLUZRh
    9ua9s8ud5CemA0PbJdZ2Uz18=; b=tXQ6C8arzgl+PWkbx3M30GUoQ9IMmg+3+5y
    esHVjM2v+ygv3q7/k8j5GxibFsH7ngPBOg/1Ikqh23iFH0a2HmefQ8j7k9MyqRq9
    elfI3S9u9Ykf51kFMCbdLVLlaezqq9AvBpPtORkDSUXOVxTsxHjO/yONqeh9xE9F
    3cZfIMrFq8E9AC8NndDOOfRxcc5fE/4P0zqeC46/HDmhiARdT+rQYfRfks/9ZeGz
    lIijnu3T9FFcX6Bgc0NlNnk7VEbS9qFHaABNLEt7HI/ri7e0mAhhfgbXi55kRS3H
    jNoNDGpS1KD2MVzOBDSpw2gu9TmTe6leaEgsLzX/MqTIDENqsVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934696AbeB1QPf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35184 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934525AbeB1QPc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Matt Wilson" <msw@amazon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.522377960@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 027/254] serial: 8250_pci: Add Amazon PCI serial
 device ID
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Wilson <msw@amazon.com>

commit 3bfd1300abfe3adb18e84a89d97a0e82a22124bb upstream.

This device will be used in future Amazon EC2 instances as the primary
serial port (i.e., data sent to this port will be available via the
GetConsoleOuput [1] EC2 API).

[1] http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetConsoleOutput.html

Signed-off-by: Matt Wilson <msw@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5542,6 +5542,9 @@ static struct pci_device_id serial_pci_t
 	{ PCI_DEVICE(0x1601, 0x0800), .driver_data = pbn_b0_4_1250000 },
 	{ PCI_DEVICE(0x1601, 0xa801), .driver_data = pbn_b0_4_1250000 },
 
+	/* Amazon PCI serial device */
+	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data = pbn_b0_1_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
