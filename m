Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5CF7FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B41208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1iHl/cW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B41208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934098AbeFLINg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:13:36 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37822 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933643AbeFLINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:13:31 -0400
Received: by mail-vk0-f68.google.com with SMTP id w8-v6so13877490vkh.4;
        Tue, 12 Jun 2018 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y2BZHJyLODDXSd/OQ6ItWjdg9jgC2rhTrJbUKrkaFd8=;
        b=N1iHl/cWRKzcA/Fla656UgRHfPAHly0kULEhTWrFGbhvmP2dLwdg+i57sCqyxLjQg2
         i58xG2J8TRA6iMqtkKldIWHXymavAPHU73wkgjkf3OJ4HvKHihUZRQ+xdu3PE+GTV6Lp
         9wK9LrGS0jr8DrY5SFBp8ufcIWe6zHbZlik1mxgBYEl6TQw/pqTItOvqTmO7Vy4S2eHP
         TSy1SVQ28EKQoP1+jZdUjoFTm2dWT0UcPN7Ut3hqR4587/4pA/KSZveHUtYAGakeEQ+J
         /3y6tymRqUxNgNmjf9Mg0h6AnKgsCpsteAYtzJX/rjmoifbfPG43VNGruduIxxHB9YkO
         PGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y2BZHJyLODDXSd/OQ6ItWjdg9jgC2rhTrJbUKrkaFd8=;
        b=HbaayL9CTpLqik1ufEIMkCZgVxA9cTpTlBKTlbuJx5sFoz4qWE95Gsv43Tb2YC5VTt
         7BfP6kX42eXx2t3hgyAJ5vvXJ5yAmKVnH8zdQGlKJgogEWBP08FGLawv2b0/qFbw8ZAW
         58ocwx1Unm1f3by1nGbHRLj+un+ldtcJGdvgBVtYsoEkdLl4QLVZ1dux1ssFjD/BGv9e
         b7/w6M1K01gqz+8pUCXDlTfvg/yLzWIR4LIG8lgUPGbxnfhA5GTlwmTB8ovebaWW3Tqh
         r0SgITagUkklezMr84XA8F/rcui/9xTkhK447wnSarjl3uA65eX+magDdhHcdQq4I5F5
         qbMQ==
X-Gm-Message-State: APt69E1lTSPs6h6Rq4q0UYAQDZfAJE/tnAi/+xx9YY1Xq0kC+b2PiDSN
        7x9S6qKGQH3oNleQHoD9usYyUGUb3l4XbEdkHjg=
X-Google-Smtp-Source: ADUXVKLdCHm7Ad9A+47ef/zwibGY7xwrNzvUMqmhSH/jthvaSvs5DCqnXsjl203kDF+IQl4OK2lzU/vqOOdO5uAsry0=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr1542764vkd.161.1528791210207;
 Tue, 12 Jun 2018 01:13:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:13:29
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:13:29 +0300
Message-ID: <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 8:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.

This patch consists 2 or even 3 ones:
- whitespace shuffling (indentation fixes, blank lines), I dunno if
it's needed at all
- some new registers / bits
- actual switch to readl() / writel()

Please, split.

> +#define asc_w32_mask(clear, set, reg)  \
> +       ({ typeof(reg) reg_ = (reg);    \
> +       writel((readl(reg_) & ~(clear)) | (set), reg_); })

This would be better as a static inline helper, and name is completely
misleading, it doesn't mask the register bits, it _updates_ them.

-- 
With Best Regards,
Andy Shevchenko
