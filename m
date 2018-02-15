Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-941211-1518680639-2-6387904120107405909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518680639; b=Xsx8aI2Lefdi+dszHnTMpaxxIRn8xLWTMyNNWXb0k+nsIhF
    xsutzNBcHiSsfZ73ZNX4rDEm4clfqBrAO1cHqag1T49F2yQLTDbt94wA4GR36/OH
    hrYAieDdFbtmUzJ2eSZn10LgJEbaIMR0zFwF/3xrbiGZ1V8eUTI1E5mFHS84mkD7
    eU4ggrTrIhSoHvIOJW7WsM0UaWutAg6sFGhp725YYv96FUuqSHO66qRlVw+kQnpd
    lKwqgNaYBaiXOylpGEJFkPf0kuvhoGvNP2YkdF0TF6bXY6qCG4/0aNsE6Oa20V/v
    mlslY3VsMUciBPAxkTnvVRVm2GDBIeDLXKXbHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518680639; bh=9m+02/dNeaQEvnSOM8esj2Lx99AsNiZQl2Qd+NCf8xQ=; b=S
    218OZl70mgV0HM/z7wpPBKwWbVJXibd9pBC/G7vm7r6sQL9i/3IAkhu+zi6AMczf
    nxWv6BYY8HgKwixIv+cgm2KLYuQb4BC2YX1IgUj/5IZn+NsNY0K/9Jcm1oO8lHR3
    ytl2yeGTuwC+qrMZScRBTLYtRmH02xugVZzNWG2lzmoTGFxOYtAPD6auQL0n0FoH
    GJdjv2iJ8WwKgtjWTUbvjGi3tT7TzrprPW0aO6CC6pWaSr51K8AlUpnqoRVQvZ07
    Zib9EQmt+8lhj9/f3Rx3IzE0HZ7vH+UDAVpRWbWz2xeIp8o16eEH4UdqAv2Q3cFX
    6N7b/Ct7IGOyeXtoUBS4A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=nu1HQ7mf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=nu1HQ7mf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbeBOHnq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 02:43:46 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:64309 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbeBOHno (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 02:43:44 -0500
Subject: Re: [PATCH 0/4] usb: dwc3: Add dual-role support using OTG core
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1516626688-2302-1-git-send-email-rogerq@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <5eec2d8e-5ce5-491c-706b-c8aa0b9fdd6a@ti.com>
Date: Thu, 15 Feb 2018 09:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516626688-2302-1-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,

On 22/01/18 15:11, Roger Quadros wrote:
> Hi Felipe,
> 
> Some platforms (e.g. TI's AM437x) don't have USB ID pin state available
> over GPIO/extcon but need to rely on the DWC3 core's OTG block to
> get the ID pin state instead.
> 
> This series implements simple dual-role functionality using DWC3's OTG block.
> Debugfs 'mode' override is also functional so user can switch
> between "otg", "host" or "device" modes for debug.
> 
> Although system suspend/resume isn't working yet in mainline for AM437x,
> I've tested this series for system suspend/resume using a local tree.

Any comments on this series?

> 
> This series depends on [1] and [2]
> 
> [1] https://www.mail-archive.com/linux-usb@vger.kernel.org/msg98771.html
> 
> [2] https://www.mail-archive.com/linux-usb@vger.kernel.org/msg98848.html
> 
> Roger Quadros (4):
>   usb: dwc3: prevent setting PRTCAP to OTG from debugfs
>   usb: dwc3: core.h: add some register definitions
>   usb: dwc3: add dual role support using OTG block
>   ARM: dts: am43xx: Enable dual-role mode for USB1
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts  |   2 +-
>  arch/arm/boot/dts/am437x-sk-evm.dts  |   2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts |   2 +-
>  drivers/usb/dwc3/core.c              |  70 ++++-
>  drivers/usb/dwc3/core.h              | 111 ++++++++
>  drivers/usb/dwc3/drd.c               | 492 +++++++++++++++++++++++++++++++++--
>  6 files changed, 650 insertions(+), 29 deletions(-)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
