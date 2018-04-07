Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3262455-1523081482-2-15967863466729131706
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523081482; b=X5kRrB90Zai5OWUp2Bnx6y2ewguXvWSmuSXXaiYLjpwZPGBcer
    Jg77pd23p6//oAFT5lnTXoqd0xPtA9JXy0DBSCWmMDuQHvZtCLynkSsGV0O9oYEe
    QC0dMtDab6WXgCDLjrp6N2RNUF4y0JAvFx2Mchu7p9WVfFqZX6CPs4SZ/ZW9Uewu
    +axW7zv825Akifwu5HPHDnmP60+MJ9b8boT2kkUt9R+pYMwViYMqSJXoPgqJ55fH
    SmSvbi1gQsLm0/fq0eOlhfFh9tFeQTbgnky+ubVOi1s9FZqUhpxMUw7a1ScB79ED
    bshKRbFUYcpTSy7HZeS97CmO9zfKTqkWwSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523081482; bh=bQiEoLV1Y1M
    b0XozuN+M4XrNn0pUsFyMd7nPHQLH9KE=; b=kF+dhZ4xLJb5UXrDyhr4KW53X9z
    Ddn/aqd9q4w0elveIh+zqWp15j6WHk6U+GzFhdWIvr7TOgiIj0tHKRYdEayy4sAV
    EORZ5WooHq04uRvSW1+2JkWtI0QP0XDYMAG9440v/fclVVfYsf3w9sfyjoXcmfDL
    iqdrRL4SHouBcVSQnhp3QruNkD5Ub2nIVvg6JiA2XmrVFQ4m9uPBfzxF5+0mqeAy
    I4dFWlAAD+W3yNwGVRdKMION/lcp7UV4hQrUXWEbj0o0+4J6axa9txUQZ+dweeoR
    PU7ClD7iT1WZHnoCv1K+hRbZuhs6zWj6eguxScIakU3nVSdB2LNM1MjYRqQ==
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
X-CM-Envelope: MS4wfEdguKdInM+BivHjX+LFLxoaTyxw5xyBfSMVzjowV2Tqx3PxiTnbAYQZzVYPeGXO/2x60L392OskbfnV8sy25e+ml7aQ6KvEs78pY/pwlL4K2HvdRh6C
    mbk2+FJdf1Tll5IOBv3DFp3dc1SOOkEnfwQbO03djLZwizKQsOufHGds3B65FHqmGDBcfZSfFSCHhKx9AeSbaPSwX/vZeRKq8uSUxtkHKBfQqTe4AmmYKpFI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zoehSAk54XIA:10
    a=Kd1tUaAdevIA:10 a=KKAkSRfTAAAA:8 a=lIMif6gCgdKc0CctGisA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDGGLU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 02:11:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeDGGLU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 02:11:20 -0400
Date: Sat, 7 Apr 2018 08:11:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
Message-ID: <20180407061118.GF18744@kroah.com>
References: <20180406084331.507038179@linuxfoundation.org>
 <20180406222524.dzzyzh3su3ytgh3u@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406222524.dzzyzh3su3ytgh3u@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 05:25:24PM -0500, Dan Rue wrote:
> On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.93 release.
> > There are 102 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> There is a new test failure on dragonboard 410c (arm64) in
> kselftest/cpu-on-off-test. However, it looks like the test was failing
> but giving a false "PASS" on previous versions of 4.9. This -RC seems to
> have changed the behavior enough to cause the test to actually mark a
> failure.
> 
> In any event, this looks like a db410c-specific pre-existing issue that we have
> already escalated to our Qualcomm team. Details can be found at
> https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.

Thanks for testing these and letting me know.

greg k-h
