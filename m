Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEPRdR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:33:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:33:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 16 May 2018 10:33:14 -0700
From: rishabhb@codeaurora.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, evgreen@chromium.org, robh@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
 <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
Message-ID: <385198cbb91c4a36ad758997916ad271@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-16 10:03, Stephen Boyd wrote:
> Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt 
>> b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> new file mode 100644
>> index 0000000..a586a17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>> @@ -0,0 +1,32 @@
>> +== Introduction==
>> +
>> +LLCC (Last Level Cache Controller) provides last level of cache 
>> memory in SOC,
>> +that can be shared by multiple clients. Clients here are different 
>> cores in the
>> +SOC, the idea is to minimize the local caches at the clients and 
>> migrate to
>> +common pool of memory. Cache memory is divided into partitions called 
>> slices
>> +which are assigned to clients. Clients can query the slice details, 
>> activate
>> +and deactivate them.
>> +
>> +Properties:
>> +- compatible:
>> +       Usage: required
>> +       Value type: <string>
>> +       Definition: must be "qcom,sdm845-llcc"
>> +
>> +- reg:
>> +       Usage: required
>> +       Value Type: <prop-encoded-array>
>> +       Definition: Start address and the range of the LLCC registers.
> 
> Start address and size?
> 
Yes i'll change it to Start address and size of the register region.

>> +
>> +- max-slices:
>> +       usage: required
>> +       Value Type: <u32>
>> +       Definition: Number of cache slices supported by hardware
>> +
>> +Example:
>> +
>> +       llcc: qcom,llcc@1100000 {
> 
> cache-controller@1100000 ?
> 
We have tried to use consistent naming convention as in llcc_* 
everywhere.
Using cache-controller will mix and match the naming convention. Also in
the documentation it is explained what llcc is and its full form.

>> +               compatible = "qcom,sdm845-llcc";
>> +               reg = <0x1100000 0x250000>;
>> +               max-slices = <32>;
>> +       };
>> --
