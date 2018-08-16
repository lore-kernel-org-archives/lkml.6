Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D550EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828A9213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3ODO9aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828A9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeHPXV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPXV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:21:26 -0400
Received: from mail-yb0-f180.google.com (mail-yb0-f180.google.com [209.85.213.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F962213A2;
        Thu, 16 Aug 2018 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534450854;
        bh=9J4lOxCNrfVUtXPcyGryaJQZcO1MjI6GpUIdCya5PJI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=c3ODO9aWB/6FkG26/m0I6Uerb7mFlBFeP1ADCQZIkLe3Yzf228NjeIj4XYMCUONFW
         jhu/YFZ10Yrwd3YnePjx3667TRVu7gwbLZs6Pzci56lLj+3e+CIHHEbQyXcYIERdbI
         5XiPqyG1pTYEUneSE1LY5snm/zv4P9boCf5AzY/k=
Received: by mail-yb0-f180.google.com with SMTP id e9-v6so1121998ybq.1;
        Thu, 16 Aug 2018 13:20:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlGjMbv7/y5loaKj6vjDjdkrZY5WhDuLlxsXYhdW05dIqDL9jm6O
        /d+oVvNYLiYOLtPmRMXU7FvCurHOawc2vUCf/B8=
X-Google-Smtp-Source: AA+uWPyL978DlUdfVHMF2n6LWVYxJQM7z0dA4t5VZ1lCQ1wYURwR9QskJkeNaq8z8fKctYjhDm/1KCMoIk0U5Ap/NKo=
X-Received: by 2002:a5b:52:: with SMTP id e18-v6mr17303177ybp.88.1534450853337;
 Thu, 16 Aug 2018 13:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81c8:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 13:20:12
 -0700 (PDT)
In-Reply-To: <20180816190252.GB3932@archbook>
References: <20180814191526.3247-1-atull@kernel.org> <20180814191526.3247-8-atull@kernel.org>
 <20180816190252.GB3932@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 16 Aug 2018 15:20:12 -0500
X-Gmail-Original-Message-ID: <CANk1AXR3gAc6YiC-WARrgnFbJWQVWv2Nuz49u7qyobJdKdNotg@mail.gmail.com>
Message-ID: <CANk1AXR3gAc6YiC-WARrgnFbJWQVWv2Nuz49u7qyobJdKdNotg@mail.gmail.com>
Subject: Re: [PATCH 7/8] docs: fpga: document fpga manager flags
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:02 PM, Moritz Fischer <mdf@kernel.org> wrote:
Hi Moritz,

> Hi Alan,
>
> On Tue, Aug 14, 2018 at 02:15:25PM -0500, Alan Tull wrote:
>> Add flags #defines to kerneldoc documentation in a
>> useful place.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>>  Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
>>  include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
>>  2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
>> index 431556d..db8885e 100644
>> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
>> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
>> @@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
>>  API for programming an FPGA
>>  ---------------------------
>>
>> +FPGA Manager flags
>> +
>> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
>> +   :doc: FPGA Manager flags
>> +
>>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>>     :functions: fpga_image_info
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 1ca02ce..777c502 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -53,12 +53,18 @@ enum fpga_mgr_states {
>>       FPGA_MGR_STATE_OPERATING,
>>  };
>>
>> -/*
>> - * FPGA Manager flags
>> - * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
>> - * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
>> - * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>
> We are actually missing the ENCRYPTED flag here, can you add that while
> we're at it? I must've forgotten to add that back then ... derp.

Sure!

>
>> - * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>> +/**
>> + * DOC: FPGA Manager flags
>> + *
>> + * Flags used in the &fpga_image_info->flags field
>> + *
>> + * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
>> + *
>> + * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting

How about this description?

+ *
+ * %FPGA_MGR_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted

>> + *
>> + * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>> + *
>> + * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>>   */
>>  #define FPGA_MGR_PARTIAL_RECONFIG    BIT(0)
>>  #define FPGA_MGR_EXTERNAL_CONFIG     BIT(1)
>> --
>> 2.7.4
>>
>
> Thanks,
> Moritz

Thanks,
Alan
