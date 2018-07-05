Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A340DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C5E20847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C5E20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGETIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:08:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41748 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeGETId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:08:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so8029880qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7nJecALQ2Ni1zTRFHD69B1x9Bb6JcxzQGgr7FGpduw=;
        b=G9fEjFVAh2TA33JfNY1ZU+3vhjONRMZbg6d3BeLG39gmIXxeYnvDd/1CYCTNz6fKem
         nOQdnDu2XU1q/l6Z0mvlEdnoC9O+bCjEHVdBfvebdFj6zf9iq1Dfyj1JeOUGvBwCpFUJ
         +v/SHQwCDpb9Y2IQpKc1WzkOBwctTqUS7IIdrbIe1qvA1ar4axMaOM+D+WhUk2kr16S0
         QTO/8MLyDXxJrAXvMTNFxdpL0yobL2P1teg6d1tuNIvShoDOFXvG26C4ZqaFr7dbbqwx
         YS7Lk+Bq52WdFxxhiHYN8oOtQ9brBUteppYexN8FVabnZm9PYBZ7yeV+6vaFxlqp072k
         vdSg==
X-Gm-Message-State: APt69E1lwakmdIrgWChpRvHCHh7HyJirpzKf2Fhe0VtkE6eYV07m/K0J
        n4fYlbK4UpfTEA69WcF/Mb6QdQ==
X-Google-Smtp-Source: AAOMgpfwKeJ/R/64lqyJ9E8la+ivcQSzW10JnM8xSvq+rl1oFtXY97dp+Etfyg8aHRwjnV2XpNNCHg==
X-Received: by 2002:aed:2a33:: with SMTP id c48-v6mr6636058qtd.147.1530817712430;
        Thu, 05 Jul 2018 12:08:32 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h195-v6sm4185525qke.58.2018.07.05.12.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 12:08:31 -0700 (PDT)
Subject: Re: [PATCHv5 2/4] x86: Add build salt to the vDSO
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-3-labbott@redhat.com>
 <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2abd8138-0f62-79a5-5a2c-8e08aee171b8@redhat.com>
Date:   Thu, 5 Jul 2018 12:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 08:58 AM, Andy Lutomirski wrote:
> On Tue, Jul 3, 2018 at 4:34 PM, Laura Abbott <labbott@redhat.com> wrote:
>>
>> The vDSO needs to have a unique build id in a similar manner
>> to the kernel and modules. Use the build salt macro.
>>
> 
> Looks good to me.  I have no idea whose tree these would go through.
> 

I was intending this to go through kbuild tree. Can I take this
as an Ack?

>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v5: Switched to using the single line BUILD_SALT macro
>> ---
>>   arch/x86/entry/vdso/vdso-note.S   | 3 +++
>>   arch/x86/entry/vdso/vdso32/note.S | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
>> index 79a071e4357e..79423170118f 100644
>> --- a/arch/x86/entry/vdso/vdso-note.S
>> +++ b/arch/x86/entry/vdso/vdso-note.S
>> @@ -3,6 +3,7 @@
>>    * Here we can supply some information useful to userland.
>>    */
>>
>> +#include <linux/build-salt.h>
>>   #include <linux/uts.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>> @@ -10,3 +11,5 @@
>>   ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>> +
>> +BUILD_SALT
>> diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
>> index 9fd51f206314..e78047d119f6 100644
>> --- a/arch/x86/entry/vdso/vdso32/note.S
>> +++ b/arch/x86/entry/vdso/vdso32/note.S
>> @@ -4,6 +4,7 @@
>>    * Here we can supply some information useful to userland.
>>    */
>>
>> +#include <linux/build-salt.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>>
>> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>>
>> +BUILD_SALT
>> +
>>   #ifdef CONFIG_XEN
>>   /*
>>    * Add a special note telling glibc's dynamic linker a fake hardware
>> --
>> 2.17.1
>>

