Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBZRly (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:41:54 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44368 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751340AbeBZRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:41:52 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v8 1/9] mfd: madera: Add register definitions for Cirrus
 Logic Madera codecs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180226130558.7634-1-rf@opensource.cirrus.com>
 <20180226130558.7634-2-rf@opensource.cirrus.com>
 <CAHp75VdTdtT8D0OmPo1DPZfjEogSJcBRJBuesHDPrB+bD9CVgA@mail.gmail.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <edb9d625-a859-2c57-999a-4d00ed5c656b@opensource.cirrus.com>
Date: Mon, 26 Feb 2018 17:41:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdTdtT8D0OmPo1DPZfjEogSJcBRJBuesHDPrB+bD9CVgA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=966 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802260229
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 13:46, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 3:05 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>> This patch adds a header file of register definitions for Cirrus
>> Logic "Madera" class codecs. These codecs are all based off a common
>> set of hardware IP so have a common register map (with a few minor
>> device-to-device variations).
>>
>> The registers.h file is tool-generated directly from the hardware design
>> but has been manually stripped down to reduce size (full register
>> map is >44000 lines). All names are kept the same as datasheet names
>> so that they can be cross-referenced between source and datasheet without
>> confusion.
>>
>> The register map layout is kept fully-defined rather than factored into
>> macros and/or block-indexing code. The major reasons for this are:
>>
>>   - #1 is that it makes the source highly greppable, which is important.
>>     "What does the driver do with register bits XYZ" or "Where does it use
>>     register bits XYZ" are commonly types of questions. These can be quickly
>>     answered by a grep. Squashing definitions into generator macros or block-
>>     indexing code is a way of defeating grep.
>>
>>   - most of the register definitions are used in tables, so a constant value
>>     is required. Using generator macros make the table definition clunky and
>>     obscure.
>>
>>   - the code is clearer when it's there in the source exactly what register
>>     and field it is using
>>
>>   - it is easier to diff the register map of a new (unsupported) codec against
>>     what is already supported and merge in differences
>>
>>   - it makes the register map available in source for maintenance/debugging
>>     instead of having to refer back to the datasheet for a register map
> 
> ...
> 
>> +#define MADERA_OTP_HPDET_GRADIENT_1X_MASK          0x0000FF00
> 
>> +#define MADERA_OTP_HPDET_GRADIENT_0X_MASK          0x000000FF
> 
> GENMASK() for all masks?
> 

I'm an un-fan of GENMASK(). It seems to me to make it less readable.
Unless it's important I'd rather leave the masks as they are because
this is all auto-generated from the hardware design. Also keeping it
in plain form like this makes it easier for people converting
settings from the output of codec tuning tools.
