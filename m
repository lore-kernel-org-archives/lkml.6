Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1958875-1527591218-2-4922273273275641672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527591217; b=RdLS+hYlPwOUMFTlCf3ENMhrswyA/suiQ4K/ekW/4cP/ke86sf
    LRyRPaGPq7BP/2cWIMAgE3Qnic6ioqDzXSUaF+0LKuSpu1+cE7tiDfznFlQfq0Xw
    2B+gcqJwS6ZXsJItIAd7IR65WIVK5p0V0lOf6f0kI4OfqeaJZoOprL01ZCsq1cyy
    bUMiVnF8MXvqLXu/GNFk5WmtKk15rbSM72P+7hAIxnzZbThpMHOCnv2GWlvAR96W
    B5B9mv4mAw8NXD5nguup3fNFooW+4DuqXMgddWtqiJgZcHv2LIUS7u01dtY2ByzZ
    dqFUV66TzV3GCMDDLRrm6h1B5gdweupSw6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527591217; bh=oz8ZJXLZ4jBtfPlEoAwMGMyol67CYw
    0frrbPwY+1rW8=; b=FH9YY2MPqF0F2H6FEQLDKBSPSbRjQV2PtEzBKaB4K5EmXu
    Jv/sAcvW4J+c1H+MGyI/WqQFGEYQCtTvEg2FtWHxInIrAxz1CjzBrxqg7s/njK4s
    9paXB9AKvnqcwsJVpvDWiXMtn893MtE9/VoyMDndpWFDeVikJcn1/chS4HYplcLG
    p3V7xAZ7fMF292ZS8J4bW5IxbglVQTcKkN6yaTDe88qAk/6o83iJHo2ffBrvwpwL
    M7aqftgYYczdvfPSYqOnrWJyAVIRF4ypWOyATRBNIPSqBpEpoTIp0x2xL2pwEwhB
    PWYEWmn3v1pAq9sg9bkqQ+dJqcjFEP+8Fby7Taow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=0jI6JE4T
    header.a=rsa-sha256 header.s=default x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=0jI6JE4T
      header.a=rsa-sha256 header.s=default x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPb0/RbTmg3cX1U2en6AozkW98owdnO7T3jSusEQTWIVUTziixdeCAHLU5UKvJRQ/pQy/UTSLwiL96l7TDeZv0Wbty/ogxRlzHzih+LxqaUZ+F68WWQ
    /gqlvZomLJuajedTVFK1/v5IltoMWkGvDTZp0Sjz6adqZSUnpQKoJ9csz7Lk4ryC3ZlsMaAxPRkw8IKPihFcqoKGMitQzLBVUocDDRbSp5jarUubEnbzGYzN
    27kA5Pj6UUMNTNxguvnQ4Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=T2DHHe30aiCLDkvZf5QA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeE2Kxe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 06:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932847AbeE2Kxd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 06:53:33 -0400
Date: Tue, 29 May 2018 12:53:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: YaoJun <yaojun8558363@gmail.com>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH 1/4] migrate swapper_pg_dir
Message-ID: <20180529105312.GA24918@kroah.com>
References: <20180529043741.27790-1-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529043741.27790-1-yaojun8558363@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 12:37:41PM +0800, YaoJun wrote:
> Currently, __enable_mmu() uses swapper_pg_dir directly.
> To migrate swapper_pg_dir, we need to pass it as an
> argument to __enable_mmu(). At the same time,
> __pa_swapper_pg_dir is introduced to save physical
> address of swapper_pg_dir. By changing its value, we
> can migrate swapper_pg_dir.
> 
> ---
>  arch/arm64/include/asm/mmu_context.h |  4 +---
>  arch/arm64/include/asm/pgtable.h     |  1 +
>  arch/arm64/kernel/cpufeature.c       |  2 +-
>  arch/arm64/kernel/head.S             | 10 ++++++----
>  arch/arm64/kernel/hibernate.c        |  2 +-
>  arch/arm64/kernel/sleep.S            |  2 ++
>  arch/arm64/mm/kasan_init.c           |  4 ++--
>  arch/arm64/mm/mmu.c                  |  8 ++++++--
>  8 files changed, 20 insertions(+), 13 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- You did not use your real name.  Signed-off-by: and From: has to have
  a real name associated with it.  Use whatever you sign legal documents
  with, no anonymous patches are allowed.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
