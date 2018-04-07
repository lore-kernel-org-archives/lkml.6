Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3262455-1523081433-2-9608377684932702600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523081433; b=CD1OcxJAzGIjkq/o4x3K4CmTXvVjUHJtvyEZiCiJQVERHExufL
    QKVNRqnSDXxVExzu/Nzroj5YYUNWNmkjaGDEkWdJeFacBppMsXhmO2UjJBH1U7jA
    xZw6cnAMRkPM7x3TYFQM2MolGKYax7Fclejeok0lft+12uZ1z8qzyl1Bwn/SW5lh
    B6UI8A3EnJsho68GtBoCQezaeS1FKXahxetl4/X5btqWXW4OGJtUyJlgzzHym/B4
    15R9nl+UR2E3FK7jaOB9l7jtXH1eaGhmZCkfJY5ZdH9f3+3i8F3AfqsgYx4DK/wr
    zo5WyoWnXiK+DzS4jrxbjOYR6xi264udwnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523081433; bh=Tu36KkFYb/9KnYwHdGpJmuQsIt+DJ9
    Fcl5hf/aGb8i4=; b=CnJX/RerZt2z3Y+3J2cS3WVsJvMydHMh0XzYorF/WkP17s
    BjkVNRPPnb2RBMShqzygIvZQwxr+qN+9UtHNcZDboJFXzrPYKUQSAq0YCeqOVS63
    ITAGPtsCPS1zvDrSNAgaemFXG0FaXxNmitXUhxaV0Ug+dU6HTLN/PKdj8IvdUdTL
    D12YKVYeT4zhOrmIub0y+C2xM4WurG0sKK+DGRQFj8QVaGBBDFNX0LVJr5Hl1FpU
    h4io/O6m7NaBc+ISdnTIa3GGO3w37uq9mCFUTAiofk28jVxgo6/N/nPaW578Z3Oa
    +LXI3j3nKBIKrmN6ha12fivhGPjwgSSI8uKdgqOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcoOHTDbUBZpiYyJGuqXVgwZvOy1re3BzgjHbfIDS8STlyv8fcTTw/fVmHr0+K/TykTbO0zgbjIO3TMraNVxCgvyxRrbR6qWydkEm9xZPPMhGtiMaX8
    k3MbmbcmiULIkPmzV7coRFHV0LUTQcb9FRnF9fd1Kb2DiRMoRHVm84vKCBh5V2ElrveA62vQ4vg/EZtc83XGp18BuKUbkUxjkJ7XgXpLAW4svVNoqm1VytHu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=n7nexZTBlz8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=C7YwrlYgIYjDNy0VuqwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeDGGKb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 02:10:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDGGKb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 02:10:31 -0400
Date: Sat, 7 Apr 2018 08:10:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/72] 4.15.16-stable review
Message-ID: <20180407061029.GD18744@kroah.com>
References: <20180406084349.367583460@linuxfoundation.org>
 <20180406202010.GA3221@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406202010.GA3221@calabresa>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 05:20:12PM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Apr 06, 2018 at 03:23:35PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.16 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr  8 08:43:10 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.16-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Merged with bionic, built successfully on amd64, i386, s390x, armhf and
> ppc64el. I have some problems with the arm64 cross toolchain, not related to
> the kernel, so builds for arm64 have been failing. So I can report the status
> for that right now.
> 
> Boot tested on ppc64el on a Unicamp minicloud VM.
> 
> Using it without any problems on my Thinkpad X200 with the amd64 kernel.

Great, thanks for testing and letting me know.

greg k-h
