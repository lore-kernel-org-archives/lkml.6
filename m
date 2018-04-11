Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeDKJhY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:37:24 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:64416
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751797AbeDKJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:37:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
To: Ken Chen <chen.kenyy@inventec.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5053d0d0-e4c5-733e-051d-b5900d05ea2b@axentia.se>
Date: Wed, 11 Apr 2018 11:37:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180320093200.19179-1-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:50::35) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:WU8eT7oqosiVCxNPE0VisLDW4QtYvmX2ebkh1/UP277y74h6tObbbD+hSvWxjRBYLkJm2cM7aQC7Qwfdh5KdPvv1B2iRE0tTf0b51nIr5kCs0jS7NJ2wMELnBz+eQsq2tNhHnUJNZeaeSZGp66uC4b3Lfo6bLLcShMAuFzeKD0YZQIcQdu7mEhjxl6hX574o6VAHm5pWeDOHw852FcLciQLsR1gwqfqNVLgj+W6Nkl+hsjDtYOdnp/9Xh6CeQGtR;25:ZnHsbDYfqzjypiAe64mGj96nnDcjvhd9ErDEHax59Rvyto7v3arX7/X+HxMwElZr6oKsXiNzKuJ2n6oIJX61DCvuG2hVPpNzBmGfjI04eetsQcbOdTnEeQEC5x4RyudqamYRgWQ4aBHatLQwHu+remPJNWgBspSugWemYZIuzKt9weMCRgvnK/pnoUktSuhQzBnZ7VrWbmyqkKO77RQzHlM+bs/8VbA3BaxYgKdRvwvABjkKKFeq9sd2jSt0l18Az/nhEaYfdNmwt7l3r8ygSayxDzIJLjPNECtP5Mc0ToaAKgFxavLkvTIVkmLd/U7kaZJXgBIasAHquKalPq52/w==;31:wcHqIfw3rMSEDm+KJwld1XsVMAXr98nl4uxhM4sGYuvPhXtYRrO4WB2apE/YKSV7u7Gzhr7bzofzD9+rK8PtVj3x/uKF1CLRPJFskUebhrt4MF4oFPVu27QRXvs4t9NwOsSWAZXRxoD0BzqOeYXBpJB07seeejZOnZ+/OdPyErFVLaRTyJ8AqfK5WhW5+JFE5AZDqUu0qAOl0ewal3t+zcF1bEl0ENj/8iseNUZNuEY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27729C908DB8901FC6654545BCBD0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(139265435329489);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:wFEqXVSGLQQSnUpV0yPqAjMT+fQLrPtvydO1RBQ2/yiWVU8mr0mM26EFLOKyedq9Nb/3irc41YS4IrwM8m1K9KuU+iCe1+eAMXATjgozhPjkgQlOX+S7E0EjBVp2T48heok+MSjNEopOxiiVmVPmVj8nBnESP10iUPB8ef4B9Pab4m60IyiG2TmbUwq/PQD4nJK4SUQyjSjdBg4Or0Rm9tIsOOz+F91iKlwCU3grKedg0p5BYPW+IcFuxXIn2xVSrKr8eAyv0EdDhk5DXzUM3AUhqHfIE/9fsMpSUTaS2Q/Ogt1DJuS2tjC4henJd72wsUrA2h8N6NaSomf8//Go6CStZMekQ+CdOpM6TCmfq/c=
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(346002)(376002)(39380400002)(366004)(199004)(189003)(377424004)(52314003)(65826007)(106356001)(64126003)(316002)(956004)(6246003)(53936002)(5660300001)(2616005)(11346002)(486006)(58126008)(446003)(16576012)(305945005)(86362001)(31696002)(54906003)(7736002)(97736004)(6486002)(36756003)(50466002)(77096007)(186003)(16526019)(229853002)(52116002)(3846002)(6116002)(68736007)(478600001)(551934003)(36916002)(23676004)(2486003)(2906002)(31686004)(4326008)(105586002)(6666003)(8936002)(47776003)(76176011)(65956001)(117156002)(8676002)(52146003)(230700001)(25786009)(26005)(66066001)(59450400001)(74482002)(81156014)(6916009)(386003)(53546011)(81166006)(3260700006)(476003)(65806001)(13158425004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6cm5kbVNnTGpKRlFyMFB5WFpDTlFobUR6?=
 =?utf-8?B?T3hia2drU2svb1duUHpyeUpIcDRoVG43dDRjWlRmMXJyWW9jN3BUckdzOUEw?=
 =?utf-8?B?VW5nWnU3WGpOVE40cXpEZ2lEc05rYlk0Sm5Mb3FpQ3BGYUdKeHRGWmlYLzB3?=
 =?utf-8?B?Z3VoVW5RUTNDakxTaktPUjRWZ0c2SFQ0M0pnc041VXRqMDBqTC9lNUpSb1Nk?=
 =?utf-8?B?K090N0RIcU4yRWJ5dTN5UHdIT0x0ajJlM1hBZzkrMk5RNXZxWFBwZEloSXN3?=
 =?utf-8?B?c29STDJoQm0yNDlJZlZHQTQyeUUxbi9CcjBjdStSWE05US82d2FxTDNSV2pG?=
 =?utf-8?B?SmJqU2kxV0xlWWZFWjNmNGw5NGJpNGZVUzJVSUFHSXdEVU10ZGFHa2Y2dFc5?=
 =?utf-8?B?VEtWZ3pLU0lHV1JuaE90WE02NnZYck12dW9oajRSUzk3Y0JKOFlWM2sxLy9L?=
 =?utf-8?B?R2dyREEySlhmQXV5ekl5cW8xZGRsS2ZVY1ZDWlYyOCs0YldhaFcyeFFMY0xC?=
 =?utf-8?B?TktaZTBpZGUrTXZtbGJyZTdiTG1CeDZISmYvTkdqODc3V2ltUmxOT2lrbUx2?=
 =?utf-8?B?NFV2WmZob3gxdlZnQUdyc3BXb01OcTdLTUtNWStCK3JCYVlQb1owbmZ4d2ZO?=
 =?utf-8?B?NVFIQ1UxcGVUZDJzdWgvYnl5YVFuaXY4M1haRHQ1SG1YYXdNeXpXVFo0Y3Bu?=
 =?utf-8?B?Y2NYR3BCbm9hVHBFK0NQRXZBckNiZjdQL3d5WUxjWC9odk5YenhVek83YTBq?=
 =?utf-8?B?L0lETVhzOGRQTmJpUERWUnJVN1p1V29PR0Y4L0tINEE1emUzdkZtc2U3UWw5?=
 =?utf-8?B?amdidkdpNDJCZ3FrNXh3QjZjUkVNUVNsbHVEaTY2Q0xueTg4N2VCengwdXg5?=
 =?utf-8?B?eXhtaXI2SVQ0a3pmMTdDL1BVV0QwQzNEbHhlVkRCemNmdnY3dCtrQUJiMXg2?=
 =?utf-8?B?Sk9ZM0NxUGNaT0VDYkZJM1p4RWozTEtIS0dWcXRlZStUQ0N2c2REajlQT0tv?=
 =?utf-8?B?VURFbmNkL2tvZC9YQi9FRHRBem5TTWxRT1lNM3RZQ01ENGtubExVY0RrNERX?=
 =?utf-8?B?Y2ppMVlFaVhIb2pHZTJTZjY0Yjk5NEVBcFJFWnNsWkFPYjBDTGgwTFR2cmkv?=
 =?utf-8?B?MHU0VWJuWVU3RjlVVTFudUpvRmdTUVJIT2FnbDFIM2VFUU9wTlRIc1NiR0E5?=
 =?utf-8?B?dERTOTE3Q3U2bjZRQ0VLdStvNW5GS2l3KzFUL081ZHhndDhCdUh3QjZIWm9m?=
 =?utf-8?B?RThpejVjSkc3UGVRZ0RWM2tkc1Z6b05ndW5Ic1lVSFNnZDZWeVVhTUx3Um1w?=
 =?utf-8?B?eEFjTjhxRXNEN0VQZXRzeEEwaVozeUxVOGFBZ1J6OHpWRXJ2dCtmeWlmTGs4?=
 =?utf-8?B?aGZmYjlXazV4a1p5OU1zUnpnT2NqK3N6ZXFubWZ3SkpZeHIxMUhZcUFZTjB3?=
 =?utf-8?B?QjNWVnY0OWsvQkY1MUN0MVRCNGxSekpyaDhjVllFNWNWaldCYjZvZTlzaVBi?=
 =?utf-8?B?Z05aSmM1ZjhsZlgvNmQyTU5nZDNmUjhnZTV4RzN5RkNsaEh5NWRpbTVGc0NW?=
 =?utf-8?B?cjRiOCtZK2NncUxvUm8ycENBUEFvV2dFK2dWK1orRVV2aU56ZS90SkpoYnoy?=
 =?utf-8?B?NE5YTTVJemJ0eDVTOStGQUUvdS9pNVBIcFNqTGl4UVYwMGxKUmRRTk1XWlNL?=
 =?utf-8?B?UjJOY0o2NTErTUlqTFQwbmhXZGl2NVp1aXZmOWZkUk1SYU9lMUlCQTZRYmhS?=
 =?utf-8?B?R2c1TFJHeU1GNDdqR08yUVZlOFBDZ25QSERtczgwY1QxQXhUNVlreW1qb0RZ?=
 =?utf-8?B?anlBWEpiZEZUWmNZTGV6SXo4MnlHbkZod0d1T2VFcE54dGFNemlkZEUvYng2?=
 =?utf-8?B?Mi9QNWxzWFppWVRYT0Vzdk1rb2l0aG55MXVhMGs3MTF6ek5tb1ZWdEFpSWZm?=
 =?utf-8?B?ZE5XWUZHclFBbHVNMWphWlpxZ24vZ29LNHM1VmFvYTdPY1BBUTlDVHNXenRW?=
 =?utf-8?B?MmU4ckMwSlN1T2pFaW85cUhWQU9HTFd4dTc0ZEpyRWhxU21xZllvQVZPVFFh?=
 =?utf-8?B?RnZoUVB5bGRCUDAzbUgrYTU5M2tuRzVYM2RHRExmK0NGQXdjTjY4ak5qMkdS?=
 =?utf-8?B?cFZyZEF6d0EzZmRNbm9EVWlIQUtCWnk1ZDJmdGh4OXl2TzFaNXNxWXp3VSts?=
 =?utf-8?B?MWZJeXRBTmxaRFlWdVpxM21mc1B3aXlYNm4vaFFhMTd2SktMbTZDNTVackl2?=
 =?utf-8?B?RDIzS0cwbWV0cmdOMEwwRVNabHJpWUFTTHViaE1TSW5PVGdnZytoL2dBPT0=?=
X-Microsoft-Antispam-Message-Info: kJs/XoH37zk3l2O3mA2Qn8eXRQSf7ZVAkhzpzicvW1j7UrXKTvXRLeNjpDtYmuacRmUrYpvrYOFtJkqoK4W/ildGECaGURAJKfJeb11/U1LOmnimdbU001Co1UB8pX/R2FSVvDGjZO40AD4NB/Mtvwr4NX6dJQuseM4eaWhQV1p9sDUtrPgiieu3Ke7wb/Uc
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:PtK3tl4ud7VuDgT0M+w77Z/F8n+k8BnL9xkQlEsF2jQ/dRoTpyp5RNMeUJghvNcUGNZlrV/mof5CfcagTJ+bEyIFWHgLWNiy0cL2ivI0GN0XN3CrEOIciXkxZh19Fe5OLzD7odMhfqK6S490nBR0F8yt0I9K1g5phvfcocVTLkjlGkka3Igagxzsd8t2Qqao3aiDQ3LCUCbmsaWDV3O9ZEXZ12qKGfj3ahNkhsi4pj/N0LS5qo0a3jaaTz+4l3q5v1YcVh2Wi17d652d8tUvCzUvcKt6oXfCsrKyRIJeBfuTgq2wA6gt2yUJOffeb0+idB6NxieU/f7buIZcEIWl5QaXOJ6W79rcI2tMyhAw+7s0NcMocVKJz7LQY+C6/ny3oS8MoUtScBF+Sjw+YCG2u0VW8KP9HZm1T+RHDMhkj2+wk+z/6lS3bDIVsNOMR32ze7PjJHgOpdzmDlooM2DQcA==;5:zgFfqkzUMtVFIEYSAAnR6DosS+w4F/V2ogTlLhVDC528kkgePTzP3FylZRV2H9GQHbma/M/9CmXjocPYv4l/gHBHxlj+loKNVp4LG1wePBxZLi1w9pL1a4IfQ3gNmtOzBSmFIBsonCamHFCJTKOLujfQ4hlyRhwJ8eLcyj7HC0M=;24:I51AVppZD7w8HmIiDfNrPcZ3xZaQT29Qylmv6RW5u2OBlg6KWOCQw1nV08GD0TNqavnV6z2AGQNOPDn19X5ht3KITOuOtCBDlUqPyZ/76Zo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:5khJ2hpxdzVIUlCqj4cJOVtMA60E9U3vg4biOvc5qYpnXi7TZwIEXn4YFoiTxBo8ZFcoyqO72ko/xAmzoZ3ceKi6IoXp9FnL1RzsXJpFoMqQ6Y2Beb9rGWq5sfSjRkrJ2vf6oC6RmKA1prP7LUONRccSMIIfWMMPl5NUrQRoc7ccJZQG0D11dJzG/dXWvjAxQG7N9u4W4VyaQ5FVz4r9qGp2Ij5q15KYU1ENtl8hG1hiKfNfzENqt9xj6Ggj31iA
X-MS-Office365-Filtering-Correlation-Id: c83abbcc-9993-4210-319d-08d59f8fd0f7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 09:37:17.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c83abbcc-9993-4210-319d-08d59f8fd0f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

It's been a couple of weeks and I wondered if you are making any
progress? Simple lack of time perhaps, or are you stuck and need
help?

Cheers,
Peter

On 2018-03-20 10:31, Peter Rosin wrote:
> On 2018-03-20 07:19, Ken Chen wrote:
>> Signed-off-by: Ken Chen <chen.kenyy@inventec.com>
> 
> Ok, now that you are not adding a new driver, but instead
> modify an existing driver, the subject I requested in no
> longer relevant. Now I would like to see:
> 
> i2c: mux: pca9541: add support for PCA9641 chips
> 
> Or something like that.
> 
>> ---
>> v1->v2
>> - Merged PCA9641 code into i2c-mux-pca9541.c
>> - Modified title
>> - Add PCA9641 detect function
>> ---
>>  drivers/i2c/muxes/i2c-mux-pca9541.c | 184 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 174 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> index 6a39ada..493f947 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * I2C multiplexer driver for PCA9541 bus master selector
>> + * I2C multiplexer driver for PCA9541/PCA9641 bus master selector
>>   *
>>   * Copyright (c) 2010 Ericsson AB.
>>   *
>> @@ -26,8 +26,8 @@
>>  #include <linux/slab.h>
>>  
>>  /*
>> - * The PCA9541 is a bus master selector. It supports two I2C masters connected
>> - * to a single slave bus.
>> + * The PCA9541/PCA9641 is a bus master selector. It supports two I2C masters 
> 
> PCA9541 and PCA9641 are bus master selectors. They support two I2C masters
> 
> And make sure to lose the trailing space.
> 
>> + * connected to a single slave bus.
>>   *
>>   * Before each bus transaction, a master has to acquire bus ownership. After the
>>   * transaction is complete, bus ownership has to be released. This fits well
>> @@ -58,11 +58,43 @@
>>  #define PCA9541_ISTAT_MYTEST	(1 << 6)
>>  #define PCA9541_ISTAT_NMYTEST	(1 << 7)
>>  
>> +#define PCA9641_ID		0x00
>> +#define PCA9641_ID_MAGIC	0x38
>> +
>> +#define PCA9641_CONTROL		0x01
>> +#define PCA9641_STATUS		0x02
>> +#define PCA9641_TIME		0x03
>> +
>> +#define PCA9641_CTL_LOCK_REQ		BIT(0)
>> +#define PCA9641_CTL_LOCK_GRANT		BIT(1)
>> +#define PCA9641_CTL_BUS_CONNECT		BIT(2)
>> +#define PCA9641_CTL_BUS_INIT		BIT(3)
>> +#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
>> +#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
>> +#define PCA9641_CTL_SMBUS_DIS		BIT(6)
>> +#define PCA9641_CTL_PRIORITY		BIT(7)
>> +
>> +#define PCA9641_STS_OTHER_LOCK		BIT(0)
>> +#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
>> +#define PCA9641_STS_BUS_HUNG		BIT(2)
>> +#define PCA9641_STS_MBOX_EMPTY		BIT(3)
>> +#define PCA9641_STS_MBOX_FULL		BIT(4)
>> +#define PCA9641_STS_TEST_INT		BIT(5)
>> +#define PCA9641_STS_SCL_IO		BIT(6)
>> +#define PCA9641_STS_SDA_IO		BIT(7)
>> +
>> +#define PCA9641_RES_TIME	0x03
>> +
>>  #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>>  #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>>  #define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>>  #define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
>>  
>> +#define BUSOFF(x, y)	(!((x) & PCA9641_CTL_LOCK_GRANT) && \
>> +			!((y) & PCA9641_STS_OTHER_LOCK))
>> +#define other_lock(x)	((x) & PCA9641_STS_OTHER_LOCK)
>> +#define lock_grant(x)	((x) & PCA9641_CTL_LOCK_GRANT)
> These macro names are now completely hideous. They were bad before,
> but this is just too much for me. So, instead of adding BUSOFF etc,
> I would like to see all the macros with a chip prefix. But I think
> they will get overly long, so I think you should just write trivial
> pca9541_mybus, pca9541_busoff, pca9641_busoff etc functions. The
> compiler should inline them just fine.
> 
> The rename of the existing macros and their conversion to functions
> should be in the first preparatory patch that I mention below. The
> new functions should be in the second patch.
> 
>> +
>>  /* arbitration timeouts, in jiffies */
>>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
>>  #define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
>> @@ -79,6 +111,7 @@ struct pca9541 {
>>  
>>  static const struct i2c_device_id pca9541_id[] = {
>>  	{"pca9541", 0},
>> +	{"pca9641", 1},
> 
> You are actually not using this 0/1 difference. Have a look at
> e.g. how the i2c-mux-pca954x driver uses this as an index into
> a chip description array. I would like to see something similar
> here...
> 
>>  	{}
>>  };
>>  
>> @@ -87,6 +120,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id pca9541_of_match[] = {
>>  	{ .compatible = "nxp,pca9541" },
>> +	{ .compatible = "nxp,pca9641" },
> 
> ...including pointers to the above chip descriptions here, just
> like the pca954x driver.
> 
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
>> @@ -328,6 +362,125 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>>  }
>>  
>>  /*
>> + * Arbitration management functions
>> + */
>> +static void pca9641_release_bus(struct i2c_client *client)
>> +{
>> +	pca9541_reg_write(client, PCA9641_CONTROL, 0);
>> +}
>> +
>> +/*
>> + * Channel arbitration
>> + *
>> + * Return values:
>> + *  <0: error
>> + *  0 : bus not acquired
>> + *  1 : bus acquired
>> + */
>> +static int pca9641_arbitrate(struct i2c_client *client)
>> +{
>> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>> +	struct pca9541 *data = i2c_mux_priv(muxc);
>> +	int reg_ctl, reg_sts;
>> +
>> +	reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
>> +	if (reg_ctl < 0)
>> +		return reg_ctl;
>> +	reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
>> +
>> +	if (BUSOFF(reg_ctl, reg_sts)) {
>> +		/*
>> +		 * Bus is off. Request ownership or turn it on unless
>> +		 * other master requested ownership.
>> +		 */
>> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
>> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>> +		reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
>> +
>> +		if (lock_grant(reg_ctl)) {
>> +			/*
>> +			 * Other master did not request ownership,
>> +			 * or arbitration timeout expired. Take the bus.
>> +			 */
>> +			reg_ctl |= PCA9641_CTL_BUS_CONNECT
>> +					| PCA9641_CTL_LOCK_REQ;
>> +			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>> +			data->select_timeout = SELECT_DELAY_SHORT;
>> +
>> +			return 1;
>> +		} else {
>> +			/*
>> +			 * Other master requested ownership.
>> +			 * Set extra long timeout to give it time to acquire it.
>> +			 */
>> +			data->select_timeout = SELECT_DELAY_LONG * 2;
>> +		}
>> +	} else if (lock_grant(reg_ctl)) {
>> +		/*
>> +		 * Bus is on, and we own it. We are done with acquisition.
>> +		 */
>> +		reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
>> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>> +
>> +		return 1;
>> +	} else if (other_lock(reg_sts)) {
>> +		/*
>> +		 * Other master owns the bus.
>> +		 * If arbitration timeout has expired, force ownership.
>> +		 * Otherwise request it.
>> +		 */
>> +		data->select_timeout = SELECT_DELAY_LONG;
>> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
>> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct pca9541 *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +	int ret;
>> +	unsigned long timeout = jiffies + ARB2_TIMEOUT;
>> +		/* give up after this time */
>> +
>> +	data->arb_timeout = jiffies + ARB_TIMEOUT;
>> +		/* force bus ownership after this time */
>> +
>> +	do {
>> +		ret = pca9641_arbitrate(client);
>> +		if (ret)
>> +			return ret < 0 ? ret : 0;
>> +
>> +		if (data->select_timeout == SELECT_DELAY_SHORT)
>> +			udelay(data->select_timeout);
>> +		else
>> +			msleep(data->select_timeout / 1000);
>> +	} while (time_is_after_eq_jiffies(timeout));
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
>> +{
>> +	struct pca9541 *data = i2c_mux_priv(muxc);
>> +	struct i2c_client *client = data->client;
>> +
>> +	pca9641_release_bus(client);
>> +	return 0;
>> +}
> 
> The pca9641_select_chan and pca9641_release_chan functions are exact
> copies of the pca9541 counterparts, with the exception of which
> functions they ultimately call. So, instead of using different
> function pointers in the i2c_mux_alloc calls below, add a couple of
> function pointers to the above mentioned chip description struct.
> 
> Then change pca9541_release_chan to something like this:
> 
> static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
> {
> 	struct pca9541 *data = i2c_mux_priv(muxc);
> 	struct i2c_client *client = data->client;
> 
> 	data->chip->release_bus(client);
> 	return 0;
> }
> 
> Similarly for the *_select_chan "wrapper".
> 
> Now, these changes will somewhat affect the pca9541 side of the
> driver, so I would like to see more than one patch. There should be
> patches that prepares the driver that should be kind of easy to
> verify that they are equivalent but that makes adding a new chip
> easier, and then one patch at then end that adds the new chip. Hmm,
> it will probably be easier if I write those patches instead of
> reviewing them. I will followup with them. But note that I can
> only compile test them, so I would like to see tags for them.
> 
>> +
>> +static int pca9641_detect_id(struct i2c_client *client)
>> +{
>> +	int reg;
>> +
>> +	reg = pca9541_reg_read(client, PCA9641_ID);
>> +	if (reg == PCA9641_ID_MAGIC)
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
> 
> This was not what I had in mind. If you do dig out the id, I think
> you should only use it to verify that the input to the probe function
> is correct and error out otherwise. But maybe I'm conservative?
> Anyway, with the above patches you will not need this.
> 
>> +/*
>>   * I2C init/probing/exit functions
>>   */
>>  static int pca9541_probe(struct i2c_client *client,
>> @@ -339,34 +492,45 @@ static int pca9541_probe(struct i2c_client *client,
>>  	struct pca9541 *data;
>>  	int force;
>>  	int ret;
>> +	int detect_id;
>>  
>>  	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
>>  		return -ENODEV;
>>  
>> +	detect_id = pca9641_detect_id(client);
>>  	/*
>>  	 * I2C accesses are unprotected here.
>>  	 * We have to lock the adapter before releasing the bus.
>>  	 */
>> -	i2c_lock_adapter(adap);
>> -	pca9541_release_bus(client);
>> -	i2c_unlock_adapter(adap);
>> -
>> +	if (detect_id == 0) {
>> +		i2c_lock_adapter(adap);
>> +		pca9541_release_bus(client);
>> +		i2c_unlock_adapter(adap);
>> +	} else {
>> +		i2c_lock_adapter(adap);
>> +		pca9641_release_bus(client);
>> +		i2c_unlock_adapter(adap);
>> +	}
>>  	/* Create mux adapter */
>>  
>>  	force = 0;
>>  	if (pdata)
>>  		force = pdata->modes[0].adap_id;
>> -	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>> +	if (detect_id == 0) {
>> +		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>>  			     I2C_MUX_ARBITRATOR,
>>  			     pca9541_select_chan, pca9541_release_chan);
>> +	} else {
>> +		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>> +			     I2C_MUX_ARBITRATOR,
>> +			     pca9641_select_chan, pca9641_release_chan);
>> +	}
>>  	if (!muxc)
>>  		return -ENOMEM;
>>  
>>  	data = i2c_mux_priv(muxc);
>>  	data->client = client;
>> -
>>  	i2c_set_clientdata(client, muxc);
>> -
> 
> Please don't do spurious whitespace changes like this as part of a
> functional change.
> 
>>  	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
>>  	if (ret)
>>  		return ret;
>>
> 
> You should change the Kconfig file to mention the new chip and you are
> still missing a devicetree binding.
> 
> Cheers,
> Peter
> 
