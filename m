Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727622-1518035586-2-5006154799565494940
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
    t=1518035586; b=T5JcmpFdzriNZ7rBtUYjjvvroGoUi991zoJjTtf/NceUA/P
    ctPGvz/1t8Aqr3tzyNv29qCQuLsLw6bptVyE11c34qch4PLtZ1BB7mVE86ysvl0o
    slabY+Npc6hoFcYIVaV3glWhom27ljKOFFTETZpJ6zuaUuzMgtsRGJIf5vhDs7AC
    McEh8rD0r8wRAaH5YmG9wVXX6QFEbfvIxTPV2x7LuFjGcd3LZSf8MVnWX01kWSs8
    BOxI2Tc36ea5OZL2HmvjQgmfslOp6uY2ZcMp9+EIL48/Br052YQq6HAB21dVhxtj
    mHSWYXh1UoDkzslOBYZxaX4HHFD1EFkp+TO02yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518035586; bh=qq+TTPcXAmolOvq00KHf5+463+
    xa4NCHZOI25QqSs1A=; b=lF55nS+to7HWrMQKS8X2uTevoRuk79beqpOluLgseq
    vHEDaipM4hyg6mUxUM7t06VpOzVcGuNO7yT1ziiX4Zrhb8FyBDqjVVtzJHMQJ+Ls
    EuDKio0VBVyxPxieaYORJHqnJ0DEOhmWNkzyYY2dLk0krnRppCKRe2lPAEuROn8P
    gssJeFDC4l681Qp53/HEPcNvPE1ibiEYBpmlHzs/v/gGCGA6Qvl1YQHqijHCdjEF
    9IUewHdVeAc0Jx2Zy3dEHf+ihRwxwfuqoYZbiXNfCGhETPbZBK0KzHJTTFu7ikqG
    rpDwXwk5Fd1PnItdHnVshCPr+9/klKMWK5ovBS4g2uWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=vDfC7uvu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=vDfC7uvu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeBGUcv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 15:32:51 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:40606 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeBGUci (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Feb 2018 15:32:38 -0500
Date: Wed, 7 Feb 2018 14:32:20 -0600
From: Bin Liu <b-liu@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Andreas Kemnade <andreas@kemnade.info>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180207203220.GB3992@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        linux-omap@vger.kernel.org
References: <20180127083403.928-1-andreas@kemnade.info>
 <20180206184725.GD21573@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180206184725.GD21573@atomide.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 10:47:25AM -0800, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [180127 08:34]:
> > On dm3730 there are enumeration problems after resume.
> > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > bit is not set. If it was set before suspend (because it
> > was enabled via musb_pullup()), it is set in
> > musb_restore_context() so the pullup is enabled. But then
> > musb_start() is called which overwrites MUSB_POWER and
> > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > enabled and the device is not enumerated.
> 
> I just gave this patch a quick try and things seem to behave
> for me from PM point of view:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing it.

Regards,
-Bin.
