Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BD420858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd+tJgDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeKQJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:46:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34261 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:46:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so40256733qkg.1;
        Fri, 16 Nov 2018 15:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S3A4Ev/wT6z58zpQ4zDoDKGnmF8EFdc13KDqMrbU/w=;
        b=Vd+tJgDCNNoWZhlCW9hcN1FAjGtOhWq4crez1mfM/UPMjVx+vwmTA/HKAvleFv+c5i
         8b61d3du8v+p1Dy3LM0zP03nICX8oEeeGU5tinyfKVy8nPDLOu0OGsJKkPEMyZbzz/zj
         jAO45I9QWoLh7cwdEOcNAyZitrvoKxi80TgxL794qH+mJiVpQEBfJpEkX91qy+ZUxx/F
         a1Lx893SwDy+GpHyTez9cjaGkEmqtUDIqYbYOzPVazbpTdlu0izl8O04qg9EB3dco6rD
         kxegyJYwIo6E0MQODeDhxMTu3hbiSN/Zi/IWCpHn9xyswy1L0Npkvqf8hwapwgosgmPd
         PbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S3A4Ev/wT6z58zpQ4zDoDKGnmF8EFdc13KDqMrbU/w=;
        b=tmTSus6bmcnpZw+skP6OcWCBSrLoxGwcqFsUcGsq14lJJhFvfdraM1f6AFEuTRMmVN
         zK6YpCc5iwTjSEhlx6TU0eXAjs5H2SB1BDLz4UuEIHiGlG9YHf5JI578u0diqC0CfPk1
         I6w7URQY8ShNTOyMFtCWtnzHdK59mp9upJaB0x1puUyCa3hO1G0DltONjxCLbq15NL8P
         CU1RJecawgYlaBYYpOZNdl8UFddkv40nA2rZHT+U5vtf2OKZaQqMlVtg67JSwIzUAZUB
         Y2fAVQspjgkD59OLzHOb+9XUqbbnkNO0pDmktyR9tcZ/J02TcFZc+n84itKCJKd65yZe
         CcxQ==
X-Gm-Message-State: AGRZ1gIB4+5M+S3Rkb+glb85DwVL5ctlERBZ86CErNrxuNinP31kMf8/
        H96KO+/cdLnN0r8ooeDdFqkMhlKpDC46zkexHos=
X-Google-Smtp-Source: AJdET5fEnqbIAJGEj1pOB1Jo9I3Ofnw04v/B2iWjD9Dd1UGEfQNWR5LiW9rg0c5sg1y9LXL2vk50x5xRMkY4VP/55ZI=
X-Received: by 2002:ac8:266c:: with SMTP id v41mr11876249qtv.159.1542411096312;
 Fri, 16 Nov 2018 15:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20181114180034.25558-1-guro@fb.com>
In-Reply-To: <20181114180034.25558-1-guro@fb.com>
From:   Y Song <ys114321@gmail.com>
Date:   Fri, 16 Nov 2018 23:30:59 +0000
Message-ID: <CAH3MdRUxuoe98m-ui9JQOhUT+xZxW-yVM1Wkpa4fkxvkMgt_BA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: allocate local storage buffers using GFP_ATOMIC
To:     guroan@gmail.com
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        guro@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 6:01 PM Roman Gushchin <guroan@gmail.com> wrote:
>
> Naresh reported an issue with the non-atomic memory allocation of
> cgroup local storage buffers:
>
> [   73.047526] BUG: sleeping function called from invalid context at
> /srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
> [   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
> [   73.068342] INFO: lockdep is turned off.
> [   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
> 4.20.0-rc2-next-20181113 #1
> [   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   73.088018] Call Trace:
> [   73.090463]  dump_stack+0x70/0xa5
> [   73.093783]  ___might_sleep+0x152/0x240
> [   73.097619]  __might_sleep+0x4a/0x80
> [   73.101191]  __kmalloc_node+0x1cf/0x2f0
> [   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
> [   73.109909]  cgroup_storage_update_elem+0x46/0x90
>
> cgroup_storage_update_elem() (as well as other update map update
> callbacks) is called with disabled preemption, so GFP_ATOMIC
> allocation should be used: e.g. alloc_htab_elem() in hashtab.c.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>  kernel/bpf/local_storage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
