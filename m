Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-639720-1527104487-2-6992892464931834698
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527104487; b=iFyxPV6WhlZEwlNviOxYYF6WyLXDpvKDbpxhdVL1iXWNOu2UKW
    8b1mNlDlhgnsf0TTqufdIQbV4CL/XCRqjRdimHopn7aCSx8w1FaotQ5OTjRNwmxX
    EvpyvnM6yuFZVaV6NAZZmybybk5L8KHei96eo5fYPdVFtsdqwBt1a7Q6KuksKtjn
    ZwXHpNNJ8z5s/RWgaHrE5Do8klEwwX1FJDMQ43tI6FnlidY8U1JneXJpaLPteyGz
    cYuvc/H6oDbC/kasgapk7TFSkXzFs6PdQJ9N/CtG6WrMihehk6kLZfv/6KhYPShv
    B5nrEvcmjG1hZ7gGuZUcWHdOWolob0Iys2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527104487; bh=1t4Qrknozgny2HWkk8cwUFddu7KHfr
    v5zVIqb2frlOo=; b=lFfC2OtbkGPoA0UzkrNFJhSjf+dVxldYtbEG/iS7c0NPAZ
    mRpRBO2m1mZ6EasyOX1bQIn/n3y8ONwsHkAWIad0qvNr3C/oBqr0ELs7DsJrysYb
    9O2xhyYpxsvPTuBN/byzVuOCkIU9JLNTplJugPdQAb7DeEvDr0JoyfH/YpSgbEDG
    oh9bKnzSA2NCsGAYozio2MZ5tAqb+3rM/8nqmIbaEhyKLKrEUe+7twQT+0eXrauj
    TPIbFY7g9NgxnE6cha/TLhF5lVoZlwQiWPG6AjAqUJD9/60JBmJdS2S67c/1puHl
    r0F+Uktd1vCsVs7ZQf3ombk1/UPLIFdCvh44R3bQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=ziepe.ca header.i=@ziepe.ca header.b=mD9v3E4u x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=XpwSKrwP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ziepe.ca header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=ziepe.ca header.i=@ziepe.ca header.b=mD9v3E4u x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=XpwSKrwP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ziepe.ca header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfByYXddYZK+yrMa9XFqcS5fz4KZvQOe1YFlG49cY8TpqTY/lkxXSMVd4c/gw7+8VkKkm7n6qCvWSdVhT08N7s3JhslH07mlqQZzQjvdKGd/z09cb0ltL
    vsGn3xP+2TkG3vapYtFCcGLjrVuBkqLFzq/XK6gKN5bkvF2X1SG0og6bpTb1m7OoAzi41Ds8c/WiqBQ5z+QPn9ZomeVhdlpIyULvKo1hrqBxuXLNgGHXemxr
    7Yy7fhPJPxoGc0duen02uw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=MkO0SgdZ2zB_4Nrzf0AA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934320AbeEWTlX (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 15:41:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37026 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934263AbeEWTlV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 May 2018 15:41:21 -0400
X-Google-Smtp-Source: AB8JxZo0HBilnJWLgadheJCf3sVx5z2eXOHTa3GOlEKdOW9gtaWNp2lpm+qsnBzn2hm8BpiBB2JFZQ==
Date: Wed, 23 May 2018 13:41:15 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180523194115.GC8705@ziepe.ca>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
 <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > Ouch o_O Do you have a fixes tag for this one?
> > 
> 
> This one is quite tricky.
> The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> and the code back then was in drivers/char/tpm/tpm-interface.c file

No, it has been wrong since before git history started, so just use

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

All the other commits you listed are just moving the bad code around
to new files.

Jason
