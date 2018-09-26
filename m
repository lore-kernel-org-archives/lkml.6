Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFEBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E970A214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyXai9QG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E970A214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeIZUHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:07:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45279 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:07:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so17267348qtr.12;
        Wed, 26 Sep 2018 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88/2cfvdBss3O2vrPN3ChGUN6VdhuZnNWDN6bZX27s8=;
        b=qyXai9QGBtomAl9+Bu+Frf25vXePFeWtyNTmyUcFOEYZ2WjUuhM5V4WepUOvvct2Qd
         BHLlQnA82XS/qGo2bEssthKLu/eMCIxiojfRr/1R9qJr0GqXhpRI8I8I0qS06mx2nIEQ
         uuzSEFT2os+sLbV6nE5vkMVv8KZ4DSJfJUaWJtJtGN6hHGq7WqTOKYxqsKbRZ2ad03zO
         NMYoFSz2e3KdnTt4QpebNBj9EXfapFyHdFFmzRbLsk9xYwioGUXetb7fXE1JuY/TRptD
         nGBz0Sz3ATFfYDNWNYBaDSk6EZ4TB0h26ZYZbtHq7ClpslNO3YZPanysR/yqEtsa6C/I
         GAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88/2cfvdBss3O2vrPN3ChGUN6VdhuZnNWDN6bZX27s8=;
        b=NAzMqeB+OdHPXHnW8SWkBI3uqybBW/ns1K6m+QLlTYeJ+xco3O47Cd0Wd93flNdJ6m
         3yHJWklZOUlB7A05Ed7VkjvMNveBpmziJ1WCeCrqPp32mBbxJ4NfcZ/mRgt4kYc45Jgl
         Wo0aLS6H8edHaLbwoAkbzOytFfbWWAt7hL+QKXqf55VL04xRsqmKaKIheXUbzE8nnPHI
         ygbMmkMRhDyeA0whSgXnq/nvr8gUhx4InA2Mw/p/RqsG8qjUu6sBsK1SnojYjKTnzv5B
         YGcJjwjBgdcPxzO0SJq9ij4lh201Vkh1fo7w0s1J+w1XIiogdn6lyZGwdEDN0PMCeYax
         gqug==
X-Gm-Message-State: ABuFfoi6uJmpYwYJzX+XiG3Jgh/R2YAlP7M/3K+in1lU84pzqePZYHYG
        juzzCcQtZbeiYrWr/OT4Z6yPKr20RtXxyQi0JPE=
X-Google-Smtp-Source: ACcGV61bFvZMz3sltAVDqtN++t3Ssefck4+1lGTe/okvZIdi4f5Us9e3ucpa1wkfuPhrRK+vCdW3wCOov7LyKLF3N8Y=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr4645360qtk.187.1537970046966;
 Wed, 26 Sep 2018 06:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com> <20180903180415.31575-3-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20180903180415.31575-3-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 16:53:55 +0300
Message-ID: <CAHp75VcKSVJQ54qFV1BwqnwUu4dkS6sOACT3nTntJV+Ww56Oag@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> The LTR values follow PCIE LTR encoding format and can be decoded as per
> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>
> This adds support to translate the raw LTR values as read from the PMC
> to meaningful values in nanosecond units of time.

> +static void get_ltr_scale(u32 *val)

What's wrong to return converted value? Actually the name should
reflect what it does, ie *convert* value.

> +{
> +       /*
> +        * As per PCIE specification supprting document

supporting

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
> +       if (*val > 5) {
> +               *val = 0;
> +               pr_warn("Invalid LTR scale factor.\n");
> +       } else {
> +               *val = 1U << (5 * (*val));
> +       }
> +}

> +
>  static int pmc_core_ltr_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
>         const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
> +       u64 decoded_snoop_ltr = 0, decoded_non_snoop_ltr = 0;
> +       union ltr_payload ltr_data;

> +       u32 scale = 0;

Redundant assignment.

>         int index;
>
>         for (index = 0; map[index].name ; index++) {
> -               seq_printf(s, "%-32s\tRAW LTR: 0x%x\n",
> +               ltr_data.raw_data = pmc_core_reg_read(pmcdev,
> +                                                     map[index].bit_mask);
> +
> +               if (ltr_data.bits.non_snoop_req) {
> +                       scale = ltr_data.bits.non_snoop_scale;
> +                       get_ltr_scale(&scale);
> +                       decoded_non_snoop_ltr =
> +                               ltr_data.bits.non_snoop_val * scale;
> +               }
> +
> +               if (ltr_data.bits.snoop_req) {
> +                       scale = ltr_data.bits.snoop_scale;
> +                       get_ltr_scale(&scale);
> +                       decoded_snoop_ltr =
> +                               ltr_data.bits.snoop_val * scale;
> +               }
> +
> +               seq_printf(s, "%-24s\tRaw LTR: 0x%-16x\t Non-Snoop LTR (ns): %-16llu\t Snoop LTR (ns): %-16llu\n",
>                            map[index].name,
> -                          pmc_core_reg_read(pmcdev, map[index].bit_mask));
> +                          ltr_data.raw_data,
> +                          decoded_non_snoop_ltr,
> +                          decoded_snoop_ltr);
> +

> +               decoded_snoop_ltr = decoded_non_snoop_ltr = 0;

You may do this at the beginning of the loop and get rid of assignment
in the definition block.

>         }
>         return 0;
>  }

> +union ltr_payload {
> +       u32 raw_data;
> +       struct {
> +       u32 snoop_val : 10;
> +       u32 snoop_scale : 3;
> +       u32 snoop_res : 2;
> +       u32 snoop_req : 1;
> +       u32 non_snoop_val : 10;
> +       u32 non_snoop_scale : 3;
> +       u32 non_snoop_res : 2;
> +       u32 non_snoop_req : 1;
> +       } bits;
> +};

Just use normal masks and shifts.

-- 
With Best Regards,
Andy Shevchenko
