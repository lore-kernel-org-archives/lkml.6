Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE0E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQQLTy/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE0E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeGYQsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYQsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:48:00 -0400
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B7C20843;
        Wed, 25 Jul 2018 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532532949;
        bh=q6xHvZfVNrhZ0AGQtRkDIYb193tEbB2nQkTF3TUjfs0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QQQLTy/GqBnd2EL+y71DTqICw2F9euar6OIoBGWRcWNUsQyli9GVtoZXH9416PF4W
         uR0pTBPQf3R//EJUtRZFvdc2GdoC1pHI67vI3vyZGZzrMZpy2vi+AzGclWcp6d9mZH
         Btpr062U5azfisp5ueL1GKuZpq/r7C9Axhn1uV/c=
Received: by mail-yw0-f169.google.com with SMTP id j68-v6so3016994ywg.1;
        Wed, 25 Jul 2018 08:35:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlFW3XdZLz0t2aNrJqDUWELwGHwN9JrHeI6kcUL47FJLoARgcMlt
        VXNeYhAcACmEvDvSXl6DkUM250aAIxA4iIjEH/E=
X-Google-Smtp-Source: AAOMgpcYFMj0iSDwIV9+XlV403UJ9rCyXtaQQDQ1B4JEmrgvHa0tCUbbvUxbijpjkpdRV4ShuD66MHKGszYVCYQou6c=
X-Received: by 2002:a81:8047:: with SMTP id q68-v6mr11482222ywf.196.1532532948085;
 Wed, 25 Jul 2018 08:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 08:35:07
 -0700 (PDT)
In-Reply-To: <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com> <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 25 Jul 2018 10:35:07 -0500
X-Gmail-Original-Message-ID: <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
Message-ID: <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>
Cc:     Moritz Fischer <moritz.fischer@ettus.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:12 AM, Appana Durga Kedareswara Rao
<appanad@xilinx.com> wrote:
> Hi Alan,
>
>         Thanks for the review...
>
> <Snip>
>> >
>> > <Snip>
>> >> > +static bool readback_type;
>> >> > +module_param(readback_type, bool, 0644);
>> >> > +MODULE_PARM_DESC(readback_type,
>> >> > +               "readback_type 0-configuration register read "
>> >> > +               "1- configuration data read (default: 0)");
>> >>
>> >> Not sure a module param is the best solution here.
>> >
>> > Need to provide flexibility to the user to switch between reading of FPGA
>> registers and configuration data.
>>
>> I suggested calling the attribute 'image' because I thought it would always be
>> a read back of the FPGA image information.  I don't think that a sysfs
>> attribute's function should change. :)
>
> In Zynq Case it supports two types of the readback (Configuration registers, Configuration data(fpga image))  which may not be the same case for other vendors.
> Since I need to support both the use cases I have differentiated them using module param in the zynq-fpga driver.
>
> As you said we shouldn't change the attribute's function, So in the zynq-fpga driver,
> I am planning to add another debugfs attribute for reading back of configuration registers as it is vendor specific readback type.
>  (Configuration registers                   ----  Usage:  /sys/kernel/debug/fpga/zynq-fpga/cfgreg_summary)

Is it called '...summary' because it is not all the registers?  Could
just be "cfg_regs"?

> (Configuration data(fpga image)    ----   Usage: /sys/kernel/debug/fpga/fpga0/image)
> Please let me know your thoughts for the same...
>
>>
>> > One other option is sysfs. Do you want me to implement sysfs path???
>> > Any other suggestions???
>>
>> You could implement another sysfs attribute for reading FPGA registers
>> with a separate ops callback.   Please clarify what it is doing (not
>> all FPGAs have this function) and what that will look like when the user reads
>> the from the sysfs
>
> AFAIK we shouldn't add another sysfs/debugfs attribute for vendor-specific readback type in the FPGA manager ops.
> Please correct me if my understanding is wrong.

You are not wrong :)

>
> Regards,
> Kedar.
>
>>
>> Alan
