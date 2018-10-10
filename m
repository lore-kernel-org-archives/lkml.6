Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D977C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23E320858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHCKMCbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23E320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJJTI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:08:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50611 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:08:57 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so1423336ite.0;
        Wed, 10 Oct 2018 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbU9M+0a2hjK2GKwZklMeGd2mg6bn26VAqBDlvwgtHo=;
        b=JHCKMCbxO157p2Q42cQI4xb8y5y7FRm2+uMaFHopVz7LtyuJcH9LAql0hFgfk14Y4l
         DDjluxkG2D5w6yQL9zgar3JQIS03l3vPGUKk5F75xeHP7lIbDs6JSRf8H8K96bCu5VbW
         HmClzfkXb3+qXIQT1AOAA7mfXCz4MWVjIDSjTG/UcUdH9eBtZ8XgGZMMGnexhTHqAGaK
         L/PfHOD2yY6TiuHquJQw9GkugsQAwVxb7wQA+9HhfNlRfrQQKS2rTuS4lPPd4FB3wWTX
         9gkBmZeA+ulqx3QAQb8Z2Z47jvI9HjVsBYF5RIz3fA7dOcYaWL7oItVu0CoxrXfksVm7
         LHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbU9M+0a2hjK2GKwZklMeGd2mg6bn26VAqBDlvwgtHo=;
        b=pOAbA9l8jagK1HScHgF3Tdrm6nX+SZy8js1UvmFenVLZWM3R0Mdoegen5O4bjH2iCe
         9k5iY2x95/MiL9hsMFG6K6RiLVcZQydlyClSucAvWIx0dBEehTOYbIWqb1DNogQEGFgj
         mxg/F3vpVrxM92eW1LLMEUn0gmo0WyNNUcNMdmnS9pMGGdAzxdFukiN7NflK+NGpDQ+p
         9Y2ekBQJm8AGabjH7LsMgfDtVTITOp9NfIdfqyFMBSlle/WigAU/KmwVX8o4XX/15aHp
         NebtU2sHpyvGuJYcL+EUtB1JHjnlhOL/3pTNkdS79rdavXm9jrGlLOxi6bRSEAKqipTY
         pC1A==
X-Gm-Message-State: ABuFfoit3Uy/PfgX4rqLmsXbViHob8q9j/U55MVzHo4XtDIesG965P4U
        WXqmCJoHJ4Ch7/LczNA4OVXA44vNhQOcJMvgQuOhFJAX
X-Google-Smtp-Source: ACcGV61d0eFWIXyx2gsDSlJCSfE+6wH7+3Gcu8kN6WW2NnHM7VQE4QztYllefv3gM4j6BL0CBce0mgLPhVSGVnYABXw=
X-Received: by 2002:a24:a109:: with SMTP id y9-v6mr408432ite.73.1539172030273;
 Wed, 10 Oct 2018 04:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181009175428.18543-1-lhenriques@suse.com> <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
 <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com> <87sh1evyii.fsf@suse.com>
In-Reply-To: <87sh1evyii.fsf@suse.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 10 Oct 2018 13:46:59 +0200
Message-ID: <CAOi1vP_YxCbb1aP=imNt6uJfEn18+kbG273mKW6A_+qQTnTA6A@mail.gmail.com>
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:19 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Ilya Dryomov <idryomov@gmail.com> writes:
>
> > On Wed, Oct 10, 2018 at 6:21 AM Yan, Zheng <ukernel@gmail.com> wrote:
> >>
> >> On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> <snip>
>
> >> Applied, thanks
> >
> > I don't think it should go to stable kernels.  Strictly speaking it's
> > a behaviour change -- it's been this way for many years and, unless you
> > are close to ENOSPC, it's sort of appears to work.  I'll take off the
> > stable tag unless I hear objections.
>
> Right, it can in fact break applications that rely on the previous
> (bogus) behaviour.  But it can also be claimed that it *will* break
> applications anyway with an updated kernel, so backporting it to older
> kernels will just allow a consistent behaviour.
>
> Anyway, I'm OK either way.  But if you drop the stable tag make sure you
> also remove the 'Fixes:' tag as I believe the stable folks will still
> pick this patch if it includes a valid SHA1 in it.

Yeah, we've run into this in the past.

Thanks,

                Ilya
