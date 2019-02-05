Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D281CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801020823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rURtGQiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBEVYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:24:54 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38191 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:24:53 -0500
Received: by mail-lj1-f170.google.com with SMTP id c19-v6so4211004lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lP4RoDnMTU+pVD+Pfm3EH+dprELT4ls4Vuao9Og8Qps=;
        b=rURtGQiWgRxtM5L1YBuYBR++Ymz9ZVaL1AuJIbFprIh+hex+VdWboChgDwXE4yxPcx
         iDZ77h+kdUSOl//wAIth/9PfbjOU51up25rYWC9/v84X/o+cnUYuGqJA+k/SQ2d/6zrE
         mA3873FEaB9W/Vf7o6ewp+FtPjr1XkPXA6JvWw/hclAaUGRhHQ2X1fe4Kohpx2wIY0pL
         7BromZ8TuLyQ4sDUmtfO/NFwFRGYs8+2Gj+jM2Uxw48uXc6gOSi3uWQfGQU85rmbi3V8
         LsCYtxVl3cpdEIAH/deIGC6WYVY8W+Sj8U+zciW2UzWDsuEmftbpV5hT7GPThxt7mKVy
         bgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lP4RoDnMTU+pVD+Pfm3EH+dprELT4ls4Vuao9Og8Qps=;
        b=OM+Er0kUAPTj9JJDlircc6cQ08sRBSFfgUWwpdmThbgVvOtQRiRJrR+m28UsQIsSuD
         mskI/HSI8n0RGH7vV3lZ9GpSQJbCnLMdDJ+Bpw8zXWLnwIrnezouwV15T5C5ZAXoaIXJ
         9CXgchX2ZRlDZFuQkkEzZNINabL70fccoZJyUIrIMvXhqaWV7K3qgnzfJIQ3gxIOoK35
         5/q34VQnq7UKgEDHf6xcrO94N6TFJOYBOzORbMGZNdicyKC5avdtXSkTQBRxdk0fM5S4
         mKX6gVd7T4KNekUi6ZsHHZvBNPpC60x2yEcOdAGXWtIhF1/bc8GYmnyCkB0MHV1Q8zgK
         51Zw==
X-Gm-Message-State: AHQUAub2BxU962pk20D1a4uh/7aBLZyFtMl7dVmN6CsFYbT3qwaFNLFK
        MOjIR/gR3X8SS0PsaWMx1QB7Xn6S
X-Google-Smtp-Source: AHgI3Ibe2Iv2iZbHArfrLJFFRXEBrAi4ufmjzdMJr5BRP647i4aQa0Pu81qPhZ6Xu9xQkfqdlnBHYw==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr4142817lje.86.1549401891560;
        Tue, 05 Feb 2019 13:24:51 -0800 (PST)
Received: from [192.168.1.18] (dnn189.neoplus.adsl.tpnet.pl. [83.24.95.189])
        by smtp.gmail.com with ESMTPSA id y25sm3919143lfg.4.2019.02.05.13.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 13:24:50 -0800 (PST)
Subject: Re: [RFC v1 3/3] cap11xx: fix potential user-after-free on module
 unload
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-4-TheSven73@googlemail.com>
 <20190205081846.GA118684@dtor-ws>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6565ec19-b629-c289-2fed-a5f404763b74@gmail.com>
Date:   Tue, 5 Feb 2019 22:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205081846.GA118684@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2/5/19 9:18 AM, Dmitry Torokhov wrote:
> Hi Sven,
> 
> On Mon, Feb 04, 2019 at 05:09:52PM -0500, Sven Van Asbroeck wrote:
>> The work which is scheduled by led_classdev->brightness_set() is
>> potentially left pending or running until after the driver module
>> is unloaded.
>>
>> Fix by using resource-controlled version of INIT_WORK().
> 
> I believe this is wrong way of fixing this. The LED classdev objects are
> refcounted, and may live beyond the point where we unwibd devm stack,
> so we are still left with the same use-after-free that we currently
> have.

Could you please share what LED classdev objects refcounting
do you have on mind?

> This is a general issue with LED subsystem as it provides no callback
> for properly tearing down device structures, but I think in this
> particular case we can simply switch from set_brightness() to
> set_brightness_blocking() which will use the work item internal to the
> LED classdev and that one is being shut down properly.
> 
> Jacek, does the above sound right?

Yes, since the introduction of brightness_set_blocking op there is no
need for out-of-led-core workqueues for deferring brightness setting.
And we do flush_work() in led_classdev_unregister().

-- 
Best regards,
Jacek Anaszewski
