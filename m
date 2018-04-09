Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081346-1523311406-2-11017050861872421965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523311406; b=skqHq5BlPnDT1UPpenBhz38NSNziqDBiq8cA87Ev7wBR5gdW61
    MNWqvGQAgkKH2+wvOq52I1z+x2gF8+v+ox22mA72G6/4AzE+W0O1c/6rrO6v3djX
    nIivZHJeaEFEY38AokrExaInicEoqdyJ0G8f34SsBli6840JEGxGwsmvz0iu4A7o
    xitIP7l/EGMZ5Gf9N3F1R1I3/QlanxIPTBW8naEDJNtsGN56reurI12Ltwnr+F6/
    0iuwPJIMQb4Wlew+6B8Ytid4lUMh4B7oA3/oxr7tHZh0lBy/qiC+zBIHM5HPJvic
    nWphx70v1x1A/rMq1xEt6P5LyfMyVKS+Ga0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523311406; bh=bL9yw4vAG0ozZQxzVUizCrBB1CfY8Y
    1AnCByRfq6jxI=; b=pEXAp2XG2dTUbw4/pmSGCYssCd2DEs+OBl6TOpk6GvMySQ
    K3FHrP9iimWPqwb/rZh8H1fwDw9Vuggo05t1KM/ZzW8gcZvpSJBVm0BdWGFrTgO8
    45KbR0+2RWAzpcKCLoF2DYeFCRbu+1BojQaK042QdpxZbDeVb9EgzvC/46FrPCov
    axaVLrPXMoUq5mL9ax4lEP1sVhpgwLJmGqmPq69CMzKENn+QnOMsW5VSQKdmdlwd
    BQQ5ul9LQDMtG2viFUbJOTMNBRXSAvl0/AT+btIPYgiOF0RnhQqmEtsByGlR4Atu
    RPl9nAGXT2ZMVD2oqlA1CisXVoRRMDzvBmljaNyg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oGUUsFMo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TUmiR6hk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oGUUsFMo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TUmiR6hk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFH/4jCRO/SJOchM2ZLpDMIrYj6tz8UazYHZjf5Za1D314SM/AKc9K3CNMhI2kqGi946gSBypSpIkoFPg0lZXRjbJf79lhW+e4zj50gxCmAmGyoN9JJ
    MfkZHUAVFlNmplYztsEO6J2YuyxN1ZfHphacYvZ1oBkZnH4p2oYyR7cAG5EvQy3bBkzahNvpF59a+NKoeF7wzFGNZk3jnb9YLRiTPvqgMRkvhHyl0srX9Q1r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=YhKUcPloZ5QA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=AznxQh4cZE-GisjZHV8A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDIWDW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 18:03:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36894 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDIWDU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 18:03:20 -0400
X-Google-Smtp-Source: AIpwx4+6puthSdfsh4B7jS+IrSXfXYzHDpdJY1iwJxP6goz5PpsB34pTjNRxZWeFToGS4YoRBiXjyw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Tegra's USB driver dependency fix
Date: Tue, 10 Apr 2018 01:02:56 +0300
Message-Id: <cover.1523307883.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tegra uses two different USB drivers for host / device controllers, one is
tegra-ehci (host) and other is ChipIdea (UDC). Currently ChipIdea driver
implicitly (and incorrectly) depends on Tegra's EHCI driver because Tegra's
PHY driver is built only when host driver is built, also host controller
shares HW resets with the device controller and host driver manages the
resets solely. This small series fixes the dependency by moving out reset
controls to the PHY driver and making them shared, then the driver build
dependency is resolved.

Changelog:

v3:
        Fixed Tegra's EHCI driver dependency on functions exported by the
        Tegra's PHY driver (was reported by "kbuild test robot" for v2) by
        making host driver to select the PHY driver in Kconfig.

v2:
        Added missed USB_ULPI dependency to USB_TEGRA_PHY.

        Corrected UTMI pads reset by moving reset assert/deassert to the
        PHY's probe.

        Removed function names as per Thierry's suggestion.

Dmitry Osipenko (3):
  usb: phy: tegra: Cleanup error messages
  usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
  usb: phy: Add Kconfig entry for Tegra PHY driver

 drivers/usb/host/Kconfig          |   4 +-
 drivers/usb/host/ehci-tegra.c     |  87 +++++++++++------------
 drivers/usb/phy/Kconfig           |   9 +++
 drivers/usb/phy/Makefile          |   2 +-
 drivers/usb/phy/phy-tegra-usb.c   | 140 ++++++++++++++++++++++++++++++--------
 include/linux/usb/tegra_usb_phy.h |   2 +
 6 files changed, 163 insertions(+), 81 deletions(-)

-- 
2.16.3

