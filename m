Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414317-1521877614-2-8134711403702249645
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
    t=1521877613; b=kO8cOx245SBs/s51n8rE67ukt9m/Bve6aWJiVT99IllOQ4G
    diiTjFu9tGDuqqyusu4lVofgKvUOMU9Bno1hj3QA5qc101QL8p2Y+PLaKyvKqC3o
    iV+hMV3ryVIov49nPFU5cYCvJb0AjaUlaq6/j5TIikXnLBjqpFXD4CI9w7ABfzrT
    Tdoj+RBADxf0RZ75MNoVkb9o/DT7/GeniNhshflDtBcOQOrDmuqg/DYRfoOMO7MU
    kEtHQyl+5Xh8YiHGUeGXPFVm1NNRlTtlhYrBuU2SdHoEl36WvXi9OOa7tD3WWoqj
    bQprNUaoh8R2o+l7DtJ9MX2aWNPgLVeA+PX9ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521877613; bh=y4xehUTzO7DYL3ztHjo9v22tDZ
    AgjVj+an+7rH2OFVY=; b=ZjP/RIFIAWtR5u3mEOXqLXIE0mp8JnFk6ovT9TgvaO
    GToEohDZwKQyp9oPLDfrNcuPxv6AcYTWLpGF3l5zCyYRgNLFxFdaXIvpQ+aoTsP8
    2Ya7jO1UKvH2llHa3IkIyxlhFdIS6USscaQgfG9O247s/129awbm3IZjwnExTBfK
    bUGii6qUVgMyTGrZ7+FHeyHUmfjGe5NOLXYMszqfNet4+xbbx61YAjNzcGo45Qlb
    POPEVWvKi3etYOE+Q1F5EgCXlMQ9Qrk06lI6bielM4vComHtN3dI6WgX5Wjz3SoV
    Tj8/Ydz+pNzj4++Ez3QRs7prMr/5jga+D5LzBJ1fcvqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1752195AbeCXHqt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 03:46:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeCXHqs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 03:46:48 -0400
Date: Sat, 24 Mar 2018 08:46:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
Message-ID: <20180324074644.GA27433@kroah.com>
References: <20180323094248.117679641@linuxfoundation.org>
 <7ab0b0c8-8943-8db2-8de9-fe2a77e820c2@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab0b0c8-8943-8db2-8de9-fe2a77e820c2@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 02:43:55PM -0600, Shuah Khan wrote:
> On 03/23/2018 03:54 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.102 release.
> > There are 47 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 25 09:42:36 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.102-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
