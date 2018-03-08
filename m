Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2448136-1520529955-2-3429719183935850905
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
    t=1520529955; b=rrQ9RVBGQo8LdMuumb/QHfbzwkNxM4MF1StLOGdPVmlpqzV
    UsLpgfLGnyguMkkRfUoE8npgLZd5LZzESriiePLwqNr0cxyq5dYQRrC2A+lVFhnW
    H4esfmC8E6Tuac8Kfz6si8O9soI8LYjbrjVrRqE27ljr1n/tSd7AbetSvzx/81ae
    6Bn5Oda3769rUiL2YQrUsRAwEVUKP+lYKwrsyHDsP4wGsj2E26HndStI613IYcQe
    89DgAMV36+PVFyyP4bkJSHlFFrXdnJAKIyY6kN96vj8wb1pOHItRYRaTqC0nw4k6
    mecP7aYVxRWT+M5jihfo4KjcEGg77Jj2J6VF7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520529955; bh=WT/oxW3PajPcgJ+VuO/vEebya3
    bRIYaqrJM68CCSCCc=; b=bircRjXRzF4wEPa2wUn2g7doteBR0XSe4P27XazLwl
    R7bnepD/3/5l5VyChrfc9Kuic/ZtM33cCgCqql+xVcm32djynf28D8qI1PTa9xuq
    SMKiDgFUVl1ueb2rYGCnbRVUacgq/xzn365PAWvDX6kg0QiGRj7zt3D0y5KBygQx
    qNmHqcthZnsYSzE6RMcHXjrzrPhBWKQWsYVQCo970RwA2bODKuSUr1oeq7i2GLTo
    sQNGuKElYxM335kZsHur9FAsev/pdCGnZrsUqSzzCknHwQdQeeo5vyd6NOdBmyoD
    wea4TG5EQuIvHRqBnO8XYARbuyX9AZV//agkyidNtngQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeCHRZy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:25:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeCHRZx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 12:25:53 -0500
Date: Thu, 8 Mar 2018 09:25:54 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308172554.GA22996@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <48f394a6-91c6-0d1c-14b7-d277ae70fadf@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f394a6-91c6-0d1c-14b7-d277ae70fadf@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 04:56:41PM -0700, Shuah Khan wrote:
> On 03/07/2018 12:36 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.8 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing both of these.

greg k-h
