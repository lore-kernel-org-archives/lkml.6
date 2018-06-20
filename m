Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889BAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9DC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9DC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFTJEp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:04:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43120 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932224AbeFTJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:04:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so2425886wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z6ZYJoz1sTzL7WOtaQ2bpc5bsQpX2pvs5i5BwUTmP5A=;
        b=ceHrVFN1DqzdCJ9UFnZl0pjnqn8Y06FH7C/pJEZiz3AogVHiIozedx4LDtqX45t4jr
         a2v0dHbMNu25HE242I8fy7LoYP59t/ZT9ASbjCX0yrzbcHJPueUw/fA257XoVJYzZ5iO
         F1kB0Apucuu4182b3Cw1mYV2TdJW/MiEbVVAGaXbVGbW+5nrSwq7ZVj3MVdMhwZybCjp
         CFHES/VN4qx1UiRfcunnoR8KX/7lFNzhu+6g1fIT/KeUn02mk0gDGxSDseowOdeI91vu
         hghn4G5vLv+tF7tsHc5tSSK+ieGv8VqPhHmLnjxAjGx814e/+Td1MAvT1ooSkzBhvz+4
         NT0g==
X-Gm-Message-State: APt69E0P4IEqa7bmja/O4V5ragL9hojUzMkngpJaE9XgW2h5Mx1O37fm
        CDLIPuD0DxvmVNXpjugIfXwB6Q==
X-Google-Smtp-Source: ADUXVKLL6wIdbxYCR6WF8n4nYinOHSi35dEISW35pldyJSg0A56LgAfzsdFtmbJWKZl3tKqM9bgT4A==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr15688583wrc.44.1529485480780;
        Wed, 20 Jun 2018 02:04:40 -0700 (PDT)
Received: from [10.201.33.7] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id g205-v6sm2393866wmg.43.2018.06.20.02.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:04:40 -0700 (PDT)
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
 <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c5ff2e6a-6bbf-deea-5250-7588b8046750@redhat.com>
Date:   Wed, 20 Jun 2018 11:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcOd5K+T6bkxyz3qgqNr4-=K9GGRh+DQ_qgW7dGKdzO5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 06/20/2018 01:43 AM, Andy Shevchenko wrote:
> On Wed, Jun 20, 2018 at 1:51 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
>>> For debugging purposes it may be useful to know what are the devices whose
>>> probe function was deferred. Add a debugfs entry showing that information.
>>>
>>>   $ cat /sys/kernel/debug/deferred_devices
>>>   48070000.i2c:twl@48:bci
>>>   musb-hdrc.0.auto
>>>   omapdrm.0
> 
> 
>> And what is the use of this file?  What can you do with this
>> information?  Who is going to use it?  Don't we have other deferred
>> probe debugging somewhere else?
> 
> Indeed.
> 
> Javier, have you tried to add 'initcall_debug' to a kernel command
> line followed by 'dyndbg="file drivers/base/dd.c +p"'?
> 

I already mentioned this to Greg, but I'll elaborate a little bit. Using these
kernel cmdline options will only tell us when a driver for a device was probed
or deferred but it doesn't tell us what's left in the queue after all drivers
have been registered.

Yes, we could parse the kernel log and do some computation to figure out if a
deferred driver finally got probed, but I don't understand why we can't just
expose the deferred queue if the kernel already has that info and is useful?

But even if we do that, the current debug printouts are only enabled until
late_initcall time. So it won't print deferred probes for drivers registered
by modules:

static void deferred_probe_work_func(struct work_struct *work)
{
...
	if (initcall_debug && !initcalls_done)
		deferred_probe_debug(dev);
	else
		bus_probe_device(dev);
...
}

static int deferred_probe_initcall(void)
{
...
	initcalls_done = true;
...
}
late_initcall(deferred_probe_initcall);

Again, we could change that but in my opinion we should try to make debug more
easier and this patch is quite trivial. The kernelci folks said that this will
be useful for them and allows to detect regressions on drivers' probe as early
as possible, which I think is very important.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
