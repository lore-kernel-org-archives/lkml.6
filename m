Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523046023-2-13786600382280867478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523046022; b=ty+otTVzwuxxGLi8XnLsakps61IiEbEsbxV27v+A5L1gv3eOD+
    BGNc4ax/w+W7HTSEESU3H5xXtDTbAcwIu8XYXKEzbwsXTDrkPgLK76WuqGL2UwDH
    VHisqOhOzHwnoV3EVpaKYyL/AnwL3Ra9XSRw6hNiAadLzI1yBistisdu/tWQDJQA
    JihZ6ApYLFWpHe5d54g3H9HlHWyaDw1uBYAFtQ3Y4LNP+6cT3DIq5yn97PhIIa14
    Rw0NBqXny/EXpfAFn8GA5wAuijMg8yurTwrjJyIwgqzmMWoPRkeZUPHfWaxyIjmi
    XUDWrtaWbwbIVkFeLTni3QobUt3dVt2A32Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523046022; bh=2Z/98gPcMrveO0kCLbF2yyeRZw2zB9
    Es326SY0NIyIY=; b=RySUNtEqZUlyLwWcUhTOn0Qo+v6C62dt4M9/XD1dKCdSFq
    IRC5S9OCF4fWbjW5fsKTRVMsvrKu6iIVcgscL0/U5dFnv9rb5r7mRGMJvHnOv775
    oVPfEosonCqOgaNIFB+2lunZqxI//nOe4YQf6fsTKHZ8AK3B2k81N0ES7v32pjAy
    5b5LyrtJOor+9FQN7dr5h6VXf436iIhv9Nplb68YvYIX/SoWHf0nNmHh7HAVLbp9
    pzbTuLt5C5/A7ddTpLMNKKLpHUUUo8Ga1oAK04iwGUdiUcvjjeZWn9w+E7X4XqMn
    6X5kR8733SEuAeFuKQ6CjAO0XursXLENZs1eBnvA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKEZu5nhzn40XuS1GHuFA2BnRcBgVyy8axLgdTQAfNndmxp6y8xisGe74p4poMlqJBSbYPAOgWSv/FHXNUycxR3+G6b3zKYtLp/PJEjlOUm75/Zvk3JD
    0dhAiiGIwCA1sN3T/z74ClLiKzD5/ssEFo2e1Ejbx7s7FJZl4LPGtd+++YRzL7hgG0YiXFhUoNABq7xvXJ97405e9GGrUKWn/scGqhXyhuP5VZxXHQc1/l6A
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=n7nexZTBlz8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=Vnhjfjo9nAEnt92jQ74A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDFUUV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:20:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDFUUU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 16:20:20 -0400
Date: Fri, 6 Apr 2018 17:20:12 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/72] 4.15.16-stable review
Message-ID: <20180406202010.GA3221@calabresa>
References: <20180406084349.367583460@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 03:23:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.16 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr  8 08:43:10 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Merged with bionic, built successfully on amd64, i386, s390x, armhf and
ppc64el. I have some problems with the arm64 cross toolchain, not related to
the kernel, so builds for arm64 have been failing. So I can report the status
for that right now.

Boot tested on ppc64el on a Unicamp minicloud VM.

Using it without any problems on my Thinkpad X200 with the amd64 kernel.

Cascardo.
