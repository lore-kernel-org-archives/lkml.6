Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775D9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426B62089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700135;
	bh=dPLLYh+PocGn5wRWMOTYqf/0L4gG9+AGs4VsvY18VXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YOaO1GxdkF60aXlSDpOEVr4WZiCrXwcjJeOKxQqq+Fa54jfHG950VmNW4YRcxIPgg
	 B9BXHL4rMZ7R9Ci+8uiHPOAdrKhghrqSdMXZQizFO2eLgw3dTDNDN6c7fb0SGc4JhQ
	 6mp3L8nOcm694t2UHSpNfL6ewxq3pAecis2Eywhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBTWCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:02:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33264 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBTWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:02:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so43000013otl.0;
        Wed, 20 Feb 2019 14:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvbga5/rKMhGa+NSWBfXnVaRcn9H55kD51cNX0PyggM=;
        b=HPZth5Mk/YoyDz3sHOI5eHhplxGssR4eoCWMlaRLSX8zETCQIqDXc0f3xje48Adpel
         m2WeOK0glufe1qmb9cW6lD1D83a5EEodYu8NbEgzB8x5W9m1JxXhjepMfatvUFBBDy0F
         bYn9jwpVWNIoTQRAgtqzliAoenwpvyRONaxrDMlRwJvczGpA1cNJmEKL/MB+1eOPlNRy
         9CW9v4C3EQ0D+5wE5KTogpwFgKGqr1JE6TJ1kelSOnfkdt+HpOAnyB/bZH6bMfuILxzR
         2vpKhkvM8aTm6uIJns/ejpxgZywiAdJU0ouJBrL4OpjFjdgVw9bn4+R3pmrgHCEUckRW
         620A==
X-Gm-Message-State: AHQUAuYKmUP9mJcZNC0WJ0yERklpkSZZMGrVygv2Zj+pb0UQbWnYY5Nr
        VvbZS4qYcj1gKRwuN7LP2DBLuzhZZrR6SfUM2QHmH5DH
X-Google-Smtp-Source: AHgI3IbAzu8gI/MWJeSOSNKf1hGrR2Pg+qTBx37R9oT5FXo9crNiJVD4x++lZ0b9JfEsAG8sY05Yvn9BSSCb8K1GtgE=
X-Received: by 2002:aca:6046:: with SMTP id u67mr2338709oib.84.1550700132699;
 Wed, 20 Feb 2019 14:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
In-Reply-To: <20190214171017.9362-8-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:02:01 +0100
Message-ID: <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
>
> If the HMAT Subsystem Address Range provides a valid processor proximity
> domain for a memory domain, or a processor domain matches the performance
> access of the valid processor proximity domain, register the memory
> target with that initiator so this relationship will be visible under
> the node's sysfs directory.
>
> By registering only the best performing relationships, this provides the
> most useful information applications may want to know when considering
> which CPU they should run on for a given memory node, or which memory
> node they should allocate memory from for a given CPU.
>
> Since HMAT requires valid address ranges have an equivalent SRAT entry,
> verify each memory target satisfies this requirement.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/Kconfig |   1 +
>  drivers/acpi/hmat/hmat.c  | 396 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 396 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> index c9637e2e7514..08e972ead159 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -2,6 +2,7 @@
>  config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
> +       select HMEM_REPORTING

If you want to do this here, I'm not sure that defining HMEM_REPORTING
as a user-selectable option is a good idea.  In particular, I don't
really think that setting ACPI_HMAT without it makes a lot of sense.
Apart from this, the patch looks reasonable to me.
