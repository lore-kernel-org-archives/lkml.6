Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3142383-1523081431-2-1663354125770150098
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
    1523081410; b=vxBejWwTJfQuyqRALMfNZ9jupaXdZhmSIpl0GJl5B8YmzmSKEm
    xKNKhGWkOCsJzqbJRjZBpEfoJ0+e+TreuNUX/kOt4oXbHWyjeFithhEfTK5RhGY/
    vZ05vjo4vltlk+gCkyygpZbAHp1XzVM/FbFMmwVPfgB+PJzCH7n/f6u22FJMGtqa
    uN2PHyycmhaLhJchXRjPHwl4G7mnDmFEjPxDqBqPi+XDZq/uOtfMHGspV1WHTqkv
    a0lDVFMLXwl6UWND6hKxL3I1lsUL+hpvdAFrurpPqEoZ8rY94F+ryoQwrbcgzB8F
    98o1GlrHLycqQRLsQMkqyNmf9V2tq+ZzyG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523081410; bh=EZcG9uwaa2FAdHMqDwlrweSE3447ZL
    JWIkC/a5OSVCQ=; b=BT1a/UrhPhP+e+r4fXSkkypnxB7kTFFnmJU+j/0cGGe1KL
    sw6e4vgVkKdlpABuRvjJEcvgEkjiaI+mcLVMRzO/2I90KVmoNhqtnpwIyNemohtQ
    xTEjAcgYO6cByk+D6oNWNn1TKC5qe1irNk/YVbBSXKihpMbkGaN9ZMcdz5LryoSP
    ppmo/yIMQqo0aIjCflMBkCyNoCUr8C9DwVnvhSte25A2XEngVaDx7C+Ih4l1fquW
    QA4bs+lMpU2IX1GPioMTFOTOPtmyxjUp3Hp7Z0s/I16q5gKJCF7I1x/yb+ycnFzE
    sv8HamSm7/WFrm5Tg1xkPrI8hp1kTN1O2bkYDSIQ==
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
X-CM-Envelope: MS4wfNUSB5Qn4RbBJT+NVyVotDBFJ57gEFgf0EA+6cb0Gv8vLx0WnuemvOIzSUj6iHPMTOxBduvFu0w71LzIfxIkNKq/usZNy1uS5q1xKXFRYfphBAtayRi3
    sQY/tuPtpTd7/eWR1jBnJi0mjrdYRjA67N7BpLQtwwPmXJaHEpFL2m9kQdC6R9FHOV9VIEwF19oIyZk3kSODUA+QfLbxhei73PcFZ/uU/vEnmhsdKIrilBzq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RRRRr2VPVCgA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=qfd2YHwZ0bTNW4XGlakA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeDGGKJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 02:10:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDGGKI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 02:10:08 -0400
Date: Sat, 7 Apr 2018 08:10:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
Message-ID: <20180407061006.GC18744@kroah.com>
References: <20180406084224.918716300@linuxfoundation.org>
 <44CEAA8A-8B4C-47D0-A5A6-F8144EADE310@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CEAA8A-8B4C-47D0-A5A6-F8144EADE310@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 12:41:38AM +0530, Harsh Shandilya wrote:
> 
> 
> On 6 April 2018 6:52:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 3.18.103 release.
> >There are 93 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Apr  8 08:42:04 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.103-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-3.18.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> 
> Builds and boots on the OnePlus3T, no visible regressions. The merge was slightly gnarly with "proc: revert /proc/<pid>/maps [stack:TID] annotation" conflicting due to kernel-common changes and the v4l2 series conflicting with CAF changes in the msm-3.18 tree.

Yeah, the merge is going to be a bit messy, not as messy as 4.9.y is
going to be :)

Thanks for testing and letting me know.

greg k-h
