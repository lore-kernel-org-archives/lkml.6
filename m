Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCDVsK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 16:48:10 -0500
Received: from mail-he1eur01on0109.outbound.protection.outlook.com ([104.47.0.109]:17632
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeCDVsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 16:48:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: add i2c_get_device_id() to get the standard
 i2c device id
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-2-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <29c55bcc-8d14-dcff-d407-33cfb402af8a@axentia.se>
Date: Sun, 4 Mar 2018 22:47:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180122113657.32094-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb3be46-a8a5-48f4-d4c1-08d582199b75
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:nvinwvhERQPWlfg3IfUXKMZNH4/E345wpOZ0PftlqkNvzumvvTQqzObn6cW7Xq1gx4I2kWn//tn8CGMwfY7XfIKCjB7JU8PpEgKZ9+HyCeL7HUc411w1g23T9u1l8idP9HqQBbUJhqhj7ahDFlhGg9uVWHfNBfE8d3UwK2NPnamaIWBBV9MBy8H+pwgqBXf80U83SqB6Dt7/JA4O6I/H5aBBhKjC14hFAbNukEWmHVdP2TewukcOE5rncpQxmRLg;25:V3c1KGgI/aq8u5694M83lVBHNynWCny7RXf2lVfU89x1o3MrhW9JveVY4nqWdbznoM/dLXb63+A92obO2hACLzhDq+F2V7XRrxTXfcc88f9Ak8/icCNaph6+Rtuf7BLZoJdc3g8FtzM+Jc+y05/xb6zit/6cZKzhwJCC2dwUq/DN+0U6rQtJSd2Zn7+T7rRUEh/EHWllVjRDKBlg3HqqAY2B4/2HB6r8F+en+Kt4W/2tXjyfI84+m4FvZSJYo/LD/A7kXopNPqjnswouESy8A+9W40icVPXv1Bzri2AkiYJQyyTez+lN/KhhTC1hkQDS3v1Tf+RWCkNMvNWqfrOHIA==;31:VdKJqoLgokQqMS8VJFiXsCU2FzSpdyBBay5vHeOmiLp1w9LjnEyQxOsA5CWYKbvslNuCc+nuylq5eONzIKwBfhW6jo+uyG6w1dHs4M/hmEiOYxHfGglbEW1KXTksnSnDahB2pl/KMg36btpvSK92QixJHYdPAvO6GOXnS9VneZ+rahSMx5rfcYofw1wDBWppzIlvnlUplYqivvPa2dScChKl0i/RfGWqIFDizGqnOP4=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;20:RCBMBytXHzHlafnTgvRR8kBDLo9si6THQIT8ucPRrUVdCVxWwm8kjcJNYKYT2eyGp6wgBN6nJsAhn4C5QXDRPb5ko5/GqrSiixNafYcAw+r4okHg4fKYYsMlpTNL4Sz486eOFAdCykEHWcApctLI3Xm1JvTtC/m5s/X1CAlP9Jk=;4:eImr+DxIORluoMEpzjStGfJ6YnSU8qUVFPf9y/wktGZk5w6E8Nt7lFsspmrZJV3aDP4YJ/UHR6W6WcVKqjc5Bgu6w2/TwySzl8U4B4Jvbbr7E2AV4z8On34vMvbibijlR/VAZOjdl+1fwbVLe0EIxezPDf+DXDYRwGHctnXzYEDE5JKwPyLW/AJ8JZjwjuC1GCLA1NUziwAvlduzJL8UoNVMTLak4DD8y/Ezzn3I0P+VJ8jJHVY/QbYsdBQjPVkijodZbnfUkUwCmU/njnDvCg==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779F60387DE908355EF184EBCDB0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39830400003)(396003)(376002)(346002)(366004)(199004)(189003)(377424004)(6666003)(6916009)(2950100002)(106356001)(16526019)(2906002)(386003)(77096007)(26005)(65956001)(66066001)(65806001)(186003)(53546011)(229853002)(305945005)(7736002)(6246003)(86362001)(31686004)(65826007)(478600001)(74482002)(5890100001)(59450400001)(16576012)(47776003)(316002)(68736007)(31696002)(58126008)(50466002)(81156014)(81166006)(8676002)(76176011)(4326008)(8936002)(5660300001)(117156002)(6116002)(64126003)(97736004)(36756003)(23676004)(230700001)(2486003)(36916002)(52146003)(25786009)(3260700006)(3846002)(53936002)(52116002)(15760500003)(105586002)(6486002)(15583001)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzk7MjM6clFlMmpMaURsSWVGaEJuYkRIMzl6dkth?=
 =?utf-8?B?azJnRGQ4dUVScmdVUDRoZFFWMHlpS2E1YWtWN2h1QW93dEdRQTNKL2k3MHg4?=
 =?utf-8?B?QUxFRGo2S3orT2RubEEwK29qL2dzU1VRMXJpcGNKdm5rcUtDU3ZjYWpiOUhJ?=
 =?utf-8?B?K09acS9ER1BKRURGeHk3MnRUb0V2KzI0MzhZb25FVEEyK21CVGZad0lZQ3Nz?=
 =?utf-8?B?ekN3RiszSitPU1lQMmNpUVhjeHBpODJTN0tTSzdmbU9xUTNQYlROWFl2T3oy?=
 =?utf-8?B?OEZ6S2czRHF0M05JYkNrWThyUEt0MGMxTVNZajRsMDkzQjl0RHcrSTRQVys1?=
 =?utf-8?B?ajlzTUxvaktlZXlFTkFnelVKQVlqV2VGaGdyUldlUko1c1Z3MHBxVm5qT0hI?=
 =?utf-8?B?ODhDVmNEOGdQRXFIVG5wMGJpVVVqRVU5USsrSVhOcWhBRlhraU9zSUFyVHZu?=
 =?utf-8?B?L285VkI3RWFQWmhJVTdtekNpVUl0c1VFaWs3ZzJQcExGTVJ5eThnRnNMTUoz?=
 =?utf-8?B?RGZYNGxqRGZrV0NYVzhDVnNYdXZRdmZzNHRhZHpZUThtMVk2bkhHR0RpdU9O?=
 =?utf-8?B?eldNMFRnL3dWTk51bCs1d2YzRmxHRGl1T0ZEUGFoOHh0OTR4OWtmK2JuZ2Rn?=
 =?utf-8?B?YUxMaEQyUWI3bmRvM2dFMllMZ2dpUmZnVDNDdlhLUlkweUNWdzJYdlVRbHJo?=
 =?utf-8?B?RGtDY3owVHdFQUN1eWRQWVhOY1A1SmVETmNjVk54MWNpUVEvVHIvSUwwZVVU?=
 =?utf-8?B?NElPT2R2c0ttcGZCem1UZ3BrYVZ0N1QzNjkvaVFXWkdkdVhGT2Fqa042T3RJ?=
 =?utf-8?B?MlRxbTdnUU5FdlIwcWtQV1QyU2lhU3BtQTRlUEk1TURkWGphQmt5a25IeStp?=
 =?utf-8?B?bEpLN1dKM1lHTENDSkVMZUhVRGs5THNFOEM5cDZYWENudUlwT2hYY2V3V1VE?=
 =?utf-8?B?TXpZWjNaRU03VGJCeTNlR1U2aTdvS2hva2JFMDE5YjhDYVErMlZvOWxxWUlX?=
 =?utf-8?B?TEdhNmZ4VkdUZS9RWTRzQmtkTGlmWjk2QkI2RGNIYzE1L3R1RVo0a1oxTkd4?=
 =?utf-8?B?aE00MHlsa0p3ZGlsd0VNNDQrb3BjZDlQV1M5QndyQVlvUWU5d1djNSsvSlhX?=
 =?utf-8?B?WnNmT3c4TEdmTlhGVVpENWU3VGNVUFRYb3NXWlhnSC9NSW50aGRTcDlwZEdR?=
 =?utf-8?B?Uy8wYVY4U1NvRUNEOC82TmczcGswNlByc1B1MUNHV0ovWnN3OEZUbmNpTWRN?=
 =?utf-8?B?UGVqb1pUTkJDaVFKUXNjdVk1VU5pZGZtcS9kZ3d4VTlBQmlpNDNRa3pWOVVh?=
 =?utf-8?B?R3gzNFdYYWFxeUY2SzVMbS9vYWozUkR0clcvVXAwR0lZdTN0b2V0Y1F6eTIy?=
 =?utf-8?B?SUdzQ2hvQ2NBQUFYbG1EV0k2MGhxcTA1VVgrdVRaVXVnQ3RDT1J4bTBqUkdm?=
 =?utf-8?B?K3o1Y3B1eDF2cnlmMFFLdlZ3aW9mNFpzS0FkMktNMngrb01qM0xTREVBdGZE?=
 =?utf-8?B?Ulh4eW01RW41Y21RU253OEY4c0xnYXUzbUZnVEVDVmJWTHZobDkySm1OUXNr?=
 =?utf-8?B?dVVPdFVrNmlWdnNBUXhhRDEyYkhBdHpUYjFXVWVBY1BSdHNPejFLK0VjSlRv?=
 =?utf-8?B?bHk3anpiYnVQaVV0QWdWTGtTbnhESnNTNThxcHFrSDRORENTRUFaMC9yV2RI?=
 =?utf-8?B?endqZFFuemdEKzd4U0p6MFcxS2d2OEtrL3BxMWIzWC9ZajFTdWNIMXdMN00y?=
 =?utf-8?B?Y1duUEdYTW91UmlyYm5FYndwWC9LVUtTTDRETWhiT3l4MDVsc000LzBtT2ll?=
 =?utf-8?B?b1E3ZFY4NllVckxmRkV4T1FNbGJJWkRpZVVRSmdxT1NTemRicHhrb05ubk1s?=
 =?utf-8?B?WjZvd2t4cjR4OTQ5dWNzckI3Ti8xQ29EdDh5SEo5U0srZVh2U0FzT3RYVzdY?=
 =?utf-8?B?alluTm91RTVQSDN4T3k3VjRtZngwb1hFMmRmZnZyci94VDhLK3NHeU5oSGxP?=
 =?utf-8?B?Zi9NYkhDaldwMDdzeTQyc2ZSNmJKUklyZk5IZmMybFVmenB3QXk1alhOMzBR?=
 =?utf-8?B?UCt3UHJPWVVBUkpzS0paSGM4Si9UY1BPYXorc2tqeW5HeTJMY1lUTzVsQ1A1?=
 =?utf-8?Q?ZVXQjRVANYpizVWiomVWAq8jyhsBEA98X84UXBVncGY/5X?=
X-Microsoft-Antispam-Message-Info: Kif6e7T+Z6nUK4Z1WZleEBloTdyIb/rlaFSCqmH2+ucw+OSFLCDo8L5Sad7hu8NQCnQZKcYhBsG73wS23dZjbnsGCtwTAn27AAmeG4e86UxWomI9N7Za8PpYjc1V1Ej6YooHvKrzcEwt6+38+P1iGranqYJyNvWGGw2ETHXYkiRxS1aSTn4xBC+Dj5Cm7S6T
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:ai21/QnnSJvHE+MgUdDBr2zvj9yEaNtFXErWXhrKQfSH6hi8BY3bxT+Auez/z0883IZ3EdQh6hwM1CmHpx1BYggbJowFHBUNmmKWNogPqV+KdAYr+rgDkivnTdwYoMbaa9QpW+exuvhON2OnJ931TpFeJKwiK2Oxm6cpxtC4np2uZjDdo/J5bORRutuqn2MG6/zvIREGNzwTQ3rW7js0w7zc7w7kYPdxRT4/sx9KEkX/itjRQ7dXzyhzVtCt38oDeE1gp1ArvI5Haanqno7aUYynswIXg6B6SPIIDu/EkUp03GYW+OyipjqdvnXADNFlv4w4jmwmpmL8nZJOgh3m09Z2M4szjiRARwPo9Bqg6BI=;5:24PKOfYV75St1HVvKv2epCrejBtVSXUFXF5WUGOjV+FpBw129YXVqQtqLLsoM51pAsrLb92XIoUGmwVOttd8BMYjPGBBFSr8Q152JWqIZeOMjklH3NSIxn+OJjJIMqg7HZzJr9B5z6XLSwCjv2PN7LgETbDhHkbqAvBfdIwAILQ=;24:judskSkKcGl1Q079w51KI76KCBdokNdrkHeQ9yjCcLg1hfcQ1MprtH3GeqCPUbsPPszDXgxrCh7Lg4UtfBLj1rX784LdkTKQwvirCqXtwG4=;7:OGW2tnIRQoMo/zFG3kyUuU0+RtGD3doo2/yGhh0RaCArd8OL5w32LPrDI0EF0LoKM7QwQtzM9WTzIyKrCNTAIshHom89BsIIN4o3WxPck/t1mPZnHzYb/nUpTkMFzIrEG0sDpPY+uLaCsOwmjTNR39OJy3dU+xnXdbc/K2bPE2+QwiZXO9dTlW92JpJki+7xGYXdlDMGlF65McI9LFDtBxKeerFfGakXjcDDl7IJmcjybgca9jQKZVHWiipoeqgu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 21:48:03.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb3be46-a8a5-48f4-d4c1-08d582199b75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Did you have an opinion on this patch?

In case you like it, do you which to take it (don't forget to add a
Tested-by-tag from Adrian in that case), or should I take it and you
then get it in a pull request?

Cheers,
Peter

On 2018-01-22 12:36, Peter Rosin wrote:
> Can be used during probe to double check that the probed device is
> what is expected.
> 
> Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/i2c-core-base.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/i2c.h         | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 5a00bf443d06..f496b917529d 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -58,6 +58,8 @@
>  #define I2C_ADDR_7BITS_MAX	0x77
>  #define I2C_ADDR_7BITS_COUNT	(I2C_ADDR_7BITS_MAX + 1)
>  
> +#define I2C_ADDR_DEVICE_ID	0x7c
> +
>  /*
>   * core_lock protects i2c_adapter_idr, and guarantees that device detection,
>   * deletion of detected devices, and attach_adapter calls are serialized
> @@ -1968,6 +1970,37 @@ int i2c_transfer_buffer_flags(const struct i2c_client *client, char *buf,
>  }
>  EXPORT_SYMBOL(i2c_transfer_buffer_flags);
>  
> +/**
> + * i2c_get_device_id - get manufacturer, part id and die revision of a device
> + * @client: The device to query
> + * @id: The queried information
> + *
> + * Returns negative errno on error, zero on success.
> + */
> +int i2c_get_device_id(const struct i2c_client *client,
> +		      struct i2c_device_identity *id)
> +{
> +	struct i2c_adapter *adap = client->adapter;
> +	union i2c_smbus_data raw_id;
> +	int ret;
> +
> +	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	raw_id.block[0] = 3;
> +	ret = i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, client->flags,
> +			     I2C_SMBUS_READ, client->addr << 1,
> +			     I2C_SMBUS_I2C_BLOCK_DATA, &raw_id);
> +	if (ret)
> +		return ret;
> +
> +	id->manufacturer_id = (raw_id.block[1] << 4) | (raw_id.block[2] >> 4);
> +	id->part_id = ((raw_id.block[2] & 0xf) << 5) | (raw_id.block[3] >> 3);
> +	id->die_revision = raw_id.block[3] & 0x7;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_get_device_id);
> +
>  /* ----------------------------------------------------
>   * the i2c address scanning function
>   * Will not work for 10-bit addresses!
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 419a38e7c315..44ad14e016b5 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -47,6 +47,7 @@ struct i2c_algorithm;
>  struct i2c_adapter;
>  struct i2c_client;
>  struct i2c_driver;
> +struct i2c_device_identity;
>  union i2c_smbus_data;
>  struct i2c_board_info;
>  enum i2c_slave_event;
> @@ -186,8 +187,37 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>  extern s32
>  i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
>  					  u8 command, u8 length, u8 *values);
> +int i2c_get_device_id(const struct i2c_client *client,
> +		      struct i2c_device_identity *id);
>  #endif /* I2C */
>  
> +/**
> + * struct i2c_device_identity - i2c client device identification
> + * @manufacturer_id: 0 - 4095, database maintained by NXP
> + * @part_id: 0 - 511, according to manufacturer
> + * @die_revision: 0 - 7, according to manufacturer
> + */
> +struct i2c_device_identity {
> +	u16 manufacturer_id;
> +#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS                0
> +#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_1              1
> +#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_2              2
> +#define I2C_DEVICE_ID_NXP_SEMICONDUCTORS_3              3
> +#define I2C_DEVICE_ID_RAMTRON_INTERNATIONAL             4
> +#define I2C_DEVICE_ID_ANALOG_DEVICES                    5
> +#define I2C_DEVICE_ID_STMICROELECTRONICS                6
> +#define I2C_DEVICE_ID_ON_SEMICONDUCTOR                  7
> +#define I2C_DEVICE_ID_SPRINTEK_CORPORATION              8
> +#define I2C_DEVICE_ID_ESPROS_PHOTONICS_AG               9
> +#define I2C_DEVICE_ID_FUJITSU_SEMICONDUCTOR            10
> +#define I2C_DEVICE_ID_FLIR                             11
> +#define I2C_DEVICE_ID_O2MICRO                          12
> +#define I2C_DEVICE_ID_ATMEL                            13
> +#define I2C_DEVICE_ID_NONE                         0xffff
> +	u16 part_id;
> +	u8 die_revision;
> +};
> +
>  enum i2c_alert_protocol {
>  	I2C_PROTOCOL_SMBUS_ALERT,
>  	I2C_PROTOCOL_SMBUS_HOST_NOTIFY,
> 
