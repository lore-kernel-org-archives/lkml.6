Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/2ZobPqpUE8xxUMxMJXNm5E6TtLnu0vdA7+YzqMujEzwHH5CrmDeLOfyU95E+TDaLW0fRx
ARC-Seal: i=1; a=rsa-sha256; t=1523863033; cv=none;
        d=google.com; s=arc-20160816;
        b=pMShSqgT6s+/XN92CdZ+3Pidbxmq4F7+NC8IlC8M+jZEU06YF0GbNwp2aPn3H06NPP
         wuC1PpYtCyoZGE37I4LPeaIljRbcc4545XD8n7YDWEFXbksJHt2PYY4mT8p4sq84beUn
         lUD9IM2WXVMJL8zp3BYnb1QI+aFgx8K3llCRSMv8P+X+iECQFLVcQHd5PFLEVf1oeY45
         rmBVLgxaO9/MsztmDywfBGhodXxgAYqCoq4stdTSFaWE4opQhTWQMEKCXkdBjbR0tvEu
         WFeQUZshIyAyGP/fQHeH2SrymnWhFRL2VvoHaBsAQKCNRYernN9R2VKmq4nL8znueCdE
         +58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=SaLiLaiNXE50t7TMNlGWOn2lJp62i6HJCbaZ4M6Xzpc=;
        b=Prw1IvZ90DiM2J+yjJAVEc+R36c7yjZxxa0avjIEBepQwxZqTQ+iRIq4yu794jLYPf
         CQwNnrQf/KxE820MQYWdhJIgstmNRPLmGU+8BYBGySoVCqw/9I9xDDeSUw4oJZiBnyjM
         rh37amjam9I6QqommEGfCw1yIzGLM6R7y6zbpeTJqU4Dd6LDDvzjQppXcnBCX4MSG+WB
         anePSXAzItMS9YBtcxkQHBN+scLHpSzSdqPF/C3V1cwU6rJRja+C4gMB8xLO+e8Lv/yj
         JDf+G3gElJOO6DLIKvyOolJ/BUwlUva2qbScmAAxdsZ4osu0QQVk64hK5UIYuDQtB4Xd
         Qjww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=J7wWp409;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.110 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=J7wWp409;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.110 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
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
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
 <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
 <d59697bb-60bf-deee-65b5-c552c59e8d5a@ti.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <30bf0000-acc0-7d06-2870-74b3c559c707@axentia.se>
