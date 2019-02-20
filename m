Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67379C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636020859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550701319;
	bh=Fx+VvrlXJ50iEedRTgbrLffXw4FpEao79c3tNUtbcqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IDC4rrjb0J91cvPU0770QcW/i8Sdd061DRfNo83OX9wlaXO6Blrn59JlcjrmTm+YI
	 qQdSFs+WeMH0h6eXQc6Aw13SljCuW23HKC0IZdnrGgqqAvr1V5GxRX9IdIrWJIkTk/
	 MQcONVQhVdX+iRftIS25ay3bJbCLpFPtzhgqmT1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBTWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:21:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36085 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:21:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id v62so34148752otb.3;
        Wed, 20 Feb 2019 14:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfRNwRVl7g3bqidrv95AzMgr3KnyTTsf1iUE/PpifHg=;
        b=XoW6zOZT2kGRjKHMXCQauoWzuslUxFIjHXsd9A7XyA6d1kd4w38JR2d4lTKB93J5A/
         QkvizdKi3w1p7nBeyIVSXWmXcTpiVLbIHlpv2R5q6YxuMOE8GjPHKqaHxxkMNqRSRmiV
         UwPVz0XR5tARDTTYhWTBfv+75cVFXiooarCqrj+e1UITuvFH+mQPL9mnGJSj9ggfaiZz
         euzvRS7+wpPHPY2JjbLmNYC2t35FxysMJlLzk1QXQjnVzRsqUmYNblBBsXJyHu2/JP8E
         /W19CjrtrcL/CLhC+l+e33sxpMcs0sa0HEwQvPZAfHNRWgMbE5LGi2tp0O17F7DWFUtQ
         Szng==
X-Gm-Message-State: AHQUAuaXSaMGnYu/Gxm7iVeVGr/WmfVhRZASvH6gbv9XbYTddAgzEnSf
        LkUXRBn3mokT4NawWpt10OiB1lcsKBn1W5tkuD0=
X-Google-Smtp-Source: AHgI3IbYnyhjUWec6h/ijCvT3Sat82fibfLBId5o8D/Dh7apFdbkV8p7Y0qk3V3QfIBdHfoKJTEwz5vR437BlQkx0LY=
X-Received: by 2002:aca:c141:: with SMTP id r62mr7076865oif.160.1550701316742;
 Wed, 20 Feb 2019 14:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com> <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com>
In-Reply-To: <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:21:45 +0100
Message-ID: <CAJZ5v0izS-MBcC3ZsRKK59zWcJOMQ672sRuv_GCVrsYR36Wa8w@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/20/19 2:02 PM, Rafael J. Wysocki wrote:
> >> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> >> index c9637e2e7514..08e972ead159 100644
> >> --- a/drivers/acpi/hmat/Kconfig
> >> +++ b/drivers/acpi/hmat/Kconfig
> >> @@ -2,6 +2,7 @@
> >>  config ACPI_HMAT
> >>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> >>         depends on ACPI_NUMA
> >> +       select HMEM_REPORTING
> > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > as a user-selectable option is a good idea.  In particular, I don't
> > really think that setting ACPI_HMAT without it makes a lot of sense.
> > Apart from this, the patch looks reasonable to me.
>
> I guess the question is whether we would want to allow folks to consume
> the HMAT inside the kernel while not reporting it out via
> HMEM_REPORTING.  We have some in-kernel users of the HMAT lined up like
> mitigations for memory-side caches.
>
> It's certainly possible that folks would want to consume those
> mitigations without anything in sysfs.  They might not even want or need
> NUMA support itself, for instance.
>
> So, what should we do?
>
> config HMEM_REPORTING
>         bool # no user-visible prompt
>         default y if ACPI_HMAT
>
> So folks can override in their .config, but they don't see a prompt?

Maybe it would be better to make HMEM_REPORTING do "select ACPI_HMAT if ACPI".

The mitigations could then do that too if they depend on HMAT and
ACPI_HMAT need not be user-visible at all.
