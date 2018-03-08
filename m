Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341778-1520527779-2-93208433070111200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520527779; b=c8Luns5V0vbtRl3BLFfuz+1hTXAF+/X6lS0wsLJDsIGU8Fj
    CYPZdDHZN5fP9z1Ld4Y1MT1pYIC74vuZXz97GpEqtSP6VHQLQvfmJoy8DwXCFVOa
    DS3WwrtzRsLfJpjSw/q8DQJMf3M5M+2Ixln0892srXn/PuoGvSZPVLKbyvzLIdyc
    LPTqiXrGDUmQCgh2fvSRkC0BEKOsUm3E0XYt5HGRrvgNQsohvmainos7ZiO7UNRz
    PNcR1BJrM+/xYnG8Ps2Us4og/7JDlZwyyF/iN/Cl3fUHvO8eA1QJQVY2awY0ZTgf
    ehuCzJ9GVOcguNK0WaV2nqkEqmpILaPytG+6aXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520527779; bh=b7BT+P1t4ftrW0VPyzeODcbhYS
    ouTm8SNgCSzSV+jMM=; b=H6udiyFUuzlSbEXWMno8cY3l6rxBGl2WAxgo+PV+UU
    r9ZlVucDIzrNffY1OllOJVV1dDDcmQNf6lGhXlMBI/ViuJI7z34Th4jAkOdESgq0
    adI4+i1TEq34eVat2B5EDiFz9FrwTnZ2ZXl1QiKDtG/8SA/LMlJFd8gcQn1p/tNY
    PPbI0RPPwwr3WeR0a75YtOfRLaWFMN/+7NxGJJO8TjBmU5+ppoXADIlUTwQ27vuo
    xnd/ZKjBz40/HPMmeiodbqd4IBNm5CLZZ2xpoOZuRg1rQChhLvq0rLZZPsXHWvPF
    yUaj4x/RLsN8k3roc305UpwG0IXzJF5GHoEA7LM0hIsg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=lR8FH0if x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BJIafoRm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=lR8FH0if x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BJIafoRm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934227AbeCHQtX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:49:23 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:35626 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbeCHQtV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 11:49:21 -0500
X-Google-Smtp-Source: AG47ELtN1HXMvMQ0MpaNVFxr9dtxo9QgM46w8No8+NxUi3Enk4B6irbNTP30ZuAYb+ipv34DjOYeDg==
Date: Thu, 8 Mar 2018 08:49:18 -0800
From: Brian Norris <briannorris@chromium.org>
To: Felipe Balbi <balbi@kernel.org>
Cc: William Wu <william.wu@rock-chips.com>, gregkh@linuxfoundation.org,
        Roger Quadros <rogerq@ti.com>, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        briannorris@google.com, groeck@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        lin.huang@rock-chips.com
Subject: Re: [PATCH] usb: dwc3: core: power on PHYs before initializing core
Message-ID: <20180308164916.GA65031@rodete-desktop-imager.corp.google.com>
References: <1515729616-8639-1-git-send-email-william.wu@rock-chips.com>
 <87ina6vodf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ina6vodf.fsf@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Mar 08, 2018 at 12:43:40PM +0200, Felipe Balbi wrote:
> William Wu <william.wu@rock-chips.com> writes:
> > The dwc3_core_init() gets the PHYs and initializes the PHYs with
> > the usb_phy_init() and phy_init() functions before initializing
> > core, and power on the PHYs after core initialization is done.
> >
> > However, some platforms (e.g. Rockchip RK3399 DWC3 with Type-C
> > USB3 PHY), it needs to do some special operation while power on
> > the Type-C PHY before initializing DWC3 core. It's because that
> > the RK3399 Type-C PHY requires to hold the DWC3 controller in
> > reset state to keep the PIPE power state in P2 while configuring
> > the Type-C PHY, otherwise, it may cause waiting for the PIPE ready
> > timeout. In this case, if we power on the PHYs after the DWC3 core
> > initialization is done, the core will be reset to uninitialized
> > state after power on the PHYs.
> >
> > Fix this by powering on the PHYs before initializing core. And
> > because the GUID register may also be reset in this case, so we
> > need to configure the GUID register after powering on the PHYs.
> >
> > Signed-off-by: William Wu <william.wu@rock-chips.com>
> 
> does this cause any regressions for your boards?

I'm not Roger, but I believe it was determined we don't need this for
the Rockchip systems for which William was originally sending this. At
least not right now. I believe our PHY init problems were mostly
resolved in other ways.

(Although I hear USB is currently pretty broken around suspend/resume
for us on -next. Likely unrelated.)

I guess we never clearly replied stating the above. I hope this isn't
merged anywhere? Or I guess it's no problem to me at the moment, but it
might be needless churn.

Brian
