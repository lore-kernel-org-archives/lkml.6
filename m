Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D41C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379602089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRQin6Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379602089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeJAPbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:31:23 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46652 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeJAPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:31:23 -0400
Received: by mail-oi1-f181.google.com with SMTP id k64-v6so10481779oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kjuGIsTVxo36jiEwcA4SKK8936mQEpwwOmxgXhaa/Q=;
        b=wRQin6Ys+/gpxQvFRLa0UJcC0rqvauvSVNgqY0G3W/vT8gSVtTiI5EBpkqAGDd9GwR
         fSyI5bN/+4pKHZbALpi1r850cpbFE6wxSuR97LR4fXkMPJIvfTVnrvWWtwl1gl2mxaMt
         uG+C0oBLWmJpQyqIr1YwICh3MMF1uExmMpaN5cbvp3hrWJ5dlBmJSsXehMIQ20wn81Nm
         YdJIvSw/kRIUw5u4KNFElffkPsRn7FulEkPNL2H5a4sqUE4c98lhi2mcTQaF+XmUyThP
         ss1dl360wt8BJI1zHG/df+5e3XGVViALs6VCApwf2QWL+LOfbMdiHXeBhVKne1D5Nv9r
         AD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kjuGIsTVxo36jiEwcA4SKK8936mQEpwwOmxgXhaa/Q=;
        b=Oph2MmCuqmPoqldsQoFzFiZmU0cvOIlWBY8meu+ItS2TESgoIHqaPvgakekoFqAQNs
         hRfh2/IK4nrBHqm1/TofPPiPCmXsBR5yv0c6sA79VvjsLPkYlPpaa43gyKwdBC5b+nNS
         NIE9bLuMu3XMhpBabPqbVRXgdxcmOVqL5hjMFBja4bw12lIpePSHE9ubQG17AZbrAsZ7
         UZZYthJG3nW1CML46rEpCy2M6ZQN72yDiwXvDNX114IbZLktwZYTLzOCl10BNikAQcON
         pw5pBm7X/ug/ZKH0eA+NB6jPr9kfABnoy8TeIk0TydqP21P7x96s/Wt6Apj+AwLIPrEV
         q3zw==
X-Gm-Message-State: ABuFfohTHag89uKnG0O0n42NmlVGzzIAbKdmjlzKQUEMhT4Pgen/1lp/
        ixAp0EzC6qOnNvVyeB62YcRdOFBIBmwwK4OJcPDRhkyIofc=
X-Google-Smtp-Source: ACcGV63V2j9YSaI1kb0tkOtWwHGBj0nU+SBDUcL1PLcvBvXF48MSzrkdA9qKmI4mRH8zxiUtbfTi+ZvmQMKw0LSTnt8=
X-Received: by 2002:aca:d513:: with SMTP id m19-v6mr4804339oig.82.1538384081375;
 Mon, 01 Oct 2018 01:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180930234628.25528-1-laurent@vivier.eu> <20180930234628.25528-3-laurent@vivier.eu>
In-Reply-To: <20180930234628.25528-3-laurent@vivier.eu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Oct 2018 10:54:14 +0200
Message-ID: <CAG48ez3hmmSndm2dS1Jr6AFuXY8_wFQwndLbO5v0GO-NmDtO-g@mail.gmail.com>
Subject: Re: [RFC 2/2] binfmt_misc: move data to binfmt_namespace
To:     laurent@vivier.eu
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Andrei Vagin <avagin@openvz.org>,
        containers@lists.linux-foundation.org,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 1:47 AM Laurent Vivier <laurent@vivier.eu> wrote:
> @@ -716,7 +711,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>         if (!inode)
>                 goto out2;
>
> -       err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> +       err = simple_pin_fs(&bm_fs_type, &binfmt_ns(bm_mnt),
> +                           &binfmt_ns(entry_count));
>         if (err) {
>                 iput(inode);
>                 inode = NULL;
> @@ -730,7 +726,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>                 if (IS_ERR(f)) {
>                         err = PTR_ERR(f);
>                         pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
> -                       simple_release_fs(&bm_mnt, &entry_count);
> +                       simple_release_fs(&binfmt_ns(bm_mnt),
> +                                         &binfmt_ns(entry_count));
>                         iput(inode);
>                         inode = NULL;
>                         goto out2;
> @@ -743,9 +740,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>         inode->i_fop = &bm_entry_operations;
>
>         d_instantiate(dentry, inode);
> -       write_lock(&entries_lock);
> -       list_add(&e->list, &entries);
> -       write_unlock(&entries_lock);
> +       write_lock(&binfmt_ns(entries_lock));
> +       list_add(&e->list, &binfmt_ns(entries));
> +       write_unlock(&binfmt_ns(entries_lock));

This looks wrong. A write handler's behavior should not depend on the
namespace of the process that is using it.

Ideally, the affected namespace should depend on the file you're writing to.
If that's not possible, the affected namespace should at least be the
namespace of the process that opened the file.
