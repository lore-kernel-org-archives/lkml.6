Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21230ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F27214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sSVumybA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIA5zbP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F27214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeGMDqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:46:03 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40470 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbeGMDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:46:03 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so11257419ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DM2fmXR+ohtz0SYzXSbChnxJiFkYc87L/bi897U8t4o=;
        b=sSVumybAMTdnmfx1XvzslUw86jOHwdOm3Jp374A9oK4fgNaaGjuYYMnKZLnerXoME5
         jbDcgGhX527GMJC64ehDG4QEWES0/Pk9xWscpYLKEtZ30WrTfHoPwtBARChqtk20u8ZN
         3+PP323rvAh0+vHXnm1pwofa8W909/8Ys0gqhupZ3FgCJ9UQzEUnuJ1WSTqtyxddr24T
         VRNu0WEdxW6efeaQQULYvA6wF4HLxjWhjCN748yN5IwWQOMeeU/oUGPwyoxP87rNpnVs
         YN0yEjTDXZZUtn/0aYOIm2PHRylDfMoL308Xx1jYHoCDyvVBMswhv+sxQ8ZWNTRjtAj+
         oO/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DM2fmXR+ohtz0SYzXSbChnxJiFkYc87L/bi897U8t4o=;
        b=WIA5zbP7Z3yYGSqhoXk39+EsURl9+sniodswcOXVH2D4YA6NR57xsoAi72Qqxx3Ccs
         1dXDunY4zF/dQKZn08k4cYAf1qpBCCCdWFnb/r10mtG0MqfhjZYAG/uOsD8J/sq+M4zO
         Fhqlip93nMNdWJn/BLb8WO8opGhZaAKbullHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DM2fmXR+ohtz0SYzXSbChnxJiFkYc87L/bi897U8t4o=;
        b=KpN5BQ5lYycaS+BYRGYetDX12jAoOSw66ijIu6qGezVptsVDIVcJGuhLXtIG8rmupE
         QB80QmLSw2yh8NWiKcG1yKKYV4w0cCoaZWCtiHI1JNbiYQzRx9mdKBjlgQgL5Hx2AxqF
         NHXHyBqLgrLnoyDjkoC5ANycoHCJrTXiPR50peekD7ZYPCHHMcPPSqzDvfZGnz8SuBci
         LJC7MTnnadfsgNVrs1jcTVL744oLaJ46UssDKpWHk3nRKaTyuji2fPsOIvMJipnJdpdP
         gqDCfdtwtvuWFICTkwOqKyoLVVLpbz1pvhs9g4Nc+quH6xdAzBfmhBtQS+49QRmaVAEc
         r5Wg==
X-Gm-Message-State: AOUpUlExtlP23W3ZJhRMel55qholloVS8PjD5QGdYQu/z3mtEWa1Yz4X
        n89+zEm/lemMV3wHedURxo5xYNlEsEMvAo27w3tIxw==
X-Google-Smtp-Source: AAOMgpf1dNvwe177BUhKW1hebaMCBvIQgqvzqMSenraeWT2l01+1/1PXfflZao6D3gMcnc6QbWBXEni4YJSeVEXTtYc=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr2510000ywf.53.1531452805608;
 Thu, 12 Jul 2018 20:33:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 20:33:24
 -0700 (PDT)
In-Reply-To: <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com> <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 20:33:24 -0700
X-Google-Sender-Auth: ZWf-SFEhbzxAROCoRX4m_xHb3z4
Message-ID: <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:40 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 12, 2018 at 06:02:26PM +0200, Arnd Bergmann wrote:
>>
>> Looking through some of the drivers, I found this interesting one:
>
> As I said before these patches are fundamentally broken.  Users
> of AHASH_REQUEST_ON_STACK can only use sync algorithm providers
> and therefore drivers are irrelevant.

I don't understand what this means. Can you give an example of what
you want to see happen that will accomplish the VLA removals?

-Kees

-- 
Kees Cook
Pixel Security
