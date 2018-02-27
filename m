Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeB0FLZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:11:25 -0500
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:3424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750828AbeB0FLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:11:23 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
From: George Cherian <gcherian@caviumnetworks.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
Message-ID: <a2016717-82b1-2802-877b-f947f349f792@caviumnetworks.com>
Date: Tue, 27 Feb 2018 10:41:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM (10.174.220.23)
 To CY1PR07MB2330.namprd07.prod.outlook.com (10.166.194.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd47f57-4ae6-4238-5fe9-08d57da08ab0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR07MB2330;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;3:BHUgn/OQO5SFbrWyny7lY9Wu3hL8tUz7PGwidDoqLpvTAP1WiD76s1hTCbzqM6NdWSyJg+FqmOGkTXO90jQ2ZdFJsT05dEIUxSUib/a580yA32fM7Isnshrn4GytYiSizx2Lwrmu6oao6Kc6oIQNcHl7QQyvQHZultqF7RWNYipg3M9nieLfA41/kcnKsQEikeRJG4uDHTJzF+NCIy+gmNbJNe99r4xbs5pU0UO5ghF418we61ik4ouecTyy67NU;25:hBfluhJowQ50r/Z/rV9wk5yjROJ3a6rjTF1+Bufpq+r3a5H1KFGQq0KMRQWzHlUoywLHDpw7Qh8FWfIr41FlIHTGFLOyBBz9q4JYVNoNdc+TcJAzt11A9TT0DrMDQBJH3lYGCICM51JnKULJBPQqJqFJ2L3ASHVBEqrQtZcxc4BA2FzYGUOCO1gd+f6q9nY91XCvAks7d4SCN9oOW9noUwk896FYtkqgGegZ00/qzHkqqA5VkbTWjrUAt3krj4oGXaun8bF4+ufPPSOKrJLSHV6gfBwYA8xT/hkOTdc0J2Ak3th5vVNu8dL9YVHbtPAUDz3RhCN/4vfFkYgCD5p27w==;31:CsTR9PIZg8NVysrCbijjlcsNyV5xmSgEjR1xV0WQKTGgximNKnNCB012PHAlZNYG/8cBGxDyIvDsMNfSm5omMLmLijVcQT4h3LE6EXTNvfva+Zfxz9vtQv0VuTpfm6whoDvJEUWljwHb/K3OxY4QNJS5BjKm3Y6voRFWscgBgPnp8lCodIN0XvgYNS3mHLRYIrjaQ1DxWpDsV62lP4/oG9GbN3nS1BjYdX9LohSSm6o=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2330:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;20:vdCtPTRCs+1RhlO4LnKFJimvDLyqDE2csKwpQscfIym0ZpuJ6564iszBQLgLBnV87eiybSB2VbVyTZXKoIB2iBhgeepMWHKqy9DcACQjasZffsJGJs+gjIcNwQ/YPOd/gwJgrjF7a4BEBDp++b6hS5dzFO1K/Kod2jJBLO4u5Y24pUf5POmV9CUEzJFItB/PdnjXQe6groBfHErLYm2njKLHueh7CCqkpO1uOL2uN/D43ynsNxH7F28rX6yxIH4vzRUmifGKD/tjwIWrSzCUsOs23T5TUiJMMVaqZqj6p6Cfdjo0XeH44pGKz3EPqT2sCnFHa+57G7xNYicqvAG8WoENE5s97cyImwFqXwCkHtv/s5hSzBi6Aag/8VVJPeBs+y8ed6zjor0D5L13R57ujpKOL1/XN/6S+SzcrEgMJuLYc42l1KXoec0BB2KyF3fM4cd1hQ7q+uGOakTxBQUkbOrJhyordKRrxFVB9DJSrz0BCMRFbEPtKQsy8H7uubsRHDZO3W2tVGOjliqPSNwBs3W0HTdcxcchAicI5fNz/FqKvinv+h84445IpH5lzVAwD17h4jJZQvsxKUQRhEMe3CBce7mJjIQYdkpf23XQvFQ=;4:B2Cj22lfRlK32BscvqRgIaKTMN3y3rmA2EQDTmxLr5ef7MsosA41a6vXlGO9g2DO8pnZJ5JyBdGe1oBIztk0R3jge6lRFlCGVvRk8FyM3a8ElgsD/KLYdFjTcDMjmIB6yP4vTXFjbS+/lFdCmMVRUqftyBth7XT4WWJkpwZp+QkFxVHMSzJC/FlwMEmBBfmQ7XU+vm9z6Dgfsw+8OCSG+XALcMtEMNtdiuZY67LNv6gw40ROx/2YcrTi284eeIxOxvTuS2e0ylA9yVrRX/OqiA==
X-Microsoft-Antispam-PRVS: <CY1PR07MB233005A69C865B69ADE50179F9C00@CY1PR07MB2330.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR07MB2330;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2330;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(51914003)(551934003)(5660300001)(478600001)(97736004)(4326008)(2870700001)(229853002)(65826007)(105586002)(81156014)(8676002)(65806001)(23746002)(31696002)(72206003)(66066001)(2906002)(81166006)(47776003)(64126003)(68736007)(65956001)(36756003)(50466002)(53936002)(42882006)(76176011)(2950100002)(7736002)(110136005)(31686004)(53546011)(25786009)(6666003)(67846002)(16526019)(386003)(77096007)(6486002)(305945005)(6116002)(8936002)(26005)(186003)(93886005)(52116002)(3846002)(6246003)(58126008)(106356001)(316002)(5009440100003)(16576012)(90366009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2330;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2330;23:NqdREtK8DtmaOvhhNFQdrm4Iq3wy66Jg3B3B5?=
 =?Windows-1252?Q?cpSncwCKltsdh9TYfLKwFcIWUwYhv2qKgwD/rCLR4AGKXb15Uk0DvmJt?=
 =?Windows-1252?Q?O83/LWpsdLGfMG9IwvHlwbmOMK1ea2SLemDK2AyjuZbtyDOlA87lqmQT?=
 =?Windows-1252?Q?e9b/2qRs3v5EHPhnWsLvG1LV3isLjKLjNfxPD/0PDL6sszGhboce4QRR?=
 =?Windows-1252?Q?jws82JJmxbHZ1WxII8Vrd8uE2khaRfQqt2A77EVDne70v1oGopDss+ng?=
 =?Windows-1252?Q?1Z05o35SW/BWmF2EZf4f44ngAUBV2D6rZnvsdOyL05N/cTlXTuVrtH4O?=
 =?Windows-1252?Q?/ezoleKKsJ+5DMMriZPHcJ6mpmvse6HUAqv2kmZXqNmxpGJDzvAotH5I?=
 =?Windows-1252?Q?4xs3i7HnYgIi/qF73OA3vfnullgLptQJmbnePw6/qBzgMnL/tk2q14zF?=
 =?Windows-1252?Q?3YTiARzj+pLWW9Db6Ms/VcC2d2j2jiqcadtZrCYHRsBgAZHcEQrdLZWm?=
 =?Windows-1252?Q?E12zFY55hgNZRRN8q3N7PIdmF/+ZzFzd01CCVwJxlsyJSHnKsc8YJgN3?=
 =?Windows-1252?Q?gjswrnrkcCnJ7aCrzlle64tblRO2d41qHehVDOco3attnc4hf9omE/2n?=
 =?Windows-1252?Q?lp9vgTpPSGEhn3pBwaf2Tp0r4JjCz5wMYU9WLdK4uWaKhgolkinNQuNV?=
 =?Windows-1252?Q?Ico01ByAtG7ftXf3zo+GQOfkxrxA2JxjWk7gI5egHWMiU/Dw3jPAY5Pt?=
 =?Windows-1252?Q?rP3Q+cKh3eMGeASLXVJ83KpOjTzDIyr9Pn3LVnf7+wfrrbdU2kby9uzc?=
 =?Windows-1252?Q?L+ibxlF/coLhDaBC1p8JePYSbJfywjpybHy/xPXTV9y2xaJSmrGdzHp9?=
 =?Windows-1252?Q?U/0GnMsqVR2pmcPmyoVyRFcppaCk0K84+lQwMLTMFmlRH+4TvmvlipDd?=
 =?Windows-1252?Q?Iq2hz6ISkT7tSegKPqOb5c57GmKVPrw1FRa9QAhdTKa3xIWqR3O6sBX+?=
 =?Windows-1252?Q?GEKLrvWCq+FDgrYCCVph+Asy1BLI7DEgm3n8908nScvbB3XhApmr/gSG?=
 =?Windows-1252?Q?RwA3yCqbjVtFG8huNAnC2YCt1xcqrVMFn5RrxicBmMEwR6j34QSmGdjH?=
 =?Windows-1252?Q?Ay6oyJ9SH3zX0VUPpJfZkUPU0a1futzNBEmG2LIV/5250XM/0Ow1BDb4?=
 =?Windows-1252?Q?bnWw7Yxd43Rd+oPrKx8sugBE8dxo99857RD70eBi2LAHPTEJuoIHabG6?=
 =?Windows-1252?Q?9c2So1Ia89Flj7ViwdV5Nj4t4I3ARDhZPk0acHl5nTDQ4k0cJedPNm5O?=
 =?Windows-1252?Q?A7doo15Id4MgYxI5aj9jXpMxUHzYlUAHSJQDB93bVcLapYQbkqKFyk60?=
 =?Windows-1252?Q?c1Ujmix8ibl+9y7UgAKfgJz2pBV2TdC0+cSOedVpE3KFN7BFAtO0fYcm?=
 =?Windows-1252?Q?U0aXoRx7pqRQxCaN5ppUw3kmXjvmml4/0NiXIP7WwQtgxKNK16UgODOp?=
 =?Windows-1252?Q?khkfXDLMJiuqmyliV4SETAHeNWgEeRrfWteKf/yErZ3Xki3pmJt11i3s?=
 =?Windows-1252?Q?nLX1e4c7rIFxVliI+vfPAV4mGJ1nUrddoDr?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2330;6:Cy7254YfDdVkjD/op1/xR4IHSdj0xVgPUGoUXG42IHS2uuVG0VYIdfLKr85qyeKTNxORTlvDGy3mvHOsZlwLymzUZhB/flVI5wZoOcsUR/qhIQwjnY1RvBgL+Bs6+fmlwGsduxFK84pd04lcmByni0vy1fF84sd3sfrYDXrVszGqGc0U8UVTf592LRkTvZ6agmdU/fDH4e3wtKO+EgWFntCCyunhUpbm4QUVD9B0lfHEuMqFL+KCBBvUXzZ1u0rTca89iF4em1mdNFfqStolzSp+jZCLoFGH5txf3qWZcKx6RJt7LySMgmur5IO5lkADJne/KgIVwa/i0S46KOHKV3MmdH8mBnGK6Wo3OD0dzUM=;5:VV3Xc1Z+g5JvzDu2G7a1R2PSOe6/PkeigTtA0QbHfTAh3+0sZfwQ7kYyW3XVHfD4CcKBAShwodyX0w8dYPR4Psdahb6N+ERr8Bw0KuVbZTnVmgJHogulWdYZCkSJ/ltxumBWa7QVUbFMOp5jsoO5BwhLNcIeGaEyL8elPcnm+gk=;24:tBpz9tagWpErWeMC0bAdTSK/+43YbLER50xeEXbbz3EIFufu3yzEFZgzDJ15VE+F0ZRGPRQK/jjLw2LkfByFpEU0baZCX6jI2ARvjWJqx04=;7:cusWOFbnXvfoSqEBrIk7kS9o9Rn/jYUtvS8judFBgZb8Y89w4NP7MYdjH6Vu5/RaeyQtfTTpJKY7lGxIzMxJ801aR66yyDatY03QNn5QAPBMtqA+qhDIBp8dG3Gu60VOEdphye7jRTIRF/+Ki86S7DF6TqBFLZduhnU0SlwaInAvqufwXOYkDGF0W+GFD5rHgxZxRW/Tx+qHjAc5WVJWjYEsKmDW3fCGdXwfZEBE8TE9AfHWMXhueHVy3/Y7k2j1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 05:11:19.8315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd47f57-4ae6-4238-5fe9-08d57da08ab0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,


On 02/27/2018 10:30 AM, George Cherian wrote:
> Hi Wolfram,
> 
> Thanks for the review.
> 
> On 02/27/2018 01:52 AM, Wolfram Sang wrote:
>>
>> On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
>>> I2C bus enters the STOP condition after the DATA_DONE interrupt is 
>>> raised.
>>> Essentially the driver should be checking the bus state before sending
>>> the next transaction.
>>
>> Yes.
>>
>>> In case the next transaction is initiated while the
>>> bus is busy, the prior transactions stop condition is not achieved.
>>
>> I didn't fully get why you can't check the BUSY bit and wait a little
>> just before you push out the next message?
> Yes, I am checking for the BUSY bit and looping.
> Here for reference
> 
> +    while (last_msg && busy_timeout) {
> +        status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
> +        if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
> +            break;
> +
> +        busy_timeout--;
> +        udelay(1);
> +    }
> +
> +    if (!busy_timeout) {
> +        dev_dbg(priv->dev, "i2c bus busy for too long after transfer\n");
> +        return -EIO;
> +    }
> 
> Did you mean to eliminate the udelay and use msleep?
> In any case I will re-post another version of the patch, since
> I have found some more issues and need to be fixed.

Since you raised concern on the patch I thought of reworking this patch.
But I can see that this patch is already applied for i2c/for-next.
Kindly let me know whether I should be sending follow-up patches on top
of i2c/for-next ?
> 
>>
>>> Add the check to make sure the bus is not busy before next transaction.
>>>
> 
> Regards,
> -George

Regards,
-George
