Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540074-1527101259-2-14861392666203171429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527101259; b=Q9W4jzeeOiadw4/Bxhf8MWxG2suaYd8O/xJ8gcPkv4oDkzb2Vu
    /b0E7GPphsiLqLK9Du0DeQAdWdrQPdtIorYzcu/AQzvvciaV8yB2k0gozcd6EzRj
    doSIXx67MVTvMF/4f20FzDis9Bab8OoswWvZ4Gp213CwhCIIJhtTuuvDD/1LDWGs
    H6xPndX8RhhH3DuxS2tiScc8zseXR5fhJJU1gTwsjydP0/M1T2u+Szsau9JG9uaU
    5Ro5cSSWGXiovy0G4Hlc3wE0Nv98zqGBOgYoAfpbLFg6H1o2ptAtoD4UBtuStbKS
    GzPrJsE6JJ60s/ZTufIKM9g2KOTbT+TggbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527101259; bh=4xg/oaqEdt+sXIRVs4tXSpCqXJl7h+
    E7FddQg4GOjEc=; b=Pq08XtexdGgSnGkqstrUOnlCOWryBe4LBRXaRY873taCaF
    L9Cnxa1Q5fiMSqxg0MG3RiWsPHCohPWGFQzwE/kQTDsrbI7KyTCSF3pnnK35MNiH
    3oStXQCCY2YBOzxDTUn5Xx4yM8EJw/8Ed2+/0lMTChMN1rG9dbgjW990+zbwKUp1
    OgoQyYubVYpYkzobQ6+dLnQpS7XsOaJIMCP5g6V8wdcEuaBVlCv9+gDf+t61N5n0
    tW+Px4f0WtLygJm6FQrAd//2zWZ/ZCSh0OK2Nnge8JL6iWnqeFN37g4vrsy0OTg1
    EsTTJHDncf81Cxsu/nCm8hzaYqxZcVnWyrc9hBdw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtKqrK8pyF900cjGpG43DGLgG3wrp48+VxcNzJjuaXYwW9IWzlcwr6tJfzfCCo7ySGJm1DFj/Qt/SDeWXtAhe3LBvQXjaqMPhmzmuXU1UnYtO82+tPd
    ixNqu5WVxLMez4x1EXJOVs/iixVVcluja84pggSLPtIEH6BX10jgtl1IPmRwcdeeiDLCBugQ19MeRixJLGHnMx0qY528AiftqJsH4sOTFyEptEh7AVFyZKaj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=C3nWvcC9HcDEjd5-WZQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeEWSrg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 14:47:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56283 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933926AbeEWSrg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 14:47:36 -0400
Date: Wed, 23 May 2018 11:31:03 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: semantics of rhashtable and sysvipc
Message-ID: <20180523183103.cdgv4slom62y56wi@linux-n805>
References: <20180523172500.anfvmjtumww65ief@linux-n805>
 <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018, Linus Torvalds wrote:

>So I'm perfectly fine with getting rid of 'tables_initialized'. But no, not
>with a BUG_ON().
>
>If you cannot guarantee that the allocation works (using __GFP_NOFAIL is
>ok, for example - but it only works with small allocations), then you need
>to handle the allocation failure.

Note that even if the allocation was guaranteed, there are still param validations
and rhashtable_init() can return -EINVAL.
