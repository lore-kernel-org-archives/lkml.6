Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+irSK8JZbx21vjSmBdK6mCbUtM3tnQU7TGUtYFvmA1tsgOfhFs3UZgOvaP59+GRHRclQ44
ARC-Seal: i=1; a=rsa-sha256; t=1523541898; cv=none;
        d=google.com; s=arc-20160816;
        b=gPHeT4uqjzBUuWQGdxmVF5+WrQySYlEaTq3AsJMDpVNAx8S6QYWtSG4CpU5jl9rX7f
         gwN7KfNmExE3Qmz8s7L491Uwt+AD5Ye+iqueY/uTSsRDxxNQO4+GW5hZaLH76dSoS+b5
         wDYBhkWjzWfBSxFsAGgrxwTAIJ+ATLBwX3hO4NrNW+fUL7PI4B1LFPQ7WTOyPXMRoAwV
         kZ3R6UVma/F7zdm0y8BsQT9vh4OFJOaWmoLMxou9gXDDllInp3cbwPr/u98OlowLc2IW
         ACLv/s81KqHpmDVGJuXqzaUZ7tOCqREGZqVa8/HlC4kImqKXB6gvvzcKp/Ct0WTGEZhY
         xUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=4SWKGeym02iQk70xqGNQK+A9mtNBSDaXWHpfKPDRbrs=;
        b=AMNX1DbYu/spYdGeHfUMG9YLYAcWDfhkRxkkvEBXnydjR6kDU9/RMmAp5zYtAdolVZ
         CL336opaiwNXrUhtCsM4pHUyBOnqw6r75G+rXtfyVcgbKBlgg+o51nGpYMvlcueP6GsM
         hp5Fw31QLo/HXfl+qHpJDkmmNkMIyQYhEX4/o7Hl+xRGd8e6J/a1KD1yPeAuj/93Qghb
         ZgNtsDNyYCQs2lfLXzdiV73zcJ0IdkuFM269b6qwVB7bSLhTbgHpDgt2BQfJjFVlIZ4Z
         LXLW+U+s181gqHqmaQrPDR68e1Ua7IRi3zT4Iux3pGZNgE/Ghqhvo6vrkZUeKHXoUWEk
         kz6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=OiYXOppM;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.138 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=OiYXOppM;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.138 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f944e87f-13b4-ccef-edf9-6283b6dd67a7@axentia.se>
