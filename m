Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678AD26E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUQhINVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678AD26E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeFZRTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:19:39 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44916 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeFZRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:19:31 -0400
Received: by mail-ot0-f196.google.com with SMTP id w13-v6so19846937ote.11;
        Tue, 26 Jun 2018 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AAv1gaiDBz7opJhs6ezmjRApRG/EorqBiknkIyCURcQ=;
        b=jUQhINVCneaWurN9WRgpvrhBvpkqZoS04kUkYIIRsItIXUnkhYiY5zJoafYjAqwRmJ
         WeakqVsbXvGtSvD6RLOJCrbJcX+qKPYSVM6gBddEoEo0xgFS8ywH+uTfjZ9yWBpP498K
         DFt9SzfQ37B7df3h1g8SuPOf+QNWF7q2zqNAa1uDHegtmtTXksJKB8iRs/RPmOfiraEp
         fOoFOF4CfA4wPknOCM21SgAOXYvXLCRJlUnNU+sLYvJ+nq+3lkCdxQZ0/XIUNhwYgSlH
         5U/fpCI6ycx/QP65tb7QDwutLticVoO9G8Sn7xSo8A9wYoETOocxlglFn0txenCHO7vl
         r7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AAv1gaiDBz7opJhs6ezmjRApRG/EorqBiknkIyCURcQ=;
        b=P2gGSpOvHMbFNmV8gKjtSUOvMubyQ9ZZ0VVq/DceF1w4tqjlhH+Cu+1bEVrVyTK8qJ
         rR3Y69OwGne4SsWTnzTvSHfi6UxgD8ZAPH5ks66zkHXvaVbbwHe4Xy8ZmeRChtBqj/Fm
         imWh8230m+o3F4Xui1vaXTmYw6NO7wauB52QWIHKGpuoBEFCM6s7jdI1o5T9KqQHZ/aN
         V6VJ4KjUjymgcnD6JsOIJC6JY4ldf1xvRhehEsXUgSqFvnzgT3IsDkgLcSMn1NgN94WM
         wotDHOSV/i2Bn425oyLiCvNdBoVo1s/bAhA9Qn+WmyGk/5iuQFCeOleX7gdHfPL3sm1f
         hAWA==
X-Gm-Message-State: APt69E04XLBJT2vjIEo7lLIAJb/0VWL8j9pqKG8FTE1m4aYeWvl6UJV0
        KJgiwA8H8bluItR52uQ40FK5fCKnkY1cK7RNlCg=
X-Google-Smtp-Source: AAOMgpeoHPZtmy3x9cFnKgoM8taIgyN9viomHDG5XtJ/HLBqOW26p7CkSwNJAOXVTHsImmK86vLVX32oiXXolwAFXlk=
X-Received: by 2002:a9d:7105:: with SMTP id n5-v6mr1286772otj.305.1530033570236;
 Tue, 26 Jun 2018 10:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:19:29
 -0700 (PDT)
In-Reply-To: <20180626171406.GC146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com> <20180626171406.GC146680@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jun 2018 19:19:29 +0200
X-Google-Sender-Auth: nPXXbo4pd7I3YQVAIpv8Igi6i2U
Message-ID: <CAJZ5v0gt+4FiiBxEjdsEYLT+dQq=Q=mC7JtZPsYxps0_a1w-rg@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 04:22:00PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>> >> +     /*
>> >> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
>> >> +      * confuses the platform firmware, so avoid doing that, unless the
>> >> +      * bridge has a driver that should take care of PM handling.
>> >> +      */
>> >> +     if (pci_is_bridge(dev) && !dev->driver)
>> >> +             return true;
>> >
>> > It sounds like the question of whether leaving a bridge in D3 confuses
>> > the firmware has a platform-specific answer.
>>
>> Well, it may confuse the platform firmware in general.
>>
>> > How does the driver PM handling know how to do the right thing?
>>
>> For endpoints this is not an issue as they always have been expected
>> to be in D3 before passing control to the platform firmware on S3
>> entry, but we've never done that for bridges by default, except for
>> PCIe ports with PM enabled (in which case the driver decides whether
>> or not to enable it).
>
> If there's any spec reference for the expected power states of devices
> when entering S3, that would be useful here.  I can't tell if there's
> any guidance for this or if it's just figured out experimentally.

It is not direct, but Section 16.1.6 of ACPI 6.2 says this in step 4
of the system suspend outline:

OSPM places all device drivers into their respective Dx state. If the
device is enabled for wake,
it enters the Dx state associated with the wake capability. If the
device is not enabled to wake
the system, it enters the D3 state.
