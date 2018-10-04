Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F021477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0F021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJDQZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeJDQZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37EA4C04B2CD;
        Thu,  4 Oct 2018 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA70D194A0;
        Thu,  4 Oct 2018 09:33:19 +0000 (UTC)
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
 <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
 <20181003113435.GB4436@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <dac69aae-27cf-9c93-a0ee-b65e241e1dd6@redhat.com>
Date:   Thu, 4 Oct 2018 17:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003113435.GB4436@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 04 Oct 2018 09:33:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月03日 19:34, Borislav Petkov 写道:
> On Wed, Oct 03, 2018 at 11:57:59AM +0800, lijiang wrote:
>> I noticed that your test was based on [patch v8 RESEND 4/4],
> 
> How did you notice that?
> 
> Let's see, the patch in question is this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=rc6%2b0-sme-kdump&id=4a0f2adf6cf374ed3e742134e40591ea33d55b05
> 
> and it has a Link tag:
> 
> Link: https://lkml.kernel.org/r/be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com
> 
> Now let's open that link tag. I don't know about you but my browser says:
> 
> https://lore.kernel.org/lkml/be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com/T/#u
> 
> which points to
> 
> Subject: Re: [PATCH v9 4/4] kdump/vmcore: support encrypted old memory with SME enabled
> 
> Looking at that mail, its message id is:
> 
> Message-ID: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
> 
> It looks to me it is already v9, no?
> 

According to your description, it seems that the patch is v9. In fact, there is only
different the content of header file between [patch v8 RESEND 4/4] and [patch v9 4/4].

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3e4ba9d753c8..84d8ddcb818e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,19 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_X86_64)
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					  size_t csize, unsigned long offset,
+					  int userbuf);
+#else
+static inline
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf)
+{
+	return 0;
+}
+#endif
+


I have tested the patch again based on upstream 4.19.0-rc6, it works very well.

I'm not sure whether your machine has also SME feature. If it has no SME feature and
previously kdump could work well, after we apply these patches, kdump should be able
to work properly too. I suggest a comparison test for them. Because it is similar to
the situation that SME is disabled.

If your machine has SME feature and SME is also enabled, these patches should be applied
before we test kdump, otherwise kdump won't work.

This was your command that loaded crash kernel and initrd:
# ~/bpetkov/bin/sbin/kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd /boot/initrd-4.19.0-rc6+ --command-line="root=/dev/mapper/ubuntu--010236012132--vg-leap15 splash=silent showopts console=ttyS5,115200 console=tty0 debug ignore_loglevel log_buf_len=16M 1 irqpoll maxcpus=1 reset_devices vga=normal"

If this option(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT) was not enabled by default,
that just tested the case which SME was disabled(because it had no "mem_encrypt=on"
in the kernel command-line). As previously mentioned, maybe it is necessary to do
a comparison test for them.

I have no test environment for Ubuntu. Would you like to share the panic log? 

Thanks.
Lianbo
