Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQZMeAoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB4520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbeGXT5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388366AbeGXT5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:57:32 -0400
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8D820852;
        Tue, 24 Jul 2018 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532458183;
        bh=xQT7qk1qzwxkzqovb1jqUl/gxsfBm24s1V2tIWyuoso=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vQZMeAoLX9TzPsevQbZpnJ6dr4q50+glkKniSetysDFE4tng4q3+EoARW42KpOPZE
         dIF4haIuKLtzn5WLUF2rNu3Lca5eckLIU3ZrNOpArlJwwwwJxsbykAn8Er89olrbOs
         iBuZnr6DR6JWsRvtctCTuITN3gMJ6SbTcC5nmqrI=
Received: by mail-yw0-f174.google.com with SMTP id v197-v6so1924215ywg.3;
        Tue, 24 Jul 2018 11:49:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlENvio0HSD9OerQelxWBGrZeb7QPS2qjNtfKynw+vg7Zxo7ERAl
        w84TsvnrMchL5TnnY99qh7IuABXrhqSHvbEjqdM=
X-Google-Smtp-Source: AAOMgpeGi5Vv+TdWVdhqbQ8lPAYjSZEpjotCt5g/urN+DdRTN+mepUHx/UPRBEdbHVmz1BDh7U1OalLmaY1ALcdRHQA=
X-Received: by 2002:a81:8047:: with SMTP id q68-v6mr9625104ywf.196.1532458182637;
 Tue, 24 Jul 2018 11:49:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 11:49:02
 -0700 (PDT)
In-Reply-To: <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com> <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 24 Jul 2018 13:49:02 -0500
X-Gmail-Original-Message-ID: <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
Message-ID: <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
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

On Tue, Jul 24, 2018 at 1:31 PM, Appana Durga Kedareswara Rao
<appanad@xilinx.com> wrote:
> Hi Moritz,
>
>         Thanks for the review...
>
> <Snip>
>> Can you please make the commit message such that you have full sentences?
>>
>> "Add support for readback of FPGA configuration data and registers" of
>> example.
>
> Sure will fix in v4.
>
>>
>> >
>> > Usage:
>> > Readback of PL configuration registers
>> >         cat /sys/kernel/debug/fpga/fpga0/image
>> > Readback of PL configuration data
>> >         echo 1 > /sys/module/zynqmp_fpga/parameters/readback_type
>>
>> The patch below is for Zynq if I'm not mistaken, not ZynqMP?
>
> Yes it is for Zynq not ZynqMP by mistake I have kept zynqmp here, thanks for pointing  will fix in v4...
>
> <Snip>
>> > +static bool readback_type;
>> > +module_param(readback_type, bool, 0644);
>> > +MODULE_PARM_DESC(readback_type,
>> > +               "readback_type 0-configuration register read "
>> > +               "1- configuration data read (default: 0)");
>>
>> Not sure a module param is the best solution here.
>
> Need to provide flexibility to the user to switch between reading of FPGA registers and configuration data.

I suggested calling the attribute 'image' because I thought it would
always be a read back of the FPGA image information.  I don't think
that a sysfs attribute's function should change. :)

> One other option is sysfs. Do you want me to implement sysfs path???
> Any other suggestions???

You could implement another sysfs attribute for reading FPGA registers
with a separate ops callback.   Please clarify what it is doing (not
all FPGAs have this function) and what that will look like when the
user reads the from the sysfs

Alan
