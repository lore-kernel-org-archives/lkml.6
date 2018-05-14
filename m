Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-457733-1526284993-2-15739139654333984575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526284991; b=ihif0yxt/0xPJh/+1545F1BcS5aSs1u7q/tFIgV6JVmpLh8urN
    AkX3aQ7BKFGDgWJ8kTBjEJVLxJPR1Z1MX8Z0EALvtzaJxuDARhgdbRZIPPhavekd
    39DZqE8QhVWl70eLUfJoUWE51iiwl/zq4e1v3JGg7GSAxsgfgUcSscoR61XG6O6G
    275te9lRLeoGdcSsCQo5GaMaZoS99o1SRxT+DN8rUmsxxaPvWIX7CSSn1LlIX7kl
    u8vMFVs5NgHOGMse7/quaW+GwC6UP/5e5mhFz8BgGdSYZOLrS9W8N6+7a3UvAXJ2
    X7Z3veQJ22V/WHfwzplR4yJrmROidItjk/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526284991; bh=Er0aM1WTJ3fM4eEzKDqSLIuUnj7KMy
    UDazJUet4y4yU=; b=Fyxi0e0yw5/xdygGXga0ZE7FxzKm/TjMKmmnhLWg1SDdNk
    QGc5SxJvZb9SfM+Pj/ogWVj07I34MRRPhA0Nxvbf7mWKBVtv/vM7CPIwLPYIcDMe
    TTuFp0Li95oR29GlsIaOZ03EzreY1/c9gwujK0p1Rw5/V/mhG4meARvA+zx76z9i
    UUifjhc0d5l1qFiGf+br4NMlJfH+dXX9ZHFA1QoK5QFgIbGEnFoi+P8yDnOv/rVm
    vIn/y1sHPVoLGIo3ySy9aLL/+zFvDaBgtcFO2saPTGQYwMweJ0aCyqLFDC88+cVS
    JBxD2oGo5/CW1yklD6PIDQ5WjWQokHpnX4dkddyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=SWEJtvvx x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=l7UQxabI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=SWEJtvvx x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=l7UQxabI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGuvgumkpHMDUTKLJx1rr/JUEvDS0eDMTp8t3DGFnOOCmfQkyjmELNAPxU/SSYrcbmcoaT4yAPmVD+5WvT67572uW4HhqqpJvzFdjJO6jJFkmtSDmdnT
    wTQtZ8IP+2FaOPre2FG+B3CUzh9CcRMb4olSCO88D7+CUfomyuNHZ/Wj2+Z+Gt9gNa65QHpOHQNtxfkEtNygRivRSfvuy7DKU3z76TyJ9OqbWxBd1rrWn0Pt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=0U73VwB4dlIA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=pSUcrQnNgr4033KNGBMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENICC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 04:02:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36921 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeENICB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 04:02:01 -0400
X-Google-Smtp-Source: AB8JxZpLhV0pzPkHCI60Yc5qGrJJRIqbDhnYbD9TJZvu4eY88q49H20U2+OxV32/+uVzKzfn5fVgcQ==
Date: Mon, 14 May 2018 01:01:57 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
Message-ID: <20180514080157.GA6589@localhost>
References: <20180514064704.046463679@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 08:48:29AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.109 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:46:49 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed on to my Pixel XL.

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
