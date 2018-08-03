Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44580C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2F2178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B7kQOZjX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J8j1XdEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D2F2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHCVud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:50:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbeHCVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:50:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51D446031A; Fri,  3 Aug 2018 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533325969;
        bh=GF4zvWf8mYMCMtje4Nt3Q6+hLOhpZSis1MWImfafphU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B7kQOZjXaoI5MKcXM2YjClBprF8ebodeixjRGfW4SXOa1Kx4s5gR8cMG3VBzOozT8
         FURgjZ0+iMarSJzKv+YNXXeINJIrqYwHAmGnRlL29Kf8S3r3Fo0RRo6PDH7LyHabSH
         1a0rNPb4j2AXjTTCRBwHWS5/2WN5IbpPfVx6uc4E=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9324760117;
        Fri,  3 Aug 2018 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533325968;
        bh=GF4zvWf8mYMCMtje4Nt3Q6+hLOhpZSis1MWImfafphU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8j1XdEIHjcjbwh7g1k9QrihwjiMI/w0cpKb+s43KEhd6CvgWH9vvR1p8hP9r6L2e
         H8WNzECF4nFoP/IkNZ8U7Vwmf6EWB9BfUiIYGFXhMqO/yWEiQM7L8Bc8kqJkBCxjLN
         QQ9/+hdv681ElYNxvbLWTF3aXyLrCl3rYOAqoIKE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 12:52:48 -0700
From:   skannan@codeaurora.org
To:     Evan Green <evgreen@google.com>
Cc:     tdas@codeaurora.org, rjw@rjwysocki.net,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
In-Reply-To: <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
Message-ID: <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 12:40, Evan Green wrote:
> Hi Taniya,
> 
> On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>> 
>> The CPUfreq HW present in some QCOM chipsets offloads the steps 
>> necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm       |  11 ++
>>  drivers/cpufreq/Makefile          |   1 +
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 
>> ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 360 insertions(+)
>>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>> 
> ...
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..ea8f7d1
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> ...
>> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>> +                                   struct cpufreq_qcom *c)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, 
>> cur_freq;
>> +
>> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +                               sizeof(*c->table), GFP_KERNEL);
>> +       if (!c->table)
>> +               return -ENOMEM;
>> +
>> +       base = c->reg_bases[REG_LUT_TABLE];
>> +
>> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +               data = readl_relaxed(base + i * LUT_ROW_SIZE);
>> +               src = (data & GENMASK(31, 30)) >> 30;
>> +               lval = data & GENMASK(7, 0);
>> +               core_count = CORE_COUNT_VAL(data);
>> +
>> +               if (src)
>> +                       c->table[i].frequency = c->xo_rate * lval / 
>> 1000;
>> +               else
>> +                       c->table[i].frequency = INIT_RATE / 1000;
> 
> I don't know much about how this hardware works, but based on the
> mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
> and 3 all mean xo_rate?
> 
> Also, is INIT_RATE really constant? It sounds like gpll0 (or
> gpll0_out_even?). You're already getting the xo clock, why not get
> gpll0's real rate as well?

Actually I was about to comment and say NOT to get clocks just to get 
their rate. The XO_RATE is just a multiplication factor. This HW/FW can 
change in the future and make the multiplication factor to 1KHz. We also 
can't really control any of the clocks going to this block from Linux 
(it's all locked down). Adding clk_get significantly delays when this 
driver can be probed and increases boot up time. The INIT_RATE will 
always be 300 MHz independent of what source it's coming from (as in, if 
GPLL0 can't give 300, the HW design will be so that we'll find a 
different source).

So, I'd like to remove any clock bindings for this driver.

Thanks,
Saravana


