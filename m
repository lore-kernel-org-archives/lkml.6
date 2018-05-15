Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeEOI6A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:58:00 -0400
Received: from foss.arm.com ([217.140.101.70]:56194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbeEOI54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:57:56 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
To: Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
 <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
 <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <6579fdce-6845-70d5-1dc1-64d52debef19@arm.com>
Date: Tue, 15 May 2018 09:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/18 20:18, Jolly Shah wrote:
> Hi Sudeep,

[..]

>> 
>> As I mentioned in earlier patch, I don't see the need for this
>> debugfs interface. Clock lay has read-only interface in debugfs
>> already. Also if you want to debug clocks, you can do so using the
>> driver which uses these clocks. Do you really want to manage clocks
>> in user-space ? The whole idea of EEMI kind of interface is to
>> abstract and hide the fine details even from non-trusted rich OS
>> like Linux kernel, but by providing this you are doing exactly
>> opposite.
> 
> No we don't want to manage clocks in user-space. This debugfs is
> meant for developer who wants to debug APIs behavior in case
> something doesn't work as expected. Debugfs should be off by default
> in production images.
> 

Good that it's not used in production image. The clock layer has
*sufficient* debugfs support that will *help in debugging*. So please
drop this Xilinx specific clock debugfs.

-- 
Regards,
Sudeep
