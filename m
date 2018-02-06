Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1871329-1517942793-2-14928660734673956483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517942793; b=Z6/AxMKbwkBMVZtJYSiJo5PjtTyXLYchHidKOgnzW3A26cv
    AxIO2Y8lfGrKRFTGVUp3EwGSugw1nnPidn/G3efuX3JaWR0df6rdvbPrftWjuYhB
    NymxqsBBL8NSBzdB3aIjYN8sRBldWqvQQO+JTP2JndnYH6x7gHkwVu6JPI+GawxH
    SHR1mKY5ErmIXZXZSXOxyjGbemiGkMTkv9ThQosO+SjpmfW2iNW6P0aBj0g5vmG5
    MzfuopgwlsY8zk0fMMtzUfHyUsAqKVgT8fm3dGdy3du3vi7QRYCAsy9VVeL2rCtD
    Nog2dd6N/ry+dMTYocgfsm5WN8f5fGuFSXpzqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517942793; bh=YSqSxCAtEeqW3tVnqBMEmwI/Vg
    TiTRmAfnDZqlCh+SI=; b=OSxE1faGYMK6xW4yy811bAlRiuIrij8oCnf8Y03bT5
    h0Tmyvdw6s/vjGRBxq97HIQTxSwdWRs5isgROaivZ3c+rQY5ETJDZ42L0n/ZTIwq
    KT2F/o5EQCDaZOrxLPEfCLbsEEDOeJTUfVYM+zl8RRTwrF+YYq5EpiYhMBicXsn0
    9nXFO/5zicAZPG2gvnQXBBrHYW+XsfjtpEEdnObpPvavG8PfgO4lnVYIiY/z7eCm
    2AWuIhjaU5KUb4c4h3M/GMqeM3WW5V5MB6syryQCqWF+VgKpGyZSxmBVA4pgikqH
    rRXlasvvfumcjid5AIRAcon8NxmtMFjk2gBMPQTbccrA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=iZFNT4rs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=iZFNT4rs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeBFSq2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 13:46:28 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:18568 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeBFSq1 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 13:46:27 -0500
Date: Tue, 6 Feb 2018 12:46:05 -0600
From: Bin Liu <b-liu@ti.com>
To: Andreas Kemnade <andreas@kemnade.info>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180206184605.GA3992@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Andreas Kemnade <andreas@kemnade.info>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
References: <20180127083403.928-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180127083403.928-1-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Sat, Jan 27, 2018 at 09:34:03AM +0100, Andreas Kemnade wrote:
> On dm3730 there are enumeration problems after resume.
> Investigation led to the cause that the MUSB_POWER_SOFTCONN
> bit is not set. If it was set before suspend (because it
> was enabled via musb_pullup()), it is set in
> musb_restore_context() so the pullup is enabled. But then
> musb_start() is called which overwrites MUSB_POWER and
> therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> enabled and the device is not enumerated.
 
Do you see the issue with the v4.15?

> So let's do a subset of what musb_start() does
> in the same way as musb_suspend() does it. Platform-specific
> stuff it still called as there might be some phy-related stuff
> which needs to be enabled.
> Also interrupts are enabled, as it was the original idea
> of calling musb_start() in musb_resume() according to
> Commit 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend,
> enable them on resume")

The logic in the fix makes sense, and I do see the same problem with
AM335x on v4.9 kernel, but it doesn't happen on v4.15. I haven't checked
if there is anything after musb_start() which sets MUSB_POWER_SOFTCON
bit.

Regards,
-Bin.
