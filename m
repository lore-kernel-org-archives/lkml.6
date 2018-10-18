Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA31ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C372A204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="U6aR27kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C372A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJRIr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:47:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42567 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:47:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id c23so26336018otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjsJ0DsFEkmGyRtmgim7gNhoMQW+hD3WUdpADcNww8c=;
        b=U6aR27kSPgtyZ5ruH4g8sl6q5+JPxcs0hI+X0ORG0RovamFXyM63T7MlAgaea0LFdu
         2HqnTkfYrSmEIOPGV3Y5HNvf6ifhffqJE10e7u3IX4VYMD+IM4viF7Qq1/y2GARks/cy
         z7oUfVehnBFVeYTLdzy6L+Tjql2sHv3NkB3Pt3WtjHtN6yNdVAo5Y8vu5PYzfmGEc9gO
         ImC2xdoaDyR947s8GKIgCPAFy0/tKwCzFZ4jThrL6P8TiwdWguDHTc/7CrztGyEOlMP5
         ZvpYZ3iAxh4r7ij3YSdVd1v5AHDVhI/KEk1+rpCg4S4J0V3BGpCihoto8/eXuwEDlX8R
         U4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjsJ0DsFEkmGyRtmgim7gNhoMQW+hD3WUdpADcNww8c=;
        b=RbnXX3uD8YTIXHirkSW07GHyWK5PVzrtH/upERQh2bYD+yjLEhaI5Q7ZjX9thNCUUr
         QGnrFteQH8OKC1lIfddHeGasI0gUXqynhYPWiyk43of4a73BDkCK9djj+tR6uHU88on9
         ifAlvulhYmoI+59sZILG8gi2aHK8zSQgLahKxk4psZSRw8qm5KfkcT00WQCa8HPAEWF/
         iflWOX5mJmNJMf2B76taDwJKrsPCKJNQ6j3pHfMpK6WKegzS2Lr2Rl10qg3x1ZlI2rpe
         G1U6vEc7yUu2jznvxUE554KQh+dPjQqpDMw+pLetmQmYoBog0LfIGzBudsAkbhWSCqWS
         TOyw==
X-Gm-Message-State: ABuFfohSuu+7vNDVnsTddEb38Isffbar29o16QFknZ0nbrg6wMoxA1p3
        vqe9ZLE+PIKw4DV2owdd/+KxWTxu2xV3/SytXRJuiQ==
X-Google-Smtp-Source: ACcGV638xfnIa/pFSfqFLPaGv8ns+Na3ycVq0mtH7X6uOKHwVjkFd9/6ggKvbRsO7eRokWlE+k7zevNtftWssnBe/Zk=
X-Received: by 2002:a9d:758f:: with SMTP id s15mr17498211otk.353.1539823776819;
 Wed, 17 Oct 2018 17:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast>
In-Reply-To: <20181018002924.GA42803@beast>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Oct 2018 17:49:25 -0700
Message-ID: <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> When ramoops reserved a memory region in the kernel, it had an unhelpful
> label of "persistent_memory". When reading /proc/iomem, it would be
> repeated many times, did not hint that it was ramoops in particular,
> and didn't clarify very much about what each was used for:
>
> 400000000-407ffffff : Persistent Memory (legacy)
>   400000000-400000fff : persistent_memory
>   400001000-400001fff : persistent_memory
> ...
>   4000ff000-4000fffff : persistent_memory
>
> Instead, this adds meaningful labels for how the various regions are
> being used:
>
> 400000000-407ffffff : Persistent Memory (legacy)
>   400000000-400000fff : ramoops:dump(0/252)
>   400001000-400001fff : ramoops:dump(1/252)
> ...
>   4000fc000-4000fcfff : ramoops:dump(252/252)
>   4000fd000-4000fdfff : ramoops:console
>   4000fe000-4000fe3ff : ramoops:ftrace(0/3)
>   4000fe400-4000fe7ff : ramoops:ftrace(1/3)
>   4000fe800-4000febff : ramoops:ftrace(2/3)
>   4000fec00-4000fefff : ramoops:ftrace(3/3)
>   4000ff000-4000fffff : ramoops:pmsg

