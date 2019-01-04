Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A01020675
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B6J9fOp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfADAgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:36:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46357 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:36:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so16592993ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sH696XfMqLRQ1tRvrc7Fi9lOpjV2QeG6g65JbjgrN0o=;
        b=B6J9fOp38YeW6xFrZDaVgQ9j69DE8ZH7irSliG5g2loIrXzWMOLx+VFHHWDY84sCyw
         ZCJCreI5Q6A4YSSe/EnME/RmhcS4NoVdJZt70efYDkn6+HLTXUs4KjINN6Xemej0aXs9
         JNqIvBBmAzkMmDwtDJDzL92fKPcUwmUsqIqPmzgjOUI07M2OHwVNzFijtsZGjlMSWXT6
         Pb5Zpcjr+Czcm/cdTNLWFTaJ3hHyJmsrQEQlA/64KO1ufM/yS3Y6GS8THA2doMPhqwsZ
         vOgmMRYWYZEepX9NI8ZgJ/ce2N028oPIG0fLBppKfdhoXxpFMUyVA8wG62aHRKxVftpf
         VcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sH696XfMqLRQ1tRvrc7Fi9lOpjV2QeG6g65JbjgrN0o=;
        b=QE7faQuzUOxrsc4NnVrf0SkoesmVEpl36kQ9rv7J9Lg4P6nAI4ukUVHbxazVuL4M4+
         wzddezNVRs9m+Dw6bh6vbelQId+fQ7WBsPqCvuTwsLc+I3A438ZZdYhbCRvp6bfOTRZj
         PNka/N/QzHOe/rn/f5Vj/ynPbM1re8vXC4Fu+IJgeGYq8MtToyh5QFPaA5liQ/i3S/zf
         tObDvIPMNeCblTtTm70M2JBV2dWE20shc3k9siSwaJD49duNl3shcJVPk8q/zwl5IH+v
         LyvPXi3hYpsqWpX7dln+r6LGHcow++cOMHYCBSvdMZKGi/6JkA/CShtBc8RsBOL01/dV
         5TyQ==
X-Gm-Message-State: AJcUukfIGqOTj1mZfv4gwB+QxTvyVkk4pVQckgDHcEV0TGmtqyEhyJNZ
        dsGcM6ScNPR5a606/mxF1bPi3w==
X-Google-Smtp-Source: ALg8bN5tKx1pXPFVw8R1Ze6QioXVWxnN4YZ4M2AQ0KfMIXpLFVOHxbATrDS/BtLmEsJjRwZmkE5ROg==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr48185166pla.216.1546562183309;
        Thu, 03 Jan 2019 16:36:23 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i184sm78920216pfc.41.2019.01.03.16.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 16:36:22 -0800 (PST)
Date:   Thu, 03 Jan 2019 16:36:22 -0800 (PST)
X-Google-Original-Date: Thu, 03 Jan 2019 16:35:55 PST (-0800)
Subject:     Re: [PATCH v2 1/4] dt-bindings: Correct RISC-V's timebase-frequency
In-Reply-To: <5d652370-4782-23b2-9896-b9666b3cc1e7@linaro.org>
CC:     atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, anup@brainfault.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     daniel.lezcano@linaro.org
Message-ID: <mhng-9767f556-9f5a-4366-931f-131222d3253b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 01:17:24 PST (-0800), daniel.lezcano@linaro.org wrote:
> On 14/12/2018 00:14, Atish Patra wrote:
>> From: Palmer Dabbelt <palmer@sifive.com>
>>
>> In RISC-V systems, timebase-frequency is per cpu instead of one
>> instance for entire SOC as there is a individual timer per each CPU.
>> Fix the DT binding accordingly.
>
> Why not use a fixed-clock instead of this timebase property which forces
> to declare a global variable to be exported from arch/riscv to
> drivers/clocksource ?

That makes sense to me.  I've always disliked this global variable and a big 
part of why my original version got delayed forever is that I'd hoped to get 
rid of it.

Given that this is all a mess anyway I'm OK breaking backwards compatibility 
here.

Is there an example of how to do this?

> In addition, please add the 'Fixes' tag
>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> [Atish: Update the commit text]
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
>> index adf7b7af..b0b038d6 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
>> @@ -93,9 +93,9 @@ Linux is allowed to run on.
>>          cpus {
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>> -                timebase-frequency = <1000000>;
>>                  cpu@0 {
>>                          clock-frequency = <1600000000>;
>> +                        timebase-frequency = <1000000>;
>>                          compatible = "sifive,rocket0", "riscv";
>>                          device_type = "cpu";
>>                          i-cache-block-size = <64>;
>> @@ -113,6 +113,7 @@ Linux is allowed to run on.
>>                  };
>>                  cpu@1 {
>>                          clock-frequency = <1600000000>;
>> +                        timebase-frequency = <1000000>;
>>                          compatible = "sifive,rocket0", "riscv";
>>                          d-cache-block-size = <64>;
>>                          d-cache-sets = <64>;
>> @@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
>>  This device tree matches the Spike ISA golden model as run with `spike -p1`.
>>
>>          cpus {
>> +                timebase-frequency = <1000000>;
>>                  cpu@0 {
>>                          device_type = "cpu";
>>                          reg = <0x00000000>;
