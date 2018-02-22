Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeBVEAU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 23:00:20 -0500
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:41439
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbeBVEAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 23:00:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
To: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55?= =?UTF-8?Q?i?=
        <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <1514652658-6228-2-git-send-email-linux@roeck-us.net>
From: Andrew Cooks <andrew.cooks@opengear.com>
Message-ID: <6af53537-f160-8ea5-2491-98f8a7966975@opengear.com>
Date: Thu, 22 Feb 2018 13:59:49 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1514652658-6228-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: MEXPR01CA0142.ausprd01.prod.outlook.com (10.171.15.27) To
 DM5PR15MB1211.namprd15.prod.outlook.com (10.173.209.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d88a91-058a-495d-6301-08d579a8c815
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1211;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;3:TL7QWqVGWCpViOo0CXHtMya6PZpJDvPbFJAFMeWUhBjlFJzOcQ6Z/VOEa9aEjlZfZf/im8JTO/KzOzq/1asqa6VJJnQhM3E9U1KqLepE9det0tpg+hB6i/L3JnXJOcSC04dSX2nUJ1/8jUIFidgdcxJAacGnVXMaEkkEYzPuiAOu7z9DV8k8TPX3iHM145OjSIEwek/W0+UQmxHgUIkWT5/+5CFH9h7Cb3P9ePw90SfXAmWSkM3QqdMsHlX64SCB;25:G4jDxM9him1D2yzCd6QGqsdFAQbBQPSUTD98NTh71Eq3sKY+X/ZZZLtepdgPU8GnClFCOby7kIQLJp08jaM41Y8Mkf+6nRRhcjnLW3WKDLnGYDrOcE4BikCzK8zazIVgxOYYlFcJ712pgL5kzyG7O2/ChncXSxWGiNNrGMK7vxR3jOcZYEU3peLJz/myiu6MCSVRu4Z1FMZui82NtvboDoSMtHc9ToU+MmswUUwhA2aDFkg/kPBu6GF3+tRA8xNZJIxuJPSMicehF47Cdj30IabLLv7UhQhuHzUZY3Ody0Jr18RmNtdMGg0ZunpKsBoEziNMtd7LkCjhpF8s7GtwGg==;31:mBJBW73i7/1ApNcL/LhOS1p6P4fdj6ULzH9UMCFKH7BCQFdepZlzH+El1+6no3JA7Ww+TkqfCDUKbSfwc5KZAnBfYBSlitC2Kqn0rJjW7UPCb09D/HRytnYBswfiyU0YE7lfOg5T+DF1mDrpP9mk2HXA+4M6arW9T8BhyPjGRwRSGX+Svc57F51+HsFR6e9A3GqxDUh+W89au0UPUPJZK1c5PPC2B8w+zzTlHPgBmv8=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1211:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;20:USmzcXwdlZETgaBIOdz0+t35BcnT03uIFiBYiCvHMq3UXaoJfDQJjv+iK47tubXTP99SYtu5/3bf+o2NtW7kYt17H5pMknSQc3C1tEZwEaBpol/UcnsxyG2c0zLD/KAnEvi0CYD7ySbpI5VfoVI1Vrnn820EZGTL82WdcYLZsz0=;4:y8YNtfyyyLkb3l+mO9XH8Fkw9BghqzpDWssJPkWQwDJmMvz+fyHOZbMD83BKYTN+MPJencXdzsuvEVFmqPCa6yiJk0QKqC5hcGDs/N1Zx7ps10T7cPYvpFJgZHzeYSwiw8slZimpja2OWiQB9+Ya2dH4t1ciuo93/sw1q6puP2KoOvdK9bp4ddgSUabemm79d+BXLKDdhJe5280H3rjxHulsCQVOiUzMI5ydIayTM5s44zr0ZOnf3chjeP06V+SymG9I1aoG553ExgHo4FyH4g==
X-Microsoft-Antispam-PRVS: <DM5PR15MB121122271FBC86026229D7A5EECD0@DM5PR15MB1211.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001074)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1211;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1211;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39840400004)(366004)(39380400002)(346002)(376002)(396003)(189003)(199004)(305945005)(25786009)(53936002)(97736004)(478600001)(47776003)(65806001)(66066001)(65956001)(50466002)(5660300001)(106356001)(64126003)(65826007)(77096007)(7736002)(6666003)(6246003)(76176011)(229853002)(90366009)(26005)(2950100002)(6486002)(117156002)(36756003)(4326008)(52116002)(386003)(105586002)(58126008)(2486003)(52146003)(23676004)(68736007)(2906002)(86362001)(16526019)(551934003)(8936002)(81166006)(81156014)(54906003)(110136005)(8676002)(16576012)(316002)(3846002)(31696002)(53546011)(230700001)(31686004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1211;H:[192.168.254.67];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjE1TUIxMjExOzIzOk1mbnBpWE05NS9MVS8vcTdEVmZ1VGxWQlVG?=
 =?utf-8?B?VHZOZ2xZZHQ4WDhpTm5uNG82ZEN2Mjh5SmY3MXVSTndkWVNuVlBrWTltcEdT?=
 =?utf-8?B?aVFNaWJlMGJualg2T00xUEdhcFRFNDBXRE05aVRXR2hYN2lSVUphZXZaWWdK?=
 =?utf-8?B?cHlsM0paSXdDTTh3aitnTkFyakFGcVZiRyt0ZkhEa1J3OWh2MGZVSDhVTUdq?=
 =?utf-8?B?VEdkbWVmZmZXSlpPZE56MDN4ZEhxbzhuRnBKTy9ZNUlZYlZiTDFRN2ZERGgw?=
 =?utf-8?B?VFJtSVVUeDVMTUpnbXlZbzBERWNEZmZjQnNUeFA3Y0h2NE9SSnhFd2g3aFBu?=
 =?utf-8?B?aFh1UGk3emF0L1luZ2VQVjA5S2JnaXB6blRIZjIzbEF6WUxXTGRPWk52Um5x?=
 =?utf-8?B?YWgwNk1td2VWd1psZnR3UTNwSWpXRFlnNzh0SnV5Ung2OTBpNitlS29PdVY5?=
 =?utf-8?B?Z09tcDFsSTdCNUx2RmpJZWd6NFFnZzdSRitaU281R0ZTZmNvekQrM0dSeURM?=
 =?utf-8?B?b1lPUGFoWGpSSTVnLzI5MEIvakFhSHlzWUVRNlpjd2h6Z081RXdZMFhHUUpp?=
 =?utf-8?B?L2JycmFBRmFQQVVIcDBka3ZuU1NhK21RS2xMRXVWbGpMZlUwa2psb3V6Tm5V?=
 =?utf-8?B?ZHdrSGp0UWVFdE55c0YxblVKN1l5UGpCWGNxdUR4SVRLWDlYWituSlRyWjRU?=
 =?utf-8?B?UFBvaDZWRU1SaHUyY2xlbXdDZzdoRzNmcHRkS3JlZVNwRHFTYS9DQ1FsVHZ5?=
 =?utf-8?B?c1N6eVBrcVNHendoOXhlMmV4b3F5SFhoVFA4bDRLclg5SEVGRUZXckxrTHpX?=
 =?utf-8?B?M0N2dTBqZEJZdEQ5MC9ZRUpNZFNwOUM0VlBhdzhuMmV2bU9CZE95SlRlTXVV?=
 =?utf-8?B?d1d5aVM4ZzZpaUpQd09ubG1YalVkRUdLUWE1cVdTVVFQa2lNSnVNczZMM2Zh?=
 =?utf-8?B?MzVoUHRXWVdENkRUbG9jRzVlMURjanVSQnl4Y1dwUUQ5SHVtcElBY0h0djFD?=
 =?utf-8?B?WWlMa3Q3QWhrK3Fqbld0ajRCRGZoN3UrZFZPNVgxL0lNeHBIbWRzQ1FqV0Jh?=
 =?utf-8?B?UGtZa2I1bVZqVkN4QWZMdTNzT1hjdU1TbFdPTlNSUkJobEtRQmNrbUpBMk5O?=
 =?utf-8?B?b2IzTVRBQkRnaW04b2tGY2pBbEhWckQrbXJKcmR6NjYwOHFVV0o4UmhOa0R2?=
 =?utf-8?B?NXp6WDdBRUVaMGloM081YlBudlFYNmRpQzRudmJTZ1g5cmdVaGZhOFcvSXZV?=
 =?utf-8?B?ZnZRc0hVTGtjQXhpMnFrZTNiZkRiS2JOU0Y3cEhiUXd4bmlra0R3ZFQxRi8y?=
 =?utf-8?B?U2xUbGo1Wk5qVExEa1hnNE5rL2pSL29TQTZjSXNIa2doM00yRmhMcnIxVm1H?=
 =?utf-8?B?b0lhdHF6YWRoN3Q1Wkl3V0tVOEszR1F2Qm5LQ2wwOElvQk85RUlIODdyTGQv?=
 =?utf-8?B?SERLRE81Uy96V2tPL1A2M3RzUmZMYndsQURQU05zeFhlbHRia0NOcFZFTmRk?=
 =?utf-8?B?TXBEU0grZ3FoWXhEVkV0ZGRzcVQ4Y08wMTdMaW8zdUxwZm44ekdBaVN5OU42?=
 =?utf-8?B?V3hZZHZGK1gvUWVMQnE5Q29lMCtPZVpMd2hkNjBjS1ArMHJVUTh0Z1NUdjNY?=
 =?utf-8?B?ODNGM0tqdWJ6Mkcxbm5xdUlCbnZqV1lKd2VOblFEbVBxSStJcHMwQjVyQUl3?=
 =?utf-8?B?a2dyUkFOallvMmxONGNTczZhYXpiclI1ZGN4ZDlxS3BJQjJRcXJEZVlXUEl3?=
 =?utf-8?B?TW1CMU40VDBoaWRFOGVncHhnQlpuN2JpbEV2M3NObHhsMHZKSTlYMVZ3c2dw?=
 =?utf-8?B?a2F4OU5FWkIwbHFlaTRLWTBXOW9SWE9FcmZDUFdnOVJPTGYvZXJRcUdIekUr?=
 =?utf-8?Q?T7nUwXiaATbhCq39wBOJIDbjlcnFaOFU?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;6:AOHUhQeAxfYGrOqkV4x+IhQuteoOMWkzYSHXqbq3RWJ53qhXVSaIPqX7P2z97y7L6L+XKHjGjK7PTqStp9csERFBjUlkzv86QJT1jYNrnYz5VYLsdMsV6jMX55/PLs2WcnauJuy1/fKHA//J4z/x7UMsAmQTNsq2KukMJTiJNLl2TE9eyfxFrqDRO4jV7l6BZR0bQ1rUC1PdCpBdWvWFIbgUlrdFlmYvDjJpPJ1OVLKmMpypasoz8UGeb/17fnF3kK/N5pIi6Ndq4lK/d5eLBJ8W+ENcyPXKNMLusratqR4OEgnToW9M1nRFo2Ew7fEvHDctZPsZvp0X2Q5Xc5sLdtmb2vbAiOiy5CoOwqRGx7U=;5:VzQlaPwI5pdicgWRVh3PD1qv+TL+Boc16LSVxxxUB6Fnvx5U3qOR+tRGJP5kZIgul3NkYl2RFmOoDY2mBaL6zbYZcbmyD2m2BiYHd43aeMg9LJM5GAecgTdkcu3bqboUGHa/w8Lr88p8m0/LOTsDHp5yX6iJ48j5BAY4dg0gLJE=;24:PMg2lOcjC0wpUFfd0FfSnQj+wqgd0VUSLBFDOKk+WuTtIq3eP7eM0pRhiyUQV8Plz8gI6wOH91YDzEZRjSya2wIeNXTP6NxQO+C33FyKKVw=;7:YU9RFw5+9OjmAUASrpV+9LAvAbhjHWaO5Ie3o55acT16FGtfNAHTc/3AqfZbgQgLdCn2e2xoSYPb7NslUWIeRiLkHqix9xIBiDJH3i4egihh6UCiGk6S3Uqk+DaRiS/JCZ8G2BmyLM7b6XybiLEA8oMj+uO8wh2rAQ4y651Vc5WG/EQffnAo6iYyJ/Yc8EGC2omdswQq0Z1mYh03I4zXuw3eBTNBTvpNLuJYT16iSLOaWTDfHZDrdNY54WulrwQY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 04:00:12.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d88a91-058a-495d-6301-08d579a8c815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/12/17 02:50, Guenter Roeck wrote:
> The piix4 i2c driver is extremely slow. Replacing msleep()
> with usleep_range() increases its speed substantially.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 78dd5951d6e7..52a8b1c5c110 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>  
>  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
>  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> -		msleep(2);
> +		usleep_range(2000, 2000);
>  	else
> -		msleep(1);
> +		usleep_range(500, 1000);
>  
>  	while ((++timeout < MAX_TIMEOUT) &&
>  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
> -		msleep(1);
> +		usleep_range(200, 500);
>  
>  	/* If the SMBus is still busy, we give up */
>  	if (timeout == MAX_TIMEOUT) {
> 
Thanks for this patch.

FWIW, this also makes a noticeable difference on AMD Family 16h Model 30h, used in embedded designs and also commonly available as AMD GX-412TC SoC in the PC Engines APU2.

Among the tests I did were reading from the SoC temperature sensor in a loop:
while [ true ] ; do i2cget -y 0 0x4C 0x01 ; done

and scanning for peripherals in a loop:
while [ true ] ; do i2cdetect -y 0 ; done

These tests may be artificial and trivial, but the speedup matters to us because we have more than one bus master and the embedded controller needs to poll multiple sensors.

Tested-by: Andrew Cooks <andrew.cooks@opengear.com>
