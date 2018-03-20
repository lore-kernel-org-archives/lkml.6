Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeCTJcX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:32:23 -0400
Received: from mail-eopbgr00125.outbound.protection.outlook.com ([40.107.0.125]:56960
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752192AbeCTJcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:32:17 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
Subject: Re: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
Date: Tue, 20 Mar 2018 10:31:57 +0100
Message-Id: <20180320093200.19179-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320061909.5775-1-chen.kenyy@inventec.com>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea156b14-0a72-4c9c-e612-08d58e457620
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:vZqNfAmHivfW+LqiYBx3nXU6Gv03MLvCZxWx2XFa56H/N4t+UjIb7oK0AfNtd3fBSkVCr0iNHAmDf4vjahmLniQyCjyJcnknzMyEaA9ZEqZ1ttQlEGYEacPkK+ecwko3F7A5AxIXnaroj5JKjUbzfyRNx8J4pl8R7aY/OljCMFKPdtJYhsdSayjvlrc4t3uqp0/k+LANq/1wuLYbHI6DF5rVK65l+6EwSAAj4qVCvTlvrt/zL0svb/IhCSEgEfss;25:pZdRrgDhHcZ5KpFMnC56hfsMorbf0bbNw1W7FwghwF296oN5rhhQL3+GW2XCd3BUmyh9Fj/oBskJiQUTw40j0rVQVB8cyu9AkNFlJYMST9bzkZmlneoiXwQhVFubwuUMPB73au0qPgrfG84T7bB7h+yZ5FSmBbblZupuZ58/lJoCwX7hNPgH/7CbxHTL3/a6GcQ2l2lPUXeR+kbCRKKUXwDOnGufADaWE4NT6GjJuhTCehUpUs07WdbXZ2R8MUYaJ0TFOWaXTYpcT0aXV1t+HideNnVWgVjezBU9QI7lPrlMWRnWZHjxVp1NEQnIGKywWuNxsSCqabDaVpMWXiY/Og==;31:7MrvFhzcUtRvMVrFxosYomBLCDfYeD7lwSlafQniFB3WY8M1TkKQ0gc1H3fJ2KBuit86EdCfIKwPTxwhxIST/Nh9x5zjO0a0koLeBBveabqovRybOssyVQ+jtRgtn51gW1uQ8bXkMh2I6IsDNXtG78ck2qHOaV3Cwu1rYVZw24yQ0Vam9m8pF+Cv68e2Xv8PJP30mQIczmwBrxL/feDVxjLbhvxRnRWT2jhbh9g0n44=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776F135FCA9A8438FCE3D9BBCAB0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(139265435329489);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501309)(52105095)(3002001)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:i7CgVCYbfFM/e6WYFl0vo41BgaCANrLqWF5/qvd5oWYu5p8dWLFy7B8BFdyF6RN7Mdke/vBum84yjd1mUOzotELWW8DMkDxCQxBsBkPgwXsrIUzrUKThV/b//IJm+URgNRhsL3WeQtLiirmC5eUmgNVIz/zlWdOR2yPsAMbfsgYMuHlTV0w+As1qU1Zo/ODRwVs7sWXUUEHsQjVilIzKvViEHyM3QiZVokUnUXaH7+fsFrV3xldW8x94prOzPoewGcYs53nSUb1Zt4McypGuWDaeHKusDLsQtYzU1vA099mll9AxuNaM9zuq9C0r1wP3T509Lk9hrSDG4CNNlgHiHYMsZmmjRm9WJ/+f2l4agtI=
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39840400004)(39380400002)(346002)(396003)(377424004)(52314003)(199004)(189003)(8936002)(16586007)(54906003)(478600001)(6246003)(81166006)(2351001)(6346003)(3846002)(2361001)(25786009)(76176011)(106356001)(8676002)(81156014)(51416003)(86362001)(6506007)(26005)(551934003)(316002)(386003)(186003)(16526019)(53546011)(50226002)(53936002)(59450400001)(36756003)(68736007)(47776003)(4326008)(97736004)(5660300001)(66066001)(6486002)(6512007)(305945005)(50466002)(7736002)(229853002)(2906002)(48376002)(1076002)(6116002)(2950100002)(6666003)(52116002)(6916009)(74482002)(105586002)(13158425004)(567084001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:jAj4RwZ3Ifj2B9v4HR/bgII7GOjfZHokyNOeQX8?=
 =?us-ascii?Q?zr5SolqV1wMjPM2bNwZquGyRw9iFVWu1Sud2WcTZhTTRjr4FyyK06db8XejJ?=
 =?us-ascii?Q?pfsf7AsyOnixHlYGlPOInom9bVHGN31PGkJKrET1CSH51JmW9zqD5d4JtWVp?=
 =?us-ascii?Q?S9W5TN0QL5OC1Vn5mJ/Ftl4PSiRsJqN8OVdjaCraHuFDaL6TI1J9e2Czj0qR?=
 =?us-ascii?Q?3Y7Wcab09CTLtsMV3+x5Q6fmdCyp0Ijcp4w48TNozD9vCz/0VPdFC1IC4pQW?=
 =?us-ascii?Q?GYt11SiRVp8nZbh9QKx+F5ytgD6N9UXOPOL+eOZiZQ9PV9Gnrii4YMwZ1EEL?=
 =?us-ascii?Q?/z1XFIeXVJSOMFf3rMwAT7v3dgfIFryuYRJIkuyVBm1h7UL3w5tgWiJcWHpV?=
 =?us-ascii?Q?fES1Uhk+GwxLyD1x/K1Td822L6a3q7AVEMR5V2MY8fbOOuoL0xiovcHU7wio?=
 =?us-ascii?Q?gnluzdD03yWXcDJyYMP7DTEbe8hRO1uSFBoJ9UaJXuA3gDSIJy1NwVXLgoq9?=
 =?us-ascii?Q?BufCogQdbyVk96z6Ud70mzfwfEgYTRSIiPyO4iRg6uKaObXl0zdsFz0rk+7X?=
 =?us-ascii?Q?9sKvq/06quOU1viypWsJ2ho2/RkNAaaS2KaQF5R/mR7Co+lzCrYPc+cxJcRW?=
 =?us-ascii?Q?aO71ofjxxoL4xokTxswGaCC1YBWVZZ3ILTeXhSZ46X99aCkUGoBDeNqTJKh3?=
 =?us-ascii?Q?Hg/p9Ty95C33ZOECmaEMwtgjMgcHJXGv8zzfekdgly3QxKmNdDQ28hvpgpSo?=
 =?us-ascii?Q?8dV4hrHzc+fxIV9ujMxPs+LsvFGXk9iWYFFwTl848uUqfCfnCEK6YHnay+ii?=
 =?us-ascii?Q?mMNq7CD3t0//El8LqUFI4N5xtszRPakZhD7J8XF3x8Ws4+PH89iAZYB4tF9D?=
 =?us-ascii?Q?DPisdpTcOqMr2FEhLaGT2wug2JYrBt1nFAikzKXo6TjIfQlVlh6RzmVV98H6?=
 =?us-ascii?Q?ZKedhAZhMJuCt5xxxsUQaJvEslJqF/60KYuIzbM1I9p5Od9VuMHPOmm5xTsn?=
 =?us-ascii?Q?GYcDCkogsOyQlY3a9NFfFeZIdSgXVPGEU0cXQ4s1ui/xZuFDLOVZsCiKXj65?=
 =?us-ascii?Q?2FDbuHtMxA1gWi5/4GXj4BQPBAnTCtiEo2l/UJsuk5NmJInVzm1gzz2mNdPw?=
 =?us-ascii?Q?8qY93X8MzG3oHVr1rE2ItB9XXz5E3YAyd3hyzPJJ9YxEeE50y3LBXYsnopyy?=
 =?us-ascii?Q?c7SMuavima3SMHKen9wQeWNRZn6iB1IOdMxb4oARmztv0ROuOdqYA6RCc630?=
 =?us-ascii?Q?1rrKV+LYA6z8voDgY40TzEvvvDDCu3peZz23ayTLbEUYFAVjJcpal1Pu1l3n?=
 =?us-ascii?Q?bWWBvLoORCQmZdZH78p7QPNIJtpjAU6ra1y4zzZq85QkINhlLJWCMipZtcD+?=
 =?us-ascii?Q?jEEgzJEiKhrs6L66VXaNncTYwEq/fwX4CgoTdm7qvJlO9TZPpDg0KMXCB8eB?=
 =?us-ascii?Q?jD366bpN53dZAdZtrcpB8wX9J8kFCVRY=3D?=
X-Microsoft-Antispam-Message-Info: pO670WgrWVXSIyBqaQVHX4DAeNp0WEzmDuG3p9btlek0Ml//VcfdKS6dPB2cXDpW9u8H8IvzfrRuAYXzkLVXoA40fi/skOtsKpwR+/WNVf0Q9UjQpGimNTCx/mv6bOS/ppBNRwcZLy/UpjJB9yLq8PU0ALNUHw1GcsHLmK6k4+TE2HbgvVReYBZattvlH4J4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:M+LjFl6HqpRmsSBzdah1/x2FY86SFwhxXnYoy0YqCDKmx4/NM73IgZ4lFsZ0ofHEy7TLOVH39FZqONZOtcpqcH2MK/jGJ+HPsMRWmPBlT8YUe+o4aYCMg/TgYuwSdxgZrFpQUKlgZclnQbply/7w5u17P9/30wS1jXMQKFI1L1aUtDXHe8pT+mk7IwLkF7dkmrkGnWUgRYXyaXTduOkPHqmGWlgu+CaNdbrbr2g2fbsmZdeI/JixyofcI2OvhM4jP4XEp89NDGMFd7Z+5sxvt/RwePL1of8kUcuPNQWIwx58UCK5/9FGKjTJSmtu7F7bigpVHD7x6qjJ6ihJ0tyr9gt57YMYnomYyK9eJhyd27U=;5:AV5ZZ3jsUJkTcszfUyyKqcXHPHyEuZLHfCCnbJspmhJb8hDwPY2zT+O2ncpkk9X2o3boXPZ+cUjXI7OuBbYYgI9A4gr9jFh7tVFukgF0zCQQLzhZXa3b6JXo+tmGttlhbrDj0z2v+4oVsz2TrgU1204QOBRuFUhKjRhfFiYAG4E=;24:vIosYyGmsOQYzWTtRjH6PkRwy+yTWYecwrx8pt/tlnLjaJQ7gB8TNMD50POX7vdxp36s1LH71aQMAWBwg7vdgoCGwRYCtXXGg4wwpJwzvSc=;7:fIkiJoNgzCcqI8W+ZG0fXe7Brgelb73XvEYTt/newDJRmnvN0QhajbKtsiVHFgxcXTUari1/piRaMHBBi6zaj4YXJAQwG7L1gJ+FIljqMJmLz+VUBVUV7x4vg/PSidD4mxcF/xEMHdVbl+omYKagqvleSax8rWoqcZOSCYW3ehHMz2FShy3TtQ7XHDkTInfRnq2K0hM7Xxjb2zQ/JRK0kjAVmovJOG5T52zc+fXV8wTIYZhrWZ/oGRFFcIPtoqq+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 09:32:11.7454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea156b14-0a72-4c9c-e612-08d58e457620
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 07:19, Ken Chen wrote:
> Signed-off-by: Ken Chen <chen.kenyy@inventec.com>

Ok, now that you are not adding a new driver, but instead
modify an existing driver, the subject I requested in no
longer relevant. Now I would like to see:

i2c: mux: pca9541: add support for PCA9641 chips

Or something like that.

> ---
> v1->v2
> - Merged PCA9641 code into i2c-mux-pca9541.c
> - Modified title
> - Add PCA9641 detect function
> ---
>  drivers/i2c/muxes/i2c-mux-pca9541.c | 184 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 174 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 6a39ada..493f947 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -1,5 +1,5 @@
>  /*
> - * I2C multiplexer driver for PCA9541 bus master selector
> + * I2C multiplexer driver for PCA9541/PCA9641 bus master selector
>   *
>   * Copyright (c) 2010 Ericsson AB.
>   *
> @@ -26,8 +26,8 @@
>  #include <linux/slab.h>
>  
>  /*
> - * The PCA9541 is a bus master selector. It supports two I2C masters connected
> - * to a single slave bus.
> + * The PCA9541/PCA9641 is a bus master selector. It supports two I2C masters 

PCA9541 and PCA9641 are bus master selectors. They support two I2C masters

And make sure to lose the trailing space.

> + * connected to a single slave bus.
>   *
>   * Before each bus transaction, a master has to acquire bus ownership. After the
>   * transaction is complete, bus ownership has to be released. This fits well
> @@ -58,11 +58,43 @@
>  #define PCA9541_ISTAT_MYTEST	(1 << 6)
>  #define PCA9541_ISTAT_NMYTEST	(1 << 7)
>  
> +#define PCA9641_ID		0x00
> +#define PCA9641_ID_MAGIC	0x38
> +
> +#define PCA9641_CONTROL		0x01
> +#define PCA9641_STATUS		0x02
> +#define PCA9641_TIME		0x03
> +
> +#define PCA9641_CTL_LOCK_REQ		BIT(0)
> +#define PCA9641_CTL_LOCK_GRANT		BIT(1)
> +#define PCA9641_CTL_BUS_CONNECT		BIT(2)
> +#define PCA9641_CTL_BUS_INIT		BIT(3)
> +#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
> +#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
> +#define PCA9641_CTL_SMBUS_DIS		BIT(6)
> +#define PCA9641_CTL_PRIORITY		BIT(7)
> +
> +#define PCA9641_STS_OTHER_LOCK		BIT(0)
> +#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
> +#define PCA9641_STS_BUS_HUNG		BIT(2)
> +#define PCA9641_STS_MBOX_EMPTY		BIT(3)
> +#define PCA9641_STS_MBOX_FULL		BIT(4)
> +#define PCA9641_STS_TEST_INT		BIT(5)
> +#define PCA9641_STS_SCL_IO		BIT(6)
> +#define PCA9641_STS_SDA_IO		BIT(7)
> +
> +#define PCA9641_RES_TIME	0x03
> +
>  #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>  #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
>  #define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
>  #define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
>  
> +#define BUSOFF(x, y)	(!((x) & PCA9641_CTL_LOCK_GRANT) && \
> +			!((y) & PCA9641_STS_OTHER_LOCK))
> +#define other_lock(x)	((x) & PCA9641_STS_OTHER_LOCK)
> +#define lock_grant(x)	((x) & PCA9641_CTL_LOCK_GRANT)
These macro names are now completely hideous. They were bad before,
but this is just too much for me. So, instead of adding BUSOFF etc,
I would like to see all the macros with a chip prefix. But I think
they will get overly long, so I think you should just write trivial
pca9541_mybus, pca9541_busoff, pca9641_busoff etc functions. The
compiler should inline them just fine.

The rename of the existing macros and their conversion to functions
should be in the first preparatory patch that I mention below. The
new functions should be in the second patch.

> +
>  /* arbitration timeouts, in jiffies */
>  #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
>  #define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
> @@ -79,6 +111,7 @@ struct pca9541 {
>  
>  static const struct i2c_device_id pca9541_id[] = {
>  	{"pca9541", 0},
> +	{"pca9641", 1},

You are actually not using this 0/1 difference. Have a look at
e.g. how the i2c-mux-pca954x driver uses this as an index into
a chip description array. I would like to see something similar
here...

>  	{}
>  };
>  
> @@ -87,6 +120,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id pca9541_of_match[] = {
>  	{ .compatible = "nxp,pca9541" },
> +	{ .compatible = "nxp,pca9641" },

...including pointers to the above chip descriptions here, just
like the pca954x driver.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, pca9541_of_match);
> @@ -328,6 +362,125 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>  }
>  
>  /*
> + * Arbitration management functions
> + */
> +static void pca9641_release_bus(struct i2c_client *client)
> +{
> +	pca9541_reg_write(client, PCA9641_CONTROL, 0);
> +}
> +
> +/*
> + * Channel arbitration
> + *
> + * Return values:
> + *  <0: error
> + *  0 : bus not acquired
> + *  1 : bus acquired
> + */
> +static int pca9641_arbitrate(struct i2c_client *client)
> +{
> +	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> +	struct pca9541 *data = i2c_mux_priv(muxc);
> +	int reg_ctl, reg_sts;
> +
> +	reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> +	if (reg_ctl < 0)
> +		return reg_ctl;
> +	reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
> +
> +	if (BUSOFF(reg_ctl, reg_sts)) {
> +		/*
> +		 * Bus is off. Request ownership or turn it on unless
> +		 * other master requested ownership.
> +		 */
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +		reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> +
> +		if (lock_grant(reg_ctl)) {
> +			/*
> +			 * Other master did not request ownership,
> +			 * or arbitration timeout expired. Take the bus.
> +			 */
> +			reg_ctl |= PCA9641_CTL_BUS_CONNECT
> +					| PCA9641_CTL_LOCK_REQ;
> +			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +			data->select_timeout = SELECT_DELAY_SHORT;
> +
> +			return 1;
> +		} else {
> +			/*
> +			 * Other master requested ownership.
> +			 * Set extra long timeout to give it time to acquire it.
> +			 */
> +			data->select_timeout = SELECT_DELAY_LONG * 2;
> +		}
> +	} else if (lock_grant(reg_ctl)) {
> +		/*
> +		 * Bus is on, and we own it. We are done with acquisition.
> +		 */
> +		reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +
> +		return 1;
> +	} else if (other_lock(reg_sts)) {
> +		/*
> +		 * Other master owns the bus.
> +		 * If arbitration timeout has expired, force ownership.
> +		 * Otherwise request it.
> +		 */
> +		data->select_timeout = SELECT_DELAY_LONG;
> +		reg_ctl |= PCA9641_CTL_LOCK_REQ;
> +		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> +	}
> +	return 0;
> +}
> +
> +static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct pca9541 *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	unsigned long timeout = jiffies + ARB2_TIMEOUT;
> +		/* give up after this time */
> +
> +	data->arb_timeout = jiffies + ARB_TIMEOUT;
> +		/* force bus ownership after this time */
> +
> +	do {
> +		ret = pca9641_arbitrate(client);
> +		if (ret)
> +			return ret < 0 ? ret : 0;
> +
> +		if (data->select_timeout == SELECT_DELAY_SHORT)
> +			udelay(data->select_timeout);
> +		else
> +			msleep(data->select_timeout / 1000);
> +	} while (time_is_after_eq_jiffies(timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct pca9541 *data = i2c_mux_priv(muxc);
> +	struct i2c_client *client = data->client;
> +
> +	pca9641_release_bus(client);
> +	return 0;
> +}

The pca9641_select_chan and pca9641_release_chan functions are exact
copies of the pca9541 counterparts, with the exception of which
functions they ultimately call. So, instead of using different
function pointers in the i2c_mux_alloc calls below, add a couple of
function pointers to the above mentioned chip description struct.

Then change pca9541_release_chan to something like this:

static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
{
	struct pca9541 *data = i2c_mux_priv(muxc);
	struct i2c_client *client = data->client;

	data->chip->release_bus(client);
	return 0;
}

Similarly for the *_select_chan "wrapper".

Now, these changes will somewhat affect the pca9541 side of the
driver, so I would like to see more than one patch. There should be
patches that prepares the driver that should be kind of easy to
verify that they are equivalent but that makes adding a new chip
easier, and then one patch at then end that adds the new chip. Hmm,
it will probably be easier if I write those patches instead of
reviewing them. I will followup with them. But note that I can
only compile test them, so I would like to see tags for them.

> +
> +static int pca9641_detect_id(struct i2c_client *client)
> +{
> +	int reg;
> +
> +	reg = pca9541_reg_read(client, PCA9641_ID);
> +	if (reg == PCA9641_ID_MAGIC)
> +		return 1;
> +	else
> +		return 0;
> +}

This was not what I had in mind. If you do dig out the id, I think
you should only use it to verify that the input to the probe function
is correct and error out otherwise. But maybe I'm conservative?
Anyway, with the above patches you will not need this.

> +/*
>   * I2C init/probing/exit functions
>   */
>  static int pca9541_probe(struct i2c_client *client,
> @@ -339,34 +492,45 @@ static int pca9541_probe(struct i2c_client *client,
>  	struct pca9541 *data;
>  	int force;
>  	int ret;
> +	int detect_id;
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> +	detect_id = pca9641_detect_id(client);
>  	/*
>  	 * I2C accesses are unprotected here.
>  	 * We have to lock the adapter before releasing the bus.
>  	 */
> -	i2c_lock_adapter(adap);
> -	pca9541_release_bus(client);
> -	i2c_unlock_adapter(adap);
> -
> +	if (detect_id == 0) {
> +		i2c_lock_adapter(adap);
> +		pca9541_release_bus(client);
> +		i2c_unlock_adapter(adap);
> +	} else {
> +		i2c_lock_adapter(adap);
> +		pca9641_release_bus(client);
> +		i2c_unlock_adapter(adap);
> +	}
>  	/* Create mux adapter */
>  
>  	force = 0;
>  	if (pdata)
>  		force = pdata->modes[0].adap_id;
> -	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
> +	if (detect_id == 0) {
> +		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>  			     I2C_MUX_ARBITRATOR,
>  			     pca9541_select_chan, pca9541_release_chan);
> +	} else {
> +		muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
> +			     I2C_MUX_ARBITRATOR,
> +			     pca9641_select_chan, pca9641_release_chan);
> +	}
>  	if (!muxc)
>  		return -ENOMEM;
>  
>  	data = i2c_mux_priv(muxc);
>  	data->client = client;
> -
>  	i2c_set_clientdata(client, muxc);
> -

Please don't do spurious whitespace changes like this as part of a
functional change.

>  	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
>  	if (ret)
>  		return ret;
> 

You should change the Kconfig file to mention the new chip and you are
still missing a devicetree binding.

Cheers,
Peter
