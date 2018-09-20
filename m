Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0707721523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="00RQTzs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0707721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeIUDUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:20:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35902 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:20:02 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so9694016oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JX0UF5iTIJls046F4bSTi/i/dmYBrM8AAoJsfFEBSWs=;
        b=00RQTzs062j1brexXsIMV2XZLmcus0ydoO5/MCxoNUwAAV0atAsR8fftvWuVvXNVU7
         HC1vY1Xodrm+XRhbBiF/+gWLWonePRGH3bK1Bn3lchhGq5YKdpTrn3T7+mQFX7/xfEtV
         KpblM9eUXS4B4X3BUNMJ2fhTT5mEjMiEbFnv4hqogfBD9gsJGb2wjkWA/dzdwQs9mIq8
         yc3+64WurJRXyWLvZY8ouREwABDo2wqmgWZyl1+3BfLetbE1VNcq5XO+dSXEnxWg2kyI
         8rPePntPljZqubELP1bSRueq5mMOVZ9AawVwYnyNTqayeuIqs+vCE8kDJpZMwEiG1oT4
         vUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JX0UF5iTIJls046F4bSTi/i/dmYBrM8AAoJsfFEBSWs=;
        b=Q7cUiD+k/LugLzSw/crahxAGv7FSMxZmPBO7YWz2N8pYhFl5WJE+yPklRoDctFWeSi
         hh4KJxZ3RVGes446GL3Oq9vqEHoXHakqOQJoGcLqAU8BX1mTMd+yqVZJkdghWpdNb34a
         JKyrztP0xDGAgdTxhkuxFUXGVkap64CWUD4aAukWTVedZiNnVehLGMWucww0kCsmcDSS
         9eEmT5KWAoauVZXm7FZBuaql0oy5oV14bXQ2rma19Zsxly2HeTdTielGYPudZHZGpiFx
         DmLhdGPKWtRS5n7ZO1da3Wha+WdWxNaYhbWSEdNXw8PsACbaRrFvHk/5RY5PMf7+/NUD
         a6tA==
X-Gm-Message-State: APzg51Dv6ZhKHzf6Js5oXTn8XmoSutX1K2aj65t8nlW6/feq8QmFSCpC
        Lqk+UPSl18HM7DAyvlpp3oguedY8Xr6KCkz9gmik1g==
X-Google-Smtp-Source: ANB0Vdadh6guDvB90q0Z1/nJRskb6lIxsAU7xKcpxt7zz1hGbiGQTsGVOZxkw3ln7yzfx3s6qh/29Uikjzx0PUDcaLM=
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr432971oie.215.1537479271172;
 Thu, 20 Sep 2018 14:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <153681530631.454480.6512525122403854324.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153681530631.454480.6512525122403854324.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Sep 2018 14:34:20 -0700
Message-ID: <CAPcyv4j8GRz2OS8_LABPbzxxBGji7qcg8dEotZWEXBwa3fx2Bg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Clarify UIO vs UACCESS maintainer
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The UIO file mask in MAINTAINERS was incorrectly directing UACCESS
> (include/linux/uio.h) patches to Greg.
>
> Tag Al as the UACCESS maintainer as Ingo and others have explicitly
> required his ack before taking architecture patches that touch
> lib/iov_iter.c.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Al, let me know if this is ok. Alternatively we could just fix the file
> mask for UIO and not add a new UACCESS section.

Al, ack / nak?



>
>  MAINTAINERS |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d870cb57c887..be6c29cfeb55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15344,13 +15344,19 @@ F:    arch/x86/um/
>  F:     fs/hostfs/
>  F:     fs/hppfs/
>
> +USERSPACE ACCESS (UACCESS)
> +M:     Alexander Viro <viro@zeniv.linux.org.uk>
> +S:     Maintained
> +F:     lib/iov_iter.c
> +F:     include/linux/uio.h
> +
>  USERSPACE I/O (UIO)
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>  F:     Documentation/driver-api/uio-howto.rst
>  F:     drivers/uio/
> -F:     include/linux/uio*.h
> +F:     include/linux/uio_driver.h
>
>  UTIL-LINUX PACKAGE
>  M:     Karel Zak <kzak@redhat.com>
>
