Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2297825-1520016769-2-16090766396292829494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520016769; b=hRTx0JWYH+Y7GglFqCCFzygSCaRj6dgNgtRRihE5LWcbpKj
    8UXdFmc4AohnZr8FwY4g1dHqoIAHu3LuFjgJK4b3INRBkZ8mAPa/3iXuwz2lTtux
    weDDM13P24pu/3x4TM4n5vUdBUGWQUrsr+eIkmksQVOAFu9M3Gc71Ze5BwJYGLqx
    ebQqgs8pPhVQoh6AtUv2R4EZtx6+PhLjQxu36PZK5waAh2pIhEzarCeiY9Vd1efb
    8dzCYMekQARg9WqfOR6xvj4mfhT1BwD1X2nNrVwz10gEXSAEryIMmTyYXX7OM2Y3
    WGpSiC2b252F6QtKhbDlPN6rEMBYywvVl2CkopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520016769; bh=3eHIT0v
    vndWEx3XeksgvbR5/FlIQH4VkyjJAgBsdsiQ=; b=Rpzhy0ye+XCE1m9ddopu4N0
    zOpbnGDNak1A4RRzaQxcIkW1ijWZkwstnUons3rnd1OFuRqVfjdPiQzcMZtEcIIZ
    WWxlQ7TEmcXclffIYmriY6ZVmq+LMw3bbRs+TW5LrSM6mP5x8+bPbbjR0Gm/QnTa
    DoBp9fBS0l+iE5LJdmdjwLxIzucfdF4z0BFcB1Jjyk791pyrhGSsqwSyHg4D+FGv
    hjXVbe7iO0MBU0cwY3x/lDJsUcxq60Iy0xIr84nCOdAySyBG7SHiyZQ68pBvuwC5
    r1YbcMLmQI4Q2TaaNNC8k6hJZYqasbQ1EC9LUgcZ3YvidiipwPOpyzOeArLGA2g=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947513AbeCBSwq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:52:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947511AbeCBSwp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:52:45 -0500
Date: Fri, 2 Mar 2018 19:52:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
Message-ID: <20180302185244.GA16331@kroah.com>
References: <20180302084503.856536800@linuxfoundation.org>
 <CA+G9fYsbD5bU8-8X8g8x-cPc95PZbA+-_TQ7xzEwxQ1A3PPMtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsbD5bU8-8X8g8x-cPc95PZbA+-_TQ7xzEwxQ1A3PPMtA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:48:49PM +0530, Naresh Kamboju wrote:
> On 2 March 2018 at 14:20, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.14.24 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.24-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> NOTE:
> dragonboard-410c and qemu-system-x86_64 are added to testing device pool.
> ignore boot failures 3 on dragonboard-410c are due to local LAVA setup.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.14.24-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.14.y
> git commit: 0ae11358b0bdffc782ee655fd103b95cbcafb899
> git describe: v4.14.23-116-g0ae11358b0bd
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.23-116-g0ae11358b0bd
> 
> 
> No regressions (compared to build v4.14.23)

Great, thanks for testing these three and letting me know.

greg k-h
