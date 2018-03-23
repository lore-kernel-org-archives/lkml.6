Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521817310-2-12598196273061289450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817309; b=Bn2E3PxFvTCVTCqMfyvEPY8nOsE+r69pcfaqJyxoB78H1Oa
    NGGjqqL6pDKjyWrUeLzDKb6DZPdKP1s7K9pCRpwkyefUzwiJXFlFdjgPSux3M2UW
    iKpajhGGR3wcAO7ymrC5BJUJVGD1V3RcjJZLfzp3lUxTSlZeXYU371dMFBGA30Yr
    DIpxJXZuJWFTWeIEgmixgg8B5cePJrc2CWW2789OOoNMqaceITt8vO/RnKBOar0e
    AT3zCmU7ud7QKtyxyCuYNiwrsDBPgz5qkwjmWu6eix9z6ZNS5iPbf/AnTW5ihmDL
    Ww3TLWELt9mrXAswIApUuLw+nojcjmkyFYNGHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521817309; bh=XsYrDCQBPnJeoXe6zn91kwNmYh
    W47IbBKldlx5+k7rU=; b=cDpKBgZZtOgSHc3u27QsLWdsZ9cfsXiWZJ9HP6DYpo
    sYPrQLuFg8V4lSz0TOz2MAho350rey64K4T9Dau+pDFikbKsmshLv8uvMvYee6Xb
    lOikpZUxqtX/WLo3zk1HuETVWgw6THITe8ToSzfBfG0GaU8kpqHL2gHf1420BR+D
    nH4wXUFz3ucKnDTHxxldb6/dTjOKMFYFNcLyqtfUEWgd4m4oBk9MBHOpo2Vd1Zr+
    uJhs8icwYDaJcX1rMb9bouvI1/cDkVTSd4i58yMTHlTrflybUARssmVMpPIoDo5z
    ie9RVUAy5pLrmE9U6Ab+7dUa/bkRUz/Wup7g2PvMZ9Iw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HcqWoZxJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QubnIsCS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HcqWoZxJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QubnIsCS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCWPBr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 11:01:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34812 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeCWPBq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 11:01:46 -0400
X-Google-Smtp-Source: AG47ELsb2sS2u3wvqRu0hI7R/0VaFSK10puyr4ljCvt3eyGrccMMJ3LMVLqk0yEZ8M4WL5YDH+5IpQ==
Date: Fri, 23 Mar 2018 08:01:41 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/97] 4.4.124-stable review
Message-ID: <20180323150141.GA13338@localhost>
References: <20180323094157.535925724@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 10:53:47AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.124 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:34 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

Couple small conflicts from Qualcomm's changes but nothing major, I'm
sure kernel/common will have none.

No initial issues in general usage or dmesg.

Thanks!
Nathan
