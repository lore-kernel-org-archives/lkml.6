Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2806492-1522256855-2-10864187196104606246
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
    t=1522256855; b=XIbVZ0GMaBro8LClpZslAOLkqZDhvqqKuqiNd1PfkqF3QR9
    tgz+OOHIlP0G73wXjWvHH67FJVAkB7KPpqxyS4hNNwxf97HBjvhSBLxmS9dMtErh
    zknNMf+qJ6KMLxHvWaqwDFrtxAkPSuHeXpBBLrhm0UleukzFLPIZ4stvJeWP199s
    cjK7EUQvoTKSypCakDTWmRevXLUneaU/jROQqPF8oDAZ6V9rwSN3Gk4gi7yi2Khu
    LW7fTGFBmnlDCI7pQPlCVZUQlTNymTUr+z9s1pQ/bdq8Axf3khHyBWbcigdXbVE9
    LtBBp2SuyHhVsnZ0jciyaxWA3aRwY4LcGMQbJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522256855; bh=gV8rNYt7KT09A9HGcry57Iojyw
    L6QQFZ8uxadOp808E=; b=I8Qvfy3tvnmrX/+siad8/P+5xYevvTedgZi5SgtXR2
    jRwpSeF0pwP3NOFytSfkhaqP4XVzgcXaCMyMPUO+Ge27AypRzhITmUeLKLEHqAdq
    SvsZLmKkIzFom1zKPCBcejQhxobv0UZR+hK5WZXoMIFfG0+hUciU50t0O0hGI7kM
    kMLpyjQ0yyKO+QrDVKLimg4x00cfxsMlsEF2CInc+m2nW2/TLRNQANboglq9kwFu
    OoJ0Sv8MwM6PZWDWGrEr6Fpy1RPkF2LMKUwJhm8WKx4zSEUP8DZHEGPGt0MpxyKs
    4bfY7cgr6sTWgDMuOb1P4isYZEhtNWhvCOsV3RwO83kA==
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
X-CM-Envelope: MS4wfG5Fd8+QaIT8HhzvQqdM1Ar/UAJLA89H3WvSDn0NhxP4RpA3sMDtE2WJoniBnW92SFqyuo5oiuqtAouRz0FkYaSr3bBsSIYvWuMXueiD/qjsJynqCRE2
    Ak5fsORKi3xMv87IaIIDyAF4zkeyelr2Dcwtudg+r2QbnjSoHrvMtolm8rEkFQV8QNR1dZgZ4+4KHJ/Oyru0EWz+XI/GwOC+VuDstxARqd45B5MYr4faH49u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=HpFSncBSp1MA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=GxB3_Mkwii_3BxoTOGAA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeC1RHe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:07:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeC1RHd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 13:07:33 -0400
Date: Wed, 28 Mar 2018 19:06:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
Message-ID: <20180328170629.GA27735@kroah.com>
References: <20180327162757.813009222@linuxfoundation.org>
 <20180328163131.GA3261@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328163131.GA3261@calabresa>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 01:31:34PM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Mar 27, 2018 at 06:26:40PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.14 release.
> > There are 105 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.14-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Merged with bionic kernel, built successfully on amd64, arm64, armhf, i386,
> ppc64el, s390x.
> 
> Survived a kernel build on ppc64el (KVM VM) and amd64 (Thinkpad X200).

Great, thanks for testing and letting me know.

greg k-h
