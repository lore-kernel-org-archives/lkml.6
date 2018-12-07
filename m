Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC932C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64F20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YB3m9hnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGIhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:37:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34674 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:37:32 -0500
Received: by mail-io1-f65.google.com with SMTP id r9so2679092ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axjiaHrB1ULkaMIAknrvQsbE0LJYkyVqkUjPnD4NEjQ=;
        b=YB3m9hncANhburPLFMAz/W4XooAHl64w43U3HLsP4EjNAnVut5AGglJBXl5RFsUUW3
         1phyg512TXiyo2xbC3SYREZYiPmM76bFY5gqM66s//Kn6gQxsxl6e8M2f965UFJ1oFof
         Hw1gFRjC5wB0RsDeVGjx+tXrhE8+TiXzDdlcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axjiaHrB1ULkaMIAknrvQsbE0LJYkyVqkUjPnD4NEjQ=;
        b=qbj9JZvKjSNgzpNOJbC7x+bRQ1R14pThHfftLeNixP0Q7zt5NwpsVyRqyjtlg2sLSf
         PrvxaTJYSq9A0jbWFQLNPNeDcxGLSVIUYwvyeJ+FyP6Q/gLntftDDaaq1odWXx2hDpeU
         8jZukfC8vJZ1qKE3tAD+xFrh6flH2lWg232R6AcSr0lniDdgsv4XUPMWeS1WZUzjIifA
         iaKhUN/9JVt7+I3SoZKPE+J9U8y7Z1igjlw+ElyK3lBPIVIOZnAnewD88qCWk20tPck5
         0/s8+M60mIDsJ+90bpxB/0EbB6QZ+7xtexvyKfnA6VMh0iAaEAW1xVVTuaBDAJXJ7tPA
         jdHA==
X-Gm-Message-State: AA+aEWZQYwJi/dX+drn9gha5EforHNACo/M5DC8keG+pQ3BhPoQ7NbAK
        yglT106nCkzfVqTNdc1zcROFqslVSh9XK2Q6BJW/vA==
X-Google-Smtp-Source: AFSGD/Wu9g2rpEVIfQVRau9qFsGtCCYK2QVFsmYhyUCl5TcNrGPk0AstIWwo+AQowJNdIf8B2lFvLZIaMliUIFPT02o=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr870290ioc.119.1544171852086;
 Fri, 07 Dec 2018 00:37:32 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org> <20181207072724.GA3750@sathnaga86>
In-Reply-To: <20181207072724.GA3750@sathnaga86>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 7 Dec 2018 14:07:20 +0530
Message-ID: <CALxhOnijfhMx8Uyiv3L5DR9dea2P85YRKD09cVK58T9h3ca+Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
To:     sathnaga@linux.vnet.ibm.com
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satheesh,

On Fri, 7 Dec 2018 at 12:57, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> On Fri, Dec 07, 2018 at 11:41:35AM +0530, Firoz Khan wrote:
> Hi Firoz,
>
> This version(v4) booted fine in IBM Power8 box.

Sounds good. Thanks for the support.
Thanks Arnd for sharing the solution for "split compat syscall table
out from native table"

If someone can review this patch series and queue it for 4.21 would be great.

Thanks
Firoz

> Compiled with 'ppc64le_defconfig' aginst https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=a26b21082959cee3075b3edb7ef23071c7e0b09a
>
> Reference failure v3 version: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/182110.html
>
> Regards,
> -Satheesh.
