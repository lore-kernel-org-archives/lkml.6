Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELvidpfM9OtTNAho1NqQQRa7DBT5Dc3XsMqhtgS+iatkHMWsT3w3ohTxS00RFEgNUc/4FH7h
ARC-Seal: i=1; a=rsa-sha256; t=1521813588; cv=none;
        d=google.com; s=arc-20160816;
        b=BhpiDs6RZWjymBGV6GToSjCq7WpdK5x6TIgbbmN0cq8l8BGU8Z+vNTAuLKq/rD5/Pt
         jtj3ND6ELUb4BsiPszuChPPT6X3yIRfyc5CiIFh1v1A+KEo6CcOkT/6EREoBuu8JlN1Q
         2NxweWdQEgN2hdaBMiyTsPfeAVnafPiiblz8e5J6W9fGCqLFna9AFei+PEHOK4odW4Y8
         zyErHcsx0PXolReCWKEuRGn2RQ5nGkqfIkL8y5iG9hkdaGRp6/V/Pp54FBm8/EhN4C1Q
         k13bjzAPu7eOeQsuUSz1SIw3xSSkDtQ3pNzx0QWP8UtXhhmhK+TzfWqZ6AGe2WloBaX3
         7mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=eCuhM7CwJ2FBLF4Hf1b6I0sSP8mXwsYEirEGFCSmhxQ=;
        b=lvsxZzZDcznib4IFu5LN0/qlM0Fo8abg63cvm/KNSqyqAM3CTNv/FKtebBIaK0AdIE
         bb1W3QREy91y0mAGxUXdriV7hF/xEMGFBEipNXjDsmMH/sKMGrZEfx/N5t5rfx4iPP3/
         lt5lPGmgkhyv6gB7/vSdkMYDrRjWIoFAhHcn+mETg4fB55ZK+in9ZVzSva733NaordYa
         2aXp3Y2el7BSriw41tjZ4U3QX9vwWI5m3R3miCnPdfbvwSzTnG2m7TVNvJE39c00yqoZ
         tpWo4WbscJhQ2ufMZZpsd8xyt3pbCvA/Hm5R4Q1u7JnZ7v3Dc+Xcv1TYJdqxyBSVHxjj
         vzhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=O/uIvcCJ;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.0.127 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=O/uIvcCJ;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.0.127 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 0/3] iio: add unit converter
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180323141401.000031cc@huawei.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
Date: Fri, 23 Mar 2018 14:59:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323141401.000031cc@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR07CA0154.eurprd07.prod.outlook.com
 (2603:10a6:6:16::47) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92076634-f19b-4d5e-d56b-08d590c6557a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:9HJr5hujv5COujttaFMgxtctd6MderHj46nHpHuQuzJYUPIvpjY1xa8mpNipZ/k5JLdYDWumJVCz/iCa93644tc/d0/IBNseqLMy9CuztRqN6BLE4+ll5GN/eNNutKkjUCmGmQKJwPvyNWVHL+dqjicg3iscN/qJlkQ4/HYobN2xmEUBsj7NaSM58aFGoXs8SrBP3b4S4ztqjmSZkeqVZz0wu80/vuLRzXb2AQ0TpVlx0RJmt0hKRXiIWWsSzkuP;25:SKYYrYO+ISdWv23VKS4YBVo9Iq9w+TQgmNPZnsQ0srgOUBzcQkd0uF583Dc1MDhcIa85l7dcBLWt4G8ArlJbX2+otmg+EPz++iqCfkmRIUNn00y248anrGo9aYiVcWd7c7zH5Pteazsjnjpgvfchp2nK8bkhSzRSzjpj/SABVI/x0nnwvjOQv/caBHFM2jwYNcoI3f5bdIYx2fYS3/mgR4xntZIOqd+vGNTUPzdIgDK6dgsxOswtm3/bDhBop3tbQtmuLg3ehhdhxxWEJh8hUcm9r02RhDidJMI9fQqOVE04E3kN3IfMldMBWTxeJzJ7EKlni8k2z1plCHjC08o8JQ==;31:o3ADlPLT7TfDI6iHmL3pNmEyLjkTmpUcz06/1hzLh8mFfKX4o2P6tPCeyE006ek9dur7D0ANWgUfPxXvH3Sn6//4Jr5K6r6ZIDWewKPqU1e3XcYP8iKME0R5ZFuI6rkzBwLB2Z4sBaEPEesX91Fl4ZTiumCuETMgTfPGvR490sjKwo936IT2HoUJRJJoIXDV5BFY4TBSw7fJkfgWZdDESUJNJ3qewFt+doi8Dx53DX8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27714AF9077B7967D6883F3DBCA80@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:Xoe1B3f/zXmPJP4m2mMs5IiUxndlfow1+cqozRoiNkPPf5E6f57nH24wNNk7WygysdwSCnLKrcv581zPWKisWiFFjdtSYXe8D+wqS/0Uy5ZLe3rN3vgKQsW/JNvJDBgooiSSJspv63yYrxD2rmsI06395CokBQ8cy5fVeAQ6dgEuSK4P0NfObRq9rGVhvttLGFyD5XRzUv2wVbKdnH62e84LpfUzXu1Gvoo8QtvbKV7BUQDAIra24IDqFEpEkWKv74+ZlDQWCPdqR2Fd7O6jXA==
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(39380400002)(396003)(366004)(376002)(199004)(189003)(377424004)(31696002)(316002)(6666003)(7736002)(59450400001)(6486002)(6246003)(305945005)(97736004)(8666007)(230700001)(117156002)(31686004)(54906003)(58126008)(53936002)(64126003)(52116002)(4326008)(50466002)(52146003)(74482002)(2486003)(76176011)(3260700006)(25786009)(23676004)(36916002)(8676002)(6916009)(81166006)(81156014)(105586002)(3846002)(446003)(68736007)(11346002)(65956001)(6116002)(478600001)(106356001)(8936002)(47776003)(5660300001)(26005)(186003)(2906002)(36756003)(16526019)(65826007)(77096007)(7416002)(86362001)(65806001)(229853002)(386003)(66066001)(16576012)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6emgzdGZBSkcxL2hQYUVBbjM3Z3VCUUht?=
 =?utf-8?B?ZjVIVjJEOHp2dzVOdWNmWldzK3p3ME1oTStJRDVKSkhYS1EwK2pTUE9oM3dx?=
 =?utf-8?B?enRoVGJoMXJyNzdIUnBLb1htM2RUM3VoZTZwMFljZlU5RDJCNmduS0VTTnUv?=
 =?utf-8?B?L2loSFE4NmFVTzB3a2NhdWRTUnhhTFYzZi9LWTFkRDdHekdmWDlBQlNGY0tB?=
 =?utf-8?B?Z2x4TjJZbzIyNDl3N2hNRkRYMDhnWDBUUWcvWFZuMnAwNTJKSVdXYzRHdXBh?=
 =?utf-8?B?Ym1Gc1BBRUtMQ1duZitmSzZnNjV2SGRkZnFqUVNrRW1rZy95TjYrVzh1cDRG?=
 =?utf-8?B?Q2RZRGhabk9Lc3pOMDBBMVA5ZXhBSXZVUTI2dlVkWTljeWhoUWMzajhDTlhB?=
 =?utf-8?B?Y3NzbUZrc1RwT1FPNnp1YmdKQWYvekN6WHJyVFV3d2szRjFnNkI4TndBNTM3?=
 =?utf-8?B?NDJaTWxLOFpoL2pqRzhtMWFFaUZRd0tzM2g5cHlBNWZEWlM3aEhCdTljaTZJ?=
 =?utf-8?B?UExtZWlHdnJKSmdrZXRSREQwSVAvR2d0OUlLM1MzR2hpTzJseVYvbkFEVXpI?=
 =?utf-8?B?NlYvMXRnMlZ6T2RPSDA3bitBazFoTjBITmd4NjVhRzA1TThKOGV0eUVoY3gy?=
 =?utf-8?B?YXpWYXlwa3pkazNnM3Q3cTBrUWZGN1djQ21EMjdWYkVvSXh3ZDJycXQvS1Jk?=
 =?utf-8?B?bFpQSlR0QThzV3hIaGFzTE5FaGxpOHg0ZDJHa2lOWUNlMEtsakFEUmVGSitm?=
 =?utf-8?B?MGY2dHJ4TGRGRjZHQ2NOSXN6OThTV3liNjRZcXcveG9PYXk0VE9KNG1rTk5u?=
 =?utf-8?B?RFBIU3A2ZEpxcE1Rcm1ORVQ1NWlBdTlPSE1HdFQ3L0gzWG5rajJxUVZoamFy?=
 =?utf-8?B?UkpWZUIxeG9oZlg1OTEvZUV6Nmg2SXIySEhoT09wM0k3cDVRRitQaDZwUVBo?=
 =?utf-8?B?RzlNRndob3lwRFZ3dktqemhyNTRidWtaUnN4cmxaanJMa3BnQjF0M2JTQzNW?=
 =?utf-8?B?MTNXVjRSR1UrOUZWajJBNHpWRE5KeGZYeGFWZkhsa1I3WVNnRm9nbnRqZGMz?=
 =?utf-8?B?eUVGWVJ0VDRsUFdYM3FGeUhNMXZvYVVIbXhvdVRHTmo0Ty8xR3lkcGhTbXVp?=
 =?utf-8?B?a0hJM0xWM29OUXZ3Mm5CM1hjRUpuaUYzd1ljc0pPSloyVUdwNlN1cC94VFVk?=
 =?utf-8?B?UVR3SE1rdTlIMTlJVXdaUW41eTlvR3ljUUk0d2t6eU00RXBoV1ltZ0hpY2w2?=
 =?utf-8?B?VzRIVGJNRHc3QjcrQis5SjJaWm1xczRLUWpqQW5qeFZvb3Q3OVFDME1ZV081?=
 =?utf-8?B?WUpXSUIvN3hpWklxYWtKS040VUF2WER2Q0NZZWZUdTZsWEo4WVYvalNGd2FP?=
 =?utf-8?B?MVZGUHFIdVcwTU1xYjRzVzFzZy9mL0dXNDNZWi9PS1BuenNtTnVOWkg1Ynpk?=
 =?utf-8?B?UERWS0RRbmRZV1ZuVUxDUVpIellDTE95SUtra2E3ZmZPTEhiOWVVSndEaG1t?=
 =?utf-8?B?aTk2WHZGbWNJREc2NVhzVFZSOU5vbjMvL1lxbjlQKzkzNk9CeDFHZW5kajVC?=
 =?utf-8?B?SjFwd0FsQ1dWV0FxZE4yUHZPNGY3a2UvUC9VYlZMWUJJUTVnUU14K0U5R21N?=
 =?utf-8?B?TlJQOEtqWnhEQTVRYlkzWmpqUVJRUlplUUhYQklqakl2QjV4QVE5cnpMckZI?=
 =?utf-8?B?ejV1bk8rUytnVE9rRDhrVENvbVNLaTdma21XQVhEYnRmU3kxUjduaWhFU3RQ?=
 =?utf-8?B?ZzV1T2pIRlNkM1pRSW1Rcnc3cWMwUnk1N2NnZmVkSkhjTEtYcEJlWmtPcFFM?=
 =?utf-8?B?dDRra2JZbTZEelVtaktjQkxrNi91Z1pFSU5aWnJET2tSSGczYkFnWGEyQVAz?=
 =?utf-8?B?Y0lUaXNvb0ttZndIaXYxdDdOM1J2L2hSaldVSzAyRmdYTnZsTDQ2NUNOVFRw?=
 =?utf-8?B?ZERTSzZhTTEwTEZONVgyWGpQYWNNdHZCaG9XcmllNUowMXd3UkhnSUhIQ0Fq?=
 =?utf-8?B?aXEwRmFnV3FodWZMbUxGcGFRQnNHWlBUUjMwdXNtYUlpVk9TZ0FMN29sK3ND?=
 =?utf-8?B?WDcwNEtYWHIvczdZZ3BuaVJTMm9HQURyU2VaZ2ZCeVFFMnJSSm11dGpVeTN0?=
 =?utf-8?Q?w3N8c9EJEami9JN9GrXuWZ9XU=3D?=
