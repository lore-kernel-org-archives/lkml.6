Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDGto (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:49:44 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:55841
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750709AbeEDGtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:49:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525300581-27217-1-git-send-email-wang6495@umn.edu>
 <4390a69e-a297-313d-044d-abf846eff1d1@axentia.se>
 <CAAa=b7e5_E_7zSaAfTm8kSA_2MkyYXv-xS=ZH1AY9-u_s+Y+CA@mail.gmail.com>
 <82973b7b-b6ef-6d42-df5c-be3ea72212fa@axentia.se>
 <CAAa=b7dgSUitBM+swrcb95Uk=Zdt0Li_dwcuskzux6m7QvKFxA@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f36dda27-b7c2-6650-7638-22e80371fde9@axentia.se>
Date: Fri, 4 May 2018 08:49:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAa=b7dgSUitBM+swrcb95Uk=Zdt0Li_dwcuskzux6m7QvKFxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0221.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:FPfEtESKxKLO3jYDFwdWCebpIzQUojf/nlOI9fjE/pGo9pxXnPspeMyYaHYL0f2vQ49GwKgn9Me1ee6Cc/g/pjlQ4JIzbMXEaUIdm7/BboRzDH3hfkqfGrepqeqWCnIMwdEgKL/vlryJNfo+7O74CQnoRgR0BvpwdmKff2xpDitx7GT9FSO6vjd3HDMtYtIolSBGfd+u9rZpaZAR/URCBm/8wcCAEP3H/gfoYVUAGq1hxvT8hxo68p38CFytnFLW;25:KRFvjrPFR2z+l7xfiaue20A2YkoGD9w2NJpQ08iUoqy/t8KUhPBtoL+VR31RPhDdMk9jTDipHg9UHkTlCJ7w0X3h9dus+wTtHrnGMIM5A35ilHiYf+/vc6Br6N3RiWdVcfHk+c/Jrq2twkWDjiJcWaBd4yT7iVw6IH5Crq2mkQsmPKDF+RKBKBCeFt/wH/vCrzEYDYrBpKk48eBb3vLcHt0i6vyWmwSP01XvH6u+jbVz9fhJCcWF8a7vCHo5laeZr0FFCivB4FnEuT7dtRSBr/RpzHk+FZLAlsG0OQaBU42IzERKQd33OzcxEnDZVM2pwv4ZNzEIk5PTU7P/iCZbcQ==;31:LLIomtSpVqAqsZwNcklK4GbnkVFaPfHPREBfpnUqxzR7Bz+S5QqUbrHhcQDXQkJUSw2bKplOTN2crPYKVWmlFTouyEB6GADflATL0ikxNg7XBlMkGZ0aPznILespwijvdiFWXuFWe86PXZGZGvCYPgI0QU53I/bp8Bbud7/CJKsI6iABf69C1gHCdaOagGYckgZLbD5OsxpvuPK8AmT1XndfAoX12BYtb392VuHCVQw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277915CC574FA4129F5F98B2BC860@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:NYZ1+XFslVT4V4B7d1kJgCWTeK3sI2DxYs++GgHvDky0NvP41E9wqb6TdnoeAsec0tc6qVAK9YCvHAmMnnK7Tk/EV5rkqHTHFvPV/z6erSdcoIJQpKFQmsT+laxFCMFsFj+KAJZebhpw6Src16d+5JH/DVhTshaVSpC4EAu0CQ4UL3mNTiKiHq1mSyLVE/JkY3nta3wqEddD9RUaRod2xdo4XV51e3ifVmuMdBSoqyR1nCynnUR+dpJpbbgpVnPOQlbj50LI8rZl1M32DFgFwo+guJ7F+lZF5a10wNntSopew8m+l79rRZJed4jgiTfxabfa2ZY0vjyZuzBtSiz4/+S05hPS8iSt3C+4dI5p1nE=
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(396003)(346002)(39380400002)(39830400003)(199004)(377424004)(189003)(36756003)(68736007)(7736002)(54906003)(2616005)(2486003)(8676002)(2171002)(76176011)(6246003)(23676004)(36916002)(59450400001)(8936002)(52116002)(4326008)(386003)(81166006)(50466002)(53546011)(52146003)(26005)(81156014)(230700001)(16526019)(446003)(64126003)(3846002)(486006)(476003)(65956001)(77096007)(956004)(11346002)(6116002)(47776003)(65806001)(65826007)(186003)(66066001)(6486002)(117156002)(305945005)(31686004)(229853002)(53936002)(105586002)(106356001)(6916009)(5660300001)(86362001)(74482002)(478600001)(16576012)(2906002)(58126008)(3260700006)(97736004)(25786009)(316002)(93886005)(31696002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzk7MjM6QVBxTWljUnQraGJ6NjhQS1hZNmY0bDhR?=
 =?utf-8?B?RUpWNXhmSnEwRlI2aXlsTWhBc3RrNE9ORXNFSWRUNk1UWWhrTDNDUUw1dVk4?=
 =?utf-8?B?VXJKZno4RWV4Uk1jQUphVWNPbW1oa0pMUExYVkFvaUloN1NYRDhMaDI5UnNh?=
 =?utf-8?B?VElPc1FDdlNITTNpQksxc1lQbWxzcWdTM3JQbW42MEptT1RrMk1yc2tVc29Q?=
 =?utf-8?B?QlZUKzVMR2VvU3B3ZkZnWVAwSEk1U1RqRWExWkxWSUxCc3FtVFBxamp5QTBT?=
 =?utf-8?B?R2dtN1JGcHBINEFLdnlxZ0YyZnpOZmc4Q1QzakduRzF2a3dEMVRYK29yVmZl?=
 =?utf-8?B?Yi9xNnhMU1JqWWtBY0tYc3lIc3F0dmxCTkNrY0NESnQ1UEN2eW04cnZjSUlB?=
 =?utf-8?B?bFRaZWFiZWJ4NHpLRVFGRHdkQ0pUS3dQTm9nazJZQ1h1Tm9PT29EK2VJNVBU?=
 =?utf-8?B?TEJ5ZC9lTWZ2U21PZlVmTjNhZDFENXZWem42cFR0d014NWtaeW1jdXdNM3lE?=
 =?utf-8?B?bFNMOFNVSlRQRmRYdmpkNEI3d0VuaE5Id0hZMHVBenJoOFRpVTQwYWdUcWFS?=
 =?utf-8?B?ZjRTdldHT2lrTk45Z2FRUEdLUUZ0azJuWUpvU0tKRDVGZFh5cGIwVDZRb1cw?=
 =?utf-8?B?MDQwV09VSXMrclNwUUtQSmtHc1Jodnp1UjZUOXhWS2dsRHhSNUNEeVlnbStR?=
 =?utf-8?B?bDZ6WGZ3WlViMG9heXhYQTZWclhjenZjYkdXVDZXL3FxNVdvSXVTU3d2MEJC?=
 =?utf-8?B?U3QweEUzRGhxd2w1T0tpRkY0R1RvVEljKzdrSEtXQnIzaS9GOTBlNk9tSE1u?=
 =?utf-8?B?TEt4OGoxTlBGQngyK2NnUEhzWDlkRXVEUW11SmJFbzlxK0FJdXhPeHRKQ3RL?=
 =?utf-8?B?VVBQSjJGTlIwMUhMdEV6QVJRRDdObkRIQ3BYZnVXTWJ6OEROeVRGc1hzLzNC?=
 =?utf-8?B?enduQklUTnNIS2ZGck1iUllJbnZWTnR1S1VVd1lrc3g2eFJoOThUeXZDQk4v?=
 =?utf-8?B?ejFLMUQrczd3NnpOckgxQmdDajFEUHllTWZyNEVlY2MrbndzQnFzdysyRlZO?=
 =?utf-8?B?d0ZzcWljbU9BZEkvMm55c3BDTDdGTXZrZlVwRXN3dENKblNMcUZLVHo4WW5l?=
 =?utf-8?B?aDF3WlF6b08rSDdibzEyMm9yN1luVERadEFKdnhoajRjYm5Jc3FzTkxqRjVR?=
 =?utf-8?B?Rm1sUjdNK1pLSVk0L25DSDdoSlNweVNEa2NGTTNrbkp5b2gwaEdJMlU1M2NS?=
 =?utf-8?B?ZkFRQ3VhUFZhRXY1U1NnVXlXUktRMnFjcms4Q3huaiszM01Hc3o4VnNjNnlW?=
 =?utf-8?B?b2E5bUtKaTdLanJhM3dvOGw5MG5jZVpoZGd6Qnd1Zms1Z2hqK2VRd0w0ZHdP?=
 =?utf-8?B?Z21HcWFNcFBxLzYvNUNTbkVOd2VxV0ZuZFdmdzhnSlQ3anNiV2hqVkNsY2Zw?=
 =?utf-8?B?U0JzU3FWMVRvY09UZ21Sc21hZy9HWFBEZ2Vid0gydHA5YTQxZjRQSmU4T09u?=
 =?utf-8?B?TkYrdW1YdTJ3cjlWTWF4TWp6U2FlRk5OcjRGbjRTV2VvUit6MzRpSHFwemdY?=
 =?utf-8?B?TWpLa1Vaems5OS8yMXVYVlhFdTM0UUZPZ3VHMXFMc3FkWUsrS2VPeGI2YjVp?=
 =?utf-8?B?UDYzRHpCUWtiVmF4TE5oaEhlZi9qcDlmaFlVempkNFdYZTNSdlBvdEROK2FY?=
 =?utf-8?B?aHlMNlpKZFN1Vmp1ZWpXSkZnek5OOUs5STRvNGhZZmFFL0pHV29KRTh1emU0?=
 =?utf-8?B?SEZvN1czRFlKbW1qeVJGWEVQTHVJbG1VOE9rdlA2NkhWdXorb1ZNcmVQVHpF?=
 =?utf-8?B?MC9iWm5HNkJlZlZ1ZzJYMlRGWVFhWEhRcklyd3B2b0xhTE1EdnBWUVY3NW14?=
 =?utf-8?B?NDRtNXl6N2ZHempQYXNXQVlXQk5yWnVlcklBNzFLemg5M1ZtaE9HWG1GRjdi?=
 =?utf-8?B?YWs2bUNLeU16clRibFJaZjZ1S1UzVVAwSHh1akFUcTE2cXJYTjE0Y3ZxaHNU?=
 =?utf-8?B?VXdQNmN1WXVMSmNVOFI4VTBoT2Y0VDNDNEx3WWU4dk16WTh6OTljNmpLYVE0?=
 =?utf-8?B?bHUxVENmL3B6Z1p6aVlTREcxRzFKTDBYdVFRWFdoZUVBWHkxZ1puaXZzMzJN?=
 =?utf-8?B?U29mdU9VM2VTemRmbnFoUndsR0htMFp1MFRMTlI2NDBEQjFXbDJCalc1NGl5?=
 =?utf-8?B?MHBub2k1VWZ2c0M2b2RNSW90d0svenc9PQ==?=
X-Microsoft-Antispam-Message-Info: Dd7SN/dSPhvAttEjI1KzoRvgzlU3UGu0N6jdD8cPknMHzzcfFlt815I/OZ4Hz445O+mx1PQj2YMVDUfgfa9nLTKWUHBeUHOe2wJnXpqQwfDThW1qte29jS33QuerRkofLGPw3KLqJv6o8NnBKhyRBkHxAr8tgeZC4+IAbrn8HTtbxPSz2q3ISkeKqugUJ0rp
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:B0HV7iyEzjPOYeKQYHxvB146/AKiZ6iu3tlAVP4rsd5gZQpQ4iN/isXtzb4Ba0q5wfJT+W0Rxoouho/sjJola9FD5UOjA6uMXeqyzYvFKG2HaUUXfBiBGrVjfMUYaAo9OduDa24knHqDyUvRY5hLjCV5zFVK9ohIXeSLx0fFFSiioRG7Zi44hRfHlbTGN1dIvSvqL1O2NglJZXV2MslHrH0SKfYoqmunYf3P+6fhk+i29f4CPul6FpVhArwv4aRl0ygyKWkaPr24pIEDKBKLVNvmZPSQHHA4TyKGPFNvoT+ggh8DMFHVpRm8zGMAXoAGHVhzHma9dE63srf4h65zwIRWPojON35Rg1plqUlONqYk7eyvsxx9NXzOC0wHVOcxN2+SGwB6Rx8s9f8xyP+UTTtNrYv0UYFGRUCi9jeozStmoWuqhVBVWzQfecNTQ7aC3GIQgp9u6izC2Qk+ZeynMA==;5:Qj6wz+Btcu2n/rHVci8QKdhY7Ma4SpkPw5YrOLGIgXjl7Pr1zxyenC3EglD7/lk+yZzPyC+6JACQA761JFUpUpjWDk1T/5iFyC/06COD3WyPdzeuonuv0DaqUoUI/D6PC44eEa3oBrTEI7ZdpIwuvVq4Ia8YyLPGTNnQ7p1ajMU=;24:J4+38dfUJcw6SyWlw+hy3YzvnWEq0GG0dXQY5r9ilNJ6ZuJUR3RHyjYhJWkhgk3XpI8DkYJcUFwSrlLDI5MhrxyuHUBpDvrVqZHMv27pTgI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:2H2ikMHfBJvIdlD+6SOku0GjoMD2B88iOHB6zRoNGuOmgzqQcBRB1KbZo7GHo78ZJrHKZH0OvWSYEIkIkjewDhwRh/DUtz6RjUn6RDHFXdYDCPRn4sG3BKmgLne4D4F6TMvmXzPy1zmWbhr0v3b+HfTK8Szo5IYSOsNqFYwIdoKG/ibosomYH8jk9YJvmQAfEstWEio2th8Vla2zaCMdeoM/cXX+sjhaUyPuwX8Ya7VuJGiDjvoLelQtmhqb8W4g
X-MS-Office365-Filtering-Correlation-Id: 50917cd0-a470-4743-6ed1-08d5b18b320d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 06:49:33.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50917cd0-a470-4743-6ed1-08d5b18b320d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 07:28, Wenwen Wang wrote:
> On Fri, May 4, 2018 at 12:04 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-05-04 06:08, Wenwen Wang wrote:
>>> On Thu, May 3, 2018 at 3:34 PM, Peter Rosin <peda@axentia.se> wrote:
>>>> On 2018-05-03 00:36, Wenwen Wang wrote:
>>>>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>>>>> which are used to save a series of messages, as mentioned in the comment.
>>>>> According to the value of the variable "size", msgbuf0 is initialized to
>>>>> various values. In contrast, msgbuf1 is left uninitialized until the
>>>>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>>>>> initialized on all possible execution paths (implementation) of
>>>>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
>>>>
>>>> double negation here
>>>>
>>>>> uninitialized even after the invocation of the function i2c_transfer(). In
>>>>> the following execution, the uninitialized msgbuf1 will be used, such as
>>>>> for security checks. Since uninitialized values can be random and
>>>>> arbitrary, this will cause undefined behaviors or even check bypass. For
>>>>> example, it is expected that if the value of "size" is
>>>>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>>>>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>>>>> value read from msgbuf1 is assigned to data->block[0], which can
>>>>> potentially lead to invalid block write size, as demonstrated in the error
>>>>> message.
>>>>>
>>>>> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
>>>>> behaviors or security issues.
>>>>>
>>>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>>>> ---
>>>>>  drivers/i2c/i2c-core-smbus.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>>>>> index b5aec33..0fcca75 100644
>>>>> --- a/drivers/i2c/i2c-core-smbus.c
>>>>> +++ b/drivers/i2c/i2c-core-smbus.c
>>>>> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>>>>        * somewhat simpler.
>>>>>        */
>>>>>       unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>>>>> -     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>>>>> +     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
>>>>
>>>> I think this will result in the whole of msgbuf1 being filled with zeroes.
>>>> It might be cheaper to do this with code proper rather than with an
>>>> initializer?
>>>
>>> Thanks for your comment, Peter!  How about using a memset() only when
>>> i2c_smbus_xfer_emulated() emulates reading commands, since msgbuf1 is
>>> used only in that case?
>>
>> I was thinking that an assignment of
>>
>>         msgbuf1[0] = 0;
>>
>> would be enough in the I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL
>> cases before the i2c_transfer call. However, this will only kick in if
>> the call to kzalloc fails (and it most likely will not) in the call to the
>> i2c_smbus_try_get_dmabuf helper. So, this thing that you are trying to fix
>> seems like a non-issue to me.
>>
>> However, while looking I think the bigger problem with that function is that
>> it considers all non-negative return values from i2c_transfer as good<tm>.
>> IMHO, it should barf on any return values <> num. Or at the very least
>> describe why a partial result is considered OK...
>>
>> Cheers,
>> Peter
>>
>>>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>>       int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>>>>>       int i;
>>>>>       u8 partial_pec = 0;
>>>>>
>>>>
>>
> 
> Yes, it is a big issue if the return value from i2c_transfer() is not
> equal to num. I can add a check like this:
> 
> if (status != num)
>   return -EINVAL;
> 

Right, but make sure to add it *after* the existing "if (status < 0)"
check as we want to preserve any existing error. Also, -EIO is perhaps
more appropriate than -EINVAL which seems wrong for what is probably
a runtime incident.

> Also, I wonder why msgbuf1 is necessary if it is replaced by kzalloc
> in i2c_smbus_try_get_dmabuf()?

It is not always replaced. The stack buffer is probably retained as
the default mode of operation (and fallback) because kzalloc is
expensive and because kzalloc might fail?

Cheers,
Peter

> Thanks,
> Wenwen
> 
