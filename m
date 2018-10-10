Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255A2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7oux7kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E255A2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:32:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36084 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:32:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so1669736plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4iVSd02n5t82I4fR1/gS3t83JVoLo94UoRFt6l3H8Io=;
        b=L7oux7kdp2ko0KVpLhGpPTyLn3LS+NuctkpylBPKftIJ9+u+Yj+TET6KlpYVhgrFMV
         AuQUp/1u2MiOpPUTnor+f1/Et3YjMsyMyEtTchGvMpNN2nTxDemSG12ShVWOu1P0mjCw
         xU1mGmnaIIg2M185Eu5b+bQKK9n/aic5wYZE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4iVSd02n5t82I4fR1/gS3t83JVoLo94UoRFt6l3H8Io=;
        b=kj31bb0+76HfsCmQ+fADgtkvM5ubjCQREyJc5G/m1PUOgU3vjD6dLhUmh+xo6VpBIF
         IvlWVPiAz7qkIzrC8gurnvqJiqwk9slGcwIgw3jYTSmF83s7JaOXl6ihi2nFSTuzt2Qn
         4OL9wC0UklsyMurgnK+MQ9Cz5uW912BXt3OwNwV4Ve5AiHM2bXFp7h64ECZxfaMVeJfw
         +jXGjb5i0VnIcD/uRXvP5dTRC5Bs0etDB9FeXqXStS2egUIFOfo9qHML2obMTUwiUoBz
         OJzyxL/F/hFBK+Hmd6BjJKcyUWPQlHT3l/13AsKo1MOXyJkxkpuLLw7Rv/p2h55MDblx
         NWZQ==
X-Gm-Message-State: ABuFfojxNkmym5G324fnFrUO6b2ZVcrrPLnJuqez3W5hOeET3n+ZWuKD
        I2b2PcFV8t/fUMLsOEXu+X8Aub6APWg=
X-Google-Smtp-Source: ACcGV61mJ0BQ1G6iDRpIG3vS75CjqbAM0dc2XdxOIZlK4bi+D9R4OumryZ2o5SbWrKFXqPyFiISiWw==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11-v6mr30058853plb.93.1539133966313;
        Tue, 09 Oct 2018 18:12:46 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 126-v6sm34905003pfd.16.2018.10.09.18.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 18:12:45 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:14:28 +0900
From:   "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
Message-ID: <20181010011426.GV32578@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, prudo@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
 <20181005030849.GK32578@linaro.org>
 <CAL_Jsq+wXU8PCyJhaTKE7ezZhiD0KARUFXVzQBk0ZptEEK7ubQ@mail.gmail.com>
 <20181009003733.GN32578@linaro.org>
 <c65e42ce-1a98-7680-3a09-1f737eb26763@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65e42ce-1a98-7680-3a09-1f737eb26763@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank, Rob,

