Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E445CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC6D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKS1rELE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfAKKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:08:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37143 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:08:39 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so11782351iok.4;
        Fri, 11 Jan 2019 02:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUPiDJ7lnfm6wI/6H7WU6hN/VwCa62q6oRlvnlQWtA4=;
        b=pKS1rELEFRWnEbgPRB33fqg4Ldf7pDMNfaJWJK6PiMwPiBUhTDbirHslHtkELzOgpS
         rhqnyqt0uCNkHo1dYwmIRvEq1dfumYu3VqyGs7TaQ77sfaeGVzznsCl6oE+ySWZg6uRE
         lcXFSJPjc1PmPi+qTm/TQ2+phaFZnLXZCq5cPS9OTqD6kepoo7AbNDSN0YhDYccacXCL
         +YQgVB2slDxHWxi5EDdKK7gTZ5sgzQiqueEuGmgymvVLDu9LwNuy8Mfh034yTCDlxg4s
         /Qmcza0Q2Gj9nyAvp2u7nK+HgQmHDThCgds5rtWP5f8LceXsWKH55q+a+Is8uQo/d+VY
         8N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUPiDJ7lnfm6wI/6H7WU6hN/VwCa62q6oRlvnlQWtA4=;
        b=UaUYSyx161ODABofgSVW4HNHAHsbMaYAOvNiyysOVhr9Pa66HYlSJi3qnpTWuh3YC/
         FLmke9xb3CzhqhHTNe0eMmPPWeRbPS7GH4JOGx4OQzZf4vQzcqCDnMkrgoU1urIwE43L
         VY4N8sO6eNjYbV5l8jqtetaNJkgpZrH603pCDTi+1LnsC/ktwqRH4Uq/YKCxHDRHKX5d
         hIE0wTlUsgHpaXBirHM3lqdsuGEuwgPi77zLRyO4ATAekcw9K6n31XHsnwLTWuYleGcg
         8ThCxJOROBJkcivyJRizgsAfK4NOZNSUbnUefQ1AxfJDydU4P2gcYRTMCyubvucYcDjr
         Ys2A==
X-Gm-Message-State: AJcUukeNjstzv8uOzMGDj9lY+9ilB0ju5miy72/ySx6yGT0K86S27V8r
        htV7wuzyLB3KPO3Dh32QFwPw0RajcUngzulhPg==
X-Google-Smtp-Source: ALg8bN6WNs9URoD/NSCPCuBXeMSAJYykLzC0vXg1F0Wbe88bwpgBSntGdZZd1qx3KHGpRnmJFPd6BTU9VL+vpU+enrI=
X-Received: by 2002:a6b:3f06:: with SMTP id m6mr8569121ioa.117.1547201318130;
 Fri, 11 Jan 2019 02:08:38 -0800 (PST)
MIME-Version: 1.0
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-3-git-send-email-kernelfans@gmail.com> <20190111053036.GA13263@localhost.localdomain>
In-Reply-To: <20190111053036.GA13263@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 11 Jan 2019 18:08:26 +0800
Message-ID: <CAFgQCTvWk6t_8fQG3OqNAQDX-23ZaRuCzRyM40-do1rPAhzwhw@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] acpi: change the topo of acpi_table_upgrade()
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Baoquan He <bhe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:31 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Fri, Jan 11, 2019 at 01:12:52PM +0800, Pingfan Liu wrote:
> >The current acpi_table_upgrade() relies on initrd_start, but this var is
> >only valid after relocate_initrd(). There is requirement to extract the
> >acpi info from initrd before memblock-allocator can work(see [2/4]), hence
> >acpi_table_upgrade() need to accept the input param directly.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: Andy Lutomirski <luto@kernel.org>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >Cc: Len Brown <lenb@kernel.org>
> >Cc: Yinghai Lu <yinghai@kernel.org>
> >Cc: Tejun Heo <tj@kernel.org>
> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Juergen Gross <jgross@suse.com>
> >Cc: Andrew Morton <akpm@linux-foundation.org>
> >Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> >Cc: Michal Hocko <mhocko@suse.com>
> >Cc: x86@kernel.org
> >Cc: linux-acpi@vger.kernel.org
> >Cc: linux-mm@kvack.org
> >---
> > arch/arm64/kernel/setup.c | 2 +-
> > arch/x86/kernel/setup.c   | 2 +-
> > drivers/acpi/tables.c     | 4 +---
> > include/linux/acpi.h      | 4 ++--
> > 4 files changed, 5 insertions(+), 7 deletions(-)
> >
> >diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >index f4fc1e0..bc4b47d 100644
> >--- a/arch/arm64/kernel/setup.c
> >+++ b/arch/arm64/kernel/setup.c
> >@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
> >       paging_init();
> >       efi_apply_persistent_mem_reservations();
> >
> >-      acpi_table_upgrade();
> >+      acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
> >
> >       /* Parse the ACPI tables for possible boot-time configuration */
> >       acpi_boot_table_init();
> >diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >index ac432ae..dc8fc5d 100644
> >--- a/arch/x86/kernel/setup.c
> >+++ b/arch/x86/kernel/setup.c
> >@@ -1172,8 +1172,8 @@ void __init setup_arch(char **cmdline_p)
> >
> >       reserve_initrd();
> >
> >-      acpi_table_upgrade();
> >
> I wonder whether this will cause two blank lines together.
>
Yes, will fix it in next version.

Thanks,
Pingfan
> Thanks,
> Chao Fan
>
> >+      acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
> >       vsmp_init();
> >
> >       io_delay_init();
> >diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> >index 61203ee..84e0a79 100644
> >--- a/drivers/acpi/tables.c
> >+++ b/drivers/acpi/tables.c
> >@@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
> >
> > #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
> >
> >-void __init acpi_table_upgrade(void)
> >+void __init acpi_table_upgrade(void *data, size_t size)
> > {
> >-      void *data = (void *)initrd_start;
> >-      size_t size = initrd_end - initrd_start;
> >       int sig, no, table_nr = 0, total_offset = 0;
> >       long offset = 0;
> >       struct acpi_table_header *table;
> >diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >index ed80f14..0b6e0b6 100644
> >--- a/include/linux/acpi.h
> >+++ b/include/linux/acpi.h
> >@@ -1254,9 +1254,9 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
> > #endif
> >
> > #ifdef CONFIG_ACPI_TABLE_UPGRADE
> >-void acpi_table_upgrade(void);
> >+void acpi_table_upgrade(void *data, size_t size);
> > #else
> >-static inline void acpi_table_upgrade(void) { }
> >+static inline void acpi_table_upgrade(void *data, size_t size) { }
> > #endif
> >
> > #if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
> >--
> >2.7.4
> >
> >
> >
>
>