X-Microsoft-Antispam-Message-Info: DfIFwuMMkxUHmfFpGSRjs3jjd5oIpGJAxDedd/uNoLT8RVSWMW2HQeLdk7x18XJBhEdtfrSdfyHzR533cJXXze1QFF7dKqOjZCIQ9+ECFL44K5gfzlbuYeSZJLzikI3QtHL0GZTWgwFFssg0MzWdGF76F8yeaMYW62h5F7dX4YizzQc7LKPdt5CTYQxinpC1
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:AH5UqcX9leHKQW9VyccFRIoKUtti72Jg/ylGgEWOciM2rgYqXxlrL9535ILK9gQMMtDh1Me9eRXAozcNUgxjrhud6gMmyf0HOalI3l5naE4CB6x8GZDldHrWMp7B1H0XuW8m9714iKSuTTucIkG+FFzT+/F6tlR06q+5HUAGQCy+WPuHK7lF9prYhFIJRWRnIAr4VWN7uSYEf24MVBAWOD0ZwVKN1SsJ2oZGjxOBMzIX/z/meIsYHMf+bwxwM1Xvi32X+qL8hvmQr4mvH/X50X7Ket1k2bpgl+qBhkbffThywGz8c447QkyTJY6TD5zSI/Ulr3iccUlj+hItp7zA8/nK7p/64wzXvt0FWbmD6e0KlP6xDiFRevL4PWOdDEqspiK6m/nVkbhbNGAfNivhT7qyW1xsuxwnmLszgvc7J8wnysAUi4aOaxIBnVWgLv1YbH0R9LQZRAw8Tv7lVsUpMQ==;5:KA6+HzefQPMUfgCuoS7KXTW68rWHVmyvFYwHXeHgzl3G3Shk7TFMmSSpcLel33/WWXBby1R/3Ql2R4dCO6pSSkgTbI0ItdsltMOPr+kRMtQ3u7p6G2Tzw+KALfAQOQBNocipFPG0KvvFI69BUqqRaqChFbKg1dxhuLwHlZsfyaU=;24:5EDoV3gSgXX343fEDCeOXef+C/e0/Bzs2pJMpqrgs6t8sYGc4TkqeLT9gmCyanZNO0K+tQE3j840dRq2eYJk38SzBKXDh8vn9u11ZPhv61g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;7:KDtPkyUcE+q2UQcjtELj5RKrup4aqmoFQGmtulu4izwcFda/QwkPBxaGVif+h+/DE9yn7wL3hOqP2Lndu9QOi84exwh5EFBEal/XnhXMthqDYthi6kOE8sVLjr1XNt9RrGdcIlAHYk9Us+VXmRxnJrGBcoq28pXHQgRV/veGGaNaLA+WjtcuFIzWx2PMKkmur6rBRsV9VlT5dbGHEKCinHtXxjH64PQ+z/Jbd3CTsRjxpdRrjDImzf4bs8/bxud7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:59:44.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92076634-f19b-4d5e-d56b-08d590c6557a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595737205654181249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-23 14:14, Jonathan Cameron wrote:
> On Mon, 19 Mar 2018 18:02:43 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> This moves the iio-mux driver to a new category, since I think
>> it will be the single driver in that category forever, and now
>> I'm adding a new driver that is somewhat similar in nature...
>>
>> But that rename is not very interesting, it's just reshuffling.
>> It's the new driver that I need. Specifically, I need to allow
>> linear scaling and modification of the type of an io-channel.
>> I don't know exactly how that is accomplished in the best way,
>> but this is what I came up with.
>>
>> The use cases are an ADC hooked up to measure a "big" voltage by
>> looking at the midpoint of a voltage divider, and an ADC used
>> to measure the current by looking at the voltage over a resistor.
>>
>> Comments?
> It is pretty much how I would have implemented it as well.
> 
> Will probably do a detailed review over the weekend.
> Not convinced entirely on the 'wrapper' naming though.
> Will think about it...

