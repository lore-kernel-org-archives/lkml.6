Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589EE25DDF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zIiXDONN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589EE25DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeFYQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:11:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35520 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeFYQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:11:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id c13-v6so4315942wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tz4sbTzwC6z1Al/KLeDwUzrLEXKFO94oX5VmfneQdmk=;
        b=zIiXDONN/g1IgTS+h18h6JppRFztUzY2dHQ8pnhQWOPl17FTkG9V4R5Kq5VovRP5+H
         cQqVy+PpcgEQKY3jwLdYrjdTfxaNyInpnPyv1xgOsRXqmf2MIdewaiCtr17hWxbYbOv2
         iz1D/8iwmFrZFZx5U6BGY1QCDyaH3w0OVR5byH5hKCtfJNIMkcKKE/OdKF5Hcmcvi2mM
         PCyBoMb0gO7gBktauclB16L7ef0nUd/b/iCw4+MfGardPEAAkDIr9GDH7kP6doqhtCdt
         1eb1UQas7yUx96/z4Vcp6hxSpAeuyilgzfHbKayEZhyQLaaJca7sZgKEsHpHpLQ09k9Y
         KkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tz4sbTzwC6z1Al/KLeDwUzrLEXKFO94oX5VmfneQdmk=;
        b=C844qJJqnTwATuHsQVGE6zSTw35n4qv2/nj+5uAbg0siDsPVYyPa5Fc2XVMlg3Q25R
         Id0L3y65L/oziZ8fpjXX+M6zNT1lNbDXweNSA8a3Qu4r2jBL37ckToi+7BCjyp+Vv/ec
         Ks1Ieixy2mqrJwM5yUJlg90BBYuU0+uJwUhXBs1aSv4oUBCSuYclRWFz/4+Yu25TVeoZ
         4fmBdEvwYdKefUtvIa4Dx3Lvu+/HoogXlMahwKANujijPEW8Grv0njpHWWa3yP4vjwWo
         LsLjfQE2Td4lR8sjVKiYIOgnwm/h3Wsjo5JmQXxvq7a90WuL5uifQfpy2D19n0hgdmHm
         AZ5A==
X-Gm-Message-State: APt69E1HyxsbQX1lpfIzpcG2dZqzwJBZE8IH+U7pPy8+X/JX1880BVtc
        bdpRhp5It9fQC4l8Edke2HPxvKzWyMgByIkL5EOXOQ==
X-Google-Smtp-Source: AAOMgpcJHOKO6CdjnzqE8PLILDRAiNHs2abE7lRXcsy6MC5KdM8ApyF1fUYQdEtzZWgvnRhgARw5s3YTiBFNgX40C+M=
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr6838772wrk.221.1529943107623;
 Mon, 25 Jun 2018 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180625155750.GA14306@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180625155750.GA14306@jordon-HP-15-Notebook-PC>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 25 Jun 2018 09:11:36 -0700
Message-ID: <CALCETrU3dS5t714BYqkxEYgkbJaESK6NP1Rsn3xq3En38yjJzQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: Change return type to vm_fault_t for fault handlers
To:     jrdr.linux@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.

Whoa there..  Your commit message makes it sound like you're just
changing the return type, but:

>                 if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
> -                       ret = vm_insert_pfn(vma, vmf->address,
> +                       ret = vmf_insert_pfn(vma, vmf->address,
>                                             vmalloc_to_pfn(tsc_pg));
>         }
>
> -       if (ret == 0 || ret == -EBUSY)
> -               return VM_FAULT_NOPAGE;
> -
> -       return VM_FAULT_SIGBUS;
> +       return ret;

You're refactoring the code, too.

Please fix your changelog.
