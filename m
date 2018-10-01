Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86094C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C510208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C510208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeJAV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:59:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbeJAV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:59:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91FFCsh138908
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 11:21:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2munrg19s7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:21:04 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 1 Oct 2018 11:21:02 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 11:20:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91FKwZp28246204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 15:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20E16B2065;
        Mon,  1 Oct 2018 11:19:12 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C05BB205F;
        Mon,  1 Oct 2018 11:19:11 -0400 (EDT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 11:19:11 -0400 (EDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: media: Add Aspeed Video Engine
 binding documentation
To:     Joel Stanley <joel@jms.id.au>, eajames@linux.ibm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hverkuil@xs4all.nl, Rob Herring <robh+dt@kernel.org>,
        mchehab@kernel.org, linux-media@vger.kernel.org
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
 <CACPK8Xd0MhrFQqiM=u-Rv5u7RJRo5R-pAejH4dmeTrYSWE0AZA@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Mon, 1 Oct 2018 10:20:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACPK8Xd0MhrFQqiM=u-Rv5u7RJRo5R-pAejH4dmeTrYSWE0AZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100115-0064-0000-0000-0000035832C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009803; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096356; UDB=6.00566899; IPR=6.00876399;
 MB=3.00023576; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 15:21:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100115-0065-0000-0000-00003AD572A4
Message-Id: <3e53dda4-81c4-1009-add2-45a3a7998e4e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2018 08:08 AM, Joel Stanley wrote:
> On Tue, 25 Sep 2018 at 21:27, Eddie James <eajames@linux.ibm.com> wrote:
>> Document the bindings.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
>> new file mode 100644
>> index 0000000..f1af528
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
>> @@ -0,0 +1,26 @@
>> +* Device tree bindings for Aspeed Video Engine
>> +
>> +The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
>> +capture and compress video data from digital or analog sources.
>> +
>> +Required properties:
>> + - compatible:         "aspeed,ast2400-video-engine" or
>> +                       "aspeed,ast2500-video-engine"
>> + - reg:                        contains the offset and length of the VE memory region
>> + - clocks:             clock specifiers for the syscon clocks associated with
>> +                       the VE (ordering must match the clock-names property)
>> + - clock-names:                "vclk" and "eclk"
>> + - resets:             reset specifier for the syscon reset associaated with
> associated

Good catch, thanks.

>
>> +                       the VE
>> + - interrupts:         the interrupt associated with the VE on this platform
>> +
>> +Example:
>> +
>> +video-engine@1e700000 {
>> +    compatible = "aspeed,ast2500-video-engine";
>> +    reg = <0x1e700000 0x20000>;
>> +    clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
>> +    clock-names = "vclk", "eclk";
> Did you end up sending the clock patches out?

Yes,

https://lore.kernel.org/patchwork/patch/978979/
https://lore.kernel.org/patchwork/patch/978976/

Do I need to send them as a separate series?

Thanks,
Eddie

>
> Cheers,
>
> Joel
>
>> +    resets = <&syscon ASPEED_RESET_VIDEO>;
>> +    interrupts = <7>;
>> +};
>> --
>> 1.8.3.1
>>

