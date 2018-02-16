Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeBPJim (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:38:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42414 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeBPJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:38:40 -0500
X-Google-Smtp-Source: AH8x2259GDe0bNkqUjIC10Pmt4gOnGdWSD6AoauOXu/kszPD6R/0xMBrTJe/CARWWi5GlbqIu0GCSg==
Date: Fri, 16 Feb 2018 10:38:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>, ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        tglx@linutronix.de, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v5 0/6] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180216093836.v6iq32jycy7sxwln@gmail.com>
References: <20180214054656.3780-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214054656.3780-1-bhe@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> This is v5 post. Newly added patch 0002 includes the change
> related to KEXEC_JUMP path. Patch 0003 only includes the
> regression fix.
> 
> A regression bug was introduced in below commit.
> commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
> 
> It caused the action to fail that we try to restore boot irq mode
> in reboot and kexec/kdump. Details can be seen in patch 0003.
> 
> Warning can always be seen during kdump kernel boot on qemu/kvm
> platform. Our customer even saw casual kdump kernel hang once in
> ~30 attempts during stress testing of kdump on KVM machine.
> 
> v4->v5:
>   Take out the change related to KEXEC_JUMP to a new patch 0002
>   according to Eric's suggestion.
>   Patch 0003 in this series only includes the regression fix.
> 
> v3->v4:
>   Eric pointed out that in patch 0002 the change related to
>   KEXEC_JUMP is not right.
>   Correct it.
> 
>   Add Fixes tag and Cc to stable.

Eric, are these patches looking good to you now?

Thanks,

	Ingo
