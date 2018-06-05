Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2574145-1528210441-2-6907413122721808106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528210440; b=NzDme9XqghJ3GxKXlepZa3WQ2K6p/4+ph/NT0coh7p243tcQso
    sEiQLzXsfk/WQnhmPqsImy9JKVw1Ojn+XnCreFqUpcGshGz8iBtV5ORf6xnchrDb
    tAF/7ZgFByKbD4kv7Qp2LLKTxlyrbV50GF+W69A2inN5uXY3PVYZmRb3/dt7lPkc
    jkzx9p80oPosW76y7YUX/idtVtdeWhpDRlvz7jJFCuH57by6tO1pL/8MDnU2psMP
    whgfScyD9SctE0/ni+1hWwTRRzJGxpCn+q4ZTHu9F7UMmGm6ZX0zIVCeKUZVVfnU
    7iXpMAh7GMN4nN8QbYkwlgU4NWJqe4JxbXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528210440; bh=9an4FYSzgInC8J7R7TEq+zB46YnSYmjt+ctimV2I4q
    U=; b=M/sGxLgIH4XqprMhX/leeH6tVFxfGwqRvKvdqsATDa0N2zfuJdAKEAhiel
    oIx2XjpWWvYQTe1Xhp+rZzDkY3l3lFDPas8qO0BBHLp8biJe1b33N1WQO7w13xQ3
    kEP8yc8jsD2kvtu34C7uoI7ZoMyJLQIE0C+Gz7KCHqhhDn/EW6o+VbGm6oiKlZ3R
    +ZJEnxVqo1qBT5YvY+UKO2Pwz8iXv7GYjNgRvvrQk2Ik2FVpxgsMB4Akd7SZIsIk
    /zgGB18wvDThcghTN2Jw2oyPtYswJ837rATgAbrmrQ8n7bRdJpcVp1Zq7M/K1XnO
    2W3lseDDYGbglbAry1hzCNKSRoew==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Gsq856Fd
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=rBttUHcj;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Gsq856Fd
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=rBttUHcj;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAb3fb7I2pcipKo4jJbfwT2Wu3P9NDh/CwI0XHZtrRF1HiAnkGypL6JdCLKDcMm4lJThXt08zSOaDMWeamM0gfswW9uqrO/rg/q13qT0pjWR/O0GsJII
    ulo1LnK7LNejNMMH/Co6Tm1USdeDiFty21NyF65cDhfhP7imYAlNkA80iEhpT944MAMSju7uY3hJ7vfv6phTw5JEtNhHnweZx7TNhZhIpXTy+u59myeMG1Ji
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=eiNRL2_UTpUA:10 a=7mUfYlMuFuIA:10 a=rOUgymgbAAAA:8 a=VwQbUJbxAAAA:8
    a=-hOVJlrfEL2FWbIVLlIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeFEOx7 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 10:53:59 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:39013 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeFEOx6 (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Tue, 5 Jun 2018 10:53:58 -0400
X-Google-Smtp-Source: ADUXVKLP7VQ9M4ZODW3MPuTlz+JLgdbj4ZMchqqBC5+zRd0+iIRPHy8qJmdjdqzw+n/BcwVvr3/gcv0Vy430yDHxvvU=
MIME-Version: 1.0
References: <20180605101741.658efe5f@canb.auug.org.au>
In-Reply-To: <20180605101741.658efe5f@canb.auug.org.au>
From: Trond Myklebust <trondmy@gmail.com>
Date: Tue, 5 Jun 2018 10:53:44 -0400
Message-ID: <CAABAsM4sBJukct3Ah7L7h2vg1dxzLWiVsSthk6ZECm3Guem4Pg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the nfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Fred A Isaman IV <fred.isaman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 4 Jun 2018 at 20:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Trond,
>
> After merging the nfs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> fs/nfs/nfs4proc.c:910:13: warning: 'nfs4_layoutget_release' defined but not used [-Wunused-function]
>  static void nfs4_layoutget_release(void *calldata)
>              ^~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   30ae2412e90f ("pnfs: Fix manipulation of NFS_LAYOUT_FIRST_LAYOUTGET")
>
> in combination with
>
>   2409a976a299 ("pnfs: Add LAYOUTGET to OPEN of a new file")
>
> # CONFIG_NFS_V4_1 is not set

Thanks Stephen! I've appended a fix to the linux-next branch.

Cheers
 Trond
