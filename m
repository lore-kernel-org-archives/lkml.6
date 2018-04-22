Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3472924-1524429858-2-13824665096613768572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524429857; b=KDvDjwCfWOvqcWbtf53T55pmGIdofFPNapegg95fv3t1HpGUFk
    5bRiq92PrMgSTCNtfU6QkwzjTPMEZBXgk42Kb53/KP9p1aY3jLdfrVFMp5wX832M
    cwjRdk64NaCt+J8VwFQRdKV90Udly9DxypdfR8Nv0nO/VqpTe98laHCtpfj40caT
    rO/x4Zlc3pWoX6oIEyoBiGH6qAuao9LtV/dUbOmcjwCf4u7CAvnHfck2iozjy9Sw
    vUan9tuIzdRaYalJKTRn3JJPIc7nHqP5J6z03yZD8jC1+LUeM7R0cMuy/2hVRImT
    /hpELBhBZdFh81uV86Avo4Ak4ffKqIERM18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524429857; bh=2nDCav5W7INaThlzDks5dxdn0LZvx2
    kDBsQwPTeqhto=; b=sKmiOqXOFWhz6Oa+poVeyLNcZ2bvo3akcUqPHr/BaxHLBD
    NxUUpqzmhKP/iPwRdG7PRjseUFlX4pQm9PQ8ifOjUOGfHb9ZbOG1FN8wmXZaZxOh
    TRa+48eI5ik3U4EO6E5++UzN0H8j8kl+WRUrrv0qmiiZYmGRgwkzab0a/UhrPJAX
    UGLCSEdFEJrIUQHcjAZ1ZXNwwiRLDIZIWosTHiVMXqXfgLJrW8gaPXqHdhkE55Kv
    WJPAgP8T8Bgr9uWejNur1ci+oaWDmCGusA3FjCmBnUVjKrYjkPgPMRm1FACLDnx+
    eAPplFJfgBFrU2uklRfwv4cBoJdq4U3P6qhq4UpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ajM+uVLZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZEs+kKdd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ajM+uVLZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZEs+kKdd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLhpobmgvxLpt+bRDtje/9MWY5Wh11K6ZRtrm9XWKAiYlOI4eYacr9S5Wjeh1bfm5IwZ7OBfD6IISh3usZHYx0jJ9GwXS7Oh7BhYfu33gis4Dv15pUa9
    oCrixUiL9nhfUxEke9M+ib4bDX0m1Dm0/1OifxSzX8/V9DX9rNkr7BUqmT9Dj+qeW70j6WYgPPQUlqFZEUUr/4rXi8R6qFsTNkg54yIG3vjYKmrLw3UVXOpS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=BKw5nfpAfisA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=0U3uj4fIb99X-BVFlicA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDVUoN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 16:44:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37708 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbeDVUoM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 16:44:12 -0400
X-Google-Smtp-Source: AB8JxZrrOPYPZw1987TdwYiRHWQDACOl8WZYfypFCqvAXrNe3RrtTHW+qfrmMdYoIJndTCczlsLTvA==
Date: Sun, 22 Apr 2018 13:44:07 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
Message-ID: <20180422204407.GB2319@flashbox>
References: <20180422135304.577223025@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:52:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.129 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No initial issues in general usage or dmesg; all images build clean with
GCC 4.9.4, GCC 7.3.0, Clang 5.0, Clang 6.0, and Clang 7.0.

Thanks!
Nathan
