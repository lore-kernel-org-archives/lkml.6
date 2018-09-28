Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7170FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D735206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/BM97Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D735206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeI2Djg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:39:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43650 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2Djf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:39:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so5089875pfi.10;
        Fri, 28 Sep 2018 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gugVoLtQWJsdxQYlShC7gKhYkEWR+0P3gKoKgTydMUI=;
        b=n/BM97BapwpdRuon7Upb7biuCGT0K4kwpb+Wk81bLe9kvqViBydjDtcjSeiAIZU3J1
         HJRDIt3XJFhWowHBFWdZ6U2m5U40jKYa7HbPM1vbxaS7jFHsy6qnVUAWajnrK0zPC6GJ
         SWgIEBSDy4jkeP3hlJ3xC9tQ9DbaoOOwia8NAOF9CPtNwJfkj6zZgiiP96xLlXbjocqH
         FFsPSFg9GgEE5tiRJ8JPHdsWhD0id0SaT62TE4xcRXJmacpqutH42XmaanzrX0pSuNcp
         DuxJsUnYzMuJwvhgO/SBx2FbUmetOQbLZ7J4FhdlulIawJaS7lwOYOUtxGLXXu5h4dcl
         aJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gugVoLtQWJsdxQYlShC7gKhYkEWR+0P3gKoKgTydMUI=;
        b=fEJUy1gq+2SPITnip6Xz3iPoBMa6Uqwe0uxATPpZ7sHgEMuSuI0omZ0rGBKewqYvj/
         bpkBjfXLLI2+ZrlWiV+4y8fbT8a3igD/WbIL7/Z0H6izuQYW5quChno4bDRQmAmTC8Cv
         k+wa1Nx3G9h9eYd+WksTBvC0efa/VFlUg9xDYYkRWrzl8gyhd/WSsLQvO2OwmN4M96wR
         y6/l4Wz1DUunB+Ypz4sxhxkoUvAkS0rGIMoYp188O/W9ZbCykW0g+xehw0aDVvOQU5Wl
         2gU6BHDX5Anfs004zlCQICkBYP1B0kUAMnVp65bldq9H+PmUfqG7esvahrCwZv3w+ZQ7
         qamg==
X-Gm-Message-State: ABuFfojvEFEU9tWQG6ibsrXH/sGxi/QwAS0RN/HLCTwUSGxZaed4LU8f
        ohe+eDagWHKL1t0xzgw/5Zg=
X-Google-Smtp-Source: ACcGV60CYHoq37KalHLXGiSFVTeW+Nq/pDjAFIS35lM0dlfKaAsz4N3RrLPAML4pvXfJGtAh21Hu9w==
X-Received: by 2002:a62:69c9:: with SMTP id e192-v6mr355908pfc.35.1538169241021;
        Fri, 28 Sep 2018 14:14:01 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r18-v6sm7683635pgj.51.2018.09.28.14.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:14:00 -0700 (PDT)
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
To:     Rob Herring <robh+dt@kernel.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
Date:   Fri, 28 Sep 2018 14:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/18 06:44, Rob Herring wrote:
> +David Gibson
> 
> On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>>
>> These functions will be used later to handle kexec-specific properties
>> in arm64's kexec_file implementation.

As I requested in version 14:

  The intent of the helper functions is related to properties whose values are
   tuples of the same format as the "reg" property of the "/memory" nodes.  For
   example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
   the "/chosen" node.

   The patch header and the function names should be updated to reflect this intent.


>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree@vger.kernel.org
>> ---

Missing list of changes since version 14.


>>  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of_fdt.h |  4 +++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 800ad252cf9c..c65c31562ccb 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/debugfs.h>
>>  #include <linux/serial_core.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/types.h>
>>
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #include <asm/page.h>
>> @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
>>  #endif
>>
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */

In v14 I requested:

   Please add comment:

   /* helper functions for arm64 kexec */


>> +
>> +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
>> +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
>> +
>> +int fdt_prop_len(const char *prop_name, int len)

In v14, I requested:

   Please rename as fdt_len_added_prop()

I'm not really happy with my suggested name, but do not have a
better one yet.  As Rob notes, maybe David G will have a helpful
comment.


>> +{
>> +       return (strlen(prop_name) + 1) +
>> +               sizeof(struct fdt_property) +
>> +               FDT_TAGALIGN(len);
> 
> Looks like you are using this to calculate how much space you need to
> allocate in addition to the current DTB for a couple of new or
> replaced properties. I'm not sure that this calculation is completely
> accurate. And it is strange there doesn't seem to be any libfdt
> function for this already. It would be simpler to just add some fixed
> additional amount.
> 
> Maybe David G has comments on this?
> 
>> +}
>> +
> 
> The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> should go into libfdt, but I'm fine with having it in the kernel for
> now.
> 
>> +static void fill_property(void *buf, u64 val64, int cells)

In v14 I requested:

Please rename as cpu64_to_fdt_cells()


>> +{
>> +       __be32 val32;
>> +
>> +       while (cells) {
>> +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
>> +               memcpy(buf, &val32, sizeof(val32));
>> +               buf += sizeof(val32);
> 
> This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> 
> BTW, for purposes of moving to libfdt, we'll need the authors'
> (Masahiro Yamada and Hans de Goede) permission to dual license.
> 
>> +       }
>> +}
>> +
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +                                               u64 addr, u64 size)
>> +{
>> +       int addr_cells, size_cells;

unsigned


>> +       char buf[sizeof(__be32) * 2 * 2];
>> +               /* assume dt_root_[addr|size]_cells <= 2 */
>> +       void *prop;
>> +       size_t buf_size;
>> +
>> +       addr_cells = fdt_address_cells(fdt, 0);
>> +       if (addr_cells < 0)
>> +               return addr_cells;
>> +       size_cells = fdt_size_cells(fdt, 0);
>> +       if (size_cells < 0)
>> +               return size_cells;
>> +
>> +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
>> +       if ((addr_cells == 1) && (addr > U32_MAX))
>> +               return -FDT_ERR_BADVALUE;
>> +
>> +       if ((size_cells == 1) && (size > U32_MAX))
>> +               return -FDT_ERR_BADVALUE;

In v14 I requested:

   Should also check that base + size does not wrap around.


>> +
>> +       buf_size = (addr_cells + size_cells) * sizeof(u32);
>> +       prop = buf;
>> +
>> +       fill_property(prop, addr, addr_cells);
>> +       prop += addr_cells * sizeof(u32);
>> +
>> +       fill_property(prop, size, size_cells);
>> +
>> +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
>> +}
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index b9cd9ebdf9b9..842af6ea92ea 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>
>> +int fdt_prop_len(const char *prop_name, int len);
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +                                               u64 addr, u64 size);
>> +
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* _LINUX_OF_FDT_H */
>> --
>> 2.19.0
>>
> 

