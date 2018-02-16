Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1024438-1518813587-2-6168715513036485663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518813586; b=ZKOH7xdulrYSNsCYEueGAMDtcsARZ5C9ObxsaGkfeOtIFex
    9YpQ5eTkSqn7hpxKuRr6FnoBKsZQjQZ7I3JzyqHVzUFIeH91hnSSpxTsx/ipXx1k
    XBRrlnYo7Hocwj8gXUFyQFi8s5RrS83EJzPA21AxeLvqwKwcFOz914Q4WmFgcy63
    sOQieJYOmgqI1SO/9PhgQCp74yX00BAXToqcp1ETIAU5Aws9OTxMc9XqWSRPXXWZ
    HfyWFMFyCtGVLeUY6iaE2cvZzI4q1Z7660J2J4ThsSD6SIQVX8NS1cs0UpyrSGcp
    yDnkfsX8HBk8lcNgGkRrCXR7D5NCLdeneXG2PKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518813586; bh=IHAzTeMSaHjGaiQ10z59FcZzlF
    JHHxffX7KcOKesnAQ=; b=blk9b0FZHatTVYSCRyqddS/ROiVDIICOMic1NxzyZ3
    jbOzWaW9lPWyjid/88D44+1yvJWJQpH+38lJ8tm/s+5oS8+PHUEPL1Y3Z43H8wbR
    /Jcfte6sgdsgD8FI5nFQ6YTpvS9L2krAW+sRWSAbRJow2hp+U0bdb0zlst2qcAWv
    I5mqLwGjmvAAAfxUes9MoW3+8XTo5egWlJSLV4n2EoqvCVLCSkon0siXGktzrJDa
    flOHTGa/rneV3lOmrSQcsYtBpbG7TNI8oOpkFfW7PRqMGJ+XhREw1iFCgnOxEaGq
    hy51Bf17r8A8xxktyUVvNJ4zpr7ian2/oQD77DzJu8JQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hl7lTPIG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tgr9JB2y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hl7lTPIG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tgr9JB2y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbeBPUj3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 15:39:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37814 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeBPUj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 15:39:26 -0500
X-Google-Smtp-Source: AH8x225gViNbfgjljK69lMKqPRPYFKqy9+pi/fUClIev8KlPnU+WasM/h+gariUXixGw4fIDK+wItA==
Date: Fri, 16 Feb 2018 12:39:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/88] 4.9.82-stable review
Message-ID: <20180216203923.GB31849@roeck-us.net>
References: <20180215151222.437136975@linuxfoundation.org>
 <cb0f5a5e-05ac-c52d-9334-40bbfc87a245@roeck-us.net>
 <20180216192117.GB11682@kroah.com>
 <20180216195456.GB6984@kroah.com>
 <20180216202521.GA18638@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216202521.GA18638@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 09:25:21PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 16, 2018 at 08:54:56PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 16, 2018 at 08:21:17PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Feb 16, 2018 at 06:19:46AM -0800, Guenter Roeck wrote:
> > > > On 02/15/2018 07:16 AM, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.9.82 release.
> > > > > There are 88 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Sat Feb 17 15:11:46 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > Build results:
> > > > 	total: 145 pass: 137 fail: 8
> > > > Failed builds:
> > > > 	arm:allmodconfig
> > > > 	powerpc:defconfig
> > > > 	powerpc:allmodconfig
> > > > 	powerpc:ppc64e_defconfig
> > > > 	powerpc:cell_defconfig
> > > > 	powerpc:maple_defconfig
> > > > 	powerpc:ppc6xx_defconfig
> > > > 	powerpc:mpc83xx_defconfig
> > > > Qemu test results:
> > > > 	total: 126 pass: 119 fail: 7
> > > > Failed tests:
> > > > 	powerpc:mpc8544ds:mpc85xx_defconfig
> > > > 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
> > > > 	powerpc:mac99:ppc64_book3s_defconfig:nosmp
> > > > 	powerpc:mac99:ppc64_book3s_defconfig:smp4
> > > > 	powerpc:pseries:pseries_defconfig
> > > > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
> > > > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp
> > > 
> > > Yeah, powerpc is b0rked :(
> > > 
> > > > Build failures:
> > > > 
> > > > Building arm:allmodconfig ... failed
> > > > --------------
> > > > Error log:
> > > > 
> > > > drivers/clocksource/timer-stm32.c: In function 'stm32_clockevent_init':
> > > > drivers/clocksource/timer-stm32.c:191:2: error: implicit declaration of function 'kfree'
> > > 
> > > Let me go track this one down.
> > 
> > Found this one, should be fixed, might be a while before I can push out
> > an updated tree, I'm on a train right now...
> 
> Now pushed out as -rc2.
> 

I'll run another round of tests tonight and report the results tomorrow
morning. So far my builders only picked up an update in 4.9.y, but not
in 3.18.y or 4.14.y (just in case you forgot to push those).

Guenter
