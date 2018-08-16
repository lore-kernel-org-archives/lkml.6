Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73635C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FBB2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+jI0km8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FBB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbeHPRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeHPRZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:25:13 -0400
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C814021486;
        Thu, 16 Aug 2018 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534429576;
        bh=WfPNLG8dyjSTrlQhF9xLCSDuAbW7b07/OcokzulIxrs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=c+jI0km8m/845TG+FVmeq1gIUc4+y86N0QY0iWkgB3vjtLvHCe11LL0J55kx4+/pS
         AKdqbbxjR1QS6iX/RwXyFUYlVxmxWDiZF0MUn1uYyNTTmc/PlyGBL0vnQuLZcPPa0m
         snbyjTILKkvIcfagm6ICBU3pWv9i+8XepLgYfWOw=
Received: by mail-yb0-f178.google.com with SMTP id d34-v6so674856yba.3;
        Thu, 16 Aug 2018 07:26:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlEsJJRV4QN8S+2hQ8AgTsadekOvEgVUuNzPm48pJTbFO2KyNWAn
        hM7+1xSrWxwfEUR0aTQrlQ788Sc2U5lHa0AayBc=
X-Google-Smtp-Source: AA+uWPw3okflg09NRb2oUVq9G48V5AyXAvO5WE3GbVCX8TkZHCbZXKYFNOkx8+f32JG+odEnuL6p/fPdBF/x3M7Q6k0=
X-Received: by 2002:a25:d84e:: with SMTP id p75-v6mr16319903ybg.315.1534429575996;
 Thu, 16 Aug 2018 07:26:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81c8:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 07:25:35
 -0700 (PDT)
In-Reply-To: <9043a69f-47d8-0ffe-ca15-77c9c73c085f@infradead.org>
References: <20180815220958.3606-1-atull@kernel.org> <20180815220958.3606-2-atull@kernel.org>
 <9043a69f-47d8-0ffe-ca15-77c9c73c085f@infradead.org>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 16 Aug 2018 09:25:35 -0500
X-Gmail-Original-Message-ID: <CANk1AXTOKKVdVDEkQ5d73F3nzgDDK9jgm2gRPpXbNM5A4aNS1w@mail.gmail.com>
Message-ID: <CANk1AXTOKKVdVDEkQ5d73F3nzgDDK9jgm2gRPpXbNM5A4aNS1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 5:34 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

Hi Randy,

> On 08/15/2018 03:09 PM, Alan Tull wrote:
>> From: Alan Tull <atull@opensource.altera.com>
>>
>> Implement DebugFS for the FPGA Manager Framework for
>> debugging and developmental use.
>>
>> Enabled by CONFIG_FPGA_MGR_DEBUG_FS
>
> Hi Alan,
>
> for your v2 changes:
>
>> Each FPGA gets its own directory such as
>>  <debugfs>/fpga_manager/fpga0 and three files:
>
> s/three/four/

Yes

>
>>
>>  * [RW] flags          = flags as defined in fpga-mgr.h
>>  * [RW] firmware_name  = write/read back name of FPGA image
>>                          firmware file to program
>>  * [WO] image          = write-only file for directly writing
>>                          fpga image w/o firmware layer
>>  * [RW] config_complete_timeout_us = maximum for the FPGA to
>>                          go to the operating state after
>>                        programming
>>
>> The debugfs is implemented in a separate fpga_mgr_debugfs.c
>
>       debugfs interface is

Yes

>
>> file, but the FPGA manager core is still built as one
>> module.  Note the name change from fpga-mgr.ko to fpga_mgr.ko.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/Kconfig            |   7 ++
>>  drivers/fpga/Makefile           |   4 +-
>>  drivers/fpga/fpga-mgr-debugfs.c | 221 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/fpga/fpga-mgr-debugfs.h |  22 ++++
>>  drivers/fpga/fpga-mgr.c         |   8 ++
>>  include/linux/fpga/fpga-mgr.h   |   3 +
>>  6 files changed, 264 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
>>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.h
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 1ebcef4..600924d 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -9,6 +9,13 @@ menuconfig FPGA
>>         kernel.  The FPGA framework adds a FPGA manager class and FPGA
>>         manager drivers.
>>
>> +config FPGA_MGR_DEBUG_FS
>> +       bool "FPGA Manager DebugFS"
>> +       depends on FPGA && DEBUG_FS
>> +       help
>> +         Say Y here if you want to expose a DebugFS interface for the
>> +      FPGA Manager Framework.
>
> Use tab indentation for bool, depends, and help lines.
>
> Use tab +2 spaces for help text.

Yes, thanks for catching that.  I'll fix these in v2.

Thanks for the review!

Alan

>
>> +
>>  if FPGA
>>
>>  config FPGA_MGR_SOCFPGA
>
> thanks,
> --
> ~Randy
