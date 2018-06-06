Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mpgN6ikV"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99182607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFFLeI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:34:08 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:33408
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751536AbeFFLeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:34:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <CAEJqkgjfhmjwYo74xivsfgvoPQUFh2dFeXFwtEKoN+DXG1riMg@mail.gmail.com>
 <CAEJqkgiVdeBf9konX4OJi59dYp4y_b+J02ns=yf-D6tjtZ7P1g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <52eceaff-987d-4c1d-a2cb-73b28e48c01c@amd.com>
Date: Wed, 6 Jun 2018 13:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiVdeBf9konX4OJi59dYp4y_b+J02ns=yf-D6tjtZ7P1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR06CA0043.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::20) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:xau+99RsQynx6tiiAiYeCVwxXqx4x+FLr836vF7z+FkYSNof36CHOFJxCxXq6ePZXcoVfE9Tk3HkwaSgmlF3QHV22ubaxWG2QbS4inEc9l0U3I9+F3hQ+Uq3PtGed0kng2z8F3hJLIiyLGBQlQRmghjOInIDpuLeZKr6UGpv88GfaZTV+1clVpwVvQwqcqZsl3jeaRn+CbwPrll7rHaSI9r05YQfdm8Jm0yI+m+ZQqY4L0Tn6mcIg949qc6XYgn/;25:kWUc0gcSk/mlv8H2XRwdjrLhHmHuEq+jR2Rry5nwMeoNUU5KbHIIZ8CN5Qce9FcxAPMsJpDfJUA5aX7iyNKspcQTr1iKq0IEtQ7z5ab3DUKiSGyeWMVBZkZ6gJ8fftu63TLb23UJSjQrQwssDd3bfj5ZZeO6ZbQBX0VYYN+Iis8uqbMYUkiKE97Z7uyk2qQATAbcsZ6KUVxLqsplVHqCYRhSIVC/BI7SzESUAD+GZ7LT0/9yLuYN5mjL4ajJez+t+fUVrAPh3F4/EYgCdYyBDb1Fll3uCp1PIGFzq5g+NcbLcpSl9Bc2qe90m2uykofr7JDwN4+/Htvw73cZgvKj0A==;31:PtpZYNarDgX8+C8Cp7uiSwSCWOkKJ67sF+dE+MOetqmMAuFhnUsP/QWHmzdce1iCn5aObg/RPNAIhvW6+ULFly6C5DU9ep/yI2TJ76zEIClqqcyVKYpvw5shBsgqn6ARK7dh6QSr/hpOy1PT03cro7xLxyfnhYxAxqtDK2CakxGjlNZmwc0YOBCd6glFzUr8K8Jp1tSDNSE1Bxn0DT4AHHOQOfF8ACiGUurQeqZLQ9c=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:7drEiBUyUHlRFAKU8JkVq9+aMnynhGZpIs4rX8Wuyqj/NJPKt0on6iyFRWYIJ9NVUBaXSO3HT8k4hKlwJl+eZRi4iq521mLh51USojVp0XwlGB0LL23tSd6t3vp6BX8wTQ0qu2SJwO35Haz/Fx+YsZ/48jIODKsBjm1DrYa5xzX7GWUVtO3xBrW+auOhB8nIfd6bkp/1jvs5KMXwYLOWhCAbPi3cXDFb1vDwFg4OFLS1JXujMsM7HmOOBAsClP//rgWyjNC9gOLxpg9Y52hSsbXrAx5gUYX2Y1TL00g9qIzf8uB9CJgV4TXRjKQAuTSVlukUV5CWv7HTY5j+GnCehXU9K8kQfnyNbW3ZWYF+61RJfoCDKR+Dbbeq/MNKQFGpcOnotbpfuiLLGm471OIz/nBGhYWEULU4lFcHNgoYTjyAJTv1M/dd1EF7UsZT6/ktZ7olmV+/B18DjndCOy9X1KnCvC6Kmu554//NRX7uJIluQxnLSDPPVB3KqXlOiCOf;4:p5p7Kz87ZmASWOIyJhEOkwQlGSEcUO9lAvAw4BOYvWz1gVtK089JNzY4TI9p++6KkOvoxAxPNnwGYKi7Xj7lQv0tqMe/RWBDnywfbCLaN1dlOfBDz8UHn6HIY4wXYAArNlUgMIpoWoxxPZ3kKNlcyhuUL5zo9AHck1/iPfE9lL+ZweS6DJj40M/6JCcB7hDbPsiI1QNLcf2+GDrXRtFoe0yTScBFz7jatvLne0LxyaW8CMRciTexS55XgSdyT33evFK/451Y9qBTJkiwTgqgwbAZUlawsYvw1+vGrXoDYUXu+YPkrvmL0WrTYpAPZ+0C
X-Microsoft-Antispam-PRVS: <BN6PR12MB171496DC94405B897CC235B283650@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(6916009)(97736004)(6246003)(65826007)(2906002)(39060400002)(93886005)(53936002)(23676004)(46003)(2486003)(52146003)(67846002)(52396003)(2870700001)(486006)(52116002)(2616005)(54906003)(478600001)(476003)(36756003)(4326008)(446003)(316002)(386003)(8936002)(11346002)(72206003)(81166006)(58126008)(25786009)(8676002)(5660300001)(81156014)(59450400001)(16526019)(186003)(6666003)(31686004)(64126003)(7736002)(6486002)(229853002)(68736007)(50466002)(47776003)(31696002)(65806001)(86362001)(106356001)(305945005)(6116002)(105586002)(76176011)(65956001)(1706002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOkRkWjdaOVFlSWU1RmV3WFpCMzJKb2orQTNB?=
 =?utf-8?B?TU9leVBsZzkwUTJFVUc5T3FRdlFTcnpWMTl1UmVCN0lhQVh6dVhIUWtFNXVQ?=
 =?utf-8?B?VSs5NjRGRnQrZ3VPcGN6eVZGWi9YMVhweGNNSC9RdmJybzNycjY3cEtoU2FN?=
 =?utf-8?B?VTYydjUxSnpwMDA3WnlqdGNnYWR4cHpJY1pxWi9adG53RUl1Unp3eHJLRjVQ?=
 =?utf-8?B?N3RwaE52OE1iaXJWNGplYVpsY3FjWGxscGxEUkJKd3ZGWGJwMm5PN042UkNw?=
 =?utf-8?B?NjZyeUlKTTV5SHVlNVF5ZnlKT1VkQ05yYVdWZk0zWDc2cy9NbDFoVnlFenJR?=
 =?utf-8?B?a0xEdjlkbzFGc0k0UGtISTBwT3c0RXFsZVh1N09IVTFzS3FBOHdPa0ljdFNp?=
 =?utf-8?B?a21PdEdHNEJiNWsxQldjaGZkV1d6Qm5id2hKVWM5bGVIUFdUZG1oQTNTZFds?=
 =?utf-8?B?ZDFPUmdwTktRT1BNSis1cVFOVU5KV2NZUGh3MEN2QWZwVUhORGZNNHQ2YVBn?=
 =?utf-8?B?MVhIRFIwa29mKzM0RlJic1piZmhzTWV4VFE2aHdnQ05nTkpuY1lGS05FV2Fq?=
 =?utf-8?B?dURLbEhnKzMyZyszSllXNW13N2dxUDZEZWUzMlJsM3ROZEZ2STFDNjJDN21j?=
 =?utf-8?B?ODV5RWZXdE5Ya2RHY21Rd2pOVVpWT2cyQnRleStJdys0aFRyb0hWRFZyS0hx?=
 =?utf-8?B?RlFFUGxFMnBtS1ZXNXRmak1xZWNhSWJpaDkxcmNCTzNPQmhaSUV5WElabFgv?=
 =?utf-8?B?SDNqUUE1SDBGNXRmRHFaeTl2WG9vcHErdXlpRTNtUGw1SkF2cFNoVk85bUZQ?=
 =?utf-8?B?eUhVM2JrdWdNblZXTTBuSC9tM01qVEdBKy9uM0RxZGtVYUo0WVN3QmpWR0VN?=
 =?utf-8?B?S2NzWXhxaFl1ZDdSRlVad1pjZlQybWJnanJ1ck1DYkxMbjRnc0pkOU5KbVlO?=
 =?utf-8?B?WVh3dVBoeStlcE4xdWxMUkJaSW5HeVhGQk1VRjZsckpBTHJTRnBiSXVvZVgv?=
 =?utf-8?B?K3ZSRDRkSkJFN2FKOWpKVFY1Ti9UWVBzV3Z5QmNMUHlUR2hNM3d4aTdsOVJ6?=
 =?utf-8?B?RUlaRVlRWGx3YWFGUWRJYlh0cmhpVWcrOElNbFBhYnFXOVBaNHZ2c3U5eFFy?=
 =?utf-8?B?cU9LVi9qNG02QjlXc0JWclhhclVNVnZGeUNFWmF1Uy9pUnFQT1FXRmRxakdR?=
 =?utf-8?B?VVBuTEpoclY0QzBYaFFHZkh2UXBWdzZteFp4anhLL0trYzR6SjZaNGd3bXo4?=
 =?utf-8?B?RVVWa1dsZzZ0Vnp0Z1hFcHhOUmNlZXZVbm01N3drVW1iVEk0eThjU0d1aVdR?=
 =?utf-8?B?eHg5VW1HTlBPam16SmdlMys3MWZLME9WK2FJMTdtbjZBNlhaeFpoempRK2RV?=
 =?utf-8?B?aDVobUQvM0h6YXlsNGFJdWtZNjI4WFpUN1hxZW9ETEhnbFpobGg3SXl6NjBE?=
 =?utf-8?B?T0hiOG0xTXJMV3BDQmEvRDJRaTFEY2puam5LNUNrcHB1ZGVDTmUyd3M4RjNj?=
 =?utf-8?B?dFpXL3BEMFJyazBEQ01IQkZzTXIzcDcyaC9XN1FkUDR3VUxsaGU1TkFVME1a?=
 =?utf-8?B?Y25kRENxTDRrV0oyMHFkQkd6UjFNMTlxalRSOW4xNFNNRXg4U0J0SFJMZjVZ?=
 =?utf-8?B?QVNDOHJVMEdnVzJ1OFE0N0RBUzdPN05JVzcrYU9UZzVxMFFHUmxRSWcvQnZY?=
 =?utf-8?B?alJIVFhyUS94K2tQdEtaQjFDRUZnSzZQelQ4TUdaWUFYanlWZjhKL3Z1dVRX?=
 =?utf-8?B?RmZuVWl5ZUNpbkRmWHY2WXNRYmdrdUlWN3dQV29UWi9YdlVTWFNqNktxd0dK?=
 =?utf-8?B?WWkrZjF1TTZoWlgzaGR0aUE0NnM1Q1VPWEo0ekxrVEFpdlRXdlNXZ2Fwc1dt?=
 =?utf-8?B?K3ZIWHpZSjNFOVNDWVNRdHlzMXBSK05Ob2xjV3hzVVdGUVZBaWU2RWcyRWdk?=
 =?utf-8?B?NTVydUplMnVSanN2d2VUcFIxK3dEY0tRQTdsUFhablBJSlJ3aDZqMzNaK1lD?=
 =?utf-8?Q?2At+nr?=
X-Microsoft-Antispam-Message-Info: dWPa452wGFnamGdv6QJLWzhfw3E7i+Uz2WmaBLUcVJU5/3Q53+ypVnRsn2BOSABrMr0E5GecNmuUiNreH6JsbSoM0B7OMOUODpR1qASYZIovf351gv3+T7nBO4cNja4zqS+eqh4eZ/tJikasozi73xOxnyyW/sEvESU6b7SvoQ7XGwoN/n4d6Dej/SlhOZSU
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:OtmC5D75vuMrgT6V1/RhDnAk0P0lVGSYVdO6enYmQY1FbUyxnS0+5AAPsSwwo+H14UAXReBLNXoI4HXKkSX67WNISs7YG5ugnU2v48UOuzfQt+0mMnQ+A0teLop4hrvZjT96M+HcOCyd83vs2KpDRdHQJ/reOl9fLC5wYKT0ble3LfQOi3flhHB39pUj7aJjLMNKs8ymTdRxbEX/4iU9/0oRTgWteh5RO+6iZmdT8DJcYZQRMv6bjn8fQdu2JwX3qtEddeN/OfA6II8fkKbwMrigQEJoAD35IXUn6grp+1mDncvajkjDTRHYJUrg8ZximQ258b1Yw9hzO0bmI5mgutKVwy21KoY4/lqt60yc+s1HnjHbdOa7la6/dVjmmjTUcjRSLQbbnoBLhMLbWo3yA6c1tIhrRZ4oAOOcqSe/1sFimx0JG6Mn5FnPwj+EucCZb1Ia3YneI7hk7PoJgX8Tgw==;5:KYn+RbY+whzwQG5KFd8PncR6AjAM63afMeOFbcgX2LWVAtfD4MnWw1eGWA9JfXTV7WlCV9JZE3Pqydf8TutVwyTsqt79achFleusvVOvty9F/U9az0Qs2gkFFWZ9J6c1i3BgLj+MR6SHnBXUoF+KLCxGdgnM+azAcYpydd+eISw=;24:lxeofDPpksNO97bSLRvH8IdZ5Qu4NPX0eeaSiM103bXbq1SQmPqMTaL7+XfCqr+dhPFE7eB0WaOvnsJSuSut19yEkJqaOdOmHRJy73j7pVc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:S5g5Okk1OnespSSKg+Yi/uA6HItlmRuey4OYJN5D5E5yQH9OSw7ZnfLf1S+5/zViB7cF+bRwzSuWwmrW5sBBUFLErUk22j0PZ/+90I7AaKqCL4NltjMw1NrifyKdHUwAkCvU3RsPonr47AxLOR0JCiP20wKrMWO8mBP1fBkkfG4o1EbWV9XREzQbV3jl4rVGGzXOMzUwq10wjtEHZfwCjqSM/JYfydFHgauhfrg5mj4o7LLOBMmKpqyTcCBlIDHY;20:RSmxJebdfgxFbteeL0Ay2rep/2ghHwske4udCHsLSToLS5WHMUphqaydJ/tCwiaYF2VxGeyngEm4JXk7k1RflWzYM7mBXRCip24NHEpiQTeXDhcvo/Fu3H8c5w1ubRp2mv7usMxK/MCYE6Z2YBeh7dTelmeKZ0+7YqHRDBK/YH4wk6zTY0LQBfrNUINrn/S8/+ARbmWj8keM7if/6du+yOYzbKBU2ToB+694VwZZR5EmHrGRVfHXsLwKg45EhEnU
X-MS-Office365-Filtering-Correlation-Id: 1f28c78b-6d3f-4d1d-2b4e-08d5cba167b7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 11:34:01.7060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f28c78b-6d3f-4d1d-2b4e-08d5cba167b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.2018 um 13:28 schrieb Gabriel C:
> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>> 2018-04-11 6:00 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>> 2018-04-09 11:42 GMT+02:00 Christian König <ckoenig.leichtzumerken@gmail.com>:
>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>> ...
>>> I can help testing code for 4.17/++ if you wish but that is *different* storry.
>>>
>> Quick tested an 4.16.0-11490-gb284d4d5a678 , amdgpu and radeon driver
>> are broken now in this one.
>>
>> radeon tells:
>>
>> ...
>>
>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>
>> ...
>>
> I have the same Issue now on final 4.17.

Actually Michel came up with a fix for the performance regression which 
is now backported to older kernels as well.

So the original issue of this mail thread should be fixed by now.

> Also I played with BIOS options also which does not fix anything but
> changes the error message.
>
> IOMMU && SR-IOV disabled the error changes to this :
>
> [    7.092044] [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0
> test failed (scratch(0x850C)=0xCAFEDEAD)
> [    7.092059] radeon 0000:21:00.0: disabling GPU acceleration
>
>
> While I could workaround SWIOTLB bugs in 4.15 and 4.16 , 4.17 seems to
> kill the GPU with no way
> for me to make it work ( at least I could not find any workaround by now )

That actually sounds like something completely different. Can you 
provide a full dmesg of radeon and/or amdgpu?

Thanks,
Christian.

>
> BR
