Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FABC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC77F26F38
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp0tTnYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC77F26F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbeFZTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:32:21 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38230 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeFZTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:32:19 -0400
Received: by mail-vk0-f66.google.com with SMTP id b77-v6so10742778vkb.5;
        Tue, 26 Jun 2018 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=svhjIJta6ftYcpoSKBEfZ3om+DfFymcPomVhFAvsprI=;
        b=rp0tTnYx5wSXV+Oqu3HgOCiPLnTzuQ7efMbbpT+p2GbTb2HQ2SiN5t4qo6ULy2a0LN
         zxi5eYgibHw5bxCj5l6Dj9CrqwE/bK5uwSsnNnzHgX0qT8FdAi6YmPpqkhT4ZUAHMO+5
         Kd1HTouHzE5pt1HQvEoIRYWJx3ol3EZ9xBk5sKx17Wb6WCaJNOjmKp165kO6xBDWnJQv
         XyIGmIb1vM8px0xIPBlr+z9Y0FfxvK7E9dY73KIWWFLp0M5hiu5JXomc4g5y2R6sflYy
         mB5+4adIVxJHta3q0d7L8Sk0lxdwheUPsJc4lRFCaIcZDGeCuA62x77zeT9pQ6NF0lkz
         cjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=svhjIJta6ftYcpoSKBEfZ3om+DfFymcPomVhFAvsprI=;
        b=Nm6kw8tsDkrgysfFkDG+c36hOyqn0e2tv/DW6zW+qvyLkzLo2EvzlPeVuSY+muUdSO
         UDYI0pFvIm5yXQoECtMdId690tLGzHORYHSXnHyN1cZBBP5iht/ZtgmzsqTIkaYlRy+D
         pO/+TbaTUD8kTma2O0ilEEQpfJvEUlO4Qs2CjLSLsdB340WHD/kdpQUGPwOgbDM2fAlG
         EJnfyOD/0UbLHx/d+GiTl2pG6mNPzrYoW86Cq1VwBYOGKrtGxeMii/E6M3UY6ZjAzypl
         TEVVKzEthesMNXYG2EDLL0oWYTWi2dYOJYl9k41QxAP/d7BDm4JQqhIR80dGYnhVoOKO
         NU5w==
X-Gm-Message-State: APt69E1tnCxuXAeeE6oyoslf8VZL7DVgMxefJday15RvoCCYEmbXkSAi
        pOsmaeOVOTDHVM9eu9uwpYOvF8ioUobRARSO/cA=
X-Google-Smtp-Source: AAOMgpdw8mVM2Q4xVeCJ7bNbGP/kqLsKblQtqG0vZlcMKOrGjc1wbywpjeUS4ro/YKScvN7XT/migBnNC3QNB+DX7hk=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr1822658vkf.26.1530041538279;
 Tue, 26 Jun 2018 12:32:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:32:17
 -0700 (PDT)
In-Reply-To: <20180623002237.GG27466@fury>
References: <20180621181524.30550-1-colin.king@canonical.com> <20180623002237.GG27466@fury>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 22:32:17 +0300
Message-ID: <CAHp75VfWcosNzM03zsGnQrL6yRh0=uidV+SU-06hyYtwdJo3EQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-smbios: make a function and a pointer static
To:     Darren Hart <dvhart@infradead.org>
Cc:     Colin King <colin.king@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 3:22 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Thu, Jun 21, 2018 at 07:15:24PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The function dell_smbios_smm_call and pointer platform_device are
>> local to the source and do not need to be in global scope, so make
>> them static.
>>
>> Cleans up sparse warnings:
>> warning: symbol 'platform_device' was not declared. Should it be static?
>> warning: symbol 'dell_smbios_smm_call' was not declared. Should it be
>> static?


>> -int dell_smbios_smm_call(struct calling_interface_buffer *input)
>> +static int dell_smbios_smm_call(struct calling_interface_buffer *input)
>
> Hrm. So these are passed by pointer to dell_smbios_register_device(), which is in
> turn called by dell_smbios_call() from dell-smbios-base.c.
>
> So while it is valid to make these static, since we're not referencing the
> symbol, but the pointer value instead - I do worry about the "static" suggesting
> to someone reading the code that this data is not used outside of this file,
> when it is.
>
> I'm not finding a position on this in coding-style.
>
> Andy, do you care to weigh in on this?

We are using static keyword by almost all callback defined functions,
so, for my point of view it's pretty much okay.

-- 
With Best Regards,
Andy Shevchenko