On Tue, Oct 09, 2018 at 10:47:15AM -0700, Frank Rowand wrote:
> On 10/08/18 17:37, AKASHI, Takahiro wrote:
> > On Fri, Oct 05, 2018 at 08:23:57AM -0500, Rob Herring wrote:
> >> On Thu, Oct 4, 2018 at 10:07 PM AKASHI, Takahiro
> >> <takahiro.akashi@linaro.org> wrote:
> >>>
> >>> Rob,
> >>>
> >>> # I haven't replied to this comment yet.
> >>>
> >>> On Fri, Sep 28, 2018 at 08:44:42AM -0500, Rob Herring wrote:
> >>>> +David Gibson
> >>>>
> >>>> On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> >>>> <takahiro.akashi@linaro.org> wrote:
> >>>>>
> >>>>> These functions will be used later to handle kexec-specific properties
> >>>>> in arm64's kexec_file implementation.
> >>>>>
> >>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>>>> Cc: devicetree@vger.kernel.org
> >>>>> ---
> >>>>>  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
> >>>>>  include/linux/of_fdt.h |  4 +++
> >>>>>  2 files changed, 60 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>>>> index 800ad252cf9c..c65c31562ccb 100644
> >>>>> --- a/drivers/of/fdt.c
> >>>>> +++ b/drivers/of/fdt.c
> >>>>> @@ -25,6 +25,7 @@
> >>>>>  #include <linux/debugfs.h>
> >>>>>  #include <linux/serial_core.h>
> >>>>>  #include <linux/sysfs.h>
> >>>>> +#include <linux/types.h>
> >>>>>
> >>>>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >>>>>  #include <asm/page.h>
> >>>>> @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
> >>>>>  #endif
> >>>>>
> >>>>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> >>>>> +
> >>>>> +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> >>>>> +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> >>>>> +
> >>>>> +int fdt_prop_len(const char *prop_name, int len)
> >>>>> +{
> >>>>> +       return (strlen(prop_name) + 1) +
> >>>>> +               sizeof(struct fdt_property) +
> >>>>> +               FDT_TAGALIGN(len);
> >>>>
> >>>> Looks like you are using this to calculate how much space you need to
> >>>> allocate in addition to the current DTB for a couple of new or
> >>>> replaced properties. I'm not sure that this calculation is completely
> >>>> accurate. And it is strange there doesn't seem to be any libfdt
> >>>> function for this already. It would be simpler to just add some fixed
> >>>> additional amount.
> >>>>
> >>>> Maybe David G has comments on this?
> >>>>
> >>>>> +}
> >>>>> +
> >>>>
> >>>> The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> >>>> should go into libfdt, but I'm fine with having it in the kernel for
> >>>> now.
> >>>
> >>> I'd like to have this function in the kernel for now.
> >>>
> >>>>> +static void fill_property(void *buf, u64 val64, int cells)
> >>>>> +{
> >>>>> +       __be32 val32;
> >>>>> +
> >>>>> +       while (cells) {
> >>>>> +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> >>>>> +               memcpy(buf, &val32, sizeof(val32));
> >>>>> +               buf += sizeof(val32);
> >>>>
> >>>> This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> >>>
> >>> Are you sure?
> >>> I originally implemented this function in a similar way that fdt_pack_reg()
> >>> was, but, you suggested, in your past comment[1], that we'd be better to
> >>> have of_read_number()-like implementation.
> >>>
> >>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579118.html
> >>
> >> Yeah, you're right. Plus, I'm not sure the u-boot one would work for
> >> unaligned accesses with armv5 and earlier h/w.
> >>
> >> My only comment then is I think you can drop the U32_MAX masking.
> > 
> > Okay, then I will leave this function, yet renaming it to
> > cpu64_to_fdt_cells() after Frank's comment.
> 
> I have second guessed myself and do not like the name I suggested
> because what the function really does is either cpu32 to be32 or
> cpu64 to be64.

Okay.

> I agree with Rob that readability is important here.  Instead of
> having a fill_property() function, how about having inline code,
> something like (untested even for thinkos):
> 
> 	prop = buf;
> 
> 	if (addr_cells == 1) {
> 		*(__be32 *)prop = cpu32_to_be32(addr);
> 		prop += 4;
> 	} else {
> 		*(__be64 *)prop = cpu64_to_be64(addr);
> 		prop += 8;
> 	}
> 
> 	if (size_cells == 1)
> 		*(__be32 *)prop = cpu32_to_be32(size);
> 	else
> 		*(__be64 *)prop = cpu64_to_be64(size);
> 
> You might want to also give Rob a chance to bike shed on this
> suggestion.

Basically, I don't care either way, but what Rob suggested
is that some architecture(s) might not handle correctly
unaligned memory access here.

I just want to stay tuned with Rob.

Thanks,
-Takahiro Akashi

> -Frank
> 
> > 
> > Thanks,
> > -Takahiro Akashi
> >>
> >> Rob
> > 
> 
