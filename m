Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCBC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8202A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aafs4w34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAUU5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:57:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38067 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfAUU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:57:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so17621467ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fA3qrPhkd5M2hoTKAJoUYCXDOy3vvddagKUT6nokP4=;
        b=Aafs4w34IFcwpaDvzGsZcD9LjOdSvhQR8TWmicHTZVMAZ3johE0QgHT0ODXOIY8pc4
         z5Hx5ITSdoDVd05CoqmqE7oUwb5EMtVGymgQ9LFdGvA2ZHnpbKQg2zOGAthf8cHQcJX6
         nnmupHIGCAJHtvXBbLHxziZRGvxqymbeLco5LAwM0SNRS9QKRAgl/bsd6zQ7Zte/Johy
         kFiqehTXxYqd6GaUdd5tOG20Rr9FD4V8xoUDpxazIPdA5ld48O+YpxFZ8PtOfHk4F45j
         vN95/uL7SHtPDgHUvUOCcmHKMSEOUS81Wj1oaK2reAwpebGy1qymBHDRjtjGrSkFRhI8
         9Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fA3qrPhkd5M2hoTKAJoUYCXDOy3vvddagKUT6nokP4=;
        b=BnWhZesrJwLtx4Deoff0AwbN1NgPZQGbgvHC9nmgzEZ5W2jTqws7x3X6ht2U05jwwW
         POi+ARZhAbxGSy+ufFZ6kqXVegWilsPUyaLUZ+osHq+meqxLgnU4tzGzeEz8ldSdoezW
         KFT/6/V81y8Yp5A8VQXUWVCFy1Z7+eoLkkf+aV5T5fqmv3Bf81YEG2+30PmS+8Z7hSI3
         mohPIXrahs+8wkMFBxE3Y2cM80LaJcchc7Ta30rOUXvTJmG6AwDYPiHSqznV1jIZR5iP
         WTYJ27w/28/T7ru0aqzftimSBmquGXt0UcDmUIqhPr9o+uCEgffYTWXSYqiJVjLrFWXm
         n+8A==
X-Gm-Message-State: AJcUukfNpS6PHS31xK8HcXX4310oYrNjr0v99VKf+A2h2wz9KXvQF2X2
        TylQ03LK6JbEQlJPx2rRi1A=
X-Google-Smtp-Source: ALg8bN6KpxQWY0ikqgxTcZZRUUHh6ilBfj7PNrTLTD3B5Wjfv75q3Fvn05L4asbBEwCqHbeAHyQk5Q==
X-Received: by 2002:a17:906:2ec6:: with SMTP id s6-v6mr25718105eji.93.1548104234652;
        Mon, 21 Jan 2019 12:57:14 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t10-v6sm4895811ejg.41.2019.01.21.12.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 12:57:13 -0800 (PST)
Date:   Mon, 21 Jan 2019 20:57:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190121205713.vai2oor3saopcja7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard>
 <CAPcyv4iGZdEw-agURohZdC7hkjrDp74M_gVdSbCB5DP-bk5YYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iGZdEw-agURohZdC7hkjrDp74M_gVdSbCB5DP-bk5YYw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:04:40AM -0800, Dan Williams wrote:
>On Sun, Jan 20, 2019 at 11:51 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>> On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
>[..]
>> Also, I have one confusion about your saying: two probes.
>>
>> If the two probes are:
>>
>>     * for dax%d.%d: 1. nd_dax_probe 2. dax_pmem_probe
>>     * for pfn%d.%d: 1. nd_pfn_probe 2. nd_pmem_probe
>>
>> Then, if the first probe fails, the device itself would be destroyed. How the
>> second probe do its job?
>>
>> >       rc = nd_pfn_validate(nd_pfn, sig);
>> >       if (rc != -ENODEV)
>> >               return rc;
>
>Here is an example path for a device-dax instance:
>
>    /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.1/dax0.0
>
>In this case the order of events is:
>
>1/ region0 discovers it contains a pmem namespace and registers namespace0.0
>2/ The pmem namespace driver calls nd_dax_probe() to check for the
>presence of a device-dax configuration
>3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
>registers the dax0.1 device (this is a libnvdimm 'personality device).
>4/ When nd_pmem_probe() sees nd_dax_probe() return 0 it in turn fails
>the probe of namespace0.0 with -ENXIO. All devm allocations during the
>probe of namespace0.0 are released.

I may have another opinion here.

The probe return error means the device will not attach to this driver.
But the device itself it not released.

We allocate devm on one device and those memory will be released when
the device is destroyed. If I am correct.

This means at this point, pfn_sb's memory still exists in the system.
Even finally we will release it, when namespace0.0 is destroyed.

>5/ Meanwhile the created dax0.1 device is recognized by the dax_pmem device.
>6/ dax_pmem_probe() uses nd_pfn_init() to validate the configuration
>and ultimately creates the dax0.0 character device
>
>The pmem namepsace driver is effectively a router to other personality
>drivers that may be layered on top of the base namespace capacity.

-- 
Wei Yang
Help you, Help me
