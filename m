Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031192AbeEXONj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:13:39 -0400
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:38599
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967532AbeEXONf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:13:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] i2c: opal: don't check number of messages in the
 driver
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-3-wsa@the-dreams.de>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5e42cc19-0f2a-c4e8-b545-eaede1b1d520@axentia.se>
Date: Thu, 24 May 2018 16:13:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180520065035.7920-3-wsa@the-dreams.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::34) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:zGoFpJOFQ9aKh8Y+ufCeVm+WsOMQ6idrJ2VMB/E0oEXx1V4AWelWZlAjvS9kcRd+4yxGYwX60IdHSeXtlEDcyE+fce/FovIT3ly8/grrDZ725DMFLp9mNvK6jE1eXqbWudKK18acAmvsoiUBYjY1Pb+ZgEm2eIYM9hHxBgKMIgKHoUMMtJpTQSGnU2VSwYC+fMYQa/Z/pohIBYFOg1pUmubSfnx3tocUABq7vua/uVXd5tuYi7wOm63DCYqkXzTD;25:RW2r9dqtNiPi5TeHLYGkY2mL8JQguiSi3Cx1ZBSH7btE51C2lXm5CFPGQ2qn8x84KX0UABzq/eus/6+yRqEKUX0eWAN+81bZk2Z+4FkCKOgIUyIc7Nw7TCqwUu8SzwMAOX90k0d2CnxV7RyL6B/eYd1D5bo2iYiWgL1NuHqyVHLk4otzEEWnQSp4CfC1Uj0o0KLTuK1FijIG7NFaozTLn63x0sYCDufnDlmrlBG0U7CX2dcRBwZFq+689aFmKS4ZQ/1dSzoI8LBYR+cVGlJMsWSEA2wqliBIMpy5nz5UjB/ykT6NMrBA3v245QawbstaDkSRc8oJZvECS1EVmIWrNw==;31:L4Y3ozQVEAvL8r/VqL9PmeFBpE9RA/5iroUDtAQnjVMvH4BnLtKSnaWe68rrKc6NC5G3+tS74K2y6LGZ7qkd6Kxi8xhoORI1ZjMCwQHFxOWeo7G6FuKsorGMZYweYjOK9/fdC0nzAnMS18jyf0xDBkT35qRYMHDaiMWTtoeLI8R9iFAsIzaNMEcseezS74XoCopR+e64BXZ+JyNKLfque8Y8ZNob9Bx9mj2lZTO/FS0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2783051D399433FDC732930FBC6A0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:tOlsq7S5dVhgmxC0++yP+4kt0rtvc1AGJK86MQY/vgbJ6lafD2REuoHf5tc6B4sJWn1BwBgi7oAai+BioVTHskWcXYadJZNaLfeHMOzd/IH6SrPCoo/QnbDPnomiByI0ON7IEJxqoB6hVONbXmtNr/m388hrtLciDj78HfLM5VVf1WGSIW8keTXYWuxMVZ/n6+mbd7Hd2LL2Lta8yhKP+xuVpCMgT2xSLa+ZSeGIkDAPh3NyWEVu9Oe8n3ZJhb2zv6oOO6mj5w6Ygr0zfxDbeA==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(376002)(39380400002)(346002)(366004)(377424004)(189003)(199004)(68736007)(2616005)(956004)(97736004)(11346002)(2906002)(486006)(229853002)(47776003)(305945005)(66066001)(65806001)(65956001)(476003)(4326008)(52116002)(7736002)(31686004)(76176011)(6666003)(117156002)(6486002)(446003)(74482002)(64126003)(23676004)(6246003)(52146003)(2486003)(81166006)(50466002)(59450400001)(54906003)(8676002)(58126008)(8936002)(81156014)(16526019)(53546011)(65826007)(77096007)(186003)(3846002)(105586002)(106356001)(386003)(26005)(31696002)(6116002)(316002)(3260700006)(53936002)(575784001)(230700001)(25786009)(86362001)(16576012)(36756003)(5660300001)(478600001)(36916002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODM7MjM6TWE0SVpZdHZhVGJRK1dkNU5nMHdQMnR0?=
 =?utf-8?B?VmtBQ215VTJKeDM2ZjNWKzY5TXhrQ05BRldxYTgxZHRDRU5oYmdvVU5Zb3N5?=
 =?utf-8?B?VVJuUE1ZcGhtdU9vbWZpdUhsbGFFUExjQURxYnJrRXdqT05kS1JvVmhCQTYz?=
 =?utf-8?B?QXBEdDc3Ujd3dDVmTFZmRWplL1B2bXM2S0w2RDN3THZyYnh5bE5IZ0o2Z2U3?=
 =?utf-8?B?eTYxRE1yZ3BrSEI4ejA1QUZpcldvNVczd1UxbjBVVmxCQ2w0ZEdzR05YZDBi?=
 =?utf-8?B?cEwxZC9NOUJIUytTWHB2WHduM0J2TUNBampyb202UnFFSlRHQXRmNGk1b2Zk?=
 =?utf-8?B?c2pZNnBxOHFxcDFzdkRWZFZ2Um4zWWJxZ1huYVJEN3VJbWlBTTUwVE1yczRv?=
 =?utf-8?B?OTF2SCtvcUVSM3JvQ2pYbHNTWHZvSEpYMzV0dU94dEk2OS9xaEdBeFRxNlJN?=
 =?utf-8?B?NXBnY3g1b2JKNTlVRDN6Vlo0QWo4TDJKdy9RTm1GMlFCeXNNSDhQM2VWbENF?=
 =?utf-8?B?ZHNKUDBIdkZKOU9aTnJxblVPcjQ1dGlhUUF2TnZXWUhvYWkvNHVqYkEwYUJw?=
 =?utf-8?B?ZCtqMHJkend1VFNRN0FocWZSYlJOUW92L1QxVmhlSWdIa21WdmxZczEvY0NL?=
 =?utf-8?B?Yk5MUzg3dlVqeGdibXYvOVYreE15ZTJoQ1VlR1dQMUlZRVUwZ2d4M2MvMkZa?=
 =?utf-8?B?STU3UjBOTHNGVVBMTzJETVZNdzVIdWRoREVWRXg5TDJCakc1eUIzUWdtM0pk?=
 =?utf-8?B?bUMxRGJEZFlrRkVLaHJ0RE5RZVgyL3hKQjlCZFpZaVl1SWVoczk1eElqK2JH?=
 =?utf-8?B?WHdlWnl2MXdWcHlIMGkyL2JJY1hTemFwMEJxQ1hMTXo4eHRzMXRQUEIxMWw0?=
 =?utf-8?B?cVhFSTNQVHFpb3dKWEFmenNwSy95L2xvNEd4OGFOd1A1OEFKdTkzdU1Cd0lx?=
 =?utf-8?B?cTYwV09FNDV4cTk0QTY2YWFqcW9UVjNuYlY0V2t2dzVFN0R0NlMxWjUzdE9j?=
 =?utf-8?B?N3hNT1IrajJvcWRwZE8vVUk0am5OZTNHWDNRbmlGR3dwNW9HS3dFd2ZGSXR4?=
 =?utf-8?B?MWRRNThaQm90UktGbmpZb1hFV1BHaGJaM21EUWdPa0xwQnc5RDhyV1FpZFBy?=
 =?utf-8?B?OTNuQ2wrK044MVFrcUZQYXF0NlpiR0dlSW1SN1NOcEp1ajgrZjNjV0d0THhH?=
 =?utf-8?B?WENBM3JvdElMNEludVhCdUNlWXRrYlVBaVhWbGRDbEtvT09JNzlGblUyZnJC?=
 =?utf-8?B?NmNQbEpXT3hNc2ZYeTM1clcrdkZsQUZWVTVVUGdEWXAxRXNZTmRrdlFrdGlX?=
 =?utf-8?B?dUwvbUpsbm84T0RIUUIzcnBsUTJGYS95MUVRenNPTEhWMjJGQjg1cDdicExC?=
 =?utf-8?B?aDlnL1MyS1psTXF3UnJZd0JqdWRNQWZRRnQ0M1drdUZvVkt3bTZyOHdockR2?=
 =?utf-8?B?Q3QxTXZoS3dwejkxUnFwaWdydmlpR0o0VTAyeUJNZmxueXdTWHpKUzlxN01D?=
 =?utf-8?B?MC9Yc1ZEU2w2ckFsRU9VN00vRGVaRkpNWXY5ZkVjZnZyd25PamtRSmVjMnVR?=
 =?utf-8?B?TVpUNDUrcFdSY0JWM004NkN2M0NiN2xiRWpOSGVXc1Y0QytYeXc3c0hKcGs5?=
 =?utf-8?B?WWVESnhjcDVYKzFyYmoxN1k5SFlRL1RFU3hsaWRJS24wOHUyOWYzNEUrdDRD?=
 =?utf-8?B?S0ZySmx5YWFZUWRpMittSzc4aWV6NjFhazJqRHRtbndiMC9PQ0NLejByQm1x?=
 =?utf-8?B?d1VaV1hScERKbmZLa2JBaTVPNjZ1Tjc0ZGNGeUg0bEd1d1FuZVhWWDFKTXQz?=
 =?utf-8?B?ZXdIS1l5UFdiUlRuaVdhWHoyM3A2U1BBWE9SZW5XQnJ3MHZYS05teU5jSXRk?=
 =?utf-8?B?clBPRXpmdFZKclluQ3hycktVcEpWOWVCM1hGMndBREhVaHZhMXZTQTNRYUlC?=
 =?utf-8?B?NXh6ZXE0bm0zTWk4U3duSWE5NFJpNTE3YUhLWEowSFI3R3oxVWVDQ3Fhazhj?=
 =?utf-8?B?enlpbktHbUUzMTQ4ZDRoRUZlRWFoR0UxaUpxakxFdGJ2cFhCWHRHMmhXTHFH?=
 =?utf-8?B?UGV3eDlMVjZQcEhHcW00cm1KYXcrMTZMR2VwR2s1NCtxVjRLWUlacDBqM09h?=
 =?utf-8?Q?9w9FHp+uGlpK1KXyd4pPYUiA5vVNOLAeSIsFJ/y2YNBi/g?=
X-Microsoft-Antispam-Message-Info: LPhQwMY5/v+TerZ5OT2iByGE8f/MRuYC66JyVxvqFrkLfTjx1KTyWuiBWbZOIFgNFArisUxqsLsGe2NTBQLhWKL1MvHwJS8/ajAkTOsvNUsIXHsXtmLf3UaWInX81Lr2G5rWttF/AtWywrUPK9GuPejIm/RiR8SEONevJ9geXevyQbnsoAulDkoibv6jNtI8
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:Fug7TwWAhj9TUdF56/jzcrwoNdNGDxyQvEeNBb3j0VdmHV7xA/rgxRdHZt+8wUyZ2nF2aUtP9gJYVR/29dKx7MeCIdVFlkepf6xAClQY8C+T3Rq83099CQxkAU5Dxwd8ldeN1ENwE1j0N3GlN7AufWkb2wlaq868Vb57qb2sB2ETdMdMppfhLEJ35BnhV8dMxYrgKkqtfxuG52K4BEe5wcRFkA438MaMulRNWNWfBtghXeENRb7uT6UjPsdgp8Z6YVP1h1U6/DlKygB+Zy9JkM7YXc/OS8ew1XUDBr6rUNIytpMg46UT1z2R3FSP8vWHRwlUoum5W630OIGQm59m1bRLUSaHEIIHg6TwmzABu9RUIUUJFDMdT68F0qBcQwyKxvcSL/Aev2ubX+dkFv/zbm4GXbzuTRdHVqrBHUJXiKdv7GC0dpvT80fu6Kvrfn6xYctDScIWbX6WASmmUyNPIw==;5:GljkydF3NZrT41KBXnyXRbBQ552jRaTaCR0S9P9ZrhSHfPIy9MQMptmNeMrrLq548xPiCrOkPWU0BxhKDkG7U2HbLEbzISMRKcipOvDsXg6IcWRx8nvGEHjzuutErks0GG9UFOeSeKCz5Ffk1ibfc2sXHT0dvevYk2gWEjxSnwY=;24:OKtYGqbbYpAQwUurF0zJ0u41KE99vi9m8pzXdPuC2JYUwjYClOzadXKIJXAYhbhY8YcS17mFzxQPRGDuuVuhw9690BAAdehCDOcPzgzkoD8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:/q8jumzoSxDfrYScktQX/SBQwrDRCmcuL/4dv6dVKCsCQMcJwL4pA0SsgFzmuI4LaDY212CZk3Unfq8NqwGHp1qfdq6RM4Mx2gAnEB6ehdsZK2bZfyrhkub0Qk5e3X2ogcxn/WXP21Kutr4+45ghQNiKYz9QanOgRgu+yzozXE7EslKxF8Tfb5s6vR9OojRZJ7yqlxW3pnKQil6+oiiNtCQ3PncJWROnYrhRr93Pzz8msEUVUdZw/5GmAvmHNW5i
X-MS-Office365-Filtering-Correlation-Id: 53fa1512-afe1-41f8-5407-08d5c180873f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 14:13:30.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fa1512-afe1-41f8-5407-08d5c180873f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-20 08:50, Wolfram Sang wrote:
> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
> I2C core does this check now. We can remove it here.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Peter Rosin <peda@axentia.se>

> ---
> 
> Only build tested.
> 
>  drivers/i2c/busses/i2c-opal.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
> index 0aabb7eca0c5..dc2a23f4fb52 100644
> --- a/drivers/i2c/busses/i2c-opal.c
> +++ b/drivers/i2c/busses/i2c-opal.c
> @@ -94,8 +94,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	memset(&req, 0, sizeof(req));
>  	switch(num) {
> -	case 0:
> -		return 0;
>  	case 1:
>  		req.type = (msgs[0].flags & I2C_M_RD) ?
>  			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> @@ -114,8 +112,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  		req.size = cpu_to_be32(msgs[1].len);
>  		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
>  		break;
> -	default:
> -		return -EOPNOTSUPP;
>  	}
>  
>  	rc = i2c_opal_send_request(opal_id, &req);
> 
