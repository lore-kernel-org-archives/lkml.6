Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2CB20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pztAiPjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2CB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeGSSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:30:32 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56084 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbeGSSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:30:31 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so10991956itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=3aI5e8XRd5Jo3yxVli0VKQ+mQnMDkAuPnkWevETurN8=;
        b=pztAiPjPUXKzO0IxYkXSV2EVbRTNQmI2zkib+nU5gXeGqaRoCBdw8nFwE5sbQmcRq0
         nQD6A9u7DdCDwcWjByuHsa+WvuMgc2MOS/0FvJUg+ol0kxmt9o6kFXH0ZyAtNsxdJ8wQ
         GK0B3RFoFeA2T0RR3pEwzavi9gJzkkh/GLIeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=3aI5e8XRd5Jo3yxVli0VKQ+mQnMDkAuPnkWevETurN8=;
        b=csJ41Mc65GKLnDH5N0cmhe/Xphah6jlOUzy+tZiRpdCVou81QHqc4EjxC+NELaIMYE
         2NpabjNLjpM2mk6F2sNOKQh1rnXeS1YpW/O9Xh+G7c0FQSUqzgqtV7ZAKBQ5HtXzW8f8
         xt7P+X6ME47XZeIJCLA6VbXSgHM83r9I+UJ91IJYjpSUCqu4INm2E5kQblH8HHHnOWye
         3gfTKC9hHvfyP460slJob8qecb7gxcIZnbDHZj2swxJxL2VbWHwu/tiYvkSHPhTYBK0p
         fATeYqhX4f6LzkpS183tdjG3oFMOSJoGmok/Ub9c0AtnzuEKZjrGO52ZKE5GKWXAjJUc
         LvwQ==
X-Gm-Message-State: AOUpUlHSlf52r7LnTBOVpxUZ5FuekQEr0qqPwTjnYfZy8V8z/LLiekSE
        8s+SHEUFLriyqNk+jYUwkHVXH0Qjl5J+dm0xwemo/fKI
X-Google-Smtp-Source: AAOMgpd2uFmg+alAzvz8bdxzprje+RxPrZCtqr2gWo0RqI+zzkGMntlND4bdNKbKSOm7tes+mlinEy2HCT769Wkd7Vc=
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr10444269jac.71.1532022379172;
 Thu, 19 Jul 2018 10:46:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 10:46:18
 -0700 (PDT)
In-Reply-To: <20180719153706.GD3949@uda0271908>
References: <20180719101038.9465-1-jagan@amarulasolutions.com> <20180719153706.GD3949@uda0271908>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 19 Jul 2018 23:16:18 +0530
Message-ID: <CAMty3ZCTFMvOtc78eoLULLzhgufVEcX0YUexCn94QAkpLLpqMQ@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: Call musb_platform_exit from musb_stop
To:     Bin Liu <b-liu@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 9:07 PM, Bin Liu <b-liu@ti.com> wrote:
> Hi,
>
> On Thu, Jul 19, 2018 at 03:40:38PM +0530, Jagan Teki wrote:
>> musb stop is musb core call during unregister or shutting down
>> gadget or host musb. For graceful exit add musb_platform_exit
>> on musb_stop so-that it can exit the musb platform driver as well.
>
> Thanks for the patch. but musb_stop() is called in the .udc_stop() and
> host .stop() hooks, which can stop (and restart) at any time by the udc
> or host core, not really during unregister. musb_platform_init() is not
> called in .udc_start() and .start() hooks, so we shouldn't add
> musb_platform_exit() in musb_stop().

Thanks for the explanation.

Look like musb_platform_exit calling during musb_remove call of
platform driver. can you explain how the shutdown sequence happen
because of if udc_stop call musb_stop to shutdown how come
platform_exit will shutdown it's PHY and CLK bits. or is it in
reverse?

Jagan.
