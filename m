Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeB0JcY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:32:24 -0500
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:20275
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeB0JcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:32:18 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
 <20180227090416.gxgof6fyzdeshtmf@katana>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <b3f7a353-7d04-bdb9-0d68-176c38a0b9a3@caviumnetworks.com>
Date: Tue, 27 Feb 2018 15:02:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180227090416.gxgof6fyzdeshtmf@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::12) To SN1PR07MB2336.namprd07.prod.outlook.com
 (2a01:111:e400:7a46::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fdfbec-c815-4048-70b0-08d57dc4fd51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR07MB2336;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2336;3:kcKxQIMWQwz9WAg1bSjQNTx58qXD8izaImJgpImObDZoyy3iH75EEilskTGqDeGGscwbho7WnofFB5LRmpHCMVXts4J/2DxWQK2C7zygTtSmPP4JGuE6Gm3WgSBCCRjgnfq1kzrNVOchm4KqDewpOlpnl2JSH7Wgfmu9GgQ+vWceIAhIu3RHbE5fvrBng0M35LWX34wghdObk+Y7/WyL7GjYrk0nUZxifRcOxeEXUtnn2baRfHNsbPJAh15K9k32;25:hUzCgTqozUx6TzFId26eL9bc/Xaxo4FdA0Ctkx96RZoNbw9HTwYTv6YIVdiOeefbkSzT4qP12e4a+cuYKtt+q19/IVH2p7+zS/UlLjXIUOL7jGF4odRSdLxy37g/DwD8MUc8jV/q/vpKh8C4Cog6zKPpzQDfbyKbhqcZhYkspCVLLBmd54/Gozz5TSHlf52yHwwDiOOLa2xzg/Ap2xvDRTPJyatOsrD9Oy4lfm2OPblOGILE8OF+oTlujjINQtmpUeazkdQ/D9F0uUB5iuoTVyJTebOkEM726C22nLmW4yjB4GhDRiDPhm/eJ212G1zynho/dwdobl9ooTDlLRi5Zw==;31:iJuK+TqImcjpJw444RmZTt9Uh+rCsea3uES0wrR34TtBP66g+2vi5nKTY+DSoYOUCg+pPP/EW5oaZiEqob3DfgNY/hYdeuJ9BxJ2RKC6C4teI0kXh5/+BSMcTV3khT+JUFooklGI7LOT8Nj+bK+uiQcL9NCoNmKT/ft22mxLD/ONy/4k/79TpZP+g9U9odN9XIaaRJMOisfFvtbc3ykpibN3TOyTxYywB7E1uE6SHd0=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2336:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2336;20:ZCZHV6DXpnYzyNFpouUdqhPh86IyJh1Cc0E4c3UeYW+6Xuz3JSTS0BKhCuwyurIQnKwcIlnNTb1OyrX+jnDvDXSHO4uLVzJjcfhmfYcHb6waIeCh9hUsrc7uv2DTsnoJ6Yt6uYSfXRUgRRHYWWYlIsZUzFhDaUnWsFx/BIPPkuaq8SRjhGEkKicvdGoBvWTYAEK0br3+53NHG/u0/sSi0QgoLMNz16wqYVqwjcJzxrqZAx1/EcCH2w7S5ps1Hhd0E5UB9ZS7s3SFVE9Uj128Rpmq3YgriJActRINL42McdQy5VCr3HlF6sNw4NQeHS69M21E9ZS2FT794xdg6mGrrI8x3rQZVL31HpFIZfK8uQEUD180NSRhMzvtPELVXVUqisHwdXmxGfKue3/L0Bx+k0R33Z+ctqq5/CADLZV9Vu0ndum2tv5iANSjGQKZR/KmQZUUWA9smX4qkRqc9dRBDNSnXiUcaLhxIj/HUM3sXOnqFnnxWm56AHsr5pL16cZgH8EUoaNG2dDJQr4mqCd+pSkX7WnpWI1aHCXQOfaIQ69LKvVuBEC3MPfdoxeI5MaUz8T5AS95+YB5/H3qU0TTANTPsVJsUndw4BNScN7reeM=;4:LZ+OxSEEcdoLBDt5gI78fgR68Cz0ANOZBuNQe3xYKX4J3FwtrS0jn17ok9IG/6zdJ6DH+ltpJFGDtE9gcR/syQcND2SK+gnCkH9ZQB8nsd+mX3fJd1opeFEYkOr0lEaw6vbf+Y1MXu/kDmgtcGT9uJ/rOLpvSM+Jgf89a/RvU5ghgNduaCYocqwGgrFlDbf+58mKrjjYr4djlwt/6Qjs+vSQN0j212IUeQc3I+cPnoPNoILVMUwSAp99BKz4qz9MLK+chP08cYqYoYP+TAHa9w==
X-Microsoft-Antispam-PRVS: <SN1PR07MB2336BF23533265C7271AEF62F9C00@SN1PR07MB2336.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231220)(944501161)(52105095)(3002001)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR07MB2336;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2336;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(396003)(376002)(366004)(346002)(39380400002)(39860400002)(51914003)(199004)(189003)(16526019)(6916009)(6666003)(186003)(47776003)(6246003)(105586002)(65806001)(2906002)(53936002)(66066001)(93886005)(6116002)(31696002)(3846002)(229853002)(23746002)(5660300001)(67846002)(52116002)(76176011)(5009440100003)(106356001)(16576012)(72206003)(65956001)(50466002)(65826007)(7736002)(97736004)(316002)(64126003)(478600001)(305945005)(31686004)(551934003)(4326008)(81166006)(81156014)(386003)(53546011)(6486002)(230700001)(36756003)(68736007)(26005)(8936002)(8676002)(42882006)(2950100002)(77096007)(25786009)(58126008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2336;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2336;23:B3tjIaIm+jqBkSdQPEPWZPIbfRO9WDjL0ZfNU?=
 =?Windows-1252?Q?xHE2cbasd1ewtCsqxpO5sQ9LmczkNEeF079E/tWJfyoB1OZ0vtBnpabN?=
 =?Windows-1252?Q?GDbFhGCSi1/7djeifdJ7dhetd46tSYscZJA3Y3zfoJvO1YR6u/Ef9LKw?=
 =?Windows-1252?Q?k6TUhlhHzNmB0wlNm5FKycV/Qwep6jOP3nPHgM8voODK8LujIKglMUEt?=
 =?Windows-1252?Q?wAiwHbWg1yNeZQhCoEFYQjsX7cgbhQbrowD1hHU4as/1Ullg2SknjQye?=
 =?Windows-1252?Q?0lOaCKeFTHNf9SIBi0Yro/7g6NfJASf1um8rOoLC7xjbuTUzTbTj3cUJ?=
 =?Windows-1252?Q?bCkFq4wx0JLJzn3lTczaVWA8GfcHqeRE9iGlVPuQ9t/NGV8PaQ1qeROm?=
 =?Windows-1252?Q?/da+xk4GLzNy3675OAGWbn9Gmsbv2OAOVtagzN6Ht+nXhZuRcVQZuZwB?=
 =?Windows-1252?Q?Mt8YX/bwqaXE6GOajULHsBK6wwL7NB96uGaIMud3Nj5+GKL3zOHFheiy?=
 =?Windows-1252?Q?O+dj6J40PoFjogb1VYcycUqQrKKLfuXl+MpIAyfphaTUuWu22I16LPUM?=
 =?Windows-1252?Q?lkZbSd+Hy7cB/k1NUsqnWN0GAnLGrLduLrZqpmRcClSDzBFCzVTN+LXk?=
 =?Windows-1252?Q?wfvETzrlySXtykK8SLnq4gCtIdOIw+GdJY/D6pffy6MlZTAcRfL15Kf+?=
 =?Windows-1252?Q?LjQAPm1u/a1Q4FPmS7HltF2qPWOljYQWKkI8NztFXEbE98DtU1CfqkEl?=
 =?Windows-1252?Q?qxlR+/cyHJhL7/vjNirYWcqtMiPnwyZIHoO3m4g+2RD/QOQqUXI3P4un?=
 =?Windows-1252?Q?1teGIiQJ2yDzgjIhaUS+M8b9oRkfjyeJvhD8sp212laJ9/Ii3Et0Cl/h?=
 =?Windows-1252?Q?Yf3wOoEPjScjJa1v+CkMkzcs3J6mBgeYJ6LAXEhFeJDd0IB18yhHvveT?=
 =?Windows-1252?Q?WXXIVXjvAaA00L37sgWER62qC5PoExbeWcT8cDKGwfnpAg/wsHoyhMar?=
 =?Windows-1252?Q?kBCNTYQ7/DnXlDFeWzXSnOF8HgOViMq98FlSmddl3QI4f3kPT1fzoy8T?=
 =?Windows-1252?Q?aARfXZ1stlXb1qo5iPQHPdSKZ6cZG1DcUTMnae2KdmvIMtXQVoyTFWnj?=
 =?Windows-1252?Q?eyhR4ttFukmy0b/zU/z7ZuqCmknXHc5DktivtUVmWBVl9iU2QtzGy3cN?=
 =?Windows-1252?Q?Mn02p+5kGlFB416ggPuDqCw8+ZlpRYs88nvJzt1BoIHkh6F9dCIo85DT?=
 =?Windows-1252?Q?sctRNYmOJO8gIQ16bkQl+O1fBPHZItUei8OHffNJpO9IdLlmJCE00uEg?=
 =?Windows-1252?Q?2FBVv/qO4fmJtf6gOj/LBCV/VayLhZer1sn4jRI+TjrRl++0T5gOTQnu?=
 =?Windows-1252?Q?z14ujohWnTosgkQfXp3sUpnfp1NlnWMXecq4frqnEIEZXYyEo1ngVCAu?=
 =?Windows-1252?Q?kcmry1VZyh6wBTOPqN2j1kgKtvPxuHvh6LnjtObZzuzNmG4+SpsvHnLk?=
 =?Windows-1252?Q?GkOepkQkNkOF2twYHKBvJ4Mv1iAH8Zyua6dZAd3KkuUUQPGITCbZL/v7?=
 =?Windows-1252?Q?3jNicysKw1VeQlmWNBUyittCopDgeLspeKnZr1o7BZt6ePUE+ToxliPE?=
 =?Windows-1252?Q?+tl7x9Gzu+Gqwxm/5/qiMa/WejXx1ptZDdxAlaVDrVA?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2336;6:uo0BzdZOpm/GyR334TZrHo0O3+yTIHbe8uK4DNH1u3PP/ZhI9ZFhRI9xi3yVlS3RPv9TXI91CCi/D/P9DHz5NDrPe4pRsAJbzDFR+wEH91ACDPwCrkAgNvKbCI09o0Bktv+M+acjVas5Y1hsC5Kp5fmF5sbkzH/g9eGxi0uaPlL1mSIJIn1dU/ZXXZPc1RoyKQv8lEHnvVIJVctP6DwBGpMDvo4Lu4RMnXtV4OuCqvR7to/g72OrOemQz6mDQym1luy0P7BVn77Un2xuN0yatKL6MO0cx44AI/4vefh2DJ1YI6m+qVizaETAZcRyETGa3mMV9P+fVmbEFpQHJN1V8+jYgRG8FqZNWVVD2/yHBmc=;5:VHnvxvJ9Hq3yxz1gabkYafXM9CZEDolQ4/QfvUhVtyJdYePnJPmdH/mKX5wtRcFuIuk2bc4Z4W3XeJku2uIUOroYryM2syXo9p+PXKcyVBjuCszVfLVUPM9FSrlwH7i/GJba/oZNfmjzw/g+KbI4xw2vlCQio+vZPqoTMm5VH9o=;24:wpTKCBDJ5aREnYx3ri8dHu+G6jpgxo+ppvh5MXYP2IiMPzxHd6c22gmnvJllfcN5hGgpSG3E51rBEcqfnuNROYIFltweoSQSB/Uo+xaMRr4=;7:G8UXDXLibfKbNS7XNQCKAnTdcTk9LTZndz1PqTcTB/dyMk5S14LIiAjM8ov3t6vckQbOL8VjM3c7NoqbrkE1skVarF7WptQLZTChfrgqiQu3j7SqlSuu4RWoexMKHr8QDqL+lrilneRwTSnm7Pqm7jB9YJ1RKDMpS34d/BC9pQbLHREbFQ7o7O+OyZwr30aKIFxWU4Y8nBr10JsNXkXEKOC76cDKvaeoJRxo59q+1WZ1Q3lhZXmJkCuropnnoIQN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 09:32:14.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fdfbec-c815-4048-70b0-08d57dc4fd51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2336
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 02/27/2018 02:34 PM, Wolfram Sang wrote:
> On Tue, Feb 27, 2018 at 10:30:31AM +0530, George Cherian wrote:
>> Hi Wolfram,
>>
>> Thanks for the review.
>>
>> On 02/27/2018 01:52 AM, Wolfram Sang wrote:
>>>
>>> On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
>>>> I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
>>>> Essentially the driver should be checking the bus state before sending
>>>> the next transaction.
>>>
>>> Yes.
>>>
>>>> In case the next transaction is initiated while the
>>>> bus is busy, the prior transactions stop condition is not achieved.
>>>
>>> I didn't fully get why you can't check the BUSY bit and wait a little
>>> just before you push out the next message?
>> Yes, I am checking for the BUSY bit and looping.
> 
> Yes, but *after* the STOP, not *before* the next message. I haven't
> fully understood why you don't do this before the next message is about
> to be sent. That might save you some busy looping, or?
Yes, Thanks for the clarification. You are right It is better to
check before next message. I will make required changes and post the patch.
>

Regards
-George
