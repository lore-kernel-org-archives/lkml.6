Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57129C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186932054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547727078;
	bh=19sNeJAh4HonkDYZVWgdPcOaDBZBAOE5Ae/ImHkJapk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Qqqb0IojMjZPt6jF6YgU/qMGoGCLBJocpt9/VZCTRTJeppbU+C/0qUzhqrpzj0S0
	 zzd4R/v1VoEJtcaaXx5J2VNcA/OmMQDQ4Z3uAp4Hdxv4wFJ7MUbS80518k/LukAKvh
	 we8l6ncZUpY6YjmVfN3BHDspjzup4klWar2OPLVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfAQMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:11:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39396 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfAQMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:11:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so10882507otl.6;
        Thu, 17 Jan 2019 04:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxIgu+ssdyh4k+fK0G2jre2kzjLfEgitJPwARRAUwho=;
        b=TAa6ZE4V6wuooWpSFmhHaC2BI2wBL5b4dwyUORwJ2aTAnezQrZoXk85GjeUlmJquUz
         UMqSkOTZ/Cl8d1+DVNXGghGCgI5bgEmUNMOUceREPmdBSeQNWudFZp4Gln0eeFKcxKSf
         VDJJ91TW0Ay3JjePnb56wWVUzq6rDQbd4Am4Ol++ZYJSr+qTz2f7s3r0vzVupMN8oUR1
         4K8DUjb7ZpBEJN/m4hD0T0sMM26HByQQnH21WoL3R5Fmqgj0ZFSXR8jN52dRVwDZMiOK
         JgAL6LGrGrR1fizOsU7wEx9slqUkV5kGIxiY/piK8qsIzQbHWbHT/TeKSt+FwOw7Ewjl
         vm3g==
X-Gm-Message-State: AJcUukexMrINL/OfhICWbHRSIE49J7LQALd5rfX0f7mj3x1BNpXXeTNN
        UzSnqdz2AaYYFVRA8I4P8O1eArxfyykaMfgBuVcjjVtm
X-Google-Smtp-Source: ALg8bN42LWfRv9IR+uyfT8y7WNn0BxMdPheEVAtGpE0LNzCZmCMDXGt44ZumSNsxxPhHTkpfbSqWnTmE4rC2gLfD6HI=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr8865291oti.258.1547727074395;
 Thu, 17 Jan 2019 04:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-7-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-7-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 13:11:02 +0100
Message-ID: <CAJZ5v0jg24sNVQiA1AvVwP-uCCq1Uo9rxkAERyb_zDL_W8AATA@mail.gmail.com>
Subject: Re: [PATCHv4 06/13] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> If the HMAT Subsystem Address Range provides a valid processor proximity
> domain for a memory domain, or a processor domain with the highest
> performing access exists, register the memory target with that initiator
> so this relationship will be visible under the node's sysfs directory.
>
> Since HMAT requires valid address ranges have an equivalent SRAT entry,
> verify each memory target satisfies this requirement.

What exactly will happen after this patch?

There will be some new directories under
/sys/devices/system/node/nodeX/ if all goes well.  Anything else?

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/hmat.c | 143 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 136 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 833a783868d5..efb33c74d1a3 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -17,6 +17,43 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>
> +static LIST_HEAD(targets);
> +

A kerneldoc documenting the struct type here, please.

> +struct memory_target {
> +       struct list_head node;
> +       unsigned int memory_pxm;
> +       unsigned long p_nodes[BITS_TO_LONGS(MAX_NUMNODES)];
> +};
> +
> +static __init struct memory_target *find_mem_target(unsigned int m)

Why don't you call the arg mem_pxm like below?

> +{
> +       struct memory_target *t;
> +
> +       list_for_each_entry(t, &targets, node)
> +               if (t->memory_pxm == m)
> +                       return t;
> +       return NULL;
> +}
> +
> +static __init void alloc_memory_target(unsigned int mem_pxm)
> +{
> +       struct memory_target *t;
> +
> +       if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
> +               return;
> +
> +       t = find_mem_target(mem_pxm);
> +       if (t)
> +               return;
> +
> +       t = kzalloc(sizeof(*t), GFP_KERNEL);
> +       if (!t)
> +               return;
> +
> +       t->memory_pxm = mem_pxm;
> +       list_add_tail(&t->node, &targets);
> +}
> +
>  static __init const char *hmat_data_type(u8 type)
>  {
>         switch (type) {
> @@ -53,11 +90,30 @@ static __init const char *hmat_data_type_suffix(u8 type)
>         };
>  }
>
> +static __init void hmat_update_access(u8 type, u32 value, u32 *best)

I guess that you pass a pointer to avoid unnecessary updates, right?

But that causes you to dereference that pointer quite often.  It might
be better to pass the current value of 'best' and return an updated
one (which may be the same as the passed one, of course).

> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +       case ACPI_HMAT_READ_LATENCY:
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               if (!*best || *best > value)
> +                       *best = value;
> +               break;
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               if (!*best || *best < value)
> +                       *best = value;
> +               break;
> +       }
> +}
> +
>  static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>                                       const unsigned long end)
>  {
> +       struct memory_target *t;

I would call this variable mem_target.  't' is too easy to overlook
IMO.  [Same below]

>         struct acpi_hmat_locality *loc = (void *)header;
> -       unsigned int init, targ, total_size, ipds, tpds;
> +       unsigned int init, targ, pass, p_node, total_size, ipds, tpds;
>         u32 *inits, *targs, value;
>         u16 *entries;
>         u8 type;
> @@ -87,12 +143,28 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>         targs = &inits[ipds];
>         entries = (u16 *)(&targs[tpds]);
>         for (targ = 0; targ < tpds; targ++) {
> -               for (init = 0; init < ipds; init++) {
> -                       value = entries[init * tpds + targ];
> -                       value = (value * loc->entry_base_unit) / 10;
> -                       pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> -                               inits[init], targs[targ], value,
> -                               hmat_data_type_suffix(type));
> +               u32 best = 0;
> +
> +               t = find_mem_target(targs[targ]);
> +               for (pass = 0; pass < 2; pass++) {
> +                       for (init = 0; init < ipds; init++) {
> +                               value = entries[init * tpds + targ];
> +                               value = (value * loc->entry_base_unit) / 10;
> +
> +                               if (!pass) {
> +                                       hmat_update_access(type, value, &best);
> +                                       pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> +                                               inits[init], targs[targ], value,
> +                                               hmat_data_type_suffix(type));
> +                                       continue;
> +                               }
> +
> +                               if (!t)
> +                                       continue;
> +                               p_node = pxm_to_node(inits[init]);
> +                               if (p_node != NUMA_NO_NODE && value == best)
> +                                       set_bit(p_node, t->p_nodes);
> +                       }
>                 }
>         }
>         return 0;
> @@ -122,6 +194,7 @@ static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
>                                            const unsigned long end)
>  {
>         struct acpi_hmat_address_range *spa = (void *)header;
> +       struct memory_target *t = NULL;
>
>         if (spa->header.length != sizeof(*spa)) {
>                 pr_err("HMAT: Unexpected address range header length: %d\n",
> @@ -131,6 +204,23 @@ static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
>         pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
>                 spa->physical_address_base, spa->physical_address_length,
>                 spa->flags, spa->processor_PD, spa->memory_PD);
> +
> +       if (spa->flags & ACPI_HMAT_MEMORY_PD_VALID) {
> +               t = find_mem_target(spa->memory_PD);
> +               if (!t) {
> +                       pr_warn("HMAT: Memory Domain missing from SRAT\n");

Again, I'm wondering about the log level here.  I "warning" really adequate?

> +                       return -EINVAL;
> +               }
> +       }
> +       if (t && spa->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
> +               int p_node = pxm_to_node(spa->processor_PD);
> +
> +               if (p_node == NUMA_NO_NODE) {
> +                       pr_warn("HMAT: Invalid Processor Domain\n");

Same here.

> +                       return -EINVAL;
> +               }
> +               set_bit(p_node, t->p_nodes);
> +       }
>         return 0;
>  }
>
> @@ -154,6 +244,33 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
>         }
>  }
>
> +static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
> +                                         const unsigned long end)
> +{
> +       struct acpi_srat_mem_affinity *ma = (void *)header;
> +
> +       if (!ma)
> +               return -EINVAL;
> +       if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
> +               return 0;
> +       alloc_memory_target(ma->proximity_domain);
> +       return 0;
> +}
> +
> +static __init void hmat_register_targets(void)
> +{
> +       struct memory_target *t, *next;
> +       unsigned m, p;
> +
> +       list_for_each_entry_safe(t, next, &targets, node) {
> +               list_del(&t->node);
> +               m = pxm_to_node(t->memory_pxm);
> +               for_each_set_bit(p, t->p_nodes, MAX_NUMNODES)
> +                       register_memory_node_under_compute_node(m, p, 0);
> +               kfree(t);
> +       }
> +}
> +
>  static __init int hmat_init(void)
>  {
>         struct acpi_table_header *tbl;
> @@ -163,6 +280,17 @@ static __init int hmat_init(void)
>         if (srat_disabled())
>                 return 0;
>
> +       status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       if (acpi_table_parse_entries(ACPI_SIG_SRAT,
> +                               sizeof(struct acpi_table_srat),
> +                               ACPI_SRAT_TYPE_MEMORY_AFFINITY,
> +                               srat_parse_mem_affinity, 0) < 0)

Can you do

ret = acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
                               ACPI_SRAT_TYPE_MEMORY_AFFINITY,
srat_parse_mem_affinity, 0);
if (ret < 0)
        goto out_put;

here instead?  The current one is barely readable.

Also please add a comment to explain what it means if this returns an error.

> +               goto out_put;
> +       acpi_put_table(tbl);
> +
>         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
>         if (ACPI_FAILURE(status))
>                 return 0;
> @@ -173,6 +301,7 @@ static __init int hmat_init(void)
>                                              hmat_parse_subtable, 0) < 0)
>                         goto out_put;
>         }
> +       hmat_register_targets();
>  out_put:
>         acpi_put_table(tbl);
>         return 0;
> --
