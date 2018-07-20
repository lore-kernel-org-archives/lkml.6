Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19543ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCBB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bKG+U0BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCBB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeGTIlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:41:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37416 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeGTIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:41:19 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so9248307ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oAN6trz2IhsdIjzlVlbmg2q6MIgeblkWsmAneV3zPQM=;
        b=bKG+U0BICI1Iaa+tBiMWTY7u3NZ1azlhOG+Bm6HNrdL/pzwSc7jpJdhgkDD7JoLW02
         vDnRayqJqxQ1tPtsePuGJUApqxYrNuPD1IwwMDKI2m2q4rDpYM5rb4NVOBaSpS+ToDEZ
         ivXV+jpGnJ/AKrAuicv9bBqfVhvjjmYQFYdNBqn7vDUZSQuMa9ACZ1KYITqIRX8VTsih
         A3A+8zYnAwnqQAj9tw19jGtoBtduosx80pAXhhF74VpSZfvRg6qniGPQKraPRLT6VCb/
         Rtwli+9DF00qZ1rDa8LGUuFMumteydswn5y/HvYRaRe3zxIV/BDJ1jn/7C8g9TTMDLWv
         9AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oAN6trz2IhsdIjzlVlbmg2q6MIgeblkWsmAneV3zPQM=;
        b=UY70YihHGkqM+yulPQd9Vlt28+J7+2gtRHy3a1b5mtJddxSyRvzfk1DPQ1t4FSSKw6
         blVELBKcLt8P1rwpCIggmCuqGsPkRPbbspWYwWyGTaKkb7EjDC7zuKcup6srotxoJpCq
         QTonek1NxS/l9A/B8tSzaim1vGLSQax9dgwhp25WF2VgcGadbuNRQWVZFrAmIn9lxoj8
         UMlb+DDbeV+NX1SoAxeZVxy7eokmPK1uolqwIXKMf4Kuw7t/wV3UzCqxAjCELU6g5bMG
         hyeUatagIbUrr4lPB53cwGaSH6PB2kaiRoUXMqbINQA9njWWdfSu0T7OxUs+4GLcFXRY
         a44g==
X-Gm-Message-State: AOUpUlHOVWVFCLVJr+9rK6fakHI8ishtjJe5nVQLnMvb59mjvl2BM3UH
        BcmQEAiQqdKoqSxocQzfMI7FiWpwTc795LHCZ6gdrw==
X-Google-Smtp-Source: AAOMgpc77TtgCo0I328KrEzw+0kclq+pbnb8jWB35jlhgP9DYoihhjzsCs5t/TpwbX+0GrdUhJ7LWDR3VjjgQVhFxKA=
X-Received: by 2002:a6b:1e52:: with SMTP id e79-v6mr742753ioe.110.1532073257512;
 Fri, 20 Jul 2018 00:54:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 00:54:16
 -0700 (PDT)
In-Reply-To: <20180719163208.5xvrafugpcbhh7kj@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com> <20180716122125.175792-3-maco@android.com>
 <20180719163208.5xvrafugpcbhh7kj@linux-8ccs>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 20 Jul 2018 09:54:16 +0200
Message-ID: <CAB0TPYFVSWtJ6RPRUZ1bpS-rBaV7YyPR-4B2Ogxs+FNAbiScNw@mail.gmail.com>
Subject: Re: [PATCH 2/6] module: add support for symbol namespaces.
To:     Jessica Yu <jeyu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Thu, Jul 19, 2018 at 6:32 PM, Jessica Yu <jeyu@kernel.org> wrote:
> First, thanks a lot for the patchset. This is definitely something that
> will help distros as well to declutter the exported symbol space and
> provide a more cleanly defined kernel interface.

Thanks, that's good to hear!


> Hm, I'm wondering if we could avoid all this extra module-ns-dependency
> checking work if we just put the import stuff as a modinfo tag, like
> have MODULE_IMPORT_NS() insert an "import:" tag like we already do for
> module parameters, author, license, aliases, etc. Then we'd have that
> information pretty much from the start of load_module() and we don't
> need to wait for relocations to be applied to __knsimport. Then you
> could do the namespace checking right at resolve_symbol() instead of
> going through the extra step of building a dependency list to be
> verified later.

I believe I did consider modinfo when I started with this a while
back, but don't recall right now why I didn't decide to use it;
perhaps it was the lack of support for multiple identical tags. Since
both modpost and the module loader have access to them, I don't see
why it wouldn't work, and indeed I suspect it would make the module
loader a bit simpler. I'll rework this and see what it looks like.

Thanks,
Martijn

>
> Also, this would get rid of the extra __knsimport section, the extra
> ns_dependencies field in struct module, and all those helper functions that
> manage it. In addition, having the modinfo tag may potentially help with
> debugging as we have the namespace imports clearly listed if we don't have
> the source code for a module. We'd probably need to modify get_modinfo() to
> handle multiple import: tags though. Luis [1] had written some code a while
> ago to handle multiple (of the same) modinfo tags.
>
> Thoughts on this?
>
> Thanks,
>
> Jessica
>
> [1] https://lkml.kernel.org/r/20171130023605.29568-3-mcgrof@kernel.org
>
>
>> getname:
>>         /* We must make copy under the lock if we failed to get ref. */
>>         strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
>> @@ -3061,6 +3118,11 @@ static int find_module_sections(struct module *mod,
>> struct load_info *info)
>>                                      sizeof(*mod->gpl_syms),
>>                                      &mod->num_gpl_syms);
>>         mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
>> +
>> +       mod->ns_imports = section_objs(info, "__knsimport",
>> +                                      sizeof(*mod->ns_imports),
>> +                                      &mod->num_ns_imports);
>> +
>>         mod->gpl_future_syms = section_objs(info,
>>                                             "__ksymtab_gpl_future",
>>                                             sizeof(*mod->gpl_future_syms),
>> @@ -3381,6 +3443,19 @@ static int post_relocation(struct module *mod,
>> const struct load_info *info)
>>         return module_finalize(info->hdr, info->sechdrs, mod);
>> }
>>
>> +static void verify_namespace_dependencies(struct module *mod)
>> +{
>> +       struct module_ns_dep *ns_dep;
>> +
>> +       list_for_each_entry(ns_dep, &mod->ns_dependencies, ns_dep) {
>> +               if (!module_imports_ns(mod, ns_dep->namespace)) {
>> +                       pr_warn("%s: module uses symbols from namespace
>> %s,"
>> +                               " but does not import it.\n",
>> +                               mod->name, ns_dep->namespace);
>> +               }
>> +       }
>> +}
>> +
>> /* Is this module of this name done loading?  No locks held. */
>> static bool finished_loading(const char *name)
>> {
>> @@ -3682,6 +3757,8 @@ static int load_module(struct load_info *info, const
>> char __user *uargs,
>>         if (err)
>>                 goto free_module;
>>
>> +       INIT_LIST_HEAD(&mod->ns_dependencies);
>> +
>> #ifdef CONFIG_MODULE_SIG
>>         mod->sig_ok = info->sig_ok;
>>         if (!mod->sig_ok) {
>> @@ -3730,6 +3807,8 @@ static int load_module(struct load_info *info, const
>> char __user *uargs,
>>         if (err < 0)
>>                 goto free_modinfo;
>>
>> +       verify_namespace_dependencies(mod);
>> +
>>         flush_module_icache(mod);
>>
>>         /* Now copy in args */
>> --
>> 2.18.0.203.gfac676dfb9-goog
>>
>
