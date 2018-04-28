Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1322948-1524892040-2-17156855776310380861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524892039; b=NVKQq9bBNxxtvh6bfJudl/GoFLjieGSHqGv1NQLaWr4pEPL7vn
    QYApoQZ1dVVA5nMT+EDekGIp0aCVJPf5BHbeZLVAy3JDTqPXzKDBWRRKxNVdxcWw
    dysuf1IVSCYwerphVFjBwX17YhrtDanOHGv3XLJETBYq/haDloR1YdBy5o/BCwLO
    iJB30iN4VKyldZxUkIcDjX/FUOOHdLkKDAmbAfs6WezFEbYnnXs7VMD2DnnJJuAi
    0Lf4Jo8BJ8aHgYsjOlGi6cIl0l1bgUi/aG1pxC3AFLEmCPrGj+DCzXb0L/QHBdwi
    nJESTgG6se8oB3VJ+naODFW2Y+pScIqwQsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524892039; bh=WWJ79S02l+bKRqT2L6lDBn6w/ASVM7
    ildYsxJXIgOL8=; b=m9ArPwLMMAxxUMiDf+FZBBdHvfNUZY/GqAJbe++9eX9PRF
    mvRC3Q3dAVG4mphoTP1jv28fBDgHMF4zOXKEZ9HcczQOLXHD/4VgoMSV4Sj7dJVU
    TLZaZBSTDG+/1TVLUbdQv/iz7dr8yzyojZ7HyerSrsZGWNMTp25yYyLr75cJ+NM4
    ib+hghlswrwQyCG9mP+mzwEV6gKGoYP8oeDst1eSjVU+x3imYQOfgHx08k4fRpLg
    wMqNrKIuhu/sXyTjGhSrOMkGvbRk7NjCPcWow21nO1oqAd/bHUQm/MzaXk1d3IqO
    NB9GhSF/94QXqial4Wm4NsSbMqy3bZVNCWMi/f+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfB0/fD/JUt33m7KcCbZX9ZNcUDuELVAz4Mdp5OHpx8wplqy4KIjnjRsSIv3Mk3FRoRnbZhrGhSnnU3T+HEbFzrDstBXS4886ReShq0ZXkiDksMdbOJL6
    nSCZgVjGwFJT2axTeHiwnZPmon4vc88cPkytBdud/PZMPlTBNCdDox/RLuFYqhJW4ut5Ko7pQ0qItZ2f5NciQyeyGgPb8r/oF9mPzFjqqKrVt1aMBwrk/MNG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=D2BsPUkyXeIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=PLIrmOfGtwyFpCt5ya8A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeD1FHC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 01:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbeD1FHA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 01:07:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7D921911
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 07:06:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/80] 4.14.38-stable review
Message-ID: <20180428050650.GG29422@kroah.com>
References: <20180427135732.928644313@linuxfoundation.org>
 <20180427193327.GA15456@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427193327.GA15456@flashbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 12:33:27PM -0700, Nathan Chancellor wrote:
> On Fri, Apr 27, 2018 at 03:57:53PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.38 release.
> > There are 80 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr 29 13:57:13 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.38-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and installed on my Raspberry Pi 3.
> 
> No initial issues noticed in dmesg or general usage.

Thanks for testing this, and 4.4, and letting me know.

greg k-h
