Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48720851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/+HZOG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A48720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeH1VxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:53:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39480 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeH1VxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:53:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so2172336lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKLBG9o7tGQK6lSHp5I+sdPD5jpw+wRP0N+QPGYhLFk=;
        b=M/+HZOG1vPvEk0qJc476htBmsD4dkft8g1a7OLbiyQKuJcCoX3Iy7lmNTw+BjLEITw
         dOG+zdDgZ+JlHASvbnQ4ldlThrvunWCzJv1OnGigL3p9BxrgQcsiGhF01a0V7YlSK3dZ
         CnZ0eMAmYIeHnBwb/tvhriSuZ5WH0azO8if1ORl2X//7Uyb/s9noJva+mZ6/La5JahGL
         9OA3LBT8XttD3HbFwzx4wv0yTsG8RenFfWWJdepxDTdJ1SHteLkZtAIvRPtsOtnPLkR6
         X4j7Tvie8X3VvjgvkWCBG/Y+BU8vA62+bhq1LXtflGeNykqQzNzStU7C49F+vGqALlUR
         2k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKLBG9o7tGQK6lSHp5I+sdPD5jpw+wRP0N+QPGYhLFk=;
        b=eObNEMAELtWmN40ngbfVwMAQQhm5AMKyiPzWbhEbAYFPQI1WMZyI5IOui3dreEscDg
         x8NSXl3Ye82THLCVbx4Bwet6e9p8+OtDovky3tiwB02SAsKx/JcH/W6R1+oQ1zBXypDp
         eLolS1KZ1uVgXNQziKKk8agirJWlU30QVpuRjcWYCSrsP1vpN8HqFhKGyJdrc3aAta9J
         YmSgWEeURURSSNBWbT71BHpyjRif46qepBf1Xil51I6KbtF2QfPQnYNHFjx+wGBeWtP0
         4awLJKaK7p836/QgTl+CN+60CHytQquU7QNJzPPUvObOwLIR0kevIRLDSQT+y/1A/mFl
         B71Q==
X-Gm-Message-State: APzg51BRRoDd2eHFVxVtFP96OUVa6Q66Fe/NKhXTT2funTpoZZqdYDfd
        PoKqvR63r4RpyUoFfoyM/bQKJxo2qKlqsqmpPaw=
X-Google-Smtp-Source: ANB0Vda5ImcqkZq+WGh/xlHsaUVNsbvPUITVMju8MXLuk5EoRJt2Qs1xG5QlFrt11wPYTuqcs/9nMeuMGk1LX2xySv4=
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr1936719ljt.56.1535479219078;
 Tue, 28 Aug 2018 11:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180828174952.GA29229@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180828174952.GA29229@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 28 Aug 2018 23:33:09 +0530
Message-ID: <CAFqt6zaDm-ashgujTicR1zcdkoPc=-VzopiTV3+hcin==t_o4g@mail.gmail.com>
Subject: Re: [PATCH] mm: Conveted to use vm_fault_t
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        mgorman@techsingularity.net, ak@linux.intel.com,
        tim.c.chen@linux.intel.com,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:18 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> As part of vm_fault_t conversion filemap_page_mkwrite()
> for NOMMU case was missed. Now converted.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

cc: Matthew Wilcox <willy@infradead.org>

> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 52517f2..de6fed2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2748,9 +2748,9 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>         return generic_file_mmap(file, vma);
>  }
>  #else
> -int filemap_page_mkwrite(struct vm_fault *vmf)
> +vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  {
> -       return -ENOSYS;
> +       return VM_FAULT_SIGBUS;
>  }
>  int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
>  {
> --
> 1.9.1
>
