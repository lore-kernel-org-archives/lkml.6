Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0222565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFcc/9aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E0222565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934316AbeGCRZi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:25:38 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35025 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeGCRZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:25:37 -0400
Received: by mail-ua0-f194.google.com with SMTP id q12-v6so1746023ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0B/ocUBw6FbBByVsbzXHbi2XzFHDvFJ6yowEnfWrFBI=;
        b=IFcc/9aYSZ3GitICx+iwliaLxCzI6J+xkoATcZL26G9JJRPU8d+GCiJp4rTx+/DkF3
         1lxWByj+XTxbnH1UMd2tYnvca/6T6O8KgoCRh18RjaIrydAbzhsH90NWRLs9ZULEpLGd
         z6Wcs1W9w83dfHXoP5r9QBSb9VbYTWosfcNYJu096Ht6BoNrhmLm/v0UqNkQ88MLoB/v
         dD0LF+NR9LJII++e6NjclSAbG9DsE+bb80X2CYMX4bRatfBZH1FnuVecVjQUXuxo2nCX
         eOkNWnyCAGL0165SpvhLKVEUIkTb8lmbqrC0uBwlkrAhM56OpqlTIom+1GhuCJyDAZj9
         b2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0B/ocUBw6FbBByVsbzXHbi2XzFHDvFJ6yowEnfWrFBI=;
        b=JwuOgKXF2oY4+5kv5HVovexmTTDRLQ3ed3ASDQDMwIo2d7LrNhPla4yJeFyMiFwJir
         z5JZF4VDMGaOnh+zFgaOZzHEmzGCNjZ8rsXCSu3ICz2nAS7pI4ENckBi0Y3rfU9CtUgX
         WJEg76LbVK0btptx+o5uXtMaWqLIfnLhSmHk7DLWHJJpbQ7EzixwsWbnknmwPgn0/zX0
         5zTzGXB+tvpZt5WBxxHvD7iqX756v2UBUcjqyLZTYxmmr+FOYpBTV8YHLKBHoMWe9zLc
         6BlXpUSZZQAl8CMWYvbJJO/v6SWUBntr+jIIvrZKWOgLbpRx0BgPWJlIxx7rWMP79piB
         bouQ==
X-Gm-Message-State: APt69E3LhbXpm36ybZ5a0j1TDsFfkCARKXJrRETa4mtp40+yNRMytgcD
        JyFuFoa5RHzR78p1LHin/agiV5MsaD7IPAayKDc=
X-Google-Smtp-Source: AAOMgpf3YR3QPRjjLv1ZxWE60lNPKtcJFXz7cOagUs3Wu/rzm+uVbuCSAJWk3C1KVL8qDLcE5hlYgUpvTDaQB2frw1A=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr10780522ual.141.1530638736224;
 Tue, 03 Jul 2018 10:25:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 10:25:33 -0700 (PDT)
In-Reply-To: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 20:25:33 +0300
Message-ID: <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     ufo19890607@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        aarcange@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuzhoujian@didichuxing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 7:38 PM,  <ufo19890607@gmail.com> wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
>
> The current system wide oom report prints information about the victim
> and the allocation context and restrictions. It, however, doesn't
> provide any information about memory cgroup the victim belongs to. This
> information can be interesting for container users because they can find
> the victim's container much more easily.
>
> I follow the advices of David Rientjes and Michal Hocko, and refactor
> part of the oom report. After this patch, users can get the memcg's
> path from the oom report and check the certain container more quickly.
>
> The oom print info after this patch:
> oom-kill:constraint=3D<constraint>,nodemask=3D<nodemask>,oom_memcg=3D<mem=
cg>,task_memcg=3D<memcg>,task=3D<comm>,pid=3D<pid>,uid=3D<uid>


> +static const char * const oom_constraint_text[] =3D {
> +       [CONSTRAINT_NONE] =3D "CONSTRAINT_NONE",
> +       [CONSTRAINT_CPUSET] =3D "CONSTRAINT_CPUSET",
> +       [CONSTRAINT_MEMORY_POLICY] =3D "CONSTRAINT_MEMORY_POLICY",
> +       [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
> +};

I'm not sure why we have this in the header.

This produces a lot of noise when W=3D1.

In file included from
/home/andy/prj/linux-topic-mfld/include/linux/memcontrol.h:31:0,
                from /home/andy/prj/linux-topic-mfld/include/net/sock.h:58,
                from /home/andy/prj/linux-topic-mfld/include/linux/tcp.h:23=
,
                from /home/andy/prj/linux-topic-mfld/include/linux/ipv6.h:8=
7,
                from /home/andy/prj/linux-topic-mfld/include/net/ipv6.h:16,
                from
/home/andy/prj/linux-topic-mfld/net/ipv4/netfilter/nf_log_ipv4.c:17:
/home/andy/prj/linux-topic-mfld/include/linux/oom.h:32:27: warning:
=E2=80=98oom_constraint_text=E2=80=99 defined but not used [-W
unused-const-variable=3D]
static const char * const oom_constraint_text[] =3D {
                          ^~~~~~~~~~~~~~~~~~~
 CC [M]  net/ipv4/netfilter/iptable_nat.o


If you need (but looking at the code you actually don't if I didn't
miss anything) it in several places, just export.
Otherwise put it back to memcontrol.c.

--=20
With Best Regards,
Andy Shevchenko