Date: Thu, 12 Apr 2018 16:04:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0194.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::18) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:ihSYoYCC/rPgKMizUqMctSv2goZliEHYqI4p4fIyJpda35AFSn26mCQRxTj/s1eFEFIE6ZF/dU3vUADN9v4+NW3bMw9cg94ICNMzMe1HJfgS/sSPht+l9L3rEJ3jSHFmMN8oNXUKF5hxFwM2IqUuTDeHuRdjv9HmCAfwTfVEgbH3hBSjaOoJg7Z2yQBes23Di5bl7VRPLjM9IcJuRkEDAQajh5zwBwXtgQms7TNuIXa0VURa9eCLylwrfwIVm1lt;25:21F22xZtOWiQboR5yBUSF31UrAAANpGSjJPG8EWP4QQP2yvLmFny5EIcvZZwyM5bre/1nHQ44U04n6UhOcuq34M9bsakyn8e7fZCKbyzMuCrO0Yijs3T0E9CoBp8CHDxd3xBnpsLgAQ5MQs1hKVvalJ0G7z8JKBKn0RnhBvJSIxRL6G5avyPyqSQCbTlMUp0BBdN92at6hVIqUsRVOC2P1uDl5pWJjL9pKOnjzltaby4Rmgu+Qrzn0RChZNwfWfyjDRGMxykppchiq6cganNRUqYP93ZkVWP8lPsG2VYXvci0SuZmpmuB5FvYQ2EUbBGWbQzxnVDbJ6i3Qr7i9avcA==;31:X/9qsTP5XzO05e4gfCE0OjOyMnUFK3xMGmoM7zMDhihtRPX2CojJAcUATc3tpa/VQE65jPe/9JY9bh2MHm9qkqPaeS59sqgpJ0Yh50simUZFG/ol7dEvqErcT5oY9/gOzAuAbMfOfK7AuOqPQL5la1z3cOujWaYLlLbZl61NUZe45mBZRMBImZaVFsAXPQarMSphUNB/8xAcR2qy81FhjiGAqN6QHUpm1SW6WisyiQE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27753349B227E13F896FBA5EBCBC0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:fliih5iVI3SJAK2UpP10lhEep4Q6n43hAfKPDDpW8paOzoujHgIwkXxfF4p1rV2rN5njw5DjpKEGo40tSWWUzkVSx7FwXgTlvK2GhGMEBhsgHcKaGBy4YT3tUWCMLlBTtgngVZP1WDRdYst/GCVbihCQoT1P6W+gwzvkBk/AbPveorTlmg6dRAjJ5YEXf5BYOjLCw6UdsS8QBpVGYyfndpEmCUD+4VyQNg2kdl+f/GSe7aJHphP47eZpmVVAEm/wrxj8TEHTEWWuMBC1alHWcA==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(39380400002)(396003)(376002)(366004)(189003)(199004)(377424004)(229853002)(93886005)(31686004)(54906003)(50466002)(6116002)(6666003)(316002)(58126008)(16576012)(6246003)(64126003)(105586002)(230700001)(97736004)(39060400002)(53936002)(31696002)(6486002)(4326008)(8666007)(106356001)(25786009)(47776003)(3260700006)(65806001)(65956001)(66066001)(2486003)(74482002)(446003)(59450400001)(53546011)(2906002)(386003)(26005)(186003)(76176011)(77096007)(86362001)(23676004)(3846002)(16526019)(478600001)(52146003)(36916002)(305945005)(81156014)(7416002)(36756003)(8936002)(65826007)(11346002)(81166006)(5660300001)(476003)(8676002)(956004)(117156002)(2616005)(52116002)(68736007)(486006)(7736002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6ZmtZejdwR0FtM2cyZ0tkQlJ3UUhYakI3?=
 =?utf-8?B?ZHlWZEY3RHFVRmdHNEM0TmJiZSsyZmNEQnhPemtQZURmNW1Fd0ZzWUhNN3pt?=
 =?utf-8?B?L0Q4OWZGZGFtaGFaazY3SlJXVVpCbHNzMkJTUlhDQWQ0YXI0c1lDQjBURThw?=
 =?utf-8?B?MTBJeHNYQkNSWEdRNHBGa01mclNWZEs3cDd0YllLYVg2MlVCOE8va3Rla1Fv?=
 =?utf-8?B?Q0hZZHBPZlBLb1NQZHpOTlNHa1pxVlRlbXlneVgzSXBJY2RPc3BsTVpnSDE5?=
 =?utf-8?B?Z0VqaFl4WGpJZTVab3pHcXR3Qm9xVnpheHp2WEJPMTNuZ3hpYkFyazFJRUNa?=
 =?utf-8?B?TkgzYlVNQTJ5THhpSTNaMzd0SThFRUNTUkI5eGdXWStwQ3hPZjNxdENGQkVV?=
 =?utf-8?B?NWM0QXVuMHFPUHdYVWpvMm1SYkhLWlJDRW5rUm1jdjZEUWtSSThTYUMwVUVq?=
 =?utf-8?B?YzMwUndld2pRTFE5UjdqcFJPYjA4QXFEZjROTXQxV2JidlA3Zm9oTjdXaUNL?=
 =?utf-8?B?NUdZLzYvU2FXZ1dIbndtbWlsS2I4YXBKS21sY1FaalNzU0FFVW0vZjZBdGVz?=
 =?utf-8?B?VGFwMHdnSVR6bmk3a2JpS3RpSVhMVHNla1l1bmNHZ29uK1FQNU1sQ0ZHV2hP?=
 =?utf-8?B?RVh0dW80VkJaQmpFVVg1eERBems3Z0hreFNZc3dhOW9RVHRPT0w0cnA3Vm5J?=
 =?utf-8?B?R0dkQzRnUDBFRVNRUE1zd1lxTytpSkttYVYvV0JSbTUzMitQUTEwUVU2bWlX?=
 =?utf-8?B?Z1hkUSt0ZlVZZ0ZxNmFGOHpYMlFJYW5ueCtUZG1kaXlrZTV6d2doSWZ6K2xJ?=
 =?utf-8?B?R21FSXJpL0tYekc0S0kvUGRkVXZzaS9sckdNS2Y5Wkp1QkpwTUpCeTk1Si90?=
 =?utf-8?B?OFNEbkJuenBmMmVmRTNZL214ajk0QWloZU9hL0NUdFVkbzlKYkVlSGFSbjdV?=
 =?utf-8?B?WTRtZytydEsyNTJuZHNlL2lNSUwwZjJwM2RoNk5ZRGl0WmgwTlQyc2tGWlJO?=
 =?utf-8?B?Nm5NaFJQOEF6alNQdkRYQWN4VC9UR3lUaHVXcUdoV1hrcnI2VlA3MnMrVGFE?=
 =?utf-8?B?WldLeU90SWJmVWVrbWJoQWIraWhDNWwwb2FXaWFOS1AvRVhhSkFlSjNPVnNz?=
 =?utf-8?B?b21DK1JmaUl2Q0VldVI3UUR4bG55UVI1UXNZLzZzbnZoR3hQeEVzVjFiblU5?=
 =?utf-8?B?VWlqL3FOV1ZTeUJ4R2Q5OTloNFQwbTRLaEh5emdQdXh0bEg0Y3RIdEV5WWpw?=
 =?utf-8?B?VEJPKzhwd2hxY2M0RFVuOTBlR1FleGJJSTllc2dBdjVlTTlJL3NsaWZXQ0Ri?=
 =?utf-8?B?dTRYRVlHa3E3ZVNxM3BObHF5cGVxQU9tZjFkUVNYS1Z3N1RWV1NKTmI5YnlT?=
 =?utf-8?B?YnB4aUwzb0JGK0JGRVRSOU9TVWtGYVBHeGhFcVd1d2xjeDc0a2JESW0rNTVJ?=
 =?utf-8?B?RGptcjk3Nlg5bEYyUFUvQlZhTi9BZ1JTSzBhMXd6VnBMOE1NOXpQY3M5K0x1?=
 =?utf-8?B?VmVFVzhWYXlqd251Tm81ZTJWT2tMRU8wQ0VjSko0a2N5dnd5Q1FtZVc3a2NR?=
 =?utf-8?B?V0lSOFJCVUlKSVh0Wk9GcEFKamtWdytXYW93akVTNjk1c2RRdCtodTdLOHd4?=
 =?utf-8?B?TFRUUUIwc294cHh5aDl1dWVPT0tNbFhQNlJvVHpTZjJXVEZGUUJVeTFCaEFj?=
 =?utf-8?B?bkNvT28vWDNJSUlkTEZoMDc4NHdvM2Q4UE1VdnBOZldNbDcrN29BY0FtM0o5?=
 =?utf-8?B?Tk5nczJzcXo4UCtxTmJ3YWJsc0NkMEozQitJV2ZUbVdpQUp1YVNYSXNYOUda?=
 =?utf-8?B?azZ3aVlaSUlBRStCSEFOQVV3d25vdjF4eVZ3WS9PVmFtMlFGVHFvYWtpMzBu?=
 =?utf-8?B?NW45MFNocm9CN0FtZlRYbjQrRXNNZlorQnlrbXY1U3kyQUFXcDF1T2Z3VitT?=
 =?utf-8?B?Zk1XZjhCVzkrQ21nS1N1dEh4SUU1UU9kSmRjV3FXM2xZMHQxUk90c3g4dWs0?=
 =?utf-8?B?Yk4xV25yWTJETXE3ZnhmUkxnQmZXd3M1WTFlbTZNbmo5R0RIMXFEd0tQRUxm?=
 =?utf-8?B?dkVIaGpNTTF0YTRZYTBuNlpGMkY1SERDZmpOdllwbmNkZDRGYjVLQkY4OGZW?=
 =?utf-8?B?cDZ4cHIzT2d0b2pBS0VmdG14UVRTVnB5NENXZFZEQkU1Vm1xQ0dWemFqSkYx?=
 =?utf-8?B?KzhJcjcxeG5aaWxkY3ZzbTZzQmhhN0UvWGtqbXRqbUMvWnIra3U1S0hCdCta?=
 =?utf-8?B?VVpZdHNXZEd0WjFCWktUc2ZMOEtIRUZwZ2NDZFFqUkNBNzhkZjRLNUZnPT0=?=
X-Microsoft-Antispam-Message-Info: x+N3PL14RCT0rE5q3zoSAm5SNnY1f6oBmQmkygq9vlxSa4VHj6OACENZw/DV0bIvJtVMlbVXMV8B6K7/4p1DKyPn11tPAx31o0WEpD/U78tcqxv8OPshqgErgpGqwKdDtzdhxPfAituIs5FlboVoGSxcOHA+AYWThs1N+a2AypOIbP7lGiaGVLZyHWiVh/1r
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:t2kMdBMK3O8349lCl9P0i3RT+81OS6ACscyH4ScYrGxjItDLnZswhSHEWp4f2mAm+X99r16og378QTKKPGIdyvVMw/gkHkoP6mn/lMde4YP7usDJgs2RcIkqVZXCZ0nr7cOsRu4BPn+XmQXK1VctjVC5Mzx0J/z6aSqIC2bOH/+B2zDTtaE6iXJYPQ2XFQdhlOKjMmIKPyXYfxNlGJI0LdXg5S+GWAbZ84HW4X0jif34EzouBNqH3tirZB3C8Sjm/O/D+Tl+VdPoa0jVt0C9ilU1nArYrlOrQpFoCWEDRtmeMo5cYD7k4P/UfU9mADsRc+bdeZZZzP2o1oibWolMifQUY5nKkBaRwn9lCsU89BGNpdPZY8szhc6DPt+kE7EHG+XUG+COBQlqOPYj/ZYhMz65xytXGI7xCBGRMRrXQSZaCCPXZ4GqYWNI+DNcZTlSPCiMzVQ04w1dAxB3jV0wew==;5:mIpf+a42Eu0aiQNrf554/HzZ4s2ViLCcay/gThG9jTjlfLOGzE0Mn3+zneB6DNj70DmLm1rdEr+1wWG4CmXNh+NjpgjnuGiPgFUhMVLH21eqK+P3PVKmA7fmus02Su65WTxPrt0bLRiY3NNWFyN947tNo8pBinOrCFEKMlYIfAU=;24:qFIhz1VUt7qd9MPmY0NPzC6V2hR8UM83wPDbp3dwTE3dQWs0+81m1zshZuJ9fB2JCp8qbWKErry+GezCHPgbjz8xiJjvhhev84g8yoyDfhE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:jcRajJxU9KyGfvniEzAQcIuM9mcMTr7sN34v7ugr3gNjleLhglvf5xR1pjHNGA82gTLG0lsXMS+Wx3zPRTWaGfZ32brMH/J0yRUJQOvqR7MESDixghNwLHadYeeak4zZWjqPZdWIwxIcX7czYN2Xzz+t9y0A2w+kMeptG1KZwA5eO3a3c/79DJP0ahji1lM5RxxvzIQGg5sxKNTfPiEF9mY0INioLLtz/6RwxTOy3OHHHPTXOavtg3ZzIUMIee2N
X-MS-Office365-Filtering-Correlation-Id: c0a3d286-3b10-4298-16e3-08d5a07e5c47
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:04:50.0560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a3d286-3b10-4298-16e3-08d5a07e5c47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597549469909074134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-11 17:43, Andrew F. Davis wrote:
> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>> This is a current sense amplifier from Analog Devices.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/iio/afe/Kconfig              |  3 +-
>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>> index 642ce4eb12a6..0e10fe8f459a 100644
>> --- a/drivers/iio/afe/Kconfig
>> +++ b/drivers/iio/afe/Kconfig
>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>  	depends on OF || COMPILE_TEST
>>  	help
>>  	  Say yes here to build support for the IIO unit converter
>> -	  that handles voltage dividers and current sense shunts.
>> +	  that handles voltage dividers, current sense shunts and
>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
> 
> Could work better to split these out into separate drivers. Maybe a
> iio-shunt-resistor.c that does just voltage->current with the
> appropriate scaling. Then make a a separate lt6106.c.
> 
> "iio-unit-converter.c" isn't really doing what it says it is, it is not
> a generic "unit converter" like one would assume. Having the driver name
> describe what kind of device it physically represents will be better
> when more complex AFEs show up that, for instance, have programmable
> gains and need a larger driver.

If an AFE needs programming etc, then it is definitely an option to
write a specific driver for it. It was never my intention to cover
all AFEs in this one driver, only those that make sense. Presumably
that ends up being those doing linear scaling and perhaps requiring
a change of the iio channel type.

Cheers,
Peter
