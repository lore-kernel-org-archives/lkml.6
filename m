Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330738-1519730973-2-16858843162507346134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519730973; b=Jle4sZIaykdESTF7ij1bvTRqzMY0kqo5b8gF9ShGW5HQtg+
    3leYmTDlBB+ALfZugIkG66zn7I6aUTnRYJitCZYuMSTYbSKZfK3/HXTUt5VQlTuj
    Qpf2SBNVhA3CtVQSXhFy1CbWnWTWTClAVeLvAGsMJsplBy6cX1Z2Tcbl2PS6gV8G
    /tGLd1aubNfoyQQAnv486U+eKeYFbiUdNNxpkSCmoZgz9Ye54pRbQo1/UdG9JGxB
    G3Vz2l6gSiqN9WQYH88+QuXwMUusIbrW13M1+kRk1ktnSUyhMnJjaP1Nnv02zBPt
    EltyFzrZTR80ZBEzmrG37OuFWFtO53xUGtuBs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519730973; bh=O+L0eGnvLUpHqCI3Gl0sOmkaH4B0ug+zhQCTibdyUOc=; b=u
    57PLDzI6KxMVKNd/zc2z1FDnN5jLqaIiSdWG0ooxCCQx1BUggYrCIZAzrp8darhU
    nlNoKGLYNb3u15hePPpbeus/9ZmbCYhXReT5BuWyrDWS2XE2twYUzTArbrSwyCez
    S7sVql3mlICyD3MAJ4fPwVaMZCf5hM+p1Frsw1Rx/7bkkF2sGpY6sa0f0x9gtDGI
    Jp7T5wnl7NrS8txuwwWloJFZ1m/jCaiqbjkhylm+nGVSAW9fju59zDRMgY8LvxyZ
    qGBzyIEu/P1J6dJ16LU8wshbnCdoKlzx6D38UAy7G4vjvmuqABJZL3UAFz5HxtIt
    U24pa23muwxWRYKPl9uJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=AWjg9Wmr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=AWjg9Wmr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeB0L3S (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:29:18 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10556 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeB0L3R (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:29:17 -0500
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/2] usb: dwc3: Add dual-role support using OTG core
Date: Tue, 27 Feb 2018 13:29:10 +0200
Message-ID: <1519730952-2102-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,

Some platforms (e.g. TI's AM437x) don't have USB ID pin state available
over GPIO/extcon but need to rely on the DWC3 core's OTG block to
get the ID pin state instead.

This series implements simple dual-role functionality using DWC3's OTG block.
Debugfs 'mode' override is also functional so user can switch
between "otg", "host" or "device" modes for debug.

Although system suspend/resume isn't working yet in mainline for AM437x,
I've tested this series for system suspend/resume using a local tree.

Roger Quadros (2):
  usb: dwc3: core.h: add some register definitions
  usb: dwc3: add dual role support using OTG block

 drivers/usb/dwc3/core.c |  67 ++++++-
 drivers/usb/dwc3/core.h | 111 +++++++++++
 drivers/usb/dwc3/drd.c  | 489 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 639 insertions(+), 28 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

