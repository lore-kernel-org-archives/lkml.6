Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBQKqz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:46:55 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34696 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeBQKqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:46:54 -0500
X-Google-Smtp-Source: AH8x226VVjlOsILg74KsBvRJvuc1E7XGUtXdI/l1zIkfZzyVPO0Q8fselQeH5a/NSfcmVDyzkXgkJg==
Date: Sat, 17 Feb 2018 11:46:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v5 0/6] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180217104649.5xuzspdqkt6zjcud@gmail.com>
References: <20180214054656.3780-1-bhe@redhat.com>
 <20180216093836.v6iq32jycy7sxwln@gmail.com>
 <20180216102437.GA28912@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216102437.GA28912@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> Thanks for checking this!
> 
> I got warning message from kbuild test robot on previous v3 and v4. I
> guess this v5 post also has the issue since the code is the same, just
> patch format is changed.
> 
> Will report status after investigation.

Well, your patches didn't build when CONFIG_IO_APIC is disabled - I have fixed 
this by the patch below.

Thanks,

	Ingo

---
 arch/x86/include/asm/io_apic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 06fec4426458..fd20a2334885 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -233,6 +233,7 @@ static inline void io_apic_init_mappings(void) { }
 
 static inline void setup_IO_APIC(void) { }
 static inline void enable_IO_APIC(void) { }
+static inline void restore_boot_irq_mode(void) { }
 
 #endif
 
