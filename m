Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92471C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FC52080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKI4Hb2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FC52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKJA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeKJA6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:58:39 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0470820892
        for <linux-kernel@vger.kernel.org>; Fri,  9 Nov 2018 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541776659;
        bh=fcMmG+hGdT/EyOrz4pCXUiDLwKLkHOCh7WRgsbJQMzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HKI4Hb2OMuLZpkMR9BnP58JjTi3DoWIsdm9RM4u3d87s2fflUR3wBnluAUYdupZuC
         L9TSbc7NJHdMJjHMk1WXC4u9U/VYX5MQVabZRoekGEzv7oUza1FRMCJnKJ5fbduqm8
         vNjM0RQ6x4zdKcrpyB9dCHc8Ss3lk6/9Uzegxtsw=
Received: by mail-wr1-f47.google.com with SMTP id e3-v6so2285849wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:17:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gL5KRbXuIBIH/Zzq9PExSqWbPwKlED1hGSDfxH8Gczjfv/XjRIF
        A9WV6VacGtdA4EiTfX/+uBMjYnkzTvybf6MItAcJ6w==
X-Google-Smtp-Source: AJdET5f1SafXU8ZfZa0XdLHaY3IvdtiRWNcc9y6WxpURmV7KvZsrefyhii7Z6jbeFTtzl8n9rziDtnERRhUijyMttVY=
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr8382930wra.95.1541776657493;
 Fri, 09 Nov 2018 07:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20181109031605.GF21511@altlinux.org> <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
In-Reply-To: <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 9 Nov 2018 07:17:25 -0800
X-Gmail-Original-Message-ID: <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
Message-ID: <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-audit@redhat.com,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Eric Paris <eparis@redhat.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Elvira Khabirova <lineprinter@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 6:22 AM Alexey Brodkin
<alexey.brodkin@synopsys.com> wrote:
>
> Hi Dmitry,
>
> On Fri, 2018-11-09 at 06:16 +0300, Dmitry V. Levin wrote:
> > syscall_get_arch() is required to be implemented on all architectures
> > that use tracehook_report_syscall_entry() in order to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/arc/include/asm/syscall.h | 6 ++++++
> >  include/uapi/linux/audit.h     | 1 +
> >  2 files changed, 7 insertions(+)
>
> [snip]
>
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 818ae690ab79..a7149ceb5b98 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -375,6 +375,7 @@ enum {
> >
> >  #define AUDIT_ARCH_AARCH64   (EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> >  #define AUDIT_ARCH_ALPHA     (EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > +#define AUDIT_ARCH_ARC               (EM_ARC)
>
> Similarly here we need to have:
> ---------------------------->8-----------------------------
> +#define AUDIT_ARCH_ARC         (EM_ARC|EM_ARCV2)
> ---------------------------->8-----------------------------
>

Huh?  How does the bitwise or of two ELF machine codes make any sense?
