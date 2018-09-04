Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB82077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEB82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDNq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:46:29 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35576 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbeIDNq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:46:28 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w849J49b011214;
        Tue, 4 Sep 2018 04:21:57 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m7r62kekj-3;
        Tue, 04 Sep 2018 04:21:57 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 097BC611C8B1;
        Tue,  4 Sep 2018 04:24:05 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 4 Sep 2018
 10:21:56 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w849Lpca023206;        Tue, 4 Sep 2018 10:21:51 +0100
Subject: Re: [PATCH net-next v2 4/7] net: phy: mscc: read
 'vsc8531,edge-slowdown' as an u32 [UNSCANNED]
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <f.fainelli@gmail.com>,
        <allan.nielsen@microchip.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <rf@opensource.wolfsonmicro.com>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-4-quentin.schulz@bootlin.com>
 <20180903132756.GD4445@lunn.ch> <20180903133746.wsvezy3rbdivnjfs@qschulz>
 <20180903200554.GJ4445@lunn.ch> <20180904072630.zc6sdz2xdti5nku4@qschulz>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <6c189a8f-7168-3861-c964-b38631833451@opensource.cirrus.com>
Date:   Tue, 4 Sep 2018 10:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180904072630.zc6sdz2xdti5nku4@qschulz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809040098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/18 08:26, Quentin Schulz wrote:
> Hi Andrew,
> 
> On Mon, Sep 03, 2018 at 10:05:54PM +0200, Andrew Lunn wrote:
>>> Just to be sure, we're talking here about making sure the value stored
>>> in the DT is not bigger than the specified value (here an u8)? If so,
>>> that isn't the reason why I'm suggesting those two patches.
>>>
>>> Without /bits 8/ in the DT property, whatever were the values I put in
>>> the property, I'd always get a 0. So I need to fix it either in the DT
>>> (but Rob does not really like it) or in the driver.
>>
>> Hi Quentin
>>
>> Ah, you are fixing endian issues. That was not clear to me from the
>> commit message.
>>
>> I don't know enough about how DT stores values in the blob. Is there
>> type info? Can the DT core tell if a value in the blob is a u8 or a
>> u32?  It would be nice if it warned about reading a u8 from a u32
>> blob.
>>
> 
>  From my quick research, the lower bound checking is performed by
> of_property_read_u* functions but not the higher bound checking (the
> internal function of_find_property_value_of_size allows higher bound
> checking but it seems it's never used by those functions (see 0 in
> sz_max of of_property_read_variable_u*_array)).
> 
> sz_max is used by of_property_read_variable_u*_array to copy at a
> maximum of sz_max values in the output buffer. If sz_max is 0, it takes
> sz_min so it's an array of definite size.
> So since sz_max is 0 for all calls to of_property_read_variable_u*_array
> by of_property_read_u*_array, we basically know we'll get a buffer of
> sz_min values but we don't actually make use of the higher bound
> checking of of_find_property_value_of_size.
> 

This was the original behaviour of the of_property_read_u*_array functions.
If you look back at the of_property_read_u*_array implementations
before my patch they passed max=0 to of_find_property_value_of_size.

To avoid duplicating code I reimplemented the of_property_read_u*_array
to use the new of_property_read_variable_u*_array hence they pass
sz_max=0 to preserve the original behaviour that max=0 to
of_find_property_value_of_size, so that I didn't break any code that might
depend on that.

> We could enforce this higher bound check by, instead of setting sz_max
> to 0, setting sz_max to sz_min in calls to of_property_read_u*_array.
> 
> But I guess there is a reason for sz_max being 0. Rob, Richard (commit
> signer of this code) do you know why? Could you explain?

> 
>> Anyway, this change still removes some bounds checking. Are they
>> important? Do they need to be added back?
>>
> 
> The edge-slowdown and the vddmac values are compared against a const
> array so we´re fine with those ones.
> 
> For the led-X-mode, I added a constant for supported modes that gets
> checked when retrieving the DT property. So we´re fine here too.
> 
> Quentin
> 

