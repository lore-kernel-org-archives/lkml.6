Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C4ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27EB2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlaovzMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27EB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJSUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:40:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37642 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJSUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:40:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id x8-v6so20852058qka.4;
        Fri, 19 Oct 2018 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAApRODXqEbLLpdIPOMqFoFJPc5hRMv3/FQob/W29ek=;
        b=nlaovzMiOBFDTYxeh+RvRdJ2TBbRgu7WUfo5cGDXDRw6cJrVO0gcRCy/4DuihE3Cin
         gYNAOoeyTJIC6JKsAFohUD5JzT4r9+csiWyVNK8FjOrYmEh+qd2h3Sct6zuVIud9rEgR
         sG9IGrkwWsIDAbdEThccIh5wstPUTy7VqiOVNFHo5cR0xOwj38N2jJtKpuGCfx/blf/5
         kd7QZKUikbbBQmrC8MLwhDv9NChokHjwHvvJnIDL3tIB5dlWLl0ulACmiI++R88U55tx
         oC8K6r56ilRrA+iB4SJyarcgPZn+4I1dvZuHG5fSYIubWaMc7QHdxMgJDAbyd1sIesnJ
         1Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAApRODXqEbLLpdIPOMqFoFJPc5hRMv3/FQob/W29ek=;
        b=UFwKAkhgix/EW8QSocn+iMM7j0aRwkRBjCsusTljEGDbHtiGY3AApPkfgKrhY02grM
         dewWyrDY0Y4vJHuAebgHrNwsZfVh2oidAg+Pgx00WlxNveR+w99nhDYOH8SBspd4CQsj
         sRXIbH1ZH3aV8XzMroYTnIDqOJSozQidd9nWXBcXfWSRyJhN9xMa56hT+CxSM+2Wrbe8
         F2nTg2SVruMcdKA8b/hRIGF8j/BYoAiCazlgYA/zZiWcQbSyNvcbz8HVpNzUMhG1i9oJ
         D7h05+oM9CScgBLFdSQDcvf4DaET983cNDNlJaGdaB85DTqXAK5mYT7tm0RGclqYWtVX
         7pnQ==
X-Gm-Message-State: ABuFfojVlqd1bXWQYKW74KtWHDmW1WJzkavhPqTCtF8q6V1+pVGFvXQa
        nOO3Nt6XZbEhFnZ+wxfpUQcCvtJIurUPq6a7svQ9FTb9
X-Google-Smtp-Source: ACcGV63yX696WTBOMcwpR5rDTYCfSCZybiyb2AN0bjikz6qCysZF6E2RHUX14TtMgXNUo5Bxn8aZ2yzgMXkXBJHPBU8=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr32553090qkg.70.1539952458354;
 Fri, 19 Oct 2018 05:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com> <20181006065113.669-3-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181006065113.669-3-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 15:34:07 +0300
Message-ID: <CAHp75VcLN6g-6FJsVgxPZRV675N6YQzxsbm19BWgKhpiYfmG3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> The LTR values follow PCIE LTR encoding format and can be decoded as per
> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>
> This adds support to translate the raw LTR values as read from the PMC
> to meaningful values in nanosecond units of time.

While I have pushed this to my review and testing queue, it needs a
bit more work. See my comments below.

> +static u32 convert_ltr_scale(u32 val)
> +{

> +       u32 scale = 0;

Redundant, see below.

> +       /*
> +        * As per PCIE specification supporting document
> +        * ECN_LatencyTolnReporting_14Aug08.pdf the Latency
> +        * Tolerance Reporting data payload is encoded in a
> +        * 3 bit scale and 10 bit value fields. Values are
> +        * multiplied by the indicated scale to yield an absolute time
> +        * value, expressible in a range from 1 nanosecond to
> +        * 2^25*(2^10-1) = 34,326,183,936 nanoseconds.
> +        *
> +        * scale encoding is as follows:
> +        *
> +        * ----------------------------------------------
> +        * |scale factor        |       Multiplier (ns) |
> +        * ----------------------------------------------
> +        * |    0               |       1               |
> +        * |    1               |       32              |
> +        * |    2               |       1024            |
> +        * |    3               |       32768           |
> +        * |    4               |       1048576         |
> +        * |    5               |       33554432        |
> +        * |    6               |       Invalid         |
> +        * |    7               |       Invalid         |
> +        * ----------------------------------------------
> +        */

> +       if (val > 5)

> +               pr_warn("Invalid LTR scale factor.\n");

if (...) {
 pr_warn(...); // Btw, Does it recoverable state? What user will get
with returned 0 as a multiplier?
 return 0; // Btw, is 0 fits better than ~0? How hw would behave with
this value?
}

> +       else
> +               scale = 1U << (5 * (val));
> +
> +       return scale;

return 1U << (5 * val);

> +}

>         for (index = 0; map[index].name ; index++) {
> -               seq_printf(s, "IP %-2d :%-32s\tRAW LTR: 0x%x\n", index,
> -                          map[index].name,
> -                          pmc_core_reg_read(pmcdev, map[index].bit_mask));

We use 32 characters for the names. Here are two minor issues:
- inconsistency with the rest
- ping-pong style of programming (you changed 32 to 24 in the same
series where you introduced 32 in the first place).


> +               decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
> +               ltr_raw_data = pmc_core_reg_read(pmcdev,
> +                                                map[index].bit_mask);
> +               snoop_ltr = ltr_raw_data & ~MTPMC_MASK;
> +               nonsnoop_ltr = (ltr_raw_data >> 0x10) & ~MTPMC_MASK;
> +
> +               if (FIELD_GET(LTR_REQ_NONSNOOP, ltr_raw_data)) {
> +                       scale = FIELD_GET(LTR_DECODED_SCALE, nonsnoop_ltr);
> +                       val = FIELD_GET(LTR_DECODED_VAL, nonsnoop_ltr);
> +                       decoded_non_snoop_ltr = val * convert_ltr_scale(scale);
> +               }
> +
> +               if (FIELD_GET(LTR_REQ_SNOOP, ltr_raw_data)) {
> +                       scale = FIELD_GET(LTR_DECODED_SCALE, snoop_ltr);
> +                       val = FIELD_GET(LTR_DECODED_VAL, snoop_ltr);
> +                       decoded_snoop_ltr = val * convert_ltr_scale(scale);
> +               }
> +

> +               seq_printf(s, "IP %-2d :%-24s\tRaw LTR: 0x%-16x\t Non-Snoop LTR (ns): %-16llu\t Snoop LTR (ns): %-16llu\n",

Here 0x%-16x would look a bit strange and difficult to parse. 0x%016x
much better.
After you remove the index, it would give you 4 more characters,
though it 4 less than 8 you got from reducing 32 to 24.

OTOH, those long texts perhaps may be compressed somehow, at least
remove LTR duplicating from the last two. Remove spaces after '\t' as
well.

> +                          index, map[index].name, ltr_raw_data,
> +                          decoded_non_snoop_ltr,
> +                          decoded_snoop_ltr);
>         }
>         return 0;
>  }

> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -177,6 +177,11 @@ enum ppfear_regs {

It might be good idea to include linux/bits.h here.

> +#define LTR_REQ_NONSNOOP                       BIT(31)
> +#define LTR_REQ_SNOOP                          BIT(15)
> +#define LTR_DECODED_VAL                                GENMASK(9, 0)
> +#define LTR_DECODED_SCALE                      GENMASK(12, 10)

-- 
With Best Regards,
Andy Shevchenko
