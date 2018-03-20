Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716958-1521531795-2-10339958301129110360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521531795; b=RAS9ePWVC4qWYQO9oaZv+Lq+6VDiJ1JAuimFVw+pxoV2boh
    ia97MqAnViPPkuI5/46E2uQQEa9s9GyrXZuOkcwCJ3SKObdLwOHlZQE+jVn8vsVO
    IlZLL+vw0hTZYHRjEdk1wp1M107hIEs7YxSdktsHOa65utufYHpJzAa7Lj4nWWL3
    pwiSRXY8TUAAHMXdkbxQu+/qwxNLEwGfCtxl9ZMB4WHp/pHgx0AyDPYx9exDoCaU
    sGqDNz6ZID6ZXZVlVHvc4MW6Ylfx4uj2rTxmJzRPys+Fgw57Huse3ezIEceUsuJ2
    oiYTA4aUk/zJp0VKVNTMdtZzktdYmmtvzFTH90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521531795; bh=P5cJOG2RD9xegNXLS6cMdEBLEi
    WyCXHTIZD759+xb7Q=; b=jFnKaLg6KDVpHA1eDYTPpeJdtU3URLCo7rM9Ow8ltu
    /czwciNFMwGrabMgNtoqxant2McLlTO/9KHnXs5b7AQnAMrpqw49JNfcIPv2wDP1
    pF99kxfKT7zwxVbxXMg0aR7knuCDJOv6T2uPt5uTjD9ozlbCwLqZa/O+VXhGsyQj
    jo86UNYj6x4W9M1vPgr2QwFddoO4Fra9cRSdUo7KKS8xCZ9l3K9VSkpNVfw3SzsY
    7WZT2WU/6SmrqQwHm65PHu5XgbaARrv1ir1ckl3n7ZyG8ukcZzbbhnL/rq0cVgMj
    1XYqI7LuKLhtaj2c3Gl+7Pd1ABc8SucKaQo2MJAikpGg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeCTHmo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 03:42:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTHmn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 03:42:43 -0400
Date: Tue, 20 Mar 2018 08:42:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Message-ID: <20180320074241.GB8152@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171854.858515505@linuxfoundation.org>
 <20180319235251.ui2gf3nlg2icbbdx@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319235251.ui2gf3nlg2icbbdx@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 07:52:51AM +0800, Dan Rue wrote:
> On Mon, Mar 19, 2018 at 07:05:21PM +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Roger Quadros <rogerq@ti.com>
> > 
> > 
> > [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
> > 
> > It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
> > is in use then there are random chances that the usb_otg_ss module
> > will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
> > 
> > Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
> > fixes this issue.
> > 
> > We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
> > issue or not so don't add this flag for those instances.
> > 
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This fails to build for me on arm32 with default config.
> 
> #
> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> #
> #
> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> #
> ../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
>   .flags  = HWMOD_CLKDM_NOAUTO,
>             ^
> ../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
> make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
> make[2]: Target '__build' not remade because of errors.
> /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
> make[1]: *** [arch/arm/mach-omap2] Error 2
> make[1]: Target '_all' not remade because of errors.
> Makefile:152: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> make: Target '_all' not remade because of errors.

I've dropped the patch that caused this problem now, will push out a
-rc2 in a few minutes, thanks.

greg k-h
