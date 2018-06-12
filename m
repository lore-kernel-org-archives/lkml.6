Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C581C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E52089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9E52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeFLSSI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:18:08 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39246 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:18:06 -0400
Received: by mail-ot0-f196.google.com with SMTP id l15-v6so28181711oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xkWY7zmQSEXZjkRufIMRw8r9klQvi3fwFqVBxg5CAmM=;
        b=lpO+IwBIVqlGi079rdcEyDcK/s3nlRgW/ozi0x7/iI/Q2Vb8RFeK8lmB1Q5m5+iRcA
         rFVr5as24za++GPU6l2yRtsFlOLH12Qv4q9ZqGg3o1NxCATRWJtqVuAuWgZdYo0TXAXu
         tbpnaWXL0eRYWcxliqK6FMiQiVEu0UKIIQKxqoKbAG/dYzwq16Xe4McbA39UZ4ALdSHm
         kD7L30LRdlhQbX18OptUXmDbD78Bju2CqjjI7qFEOrnUPBoaNpNEQ+4LQuK5BVDCI3j1
         Afb4YXXo0gD9nN40YhxYCPL8tOPm5YT2qf6zBSSXSbcOksD3yLZ/Xg+9Q5SOsWj693rz
         Wtpw==
X-Gm-Message-State: APt69E3lBAJihBaUOZ0n5V7E7K2yqYD4UUaEaiR5E+4q2722VOn652sp
        QlXLGn+/jiCRDUQgdnMJA8qd7w==
X-Google-Smtp-Source: ADUXVKKemvp1COXWfGVWQucNMe4lPYmZF6U+pych2vMvGGM92frvNJF2UbGURk3c5QQWglPwprZLqg==
X-Received: by 2002:a9d:4098:: with SMTP id n24-v6mr973469ote.69.1528827486057;
        Tue, 12 Jun 2018 11:18:06 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::30ff? ([2601:602:9802:a8dc::30ff])
        by smtp.gmail.com with ESMTPSA id 17-v6sm320470oir.27.2018.06.12.11.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:18:04 -0700 (PDT)
Subject: Re: [PATCHv4 1/3] scripts: Preprocess module-common.lds
To:     Michael Ellerman <mpe@ellerman.id.au>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andy Lutomirski <luto@kernel.org>,
        mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
References: <20180612003224.3658-2-labbott@redhat.com>
 <201806120915.NeKL1aUj%fengguang.wu@intel.com>
 <8736xsv8w3.fsf@concordia.ellerman.id.au>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <1d6bf671-ec88-2d04-065c-96045759c680@redhat.com>
Date:   Tue, 12 Jun 2018 11:18:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8736xsv8w3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 11:03 PM, Michael Ellerman wrote:
> kbuild test robot <lkp@intel.com> writes:
> 
>> Hi Laura,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.17 next-20180608]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/scripts-Preprocess-module-common-lds/20180612-083632
>> config: i386-randconfig-a1-201823 (attached as .config)
>> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld: cannot open linker script file scripts/module-common.lds: No such file or directory
> 
> This seems to need the following.
> 
> cheers
> 
> 
> diff --git a/Makefile b/Makefile
> index 73f0bb2c7a98..55a5725b6606 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -425,7 +425,7 @@ KBUILD_AFLAGS_KERNEL :=
>   KBUILD_CFLAGS_KERNEL :=
>   KBUILD_AFLAGS_MODULE  := -DMODULE
>   KBUILD_CFLAGS_MODULE  := -DMODULE
> -KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
> +KBUILD_LDFLAGS_MODULE := -T $(objtree)/scripts/module-common.lds
>   LDFLAGS :=
>   GCC_PLUGINS_CFLAGS :=
>   
> 

Thanks for pointing that out. I think I missed that when refactoring.
I'll fix that in the next version plus adding your powerpc patch.

Thanks,
Laura
