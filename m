Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeDKJ4h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:56:37 -0400
Received: from mail-eopbgr40132.outbound.protection.outlook.com ([40.107.4.132]:61630
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751889AbeDKJ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:56:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to
 at24_driver
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180410131206.25760-1-brgl@bgdev.pl>
 <20180410131206.25760-2-brgl@bgdev.pl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
Date: Wed, 11 Apr 2018 11:56:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410131206.25760-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::34) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:JlMl/mcPFe7u1UzEZ2iRiZtK4yBnyOrHt+zPXNhxSxSlaSt5jv0TcrqVOxf6OrgHVpciHgjfpbdnuJPe/jVLDzhkI0EaKLJQ/+pbuKhhHZ6ji8oAoSoSTup5WnWrAgiTtVbG6qCq1jRXZQTsjf2xsZ/j2wpJrwiEVecx5cuzacW3xHPwuogQW8yzZm9zbkX7bRVBgVD1PkOuV+k3G9LytbAzWXjQ9XaruudrAdgJSm748g7+YWD1oYCjqaFXIDfd;25:tyo6RRhSDrjlQCfXEDrvZQbG70kar08QEGLIw+OouWxI3o0ocZEh7JfJPbSFatCQPxLdAshm0UnbqW06tABwaprD1Z09OTDzV8A2hCWsLe7Mn+Wi6LAWc14oq6UsLj6+0HFPkAKHfs0ye72doZwJ1UpOKwgtIX8MvKat0gk0dys3amkQhyDy6S/aPzvcySDVZMhSrSB+vWTPKF59sZpgdnkLZiKc+IIAe8Dd9IA8sfPihyDzDkppllo1E5YO/p6gDD6JpWBD56t18DBIYOgcncvq7w450OjrCbaMwLvN4eNRseUYUsy8ywRQQvVEgzODrOdyMRLh9YPiddKwfYKDGA==;31:cL8vlBnU6iwIo0v4UbUVBDnnAE8A92SGszpYYSe1wPrcdi1pj/tSybGKT3zk+wEibyp8mdGThY6z/0PRTEGfEV3PEISF+UYKhaZYw0GQTbT2IP3tu1qXrE7jee9YVgLNSaVyXJdWitu34phz2t9zChGs8ytcVsZgvrTVzOt9AWxMfLBcrQAcyEpPpyGjGAw01oJBHjLaMdDmnPK+FUskKGAtLdWHH6QN1bk23Ih4BB8=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779F44FA8B8C7C730779A09BCBD0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:2L/hczKqjtgxeu+A5jLtFAYCHbisH9MzDOSN+CHRXj/fsV8rfnCg1U6S254Dl0Iu1VwWfdPs4xfGz8NlOiJy/xj200BT2KmpC2PNzRat89U5cY1u7OY5l2gvNmveQToet8H6KbyZ7ifRDE3wiXTIKYm/ZZjJkbg4v6rfwD/Nbgq5eqgPdCIWAnjx27igQbTRcJKP1XzLK4KzkHlKKybp4KRNcebJUfrRcwS0ll38aSf1TJzupIzWJhr7K5PWyRmJ7U2dTnWrucJZv8BeIoGJsg==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(346002)(366004)(376002)(39380400002)(396003)(199004)(189003)(377424004)(3846002)(52146003)(66066001)(23676004)(81166006)(81156014)(305945005)(58126008)(52116002)(47776003)(2486003)(36916002)(16576012)(316002)(105586002)(106356001)(8676002)(6246003)(39060400002)(36756003)(68736007)(86362001)(110136005)(7736002)(8936002)(486006)(31696002)(97736004)(4326008)(956004)(25786009)(3260700006)(478600001)(31686004)(446003)(11346002)(386003)(2906002)(53936002)(74482002)(65826007)(2616005)(59450400001)(117156002)(76176011)(53546011)(476003)(65806001)(5660300001)(65956001)(16526019)(186003)(64126003)(229853002)(77096007)(50466002)(230700001)(6116002)(26005)(6486002)(6666003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzk7MjM6WUdhclJXY2UvbXlCVUh5dkJxRGZhZHA4?=
 =?utf-8?B?UW05U0dUd2lhK1NDVHhEU2ViYXdoNXNLZkZJZnl0ejlNQ3JDaG5sMm01SWpq?=
 =?utf-8?B?cUE2aUo5UzRYdkQwYnBtdVgxODk0cnpSMXNxVHZQNVprbk9aa0R5c3dzdDlr?=
 =?utf-8?B?MmlBN04zYWxpa205T3BUVVA1NEFtNEUwcVZxbnM1RElBUENlNFdTMXE2eDRk?=
 =?utf-8?B?aGtaK1oyU3g0cTNZbXk0TmZVeEUzbmRReXI0dVlIbG9DRm15VzBHRVJ5a1RL?=
 =?utf-8?B?MUlDVVk4L1haU1h4U1JjTEQvYXpod3hLVDQxNUwvL3B5S3VHTjh2NXRweTJY?=
 =?utf-8?B?dWtZZjlBMmQzWTFlYUpSTW1nV1QxTlJUeG1PdEdkMVJZM3E2MmRleS9ueTk1?=
 =?utf-8?B?K1BhaEZYL1pJaFdJZjFZSDdBOHNNZ1FQdTNtMDh4Z2xTVUNZbU0vaFhwZDRV?=
 =?utf-8?B?clhHSFJubFhOWGliMWhVU0NBSVYrc2s1N2ZHV0pOSzVwV0VZeks5bis5Z1VW?=
 =?utf-8?B?RjhtMnZLdUtCeXA1L3pMZytRWWFBSnMyS2xQTHBQSWhCRUs5UXBWd0ZNSFBl?=
 =?utf-8?B?THlHbDB5MDg3MEt2OEl2dnd6M3RRZnl2OTR0Tm5yNW4rSzlKK3JyUlBFekdL?=
 =?utf-8?B?OERsVG4waEVZdlRIZnFzTG5ILzdaV1N2NEpwcUM1U2xHUDNBWXJiWTlRWlBZ?=
 =?utf-8?B?RVlvbFhjbVlTVEQ1RXFqUXB6TVNoNzhmckNCbkk4ODZ0NGZvOXNEc2s1MEpH?=
 =?utf-8?B?NHp5L1Mvdk1hNm5JZFB2dENEY1RtTytrWXFydmw5UGgyUU15QzMxWngveHVx?=
 =?utf-8?B?dmlLUUJWL2xhNDdXbndWVnBBajRDQ0l6dno3STJDNStaQW8wSllIOU41SjZP?=
 =?utf-8?B?MURIdmNScjdsWnJIUlN2Tld6d3FIZXZrQ2xxUkErWExpSVdtdEVBRDZvMkpX?=
 =?utf-8?B?YnVzOHVLNVhXT1ZyWDAvN0VheHlVT0Q5V2VWY1pndWt6YURMemZUZThDL0o4?=
 =?utf-8?B?OWVYSDY3Q3FJL1lDUGdmSG1Va2REK1pGb1lPRTA1QmFJMkVQeVMrWFU1MWd3?=
 =?utf-8?B?cEpHVnJ0K1hDODdkdk5VZm54N29uV2pTM29wWnFDd0Zvd1hkSlNpaVJNWGF0?=
 =?utf-8?B?NXBFVUhJOW5nVWdQNjN1RVA3V0U1Q29oa0E5dk9BcDV6N1QzVU9naTk5UVpl?=
 =?utf-8?B?aTYrbVI0eW54NkdhcVg2OUZnTWZtSHhjQ2t0RTRCUkFqRTZoeXR0VnJUd2JW?=
 =?utf-8?B?TjVnVk5uN1dKQlJNNVNhTUU1c0phQTI2NHJwRVdZOVV0ekEwV1Q2ZlNXREFx?=
 =?utf-8?B?cmFOU0wySUxlOWUweXBnZUhsWUo3Y0sxMHlMUWpLQTNJbU9xNFkwYjBkWEt1?=
 =?utf-8?B?TktGK1ZLTzFZeHhFR3Rka1lmcnhPNVdhU1RzZ1o4aGJYUjhTRDRCS0dYdHc5?=
 =?utf-8?B?T3JqL2ZIUDZ2a0dQWjl2L2dYaTduRklZMHVmZjBWWkRLRm54dnN4M1gyQVkz?=
 =?utf-8?B?SCs5L2lZSzdpcjA0UTc5QmpTc0dRNUlkcVl3MDc2VHV6M0VpNENBRWtGQ2x5?=
 =?utf-8?B?TGpPUXpwdjVEalRVd20yN2RBakQ0TlR2TnB3dWs3cXcxakNKTlg5eVlWV1FB?=
 =?utf-8?B?Q2hRWE1jcVorL0dMUmFpL0UzM3pxZCtZZUNnWjJmRzJqblZqcWdQb2c5QzFj?=
 =?utf-8?B?a1VBY2d5MjFwaFBpa3RobWtEZ3phRXlLOFdDMHVnOVRBdDF6aEdJcXNDeFFt?=
 =?utf-8?B?Y2I1bHoyQ3NXLysrTEVUT2g4N1M3OHFrNkxXREQ5WEZhamJDU0xSczFzcmRT?=
 =?utf-8?B?dXQvRlVkWTNKbm1ZV0JQdWxqT1dmWnZqQzFnSWIyTUw4eTRXOGFjSTBNRnJy?=
 =?utf-8?B?NVVVbDAra0FBS2dlV2dhTXluNUd2T2N0NURha2I2L1d4ZythM1FPb1NWc0xx?=
 =?utf-8?B?NUdlb0htbWdEdFVVUDlHU1FaRmhuYzVLTm5vMy9IVElYeVRLbUlFQ25EWFNJ?=
 =?utf-8?B?Wmtva1FyQ3prK1c5dXJUcW1uaGlsRE9LL2g0V09XZUxpY1c0bXJsKzczVTJK?=
 =?utf-8?B?dE9JdXRRTHRlQUpXNnM4MlpUb2xSZHV2RlBScThRQkgvcWN6YXgwVE5JcFhj?=
 =?utf-8?Q?ZoReWodRGeo32NOxDUx9wSTaN+g48PAutvn1NaxdfQXwUf?=
X-Microsoft-Antispam-Message-Info: vhNFv5PGOez/Scc6Y8qB720vTBF8rHYaHkfVTPbogA49wTlLEQkZmph3DCfq3xnGbqNgm3IyFtWLBravV9eKGN8j2y4FJmx/pf2ypBQCrjmsXZY7IfLznWtzKgNnV+mZ1xCZBITBxfmkmnb1T0K7kuQC2CZPnVJoLID13BwXxCPrgpaEk7fGGFyHDCO4MYHQ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:yTAhn2rtO10Aix0SUJHcAkwtvnaLbm1PsXZ5kR4tjcxpBAPuWotIq0/hWqh2VQEFB0Mb1/wL1arjI3Tc/VOYsfaVYukjr8pDiuxYcW6I2WU+pwNVJzt/oO2hSKYDxokzICH66dqZrCtUPbgRpS8cmHM7Pqyk2ehw3AYLoGxAePMXoVsAKflSPWlYtykDVQWCYs3Saccq0KknPdLqp2pDYWNEs32jA7cNSWJlIBUMdqndf+cWB4dLn2RwbubPAqpQ/uFm/wIBkbgcFMxX+CPqtwRrNTDOretuiNIVGUCfNl59rxxsnNN20JAYRlLpisWkD5PnHPqspEK0LmIgRhWJaNqAa9CugmG4QcHjUqE9cmqRnVCXP9PcGOMdQJ/7whhIds2uIgs+kNJtyG3H3R5Mdk1txANnCqkkln3HAUyg79ZRmheRlnpsqJt1puHd2Qy91eXl8qRr3NdiaBo3spwftA==;5:kFiYJa6d+byC3eNWrbBcI90s6lJfQVLQuovEJmNpxMNxZbcEtvY0xbv19lLr7zm7nVPIick0cf4kzRgPDy0qHsgCLn+1ovi6tOBGjotVXoJRfBIkLIlHYh69KRLbe25zcKhrfYuqh1P5AnASYYFhm2279Qg+jBj4R8YcBX25sdU=;24:YUen6Kgz3NPNnppaJ+YAh779yIlQ9Q6ANN+5f0ijdoZ1vNbGV5vTxMk3mSx0/vijI8XQt5frZi0vKKbpBCdPOQYUyMe5j8NW8FhD7q0hv3c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:7DneJrSkQd9HIegBjI6qPYQyCPWcRynFy8GOniCig4zyiddFYoKJQyBhfi/XN5LZh1Y6JfrE4T49SlMSIiQbAfuaPuCSk3YGLiXp6Ow9vzV5tXFxG1B7+BLmwdMFd0MDhEld3z66qQPi1cIHJwk2k4lw/Zp9GFTeQegQcCdNXdpELxEudBCKifetvkadIQA6knC2SewcXzHgCU9wKbnIoJ+5ekGbP7uKCil5X/N3jE1PGpecv1ylijcDFWZ/lHU+
X-MS-Office365-Filtering-Correlation-Id: 90e32a3f-dcf4-4293-b91a-08d59f928044
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 09:56:30.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e32a3f-dcf4-4293-b91a-08d59f928044
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 15:12, Bartosz Golaszewski wrote:
> We switched to using probe_new(), so this is no longer used
> by i2c core.

It seems to be used in i2c_device_match() ???

This could easily be me not understanding something...

Cheers,
Peter

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 0c125f207aea..2310f26ac4f3 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -737,7 +737,6 @@ static struct i2c_driver at24_driver = {
>  	},
>  	.probe_new = at24_probe,
>  	.remove = at24_remove,
> -	.id_table = at24_ids,
>  };
>  
>  static int __init at24_init(void)
> 