Date: Mon, 16 Apr 2018 09:17:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d59697bb-60bf-deee-65b5-c552c59e8d5a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0314.eurprd05.prod.outlook.com
 (2603:10a6:7:93::45) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:YOOfyXiQVXq4zbWgBxrSrYOFAFvkC3nzgYJprHKjebXz5PXgMB3zDhI17L9/vZvENjO9lXxtd5J3qfix0iX/aimWD1CuxRlNUgd/T0oPWy9xRM2HT9b8g+l1QQIzMHnI+SEqQAPLIu3drwxLGYETtXIQQI5JFPTou93MH8kEnfsdIbHt/bFJDk3Pwj7bJ0IUwQOvgXCoElrj5kAY+7ezYX2nXNtnLN4cAaTFVphm2BQG9VW4MOY8t51RPiLoUZta;25:MRpP1gDoEbA2c/MgsFPNyRZrPKREvyW+e8Wh8TlJtI02VX01ZCLkI4rBMo+6eaZkbL5qu60ofr/q2VRJ7S06SFZGzq3N3l8PyW/rIr0uT+Yx+vUbarAXaHB5vXWunfO+Q7BQsoCiCCyz2QpyIwSnKol6Ipv79a3mYJVKPh9OWrnMNk8NYfP2FTbqSYIHhjqtWdCbilQfo88Nu12LElNuQBfVsNz18YY0/a0q5hTY6aguVLZW1utupyYImmoWbgcfscyfRwzO1h4GRdpWj8oqPpX/ivyo86uhp47YpyJBZRU0YVXNKiOYlmtFP83MTMEO0cW5UOdt8kn46wN51emX2w==;31:nMFf6Tz/hwPz3/szdMQyf5n34mjUGqbE2kI2t+QRDuTDVreK1UQ1VgC2KSwHJYI5g38MWL1g5maCdkZV3MOxWQ4N7hfOKTK9U+m7lMTM9+r7l+qXYS3hK2ouIfg+PCKvKmzEcnkt9gV2s028kJPJh2G4QRqScJR2VXR8KyFwwcpfo3QCRcoO3C/CIp99eLt41MJKsEnStDPSa6ZOzD5iJfFtfcTpE7Tz5bTqKMoAnmQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27694A47D845EC34C8CB628EBCB00@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:RgBf/fE9AqCKCnn0N0DXl6Gzcg349Kx0QhcSmL+eQrgSU9W8N4Odw9uz1TWiLFBShDIoOUCpHNIr5hLcwhkMK9cEGgv59fOsMFXbSqbcNm3v1dzj4EVIQqzcXIEDhEPpqA0/H21naTwMwE+NKpcFin+so6nsx6TSpAPPdd2ZIkX81o0xY3XdEb4Xd0JtqmegrnIWCNtECBqQ2y5vmhy4blD7CnabafQ93y9v56gAgJAl0WMKOBwfkKcQLLupaGDnd6s8YYSobuagEMIPH9d8Tg==
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(376002)(366004)(39380400002)(346002)(396003)(377424004)(199004)(189003)(105586002)(53546011)(81166006)(31686004)(7416002)(5660300001)(36756003)(3260700006)(31696002)(25786009)(117156002)(305945005)(7736002)(106356001)(478600001)(76176011)(77096007)(486006)(16526019)(65956001)(66066001)(47776003)(65806001)(52116002)(229853002)(2486003)(186003)(52146003)(11346002)(6486002)(65826007)(97736004)(26005)(2906002)(6666003)(59450400001)(386003)(23676004)(74482002)(53936002)(8936002)(36916002)(64126003)(476003)(316002)(8676002)(446003)(8666007)(2616005)(16576012)(956004)(6116002)(50466002)(230700001)(93886005)(54906003)(81156014)(58126008)(4326008)(68736007)(110136005)(39060400002)(3846002)(86362001)(6246003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3Njk7MjM6QWtIbVN1V3hJOWI4MlUrRHBkWmp3VXF0?=
 =?utf-8?B?MEd5OWFSb2FPZ3ZaaDNwREphVE9oekFLVlh3S20xampmSnVUaDRHdTBJR2Z3?=
 =?utf-8?B?KysyNEFoaE91a0NOQ0pVSlI5dDRTQ1JUcHllTjI3R2RoL0IwWkxxN29uL293?=
 =?utf-8?B?TXE4Ui90WVY1WWZUQ2NYbFFubXFtRmVBL1k4Vm5GSFoyU0VyM3ZCMWhyVldW?=
 =?utf-8?B?WlRUR3R3SFVxMWxCRW9vMUtOQS95aGFUT05XRStacmtQVVpVM1pBa2xMOTlD?=
 =?utf-8?B?cWZHZFFJci82SGFydTNYd3JqMHlXVVZ4VUpWVVN0a3hieEpiT0o0RXVMZTVi?=
 =?utf-8?B?aDNqbGIwYWF6SkhMekc4YTRGRTJ2UmNwdDFLY1N4MTdaVEdZWndQdU40eGt2?=
 =?utf-8?B?M01xd1pObExteTAyT203Z1hTaGFZNzFuSlBuQ2RRWExUUHREeDB0OWZFbld2?=
 =?utf-8?B?UXVlZ2R3NEJZR3lMVWJOdGE4a2VBcnQrVi8yZnJmOVdPSjZFNmVTdXlMV1Qy?=
 =?utf-8?B?UDNKUWpuOGpVS0JBVFkyanhFS3pUOHhzRFdwMGFBaUJzdk9laEE5Ung2WFU2?=
 =?utf-8?B?cWJlT0N2TFl2RDJaOEd6ejE3VFNSVlFUb1pJOUR3NXExbTlKOGMxelUzdmVJ?=
 =?utf-8?B?UEZhWFkrN2M5MGFMbTZCSWhDUDdsZm9Wd3pMM2FkMTlWNkhRZC91WXFubFJo?=
 =?utf-8?B?cjgxMHluMTBIcVlMRVY1VU9MWGNNc2I1cTg0Q21QdVRMTjk4ZjRxSDRYMG5l?=
 =?utf-8?B?cTE3SUo3V1U4WUlicWgxS1ZWN1VYMWVUR3ZkWEEra0xkanhOeW5IM2p1bTN5?=
 =?utf-8?B?SUNlUVNKQ2ZaMndFc3ZRT2pmZFNHKzcxMkZpak5kZGt4U3ZwZWlqMFR2VlBt?=
 =?utf-8?B?R1lIWnRVY20wYTgwK01lWlN6Z00xaGNRR0RGayt1c0dSUGFpN1h1amxKbTF3?=
 =?utf-8?B?YmN4b0duc2xaRnptdjFBakpYcWN6Y1R4NGYrSDJ4R1FjRlhwa2tVT29hWUhy?=
 =?utf-8?B?OXBRM1Z4L1lQdXJHNzhLWitlZXRlcm1qeUJkeHp4TEF2OXNuekhOb05rNUtK?=
 =?utf-8?B?ZzNvL0JTcGx4cDdKcXpEdUdVWTNsdVAvK2VoMmRUczAzb0hLWGkrOEw4Q2s4?=
 =?utf-8?B?TzBOenJjU2tKMzZYRWZ4ck1STllaV09QbmNaNXVqWTFOM3pMdUcrWWpKZDhr?=
 =?utf-8?B?b2M2ME5uOW1VdUhiOUkyNzdjUXJWcitjU0FNN1VTVmxZeVQ5dHlpT2ZxTkFj?=
 =?utf-8?B?T3BHN085c0JBUlVaNHR4OENMN0N6Wk1Yci83RlhqUHJXNEVYMER4VE9kTW85?=
 =?utf-8?B?TjRUcncxSjRTbTEwMkRURmVOdGc3MWV2MnYxcUZyZERRZ0xVc29aSGMxZXBR?=
 =?utf-8?B?ZUVtZFVoMFZUWUl3N1RCd29NNFhmL0xRZ3VMalNVQUJhWGJhK2RnZk9pWnYw?=
 =?utf-8?B?ZDAvbXJaMzdBc29xQVkrek1zUEJZT08waHNYRnliSFNPc3RJZnpXZlVBWVJ3?=
 =?utf-8?B?ekF4L1oxbiswV0QvdTd6OW5nWm5vT1RWWGE5eEVoTWNLRXhHZHd1QUJIUjFR?=
 =?utf-8?B?RDBEN0ZaN05hM2hIc2FKYnp1eTdWKzhSUTBOVVk2YlpqN1ROejk2clQ3b0Jk?=
 =?utf-8?B?dzB2ckl1NStKSjJFM1ErVDhnTWpVWFk0YXVJTmIzTVhZZkVDZjNiTUlOdDlh?=
 =?utf-8?B?RWVjZEFEZmxqekF2d1ZzV3dDbW8xS2srRTNreUtzTXNic3ZGaGE1dW9ZTkt0?=
 =?utf-8?B?STZ0YlNPR3ZSd2xmK1lwaDhmSTgza0hEQVVlbWg2SGV0UTcxS0Y3eVBpY05H?=
 =?utf-8?B?cHB4OE5yVjlmanJGTTlodEdiYlBtSGxYcnU4Y2tIeEFGcHpHUDJoMEQrVkV3?=
 =?utf-8?B?RmlkWkF3enRkZzZxUmVlc0l6RVRLWGtHNXpaUkVRU1U4RFNuZHBIQW5pR1Ey?=
 =?utf-8?B?R1NwQTR5bURyb3QxbVFkTERHWDdmRVJhdmNLeTVzUUh1NHRqVjg5ZFBkaS8v?=
 =?utf-8?B?NmJVVjJOWURmUFlOdUxnVWJwNWQraUdOYmlESVd0K1BwZmo4SytYVHVSTVdY?=
 =?utf-8?B?Q1JiK3BwcHhVMTA2TjM2T2MyN1pXMEpSRFd0RlEyOHEycXJSSkJuRXorZTcx?=
 =?utf-8?B?VXRybzhxVGZKQXFRdDIxTm1GdFU3ektEZW5CVE1kRFpmeGNseC8rVUc3N0JK?=
 =?utf-8?B?VkZWTFpmRWxFT1dQY0VaL0FXSjZCNmRURzJUU25RL0VBb2t2cXJVWkhPTlcy?=
 =?utf-8?B?KzBOTHhkUGxyNXhEK2NyY2pSSnZmNTVJOUx5SFl6R1lSOGNoSVBVODNjSHpF?=
 =?utf-8?Q?+GcvttZWlP+KnwWtww=3D?=
X-Microsoft-Antispam-Message-Info: pC6aM8NxN13eBf1rxqKZRHuB2C5fJoxNUWMHW0TQ0d16Tz/Lr47q17brDgVpOn6/bZrVz8lpnvdE7zBpdsuD9nxfBdf1gSiLQxwfEOKNGwj1olk31+BfKDXhmOaEGrPxl3X+YPF94TdheqoPMK9Sie6aMVLJrmR0zWb5s8QIBTJjSqsMfUAJr+F4/oNG62hl
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:Xy38MZGzTGmFh2piK43OACAAOyksjsEyXrZWjh5KGjQi9K6PJT/v9h+QS/jHEauORbhyXi1JPvWXZ7W8VNlV1IonKdLF4QL0+pY25kWruCkdbZ8rHcBV/BAnX4vrAqzn5cWAwxlIh8LN6nDR5DWYMg+gZwiqkO4FOpmVfnhz0I0laZimvN+Jy55mRW84+gfpitPZYdOY05OSLMHgX1vU7gQr2O5u4YSu7SOxfzR4BYQ6y7f672zCa9dx6djx6AsuXI7Hq/vmyrYeg6C349XQDoQnGqSmEcITqeLW4m/kOvej32jiEQBGkJWO70yjz0PZV2NqyUTJnkCBGfhmGzOM/3sab/SbI1BJbCly4JalHbgr91W9P7ODQAfHIfELa6PNqyIVmulwVAXe0Wol/h5DqvB2+3pUmVRMBB6BX+6ciZNUJdGoRptOGIp41/duZav363BShyqNl1MV6gMeqbg0zQ==;5:d1lC8YdeAVB9tellvnKqI/YEEWIgK1zuruY4STDeMyrp6KcxL+J3T1GULg8oGYpolw/W7SyhEO6KSDho0B+QIlSB5QMmGdaJxOYNw5J2ZviB/kL8Gnns3yNfAxjEE6wZmFWpjHDSLJ639/yF/HZXOAkitnR3n87z4q4EZXWPRoM=;24:G6GGa6qUml5hSf/pxqyauKhzjidALKvnWtX0SczpTakzSqznOOemYuNsXTnyljHW9o75298PQp9aw8ofhhVEL6QqNi5FEyGdi1MO5LtqgBQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:bjpNpbk/sskCCEy+dMviQXEAxBdVJYMiuTwh2b1Ox4IwQGJleZQ9xcndGbMXAQAs7IDM9/rUhLpS1g+TH+UfD0+2A7g6+Rh/cTIoYihjkoeKDkWov1bs0l4KKyoO1XPhZIG4kFqE+eiJzqYJ5qLMP30P+dOnWmoZ1l8OrdX/zTkYAezKeKn9yQ/Fpf0KG/Gfg+k3SgHj+s3lhJmSPBPgWMApRJOomGkKFOrVKpV8UkGBjlD2RT9S339u0ac7rAC/
X-MS-Office365-Filtering-Correlation-Id: 337af0f0-405d-4527-40d3-08d5a36a10ea
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 07:17:07.2458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337af0f0-405d-4527-40d3-08d5a36a10ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597886203799134133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-13 16:47, Andrew F. Davis wrote:
> On 04/12/2018 05:31 PM, Peter Rosin wrote:
>> On 2018-04-12 17:35, Andrew F. Davis wrote:
>>> True, how about "current-sense-from-voltage" ?
>>
>> Doesn't cover "voltage-divider" (and we don't need separate drivers
>> doing the exact same calculations, that's a maintenance nightmare).
> 
> The driver name doesn't have to cover every use, just more than the
> other name.

I also find current-sense-from-voltage unwieldy. It's simply too long.

Cheers,
Peter
