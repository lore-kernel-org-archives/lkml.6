Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1982828-1522231418-2-2259828332726436690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522231416; b=kO2tLMT9fYxn5Oq9dXke+bCt7K6DVYFLyOxrnQF3xNb89+c
    0NB3yp6izAM77ltNljkzKav7BjJXmCc3ue1NvCgBajis9Dx+ArjEe88kdmVidfEK
    sjOh8JRFt1MoAeFhx4PJKmYhYvXJrazvYg8n0Vcff91M3el8csF+Zz3PC5Bxc62X
    IjYPQvJ5ijsE7I742Rse7w9kJU/MJ1P8+27lZ6uzEgWyxNg67CZIX6HDrQHAU5Du
    mBcg7klE+X/XRJcDxUqDqa5obGTKpx4IeZ2/TULhldbE+4WoTu0qqvwxurss06fj
    aMZN8CB1XHkH3y1QnP7q46mYh2VNyWOfA2+wA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522231416; bh=YTWQCKIA1N1wq7u51+xjb8u7Nb
    mHcmHYq6LBK73RvIM=; b=cR1e4oNYr1158nWt3+qi20lcZNDuUIvx0rl1YKh5Ss
    UrjaQ2HflG22oIo0jRVPrCZZe2siK5eThKl9z6lMF+/J4Kb+0U+IjLvub2A5OYss
    8Ty56B6NSv7e4AjyaH34HivVhkRM8fxCG+FamtX+ksQxMlIS3Zcon1fDOt7Ide7F
    W82ejp3t11oqdGp5NefM4F1S3cAZrUl5b3m2ya1kuT9eiVoAhayJkn7toTmjTdM8
    btCiP868jEhxEanY6mJgDuDCRluuX6lN2ubvBCaLpQsTb2XmPKDarugTpLZh0/yD
    k+G8DzII1zcqU23iuInCTwGYowaCTdswl2hUU8/XP77Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKfgKlfboZ0nPPeSa/8DZsMDnyvsa40GrcoSeCYmWi62sS52hRGwOuO/ewzlxV03cVJPTKE8ZxH6bYYlN4F+hQ/4zvJFqGIOH20lyFdRJY9waUX/ynk+
    dRU4xtvsSea6++g2TZ4DHVEj6HxbB/+ZQD2CPQlEJHjAkh8qiARbjhpuASfZRGxBWfT1qfEPWXmJkd7gnJha+/idr4lu+cTAiC2Qhvbi/BQQuXwtcqnsveCH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=y98JahJlUwsA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=DnoLg5nJ210BuBmKe-0A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeC1KDd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 06:03:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeC1KDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 06:03:33 -0400
Date: Wed, 28 Mar 2018 12:03:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Message-ID: <20180328100329.GA29527@kroah.com>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327202120.hwibyvaiovg6jage@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327202120.hwibyvaiovg6jage@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:21:20PM -0500, Dan Rue wrote:
> On Tue, Mar 27, 2018 at 06:27:04PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.125 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> 
> ...
> 
> > Toshi Kani <toshi.kani@hpe.com>
> >     mm/vmalloc: add interfaces to free unmapped page table
> 
> Fails to build on 4.4/arm64 due to
> 
>     f2ef4616ccfd ("mm/vmalloc: add interfaces to free unmapped page table")
> 
> See my reply to the patch for specifics,

Should now be fixed, thanks.

greg k-h
