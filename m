Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BCC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A320C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tCa+d3Di";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZoNvSdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5A320C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbeGLCNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:13:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42672 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbeGLCNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:13:36 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so9094105ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Lh3G6ijysGk7hzzWxXKzuyM9t1uCBV7NJ1HstZBtPO0=;
        b=tCa+d3DiBo5PCBVvHRC3yu4hZ6IMWUrUZsBt9QEi+NUqXqTo6HBF3C8t46QutXc4WA
         0WrqPlHe9pXXtbrP1YQE3JdfVnkJMBssSkO6tBa6/h4/xf9w5AxNyfu/aHE+2GNKvUBm
         6EDm1zhbnPOKuGp5Jv2vkWYNO2LEM1fTVU3ZlwH46WHRj8hsN28LUKVAMIBYfwDRRACB
         XE0pdTMMOi89K0PbVQQOKmKqMSY9s5bSaOURoh8Oq8htcun7wM1HCliF9GnWikG6pJ/Z
         KrRygtnLTgzZloAc4vNuoWZ8Cy8Zofzx1AHWsFqMnTa4XiRwKTINAOJeRO65bk9tEzPT
         EFjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Lh3G6ijysGk7hzzWxXKzuyM9t1uCBV7NJ1HstZBtPO0=;
        b=nZoNvSdbriCr3mO19+iV5BofxxhyuBmuH5T0Qcp/ihjx3ziB3smpBLUJz3rkh+nQ31
         j7vOWbfq2cgflf9MJ/yvy3CCUQt3xADc3QYZ6aq8y4gGxynyH4E5GPvSxpTzViSg6B9T
         5I1pbxuKTKgPaNKsPDTfzP7DWSgWfoOkqZNlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Lh3G6ijysGk7hzzWxXKzuyM9t1uCBV7NJ1HstZBtPO0=;
        b=b9Kq/GVX7aX588GgJWRJoJW49GTLPk0SfS7X0a77+zAUwXDNv27cJRfU9PpQOZ57o8
         BTY6MCGH8mbkR7tEWIfNsU0UUdIaJzJFRZGUx5o0Ccgnx1Wj5kjpWU7e9Cj/wMGl2eY3
         7P/70CPTqy5ET9GV59EzF3LcV210GysuKWUT2/nKxt7fYddSVIbaGK27RTUNBsHN0sFU
         F5NrbyLLxjmOkksSGYBNP1nANlVlG88ORE6dr2jofnk2IBEJ8ojmZj0x0Rhy6lvCYgkT
         Rc07x9NFO1/EvYc5q4KZfL3ChA5wQ8aHjmq3YmAE7A6OidnT0+7uXMyPRJGWPrariRCZ
         AmcA==
X-Gm-Message-State: AOUpUlGDLf62Kv/BrqyGy9znOzdbL6U1i2k3aj2Al+w1WqMl3GnqrNcY
        yVBs8JhCOhGoHG6SAHoLgTlmOuu1hpaBY4wGt29AZQ==
X-Google-Smtp-Source: AAOMgpePadKKb1kyj/QpRPUY09OImNtcH6nhRByZhpaDUvyTdJUOnI7VlPIoShCnqTBSsXaPuhYsk+xQkuMS2rtKsp4=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr161705ybj.112.1531361185687;
 Wed, 11 Jul 2018 19:06:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 19:06:25
 -0700 (PDT)
In-Reply-To: <08f1c1d4-52a8-6d42-fe56-241c255ba934@redhat.com>
References: <20180712000337.GA4022@beast> <08f1c1d4-52a8-6d42-fe56-241c255ba934@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 11 Jul 2018 19:06:25 -0700
X-Google-Sender-Auth: GP7OoByvHCEKupBdPdJKeIuFOns
Message-ID: <CAGXu5jJtuut1E4DKB=AVs-pq8H9Jvwr3Ve6eskraBL3ekfUzqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add support for STACKLEAK gcc plugin
To:     Laura Abbott <labbott@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 6:45 PM, Laura Abbott <labbott@redhat.com> wrote:
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +#define MIN_STACK_LEFT 256
>> +
>> +void __used stackleak_check_alloca(unsigned long size)
>> +{
>> +       unsigned long sp, stack_left;
>> +
>> +       sp = current_stack_pointer;
>> +
>> +       stack_left = sp & (THREAD_SIZE - 1);
>> +       BUG_ON(stack_left < MIN_STACK_LEFT ||
>> +               size >= stack_left - MIN_STACK_LEFT);
>> +}
>> +EXPORT_SYMBOL(stackleak_check_alloca);
>> +#endif
>
>
> I think the conclusion was this needs to be re-written to account
> for the different stack sizes in the same way as x86.

Oh, whoops! Sorry, I missed that fork of the thread. :)

-Kees

-- 
Kees Cook
Pixel Security
