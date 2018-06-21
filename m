Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7568521076
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568521076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFUP6Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:58:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36799 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFUP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:58:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so3293236qtp.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=597dF/sKwLSYFmLI/mNRUCwfLElNIoZpqH0EjY6O11s=;
        b=crbAMXjdbH32CepChceZA6OTWJw4Es5SoM76KwisypKgazUemkEbQ95t4u+0Cv1AeS
         pg1B15g1yjwI9BbDsyccLRCTHpUWWmdJ8C0KRZs36ECricA2ZzZ/I676zgLp0UmC7ofm
         KEu7KNgZPDlE6F9z2lKgXmmLnpt86/8ZYoB80ZX0z2Z2ywjGGQnzFz5LjcNQt1+h2oL8
         jg0MSLplHxwEcbq/EWCN1t0Mdc/NB4Q1QPGJcNe8IwKMnxXD8XeednLKrbgSoVzIImQw
         hbvIye5b6xaidZ7A3HxhN0PwolwfFDP9XM+aLFNevAaKfVsaQ9giIOVlTM4EbEprNT/q
         Q/4A==
X-Gm-Message-State: APt69E0Oo6IrRVY7hqZkZT8hGNJzblvVcc5JnuQ9M0uKR0brl+yjYIqe
        sRQ/MTgIQNWHqDZOJg029j1GYg==
X-Google-Smtp-Source: ADUXVKIEmjcDzrsjJifLTrt/tVmdS2N940/bxV47VI4RO1HQWfrIBFZq+DfcgO2V5zT6Q0GyK75bjg==
X-Received: by 2002:aed:2798:: with SMTP id a24-v6mr24397222qtd.40.1529596702274;
        Thu, 21 Jun 2018 08:58:22 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::30ff? ([2601:602:9802:a8dc::30ff])
        by smtp.gmail.com with ESMTPSA id h43-v6sm4356071qth.6.2018.06.21.08.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 08:58:21 -0700 (PDT)
Subject: Re: [PATCHv4 3/3] x86: Add build salt to the vDSO and kernel linker
 scripts
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
References: <20180612003224.3658-1-labbott@redhat.com>
 <20180612003224.3658-4-labbott@redhat.com> <20180621124334.GA30110@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <d55c2992-09b8-5182-419d-8efa5782ea16@redhat.com>
Date:   Thu, 21 Jun 2018 08:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621124334.GA30110@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 05:43 AM, Ingo Molnar wrote:
> 
> * Laura Abbott <labbott@redhat.com> wrote:
> 
>>
>> Both the kernel and the vDSO need to have unique build ids.
>> Insert the build salt section to make the build ids unique.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   arch/x86/entry/vdso/vdso-layout.lds.S | 3 ++-
>>   arch/x86/kernel/vmlinux.lds.S         | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> What is the upstream merge plan for this series? kbuild tree?
> 
> Thanks,
> 
> 	Ingo
> 

There was an alternate proposal that requires slightly fewer
changes that needs to be cleaned up and submitted. I do
think the plan is for the series to eventually go through
the kbuild tree.

Thanks,
Laura
