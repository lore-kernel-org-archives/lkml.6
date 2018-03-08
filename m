Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2938067-1520543943-2-1334102112707536295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520543942; b=UPacEcqtCE41PtlwAQh0E2CJL/nY8Ek1gKmoaZzT7/6jYz/
    24VG0unqRxSPYvd2otePPiWPNTe8xpQnr3QnH5MhUQFTtRsPwSgIXR1WfwADfc+z
    au7ITc3OLYJBudHOVym774FD/Ms61wpsgeiXdQPtxxOmVQ6Hood3n1/EDDg9c7NN
    PxxauQcrrKD7sp2qIZ94bQl1BbeqaA3eN9d9cwnYJc3Gi4tLEksAM3xV8FgYZWr1
    Pk6DcOee/z2YcfVVv+4mD7M96Bw0hoDr2/EVByco0l5O0HWWiY9ezLcOcSDiIEPB
    nJrufixuvamVMIT3QEUEmJ9I5sLvrmR1qiltOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520543942; bh=T1aJlcu1QPMhCsp3rjTnHE/iz8
    b1KrC0azsR7iLbiZc=; b=TsvKUnn4rYrFm+uMDPnO0nZZDsKywCfDIJBWs5s4/C
    3EKm1yx8Gas8CgvIzwk2tWjIvH1Fymi0E0qKonmicKZtlzb8dmHaxs/oQR7hmGI/
    cQK+M4B0cTz4ScplEbXSyBMPws0o1loicdpbAyG6AZbjR3pxeCbFQoM+yhggKyVD
    bNXGIxca/Oi3NJZUrBEDDOq1rpgjhmcGj6GNiHC4FwVlxvqzoV3cpcww5L865aNT
    HzxXR/0FICYlzTK26Nm6whGXT/BOeQnR0+G4SL6Y3kzojHH4OZLxiNaqvV5jqwov
    vfJjeJdjipPUeBT3MF5WDBgZ/vgSV0clqUKEsaSkQ79g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=q9fbYEcF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=q9fbYEcF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeCHVSt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 16:18:49 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:56087 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHVSs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 16:18:48 -0500
Date: Thu, 8 Mar 2018 15:18:46 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Message-ID: <20180308211846.GK14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308204049.29474-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180308204049.29474-1-merlijn@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:40:47PM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload.

Please also mention here that it happens on omap2430 platform.

(omap2430 is the only platform affected by this bug.)

Regards,
-Bin.