Hopefully ramoops is doing request_region() before trying to do
anything with its ranges, because it's going to collide with the pmem
driver doing a request_region(). If we want to have pstore use pmem as
a backing store that's a new drivers/nvdimm/ namespace personality
driver to turn around and register a persistent memory range with
pstore rather than the pmem block-device driver.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/ram.c            | 16 +++++++++++++---
>  fs/pstore/ram_core.c       | 11 +++++++----
>  include/linux/pstore_ram.h |  3 ++-
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 6ea9cd801044..ffcff6516e89 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -587,9 +587,16 @@ static int ramoops_init_przs(const char *name,
>                 goto fail;
>
>         for (i = 0; i < *cnt; i++) {
> +               char *label;
> +
> +               if (*cnt == 1)
> +                       label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
> +               else
> +                       label = kasprintf(GFP_KERNEL, "ramoops:%s(%d/%d)",
> +                                         name, i, *cnt - 1);
>                 prz_ar[i] = persistent_ram_new(*paddr, zone_sz, sig,
> -                                                 &cxt->ecc_info,
> -                                                 cxt->memtype, flags);
> +                                              &cxt->ecc_info,
> +                                              cxt->memtype, flags, label);
>                 if (IS_ERR(prz_ar[i])) {
>                         err = PTR_ERR(prz_ar[i]);
>                         dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
> @@ -619,6 +626,8 @@ static int ramoops_init_prz(const char *name,
>                             struct persistent_ram_zone **prz,
>                             phys_addr_t *paddr, size_t sz, u32 sig)
>  {
> +       char *label;
> +
>         if (!sz)
>                 return 0;
>
> @@ -629,8 +638,9 @@ static int ramoops_init_prz(const char *name,
>                 return -ENOMEM;
>         }
>
> +       label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
>         *prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> -                                 cxt->memtype, 0);
> +                                 cxt->memtype, 0, label);
>         if (IS_ERR(*prz)) {
>                 int err = PTR_ERR(*prz);
>
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 0792595ebcfb..12e21f789194 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -438,11 +438,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>  }
>
>  static void *persistent_ram_iomap(phys_addr_t start, size_t size,
> -               unsigned int memtype)
> +               unsigned int memtype, char *label)
>  {
>         void *va;
>
> -       if (!request_mem_region(start, size, "persistent_ram")) {
> +       if (!request_mem_region(start, size, label ?: "ramoops")) {
>                 pr_err("request mem region (0x%llx@0x%llx) failed\n",
>                         (unsigned long long)size, (unsigned long long)start);
>                 return NULL;
> @@ -470,7 +470,8 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
>         if (pfn_valid(start >> PAGE_SHIFT))
>                 prz->vaddr = persistent_ram_vmap(start, size, memtype);
>         else
> -               prz->vaddr = persistent_ram_iomap(start, size, memtype);
> +               prz->vaddr = persistent_ram_iomap(start, size, memtype,
> +                                                 prz->label);
>
>         if (!prz->vaddr) {
>                 pr_err("%s: Failed to map 0x%llx pages at 0x%llx\n", __func__,
> @@ -541,12 +542,13 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
>         prz->ecc_info.par = NULL;
>
>         persistent_ram_free_old(prz);
> +       kfree(prz->label);
>         kfree(prz);
>  }
>
>  struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
>                         u32 sig, struct persistent_ram_ecc_info *ecc_info,
> -                       unsigned int memtype, u32 flags)
> +                       unsigned int memtype, u32 flags, char *label)
>  {
>         struct persistent_ram_zone *prz;
>         int ret = -ENOMEM;
> @@ -560,6 +562,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
>         /* Initialize general buffer state. */
>         raw_spin_lock_init(&prz->buffer_lock);
>         prz->flags = flags;
> +       prz->label = label;
>
>         ret = persistent_ram_buffer_map(start, size, prz, memtype);
>         if (ret)
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index e6d226464838..602d64725222 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -46,6 +46,7 @@ struct persistent_ram_zone {
>         phys_addr_t paddr;
>         size_t size;
>         void *vaddr;
> +       char *label;
>         struct persistent_ram_buffer *buffer;
>         size_t buffer_size;
>         u32 flags;
> @@ -65,7 +66,7 @@ struct persistent_ram_zone {
>
>  struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
>                         u32 sig, struct persistent_ram_ecc_info *ecc_info,
> -                       unsigned int memtype, u32 flags);
> +                       unsigned int memtype, u32 flags, char *label);
>  void persistent_ram_free(struct persistent_ram_zone *prz);
>  void persistent_ram_zap(struct persistent_ram_zone *prz);
>
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security
