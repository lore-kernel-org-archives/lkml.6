Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1375FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89DD23E2A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89DD23E2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeFVHXT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:23:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46298 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeFVHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:23:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so5269706oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tHfjUnOTv0WI6CZuIlGQEakZi0hZQbBQ6LP2lBi2Ag4=;
        b=tmdY//Lj+LBkusOQDsqQLBA9i2e6WUwOvMDt6Hu5DvPVO7iR4nlz8YQ7k/Yer+bSx7
         97ydhNy5ZLVWXZb3ESsf0eGNW+fVRIfMo/Cy5MQD/3zka1Fd5P4YxjDRjt6GZ6GdC+La
         /c2GUYlMhGTlYL5EhSBTozVrEyVAgTluO6EZ3zf6ovKpnZZjn4V+Xl+XkQU3y5QCLBIa
         tSm0kXHH8WeLskU8UXGcaVMq3sALEk5o7GrJN4wi3nlDDk1/HqRI9td0BwN8M84cQsjc
         BW1MFdRjQYrgK2rI0NyGzRGS49p79M/9/Rp0nTaYkmbmRHpPLhV7SHoj7l0xKIvhQ3bh
         oa5A==
X-Gm-Message-State: APt69E0p2yuYkYWD2MJ9MjWy5IsVZclJStix+Vy2vUPIGXLqWVQDUfps
        ODqGcKtHZhK3VA8t81a8c71WtiN7R6RxqUcT3xg=
X-Google-Smtp-Source: ADUXVKKy+BQ7JkNpCMZYtxMOzqR1Z3qaaKvrb/dlzFqD2GN6oNBaGzfGj6fWgy5upIOTPakYjKhvseWFxVxKgX0gDfc=
X-Received: by 2002:aca:ad91:: with SMTP id w139-v6mr242081oie.107.1529652182628;
 Fri, 22 Jun 2018 00:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180308202856.9378-1-malat@debian.org>
In-Reply-To: <20180308202856.9378-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 09:22:51 +0200
Message-ID: <CA+7wUswY+W1x0DeBHaproaKicWON7hSxNUMXgOcO_4NsFdJEsQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Move the inline keyword at the beginning of
 function declaration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     trival@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?
On Thu, Mar 8, 2018 at 9:29 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> The inline keyword was not at the beginning of the function declaration.
> Fix the following warning (reported at W=1)
>
>   CC      kernel/events/ring_buffer.o
> kernel/events/ring_buffer.c:105:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static bool __always_inline
>  ^~~~~~
> kernel/events/ring_buffer.c:116:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static int __always_inline
>  ^~~~~~
> kernel/events/ring_buffer.c:416:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
>  ^~~~~~
>   AR      kernel/events/built-in.o
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  kernel/events/ring_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 6c6b3c48db71..03e39e3df543 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -102,7 +102,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>         preempt_enable();
>  }
>
> -static bool __always_inline
> +static __always_inline bool
>  ring_buffer_has_space(unsigned long head, unsigned long tail,
>                       unsigned long data_size, unsigned int size,
>                       bool backward)
> @@ -113,7 +113,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
>                 return CIRC_SPACE(tail, head, data_size) >= size;
>  }
>
> -static int __always_inline
> +static __always_inline int
>  __perf_output_begin(struct perf_output_handle *handle,
>                     struct perf_event *event, unsigned int size,
>                     bool backward)
> @@ -413,7 +413,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
>  }
>  EXPORT_SYMBOL_GPL(perf_aux_output_begin);
>
> -static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
> +static __always_inline bool rb_need_aux_wakeup(struct ring_buffer *rb)
>  {
>         if (rb->aux_overwrite)
>                 return false;
> --
> 2.11.0
>
