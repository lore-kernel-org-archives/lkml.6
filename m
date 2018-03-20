Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeCTLpY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:45:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeCTLpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:45:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 17:15:19 +0530
From: sricharan@codeaurora.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: absahu@codeaurora.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux@armlinux.org.uk, marc.zyngier@arm.com, mark.rutland@arm.com,
        robh+dt@kernel.org, robh@kernel.org, sboyd@codeaurora.org,
        will.deacon@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <152153121123.254778.13134751025860491351@swboyd.mtv.corp.google.com>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <152153121123.254778.13134751025860491351@swboyd.mtv.corp.google.com>
Message-ID: <791f479d0dc9b212f8bccdb441def953@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2018-03-20 13:03, Stephen Boyd wrote:
> Quoting Sricharan R (2018-03-19 20:58:47)
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> 
> That is an odd place for a reviewed-by tag.
> 

   oops, by mistake. will fix.

>> Adds missing memory, reserved-memory nodes.
>> 
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 
>> +++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi 
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
>> index e413b21e..ad0fbc9 100644
>> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
>> @@ -20,6 +20,34 @@
>>         model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
>>         compatible = "qcom,ipq4019";
>> 
>> +       memory {
>> +               device_type = "memory";
>> +               reg = <0x80000000 0x10000000>; /* 256MB */
>> +       };
>> +
>> +       reserved-memory {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               rsvd1@87000000 {
>> +                       /* Reserved for other subsystem */
>> +                       reg = <0x87000000 0x500000>;
>> +                       no-map;
>> +               };
>> +
>> +               wifi_dump@87500000 {
>> +                       reg = <0x87500000 0x600000>;
>> +                       no-map;
>> +               };
>> +
>> +               rsvd2@87B00000 {
> 
> Lowercase hex please.

  ok.

Regards,
  Sricharan