Yeah, let's put 'Wrapper' in the crapper. Not married to it.

Miscellaneous?

So, not super-happy about that either. And maybe leave the mux
where it is? It's just that I have the feeling that the iio-mux
is never going to get any friends in its category, and the mux
and the unit-converter are kind of related in that they operate
on other channels. But maybe that's only logical it you know how
they are implemented...

Cheers,
Peter

> 
> Jonathan
> 
>>
>> Cheers,
>> Peter
>>
>> Peter Rosin (3):
>>   iio: rename the multiplexer category to wrapper
>>   dt-bindings: iio: wrapper: add io-channel-unit-converter
>>   iio: wrapper: unit-converter: new driver
>>
>>  .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
>>  .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
>>  MAINTAINERS                                        |  11 +-
>>  drivers/iio/Kconfig                                |   2 +-
>>  drivers/iio/Makefile                               |   2 +-
>>  drivers/iio/multiplexer/Makefile                   |   6 -
>>  drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
>>  drivers/iio/wrapper/Makefile                       |   7 +
>>  drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
>>  drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
>>  10 files changed, 381 insertions(+), 12 deletions(-)
>>  rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
>>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>  delete mode 100644 drivers/iio/multiplexer/Makefile
>>  rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
>>  create mode 100644 drivers/iio/wrapper/Makefile
>>  rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
>>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
>>
> 
