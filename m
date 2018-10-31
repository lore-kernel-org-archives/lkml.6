Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E314ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563F220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fqqCOQ1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563F220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeKAC0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:26:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeKAC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:26:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so7934999pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=c+AAfyPSg6Bdkghso4fAoZ8kpHRWAa540BD2QamzIO4=;
        b=fqqCOQ1+Xf1H6++nKQTU6L2QBwzE2LSAa9FuAeFx7LJfWf3NF2QAf3Irn6hpJ23vcP
         V4yPCOc8JwKAvB7GbExsHiPYJMmnxMhwrkyTecP0SrteNaGzTCr6xv2cHsAaBqWK4CFb
         bGD+cOfXA6FNZJy/+ol7bI0emyDc+ADoEk/M6LUNPnKNE2IdAa6GweM2ZFUt12eNllAO
         SF6vb4DqRo7KYuN3G70hu0sBIf3ABD9h7OJuxdQgbJYi1YtIJvnyGQ66P4u69jnJDXxi
         azf3GwI65YDsHzmdZH+9eMnl968oeP3xofZmmPkimRLrivj0kDC13++q+HmAH+8vzDw2
         6ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=c+AAfyPSg6Bdkghso4fAoZ8kpHRWAa540BD2QamzIO4=;
        b=G0tzeMwomcPZL/OBnbmic9Kr2SqoGjYmYIgJw53VLh+Z49Yo+thse8tlGhDr8T3chR
         zYDllVMuUbwhH5EA7/31qgn3BNwjWLDKrMU+iCgoyuwK6F/DoRD1R099sdE7XcOio9Mn
         IqVNACzgMtCEzJ99j9mFuOFVoGnUlPIDR3W871oj1LkoGATpBCqWsXmQFZ5pMys/eMdn
         IOgY3UiYdO3z9gSohdb7FET5gnfLH0Ujarelm9sBMCIUj8nv0ImSkSe9EUYju1LZO3Em
         3xIdf42EypJE7xlw8GVpXv8OyMXROqLhlBW5RAxO+OPIr8BP2v+s4GCuW/ezHDANDaq/
         cBOg==
X-Gm-Message-State: AGRZ1gL6IEDlQjFocCT79ArhnyxXUYsIc6jqxt5iQ9wdM8fsQzcjF0Gf
        w5YOHm93GaOXQBp0UtStdOYpbQ==
X-Google-Smtp-Source: AJdET5fwA+Ltdfa8FKYsZWwM35vQQzvVRvX4j21gCC7e6pycd0MjlnPX0mKo560Vj/eVqyu6b81+eQ==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr4320959pfl.67.1541006826531;
        Wed, 31 Oct 2018 10:27:06 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z14-v6sm31349726pge.47.2018.10.31.10.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 10:27:05 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:27:05 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 10:26:53 PDT (-0700)
Subject:     Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
In-Reply-To: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
CC:     vincentc@andestech.com, aou@eecs.berkeley.edu, zong@andestech.com,
        Arnd Bergmann <arnd@arndb.de>, alankao@andestech.com,
        greentime@andestech.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 04:16:10 PDT (-0700), anup@brainfault.org wrote:
> On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
>>
>>   RISC-V permits each vendor to develop respective extension ISA based
>> on RISC-V standard ISA. This means that these vendor-specific features
>> may be compatible to their compiler and CPU. Therefore, each vendor may
>> be considered a sub-architecture of RISC-V. Currently, vendors do not
>> have the appropriate examples to add these specific features to the
>> kernel. In this RFC set, we propose an infrastructure that vendor can
>> easily hook their specific features into kernel. The first commit is
>> the main body of this infrastructure. In the second commit, we provide
>> a solution that allows dma_map_ops() to work without cache coherent
>> agent support. Cache coherent agent is unsupported for low-end CPUs in
>> the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
>> need this solution to overcome the limitation of cache coherent agent
>> support. Hence, it also can be used as an example for the first commit.
>>
>>   I am glad to discuss any ideas, so if you have any idea, please give
>> me some feedback.
>>
>
> I agree that we need a place for vendor-specific ISA extensions and
> having vendor-specific directories is also good.
>
> What I don't support is the approach of having compile time selection
> of vendor-specific ISA extension.
>
> We should have runtime probing for compatible vendor-specific ISA
> extension. Also, it should be possible to link multiple vendor-specific
> SA extensions to same kernel image. This way we can have a single
> kernel image (along with various vendor-specific ISA extensions) which
> works on variety of targets/hosts.
>
> As an example or runtime probing you can look at how IRQCHIP or
> CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
> hooks should called in similar fashion.

Yes, I agree.  My biggest concern here is that we ensure that one kernel can 
boot on implementations from all vendors.  I haven't had a chance to look at 
the patches yet, but it should be possible to:

* Build a kernel that has vendor-specific code from multiple vendors.
* Detect the implementation an run time and select the correct extra code.

This is essentially the same as my feedback for the performance counter stuff, 
which IIRC is what prompted adding a vendor-specific extensions.

If I was going to do this, I'd split it up such that the vendor-specific 
additions are per-subsystem.  That way we can focus on building a decent 
interface for each subsystem that needs vendor-specific support rather than 
just bundling everything together where the vendor-specific stuff will get all 
tangled together.
