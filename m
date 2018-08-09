Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBC621B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyznyqOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBC621B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeHII7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:59:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHII7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:59:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so4085900wrv.10;
        Wed, 08 Aug 2018 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Px9zpOqBFzv0rRYyWbqXgS1ySMvRYSOHOnJOQH5mL5A=;
        b=kyznyqOLqf+BbvCSm2SBfb/6BHacjHgOuwVecPxWZozHDIW8FQsWv9hNhTsaR1nhI6
         bmcgmIo4M7CuwnEZ5ckPeIIYldMEW9h8EXH28n9CKUCDuTJ0js0FJFf5iUCKsRCEHk1j
         IYXdpfDJX7s4zpN8Jra3+Rx6GWL0E+vO51y6L0HbsXBWfKH74rDQb9pjMPHLqJrkLWuh
         7/txIpztIFkUFjS4UiuvL2V7SwjWJrK2+wPEL9mebqI/X0PEluOBGv4w6E+JDWwTrPYS
         0wHRl9SCnOleJmfWmKP4n0f9qA84Xc4GINh0Nwn989u05mCarPGXoziskmBV2LsUCZZ4
         NM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=Px9zpOqBFzv0rRYyWbqXgS1ySMvRYSOHOnJOQH5mL5A=;
        b=GL32UB1E5C6q4auOAoUyP9vsnr8jp05ixc9EkLdyobX4zFUWaTAMGqrOVlRqqlSfzK
         q24Rg9Jv2ppzzJ8yOUw09vbI/WSX2dDqECE3YC4l9AQXRIyOVsuidggV+BxuBbAowTKc
         rDokEHTmWyb8Uu7LNu83mfzXpZ9/tBhHmj3AONQWRvXB5/gtZlQd6BeD+HnC1PR6Qex+
         H1kY/H4BZDPXAB3BOXvA1nm130q+zGC7xEMi7Q/rzBv4fLVp3NWHmxM+P1saXAJQBfwl
         Oo9fdCVBZ8r6VjFD6owKe/F3GZ37yERoG1noCytgX5810dEluWTKJKi43Gd23HlX+tvf
         DPBA==
X-Gm-Message-State: AOUpUlGsKBHIApFiub7ZlUTtg3Zufm1Ul4vsaWAdmHee1Vg1mp57ZegM
        tz8CkrQIhHvaAEsMDHJATGEGOKAXb6Sb4in6AkI=
X-Google-Smtp-Source: AA+uWPyu55OIuX6pa1fO02VkQfRqDG+8BWO0nN3iMuVNHNN6a9VlyT7fpl7TQDlTQcrUFV9u8r7YttmIPeQw9gTzwPk=
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr500469wrn.143.1533796581270;
 Wed, 08 Aug 2018 23:36:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:af53:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 23:36:00 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <20180807145603.GA1664@rob-hp-laptop>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-3-andrea.merello@gmail.com> <20180807145603.GA1664@rob-hp-laptop>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 9 Aug 2018 08:36:00 +0200
Message-ID: <CAN8YU5Pwn-dqU=QwiG=Wmg2QbEj2Z5U-uEQZcc3huZw-w568jA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod <vkoul@kernel.org>, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org,
        v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:56 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Aug 02, 2018 at 04:10:08PM +0200, Andrea Merello wrote:
>> The width of the "length register" cannot be autodetected, and it is now
>> specified with a DT property. Add DOC for it.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> ---
>> Changes in v2:
>>       - change property name
>>       - property is now optional
>>       - cc DT maintainer
>> Changes in v3:
>>       - reword
>>       - cc DT maintainerS and ML
>> Changes in v4:
>>       - specify the unit, the valid range and the default value
>> ---
>>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>> index a2b8bfaec43c..aec4a41a03ae 100644
>> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>> @@ -41,6 +41,10 @@ Optional properties:
>>  - xlnx,include-sg: Tells configured for Scatter-mode in
>>       the hardware.
>>  Optional properties for AXI DMA:
>> +- xlnx,sg-length-width: Should be set to the width in bits of the length
>> +     register as configured in h/w. Takes values {8...26}. If the property
>> +     is missing or invalid then the default value 23 is used. This is the
>> +     maximum value that is supported by all IP versions.
>
> If 23 is the max, then why is the range 8-26?

26 In the max possible value and it is supported by some HW IP flavours.
23 is the max value supported by ALL HW IP flavours
