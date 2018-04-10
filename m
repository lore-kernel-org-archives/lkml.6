Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523369805-2-14295835125512831212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523369805; b=v6b8W/gsMgPdd3eCF49uM27vJoQHzPq/5J/fHwcedTlf6Zau/c
    5Tc8QApS3KRALqa/52tWW+JJvcgOBbfEJoN7FcXhZuTPIxtBzNHLwct8aNIjq+4l
    d9JLDx3lnU95zFGIHa/4ZHHM+vMaV/kVMTlI5pmyqR414wCgyKrMrzZM7o7qY5+s
    tJYAd27rj+6bRXmfBKJT1OfisS2gPyrwtCpsGVZQoECMaR1bhlN65VNaD0FkDUtY
    JTu4xj865jO3ATgUxW3ghUup/EGaSLTvFpTbqyfbn6GURcfo7a5E86ybIbNoFpMi
    fExrZNKzJkz5n2F6iEfRWl2x9DsI7lEgCYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523369805; bh=A+MvXApl5A
    f2eveBW4qsjrxAJnZsK3QUHoh7dWMMWE4=; b=BPgToK7M7ETi0zgiArv2lDPUOY
    Q7XzIcuRhkck5aoX6CVLokp0fUjbAO8JI+4LNS25echbiLveUp0GVA3POG7QxOAn
    Lcbg9FovVR/Obz2TSkQ/tANV+Xg79/sl04i23/jdUH+v5av7u1oFPLAGY4NCVem+
    lnUthtqGRrg2KsfX0aS0wkXHx+qJiG6AsruGJC2dQ0mplECl4Wl61tuMfhrakXEu
    cRQbotQr1AC//mB/wyCFzCCrlEGTVAZsO0IDjtpfOXwdFiooAOxWEaYjtR9Wa+Fl
    OwvaetDHexdnvqF4jBXi7wxl1KjR8SHO3mtZ3r27T8jRNzPNEwXD3OndLogw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKS5SBm8S1p/lJwP1fhM8nqy9VTPWuV8Eb2QzwJyDwB0HQQDWR7G/ycRx10rSaw2OpUmUzEN0dfBBMfat0aCvMHjqe5KNtBmzp5v9t28Oiij7mnlBade
    25Tx9zHGyj52q+Cj6u0SeY29QPtIAXAjTRPsmKF9sZ3x+HfjxBu7enqqr8cCEw0waFiocKpgwd0IvDS3POejmSDfxdoLULJjniPY5Qsf5UlTmANqCc9+J2A7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=ov2PNBzdZgQA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=R0E6HnvhYAOI2WPeOe8A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDJOQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 10 Apr 2018 10:16:26 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18984 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeDJOQZ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 10:16:25 -0400
X-IronPort-AV: E=Sophos;i="5.48,432,1517900400";
   d="scan'208";a="13124434"
From: <Nisar.Sayed@microchip.com>
To: <phil@raspberrypi.org>, <Woojung.Huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <agraf@suse.de>,
        <tbogendoerfer@suse.de>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lan78xx: Don't reset the interface on open
Thread-Topic: [PATCH] lan78xx: Don't reset the interface on open
Thread-Index: AQHT0MYPbZtiT4HsgkyLpriGu/5z6qP6CNcQ
Date: Tue, 10 Apr 2018 14:16:23 +0000
Message-ID: <CE371C1263339941885964188A0225FA3A3F82@CHN-SV-EXMX03.mchp-main.com>
References: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
In-Reply-To: <1523362705-30032-1-git-send-email-phil@raspberrypi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.7]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Phil, for identifying the issues.

> -	ret = lan78xx_reset(dev);
> -	if (ret < 0)
> -		goto done;
> -
>  	phy_start(net->phydev);
> 
>  	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
> --

You may need to start the interrupts before "phy_start" instead of suppressing call to "lan78xx_reset".

+             if (dev->domain_data.phyirq > 0)
+                             phy_start_interrupts(dev->net->phydev);

- Nisar

