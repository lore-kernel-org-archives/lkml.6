Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC621C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE94521502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE94521502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sembritzki.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeHOUUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:20:40 -0400
Received: from mail.sembritzki.me ([5.45.101.249]:60304 "EHLO
        mail.sembritzki.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:20:39 -0400
Received: from [192.168.1.22] (x4dbb4132.dyn.telefonica.de [77.187.65.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.sembritzki.me (Postfix) with ESMTPSA id DB783A7A3E;
        Wed, 15 Aug 2018 19:27:33 +0200 (CEST)
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180815100053.13609-1-yannik@sembritzki.me>
 <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
From:   Yannik Sembritzki <yannik@sembritzki.me>
Openpgp: preference=signencrypt
Autocrypt: addr=yannik@sembritzki.me; prefer-encrypt=mutual; keydata=
 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
 YfNfIPB+
Message-ID: <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
Date:   Wed, 15 Aug 2018 19:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would this be okay?

diff --git a/arch/x86/kernel/kexec-bzimage64.c
b/arch/x86/kernel/kexec-bzimage64.c
index 7326078e..2ba47e24 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -41,6 +41,9 @@
 #define MIN_KERNEL_LOAD_ADDR   0x100000
 #define MIN_INITRD_LOAD_ADDR   0x1000000
 
+// Allow both builtin trusted keys and secondary trusted keys
+#define TRUST_FULL_KEYRING     (void *)1UL
+
 /*
  * This is a place holder for all boot loader specific data structure which
  * gets allocated in one call but gets freed much later during cleanup
@@ -532,7 +535,7 @@ static int bzImage64_cleanup(void *loader_data)
 static int bzImage64_verify_sig(const char *kernel, unsigned long
kernel_len)
 {
        return verify_pefile_signature(kernel, kernel_len,
-                                      NULL,
+                                      TRUST_FULL_KEYRING,
                                       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif
--

On 15.08.2018 18:54, Linus Torvalds wrote:
> This needs more people involved, and at least a sign-off.
>
> It looks ok, but I think we need a #define for the magical (void *)1UL
> thing. I see the use in verify_pkcs7_signature(), but still.
>
>               Linus
>
>
>
> On Wed, Aug 15, 2018 at 3:11 AM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 7326078e..eaaa125d 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
>>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
>>         return verify_pefile_signature(kernel, kernel_len,
>> -                                      NULL,
>> +                                      (void *)1UL,
>>                                        VERIFYING_KEXEC_PE_SIGNATURE);
>>  }
>>  #endif
>> --
>> 2.17.1
>>
>> The exact scenario under which this issue occurs is described here:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1554113
>>

