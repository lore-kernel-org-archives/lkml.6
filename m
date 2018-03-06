Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeCFP5I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:57:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:57:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 998B7600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 6 Mar 2018 08:57:03 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180306155703.GA4930@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
 <20180305231455.GJ18510@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180305231455.GJ18510@minitux>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05 2018 at 16:15 -0700, Bjorn Andersson wrote:
>On Mon 26 Feb 09:58 PST 2018, Lina Iyer wrote:
>
>> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>
>> Command DB provides information on shared resources like clocks,
>> regulators etc., probed at boot by the remote subsytem and made
>> available in shared memory.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v4:
>> 	- Fix unwanted capitalization
>> 	- Add reg property
>> ---
>>  .../devicetree/bindings/arm/msm/cmd-db.txt         | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
>[..]
>> +	reserved-memory {
>> +		[...]
>> +		qcom,cmd-db@c3f000c {
>> +			reg = <0x0 0xc3f000c 0x0 0x8>,
>> +			      <0x0 0x85fe0000 0x0 0x20000>;
>
>I'm still concerned about the use of the redirection mapping here,
>the relocation at 0xc3f000c is used a convenience thing so that the
>command db can be relocated, but because of how Linux will consume any
>non-reserved memory the dts would still need to be manually updated.
>
This location is fixed and it is not expected to change between
different boards. OEMs may change the actual address of the command db
location, but would not change the dictionary location.

>As such I think you should just describe only the 0x85fe0000 + 0x20000
>region here and to support the dynamic aspect of this from a system
>point of view you can have the boot loader read the information at
>0xc3f000c and adjust the reserved memory. (Or just keep the step of
>manually update the dts without caring about the indirection)
>
It would be incorrect and very board specific to just use the 0x85fe000
as the address. It is not how the SoC defines the location. Upon request
earlier, this memory location was added in DT and the location is
typical reference platform usage only.

Thanks,
Lina
