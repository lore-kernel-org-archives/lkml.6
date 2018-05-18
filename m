Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4113709-1526656059-2-8775967930609693119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526656058; b=bI3FHs0CqtIh+FWr82P9Nqq1cLyszA3ydLCC5EVQGLWAiNG3IV
    1DL+Bpm8PNHUtXPMRtAdo1htj7GSrg9kx2GPQpIK9sm7Sgs5DLOikL+/RQAk5jzb
    ODRvRAnS/tb5ckKWjSBvUYwPyV5IfeCsZtROsJWI1d7P/9Y8z0a60WgkdlqRlz1I
    n8+qYoFKNnz8a/n9kTpBiMPzd1pNlLMW+2jo8BoP8VyaCrVQXDbczX3g7sN3hq8D
    0Ti4qUmt54060VjaAaRf7VbAjZ3Rjwna3xd9a9qzSX7kijR9K6FGXBo1WqcG1qyd
    XZp45ljeIl8CN8Fx0UcghAq79AZ6bZCfw2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526656058; bh=Tia8a+sfwlU4nnpN8MJZI9Fzy0Xugv
    jzRY+B4+3ncQE=; b=gGPy2+rO30X7a40P6TW5+Q1yU0iGK6KnDTOIoEDGL/IOsi
    9mesYZyU/zdL6BaS5EWPlzJccBmNG1DVExzSjDlQDkuEHST0rcBTJ3mBCigzwkE4
    OuepDDMdxfZiEdOmKb/UOGRlsW4uDrf8YL6G6nRRbeoM1WaLl5vIwJmi9FACf+BU
    yHeUhYl+2mKf1p0xfflkLCV5KqGYP20TFwsUbNKGr6LIbI8VKbjurAQFwifUInwb
    1vDJxuLTf7kHqKtY7xga7Hbbz0uiEh6C33FAV3bQamV78sLlq5i8OBRKz3IiKgju
    ec8UCSJH1d5Rdnm87/QyyxGgNTkNj7Pa35acRmjA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=kivDz6oY x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=kivDz6oY x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCs3z/GdgMCFqv1qNwqOZ/onxt46o7QECIbGoblN50c7amGpFGYM72zAlyEzcIKIbIUyIxytLZPiv7pOXbYRcAyROJG6HS4+nVl6hevRH5o6z/ebCJzw
    KHrqAQZ0gUtvDSHNLU/LhTCTA+ShUykCXSf7IZzY6jWk6dQnQ6fG4sWLprvSSrSUeavPf04ToeVnHmBrR7Q+aYhl8r0J1wBRsdhJ4vOPcbAYXSov5H1Xg/AX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=kwwYtt491qr1f78z-vIA:9 a=wPNLvfGTeEIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeERPHZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 11:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbeERPHU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 18 May 2018 11:07:20 -0400
Date: Fri, 18 May 2018 17:07:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.17-rc6
Message-ID: <20180518150702.GA5868@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.17-rc6

for you to fetch changes up to c171654caa875919be3c533d3518da8be5be966e:

  usbip: usbip_host: fix bad unlock balance during stub_probe() (2018-05-16 18:52:13 +0200)

----------------------------------------------------------------
USB fixes for 4.17-rc6

Here are some USB driver fixes fro 4.17-rc6.

They resolve some reported bugs in the musb driver, the xhci driver, and
a number of small fixes for the usbip driver.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniel Glöckner (1):
      usb: musb: fix remote wakeup racing with suspend

Mathias Nyman (1):
      xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (4):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
      usbip: usbip_host: fix bad unlock balance during stub_probe()

 drivers/usb/host/xhci-hub.c     |   2 +-
 drivers/usb/musb/musb_host.c    |   5 +-
 drivers/usb/musb/musb_host.h    |   7 ++-
 drivers/usb/musb/musb_virthub.c |  25 ++++++----
 drivers/usb/usbip/stub.h        |   2 +
 drivers/usb/usbip/stub_dev.c    |  43 +++++++++-------
 drivers/usb/usbip/stub_main.c   | 105 +++++++++++++++++++++++++++++++++++-----
 7 files changed, 145 insertions(+), 44 deletions(-)
