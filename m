Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4038955-1523372392-2-6124691332960337399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523372391; b=QAJeExToasfPiZpRaF0vIS6pNoy0QbWjakxE2uwTshsXp5xZ45
    nikAlLRGbstwo3lqg4Zc7JnULktKbvqMwxh3J7Zp8FfWbhtqBKCLti8p+L17lvcq
    +iEBQ8Bs/FfVkSkjxVTFWC1QBP9qbeqGqcpJmBJgLgsnSgSP04GEVHlMmHt+RirL
    aTovlN7FFD0esfCpt05y3QR22jwlRVYZ3hW4CL1DskQoIOJD7KcYrQhQlVIqrjR5
    UtqouBgIieK4AOLdnjh1fe/a2NUl144AYaQ77RJB2lPUUyoCPBrA4tvnp6V22VLo
    Z/YCsiCIQ777Vu9rvvfV27zcQ/0G4Q9CyuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523372391; bh=6MZ/JLUSgVAZ/pzLkqV1cOg9NIU+qN
    MutuC0wwyAK9Q=; b=twgYq4R3hJFJEs3428pNofwUZbIeqny1btSp8a6Cynz2E7
    xl7FkFFkhKYavIkT4j+Fskk/KrZIOu2K/8tLpVKAMgPfXv1e12qi5eazQP0jzZVs
    troPMWRM911uJc8eZwVZNO9cgHBEfT8uLDzdT5WgHKnqCArwCnuF/4wTk2zKMqRz
    mb0381qOdDOUIvQT4sPa5RnrmiHYpbMTxWLT/ppvEIZX/rC4NGp+QdxCrLxZtAJG
    30pJtTp5uYwmp3IaEfv6+Kz9FkXsDmLkWHPFFkV2saCMXNBtlHiYvSuIpi9F9Cft
    CIJc4V6MFS0KXuhA9U9h9CALLuWfugSzlAJCThqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bllqBAr0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CD6Dpv99;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bllqBAr0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CD6Dpv99;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6qOSapMsLA7Jb8f6fPCxvdW0NymKXhCFaodto9ss8L2dB8c+pnENTkfZ6C/h9p5UN7ytE8vHA79zpuJb8rmk1mA8tMpmh7NiZjviTOov5+muJToovr
    5bsQPYhDc3sqbrCjiWUf/ZymLWVx6duNOVB7KEWeyYmuQT3bnn3Z3agoDSY36s0aBTjPlBUrJUyHwSCsiUDVb8XEZzoKaQvt4ZvX5iTT/OhOw9V7OMYF/SnX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=F2e83xq_C__GpNM0TzkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeDJO7f (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:59:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35754 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753694AbeDJO7e (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 10:59:34 -0400
X-Google-Smtp-Source: AIpwx4+mVfXynMdQ9kQIDR5S0epBSY+5mNb0M+HBBhlgXpMbCgC5gUhaiFh/wgkMmEoaICiFPzq1gg==
Date: Tue, 10 Apr 2018 16:59:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: davem@davemloft.net, andreas@kemnade.info, johan@kernel.org,
        johannes.berg@intel.com, stephen@networkplumber.org,
        Linyu.Yuan@alcatel-sbell.com.cn, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: hso: Replace GFP_ATOMIC with GFP_KERNEL in
 hso_create_device
Message-ID: <20180410145928.GC10795@localhost>
References: <1523370924-32425-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523370924-32425-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 10:35:24PM +0800, Jia-Ju Bai wrote:
> hso_create_device() is never called in atomic context.
> 
> The call chains ending up at hso_create_device() are:
> [1] hso_create_device() <- hso_create_bulk_serial_device() <- hso_probe()
> [2] hso_create_device() <- hso_create_mux_serial_device() <- hso_probe()
> [3] hso_create_device() <- hso_create_net_device() <- hso_probe()
> hso_probe() is set as ".probe" in struct usb_driver, 
> so it is not called in atomic context.
> 
> Despite never getting called from atomic context,
> hso_create_device() calls kzalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Thanks for the patch. This looks good to me.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
