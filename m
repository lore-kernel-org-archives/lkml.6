Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDRKcH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:32:07 -0400
Received: from mail-he1eur01on0089.outbound.protection.outlook.com ([104.47.0.89]:60457
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751407AbeDRKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:32:05 -0400
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Paul Durrant <Paul.Durrant@citrix.com>,
        "'Oleksandr Andrushchenko'" <andr2000@gmail.com>,
        Roger Pau Monne <roger.pau@citrix.com>
Cc: "jgross@suse.com" <jgross@suse.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Matt Roper <matthew.d.roper@intel.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <7d6710a76b9a42299139d7914358ed52@AMSPEX02CL03.citrite.net>
 <3c56505c-8f03-e49b-a995-a2118d255164@gmail.com>
 <c09dc0b4367f4962a69ad0dd894db798@AMSPEX02CL03.citrite.net>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <7f04fc8b-8790-fb25-7b4b-7f81ad3d8e47@epam.com>
Date: Wed, 18 Apr 2018 13:31:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c09dc0b4367f4962a69ad0dd894db798@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.56]
X-ClientProxiedBy: AM5PR0701CA0023.eurprd07.prod.outlook.com
 (2603:10a6:203:51::33) To DB5PR0301MB1942.eurprd03.prod.outlook.com
 (2603:10a6:0:35::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0301MB1942;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1942;3:Iaqv7/DQ9DUFzkYGODa/zurg8pUYTsKJ49eNJQi/rIFu25f/4K1VcM67PH/a9D8hDDC4hIGqzXW8f/m58BnzAMh2O9/n35D2mAZPY/8kfY4ms+R3J5Z11BZbFDy3bqvEFjruqF3CYIYGU6pEwY+V7/eQfx9XHv4IAU28oMlJEg8ZOam/AvcUvhk1YrQS44tL2sJo+ItNwclU8e/LXD2qHWrSnXbDfS1ouv7tDUxS1swHiQSRJ55I+SDun2161ntD;25:rNHY4W1tawzw9r29kYrMvMdxYwfBi9MRBbzmxrnTgwmP/aIjKhITtz96OPbndPzORT3FvnNtyKWPRlYrKA8UkLCV7FsfHPBorjfoIUOj9RTutu9B68J55hkSTvCkVZQINV+RNufI+Yb4mOLt8RAgtSsjfBjIVmrs0BJbhXzlzIqvbiYBYJg1Bs6ELsrK/TLriz+mrVMf8HqmwCmXkBmqUw7pArMCsotRWqXI1gJNU0hXR0yf/9ebovNe660O538rb2rX4STJznMb3bo23YijDKx/Awt4qAjCFbxoImr2JJ48Ol/NvbLxZOwgUGjFVS8QgdrGPUqjSa+LHbFDkDh3/g==;31:R4l2x1DSgy7A9ZHMxlQWyPa/98D6tGjhOb/cNPiOdrvhTxP0WA/I4tmVHqPqyibmY0Bevc02BnKVdvd/vu88zLK8AwOmUE/+QiUW4yOQHzvNfmHfYjTWDbJX8D8RWY6bvUNOLwPr1nq8qfR3PppdnDGkxprWeeQ5oh4ClRhULeQt47zu6C8XePDLdzleiMZ+fZvz7DqTQ1Z1KsJfr2Lvj4Eh0vfnF9PZ4t5gSrhclms=
X-MS-TrafficTypeDiagnostic: DB5PR0301MB1942:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=epam.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1942;20:Pd+a3pEdcRQy8lXKF3x9kri1diOPYeg9wQdl66D1aCIzXxZcEvjXr5PHH63pgDN1xdiH79hVTeyMH+C62kiIZBJC7VSQt7zi5rBHWak8nVtgfz5QkuojNX7Cpd/aWkGuDWF4JDQ6IozMIA883zZtpxR+0oMMcpWPKRCEUSG0DEClKoXyHNg7UHHmo8O1KRhChA0IYmrVihh/Txp63+uMgX6qCV9Gxt6Nbuhx0DAT4bYJwH58g84D8eFAqTlFYkItJpzOwPGY0JVxP739qlyJwgq1JwGtLsRCmT3q9VRT1FoeJY4eZqAYA/8VPnrWjk5q8iwY2GwMZuAr5GvOH1M8uhwBFkDiGIQ911wgUC+T+Qay0QAtUfF58D7W495Iu3/ToamprGcpknrnE/VBCdVhVo1Pfp5RVMne+NXuZNDVVhiH7ZYjRGHScIukAjdbTi21Pj7/e3Wk25sBt5OLYPRWM2OxHYbOM+cF/gsfCJeEWzdyvllnMsrgNXP+HC0r9ze6
X-Microsoft-Antispam-PRVS: <DB5PR0301MB1942BA66406A0B1BDE34C844E7B60@DB5PR0301MB1942.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(192374486261705)(9452136761055)(85827821059158)(58134797142442)(217544274631240)(4114951738403)(70601490899591)(146099531331640)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501368)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR0301MB1942;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0301MB1942;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1942;4:eSdyoigr0v2BPO7EVU60fdxXFhmHIXGgnub2zSo8KceiOWFsQx84KaObVJjfcm7q5Ijgo1+QEOpnC6cIRpakfgpBc2h4kgbMkLypWsgwiuQ3z2O031lhWPFJfjsgjlKORsp2m5S0LvUZebKTY5VhnGqkM82iYXwcq9o71z6GiAX7bvbKvD8XyN1cKNjx06HDu95w/UpWv9FMowm/LfeK0zbUm2QLE9MmDb1DERFzRB7bo0hBWZxSTXIHJ+VCTPFjTNfDpMr4aXeXA6yUKvKFiJbzdJ3t24ncl4gBwWR+ol0eN+ksO5gBhYsm83b6/QBwB0v6A/Z1XAw34LpYEinaSSneiBoUDdgDLbVFy8B+UERxB4u9jV7yFLBJDojWOkek/uKn/wrlqaLeGhAKJtp5gSBpCkROOn0zoB/R/UT6PeFbxMah/+JXkGjPF7GxarIiCesC4BjJBEjsgG1pQ76O1b9ASKhu+Y9A/vw6WkZcSpQ53gVTio97MhbgaoIG9gjxPbVLNmnrHIGpmjqbpr5Rn1I3OR/DGGlb2BLe93qXqNYD64bbIBmWJlFj6aOHXR+/Xlt/59rkc4LGMso5s0DZn/u+2C9u8PxVviQdwXjeIUwF8LbyLBC7a64/15Blqfnq
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(346002)(396003)(39860400002)(376002)(129404003)(13464003)(57704003)(67846002)(16576012)(305945005)(31686004)(6486002)(31696002)(76176011)(86362001)(3846002)(6666003)(25786009)(36756003)(6116002)(81166006)(8936002)(77096007)(54906003)(316002)(966005)(58126008)(7736002)(93886005)(229853002)(8676002)(72206003)(55236004)(110136005)(6246003)(16526019)(446003)(186003)(26005)(39060400002)(65806001)(80792005)(66066001)(65956001)(4326008)(11346002)(478600001)(65826007)(50466002)(53546011)(47776003)(64126003)(956004)(52116002)(386003)(7416002)(2616005)(5660300001)(476003)(2870700001)(52146003)(2906002)(59450400001)(2486003)(6306002)(53936002)(97736004)(8666007)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0301MB1942;H:[10.17.182.9];FPR:;SPF:None;LANG:en;MLV:ovr;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjAzMDFNQjE5NDI7MjM6ekk4d3g4NFhPSEhhVGpBZFFoM3dDWDh3?=
 =?utf-8?B?SFVTcWxJK0RTdUFNY2cyOGpmL0lIUUN0K2JvVituTm1LMW16VVFWM0NvNjh1?=
 =?utf-8?B?VDJFTFV0SFZaUEs2SXhFZ2VkUjNBNFQ3elJ4WmY0ZkY0WWdEbThMK3d2b1dV?=
 =?utf-8?B?dkxwc2ZobnFXUTJCaXUrRHIxcmQrc1k4WUJya2g5RFhTN1UrakNrM2lsMFZx?=
 =?utf-8?B?OW1CMElnMWYwTkZVeStGc2E5NW0reXZhZHBLV1duOHNZUitPUkdhcTRZMnJD?=
 =?utf-8?B?dU5wOGNjSTZ5SzFpNDFjanI2Z0ZIR3NUT1VFZy9uNTgwS1dQanRGeXROb050?=
 =?utf-8?B?bFpoaFlxVk1JWm9oRjIwYzJwSTFZZTRVVm5WeERoUG82Y0YybitGYytmMFdP?=
 =?utf-8?B?RkhyNDM3V045T1pwRDQrL2VRTTg1NE82MWgwQWNPTndtQnM3a1hlNGxTQmZp?=
 =?utf-8?B?T0wyMThYdk9PRy9iTWVwK0o5ZE45c3R3ZWVIdW9SaUFHTlhiU3NhTitEMWMr?=
 =?utf-8?B?S0FSblJQVWM4QlNwbXQwcWFoNCs3U1FKS2JiSmFJNGdGTWdabTNQdW9KcS9o?=
 =?utf-8?B?QjFnN1V0dDZXcmpOdEs3a0h5MVFHY2pqaVM1bGQ2QnJGL1B4bGJpUFlSZ3dy?=
 =?utf-8?B?TkwxTFRqTkJaR3o2NnpmTTVYS21aNXNHbWViS0ZxQTNxTDY5eDE1U1NyTGgx?=
 =?utf-8?B?YWpvc285VkQ5SHVJVDJQeGhxVGVZdUVBM29QZ1h2SWJiK0FUZ0RLbWRkNDJr?=
 =?utf-8?B?ZWJua1ZIU2NVdEtUZmpxVEJXbGV4c2lxNi9wY2ViVTJaWDdmdDNwRUFLaVpy?=
 =?utf-8?B?Z3AwMWlrZ2lwNlZPWUlUcnFJWmZobWFtc1lIanhJS2M5ckZRTjJPeTluYVFx?=
 =?utf-8?B?MmZYcTNJRUpTMVVWMEF6ZmprSmpEWVlnYUNVcitpOFhscG5jWDVuYVNvQnFR?=
 =?utf-8?B?Q3hPOXBORkxUZUdCeCtteUNydVB6ZVdXTkdCUU1ZMm41N0wySURNSnFtMzFH?=
 =?utf-8?B?N3k0Yllnc1kvcWNCTi94czhjSXg0QWpXTjlLTkQvNC85emQyenFIendNRlNO?=
 =?utf-8?B?V3ZvakZMTWJYRDFwTkxuNXpreTZSMS9Jb2pMNHFoaklXTEdheXVLTkViVGtC?=
 =?utf-8?B?WmxTTjM2KytFWWhYRlZNS3RtSysyK2RGbE9qdlBaN2YvSGUzVStVN01Sa3hn?=
 =?utf-8?B?OGJuQ3QzM2h4NGhGcEFUOGczUHA1L0lLZFNBUFpBOVBMVTVyK3BVblNPZGNV?=
 =?utf-8?B?NGNieVhsM1BLaHN0MWh3YTgvZmRjT3lubDJsUDN1MGFUSmtxUGVCVEJXOWVR?=
 =?utf-8?B?cmhiTUw2VFdNQlJ3WHM3WnI3MGxEODFjSDR0SUJXTmdCK1RtMzYySUFsVUNr?=
 =?utf-8?B?Wmpia293c1hsR21JSktubnlJZTVYS3VpUllVaGZVOVY2REE4MjV2MEYrU1J1?=
 =?utf-8?B?VnBZcGhOczdRUlJ3eWZzdlJYYytSWkNlU0cwKyt3Y3F3SUt6T2RYZGUwMmhV?=
 =?utf-8?B?RWxMNHZGM3RzeGY1WDU0ZGdWTVpqb1RrdnpON2laT3NWOWdXeVZrVUhHUG1B?=
 =?utf-8?B?ZUlDUEtVK01PUXRlOVUycDFLMWdnRFpNRkZUbFArMW54ZTBiNE1Pd0I0alFi?=
 =?utf-8?B?TEwrbW9qWm9aU3p4WGttUXdsSkcxYlBxalQrdUJWbXgrYUFjYlJZMmhKU3Er?=
 =?utf-8?B?cGJCYmxCclVwM1lJZFB2ZlZMM1JIYk16MW8xM1NNbkM5b1pISVlVTFgvSWpL?=
 =?utf-8?B?ZU9XUFBtU1hWK2pFZ3FoM2N2d20zRlJxMGd1R0pRTEUwKzhUMDVCdFNRVFRW?=
 =?utf-8?B?MEpQV09IL3NaV0ZTUFd3Zzk3eUFUUUcxaTFKMXFqZEpZT1JCQURPNXFRTWtJ?=
 =?utf-8?B?K2hndVU4VmtIeGpQcHlFNmsrb2oyQzU1M3Awakt4aWRrR1Frb3FraGRMd0to?=
 =?utf-8?B?UDRRc1ZwY01oTXZNSWpyT3BtVUpEN1BRZkxRQ2FPUXNJR1YxSkF3VlZBaWY2?=
 =?utf-8?B?TW83Q0Vzc01VcmJpZmdDc3c4amxsUWJZeHFxbjdRWldhRzNtalI2WklBN0Uy?=
 =?utf-8?B?OGdRZ0ZwZG9ZS2lwMlF4NE1vVktBS0JsN2I5S1ZNUTBFemJLaFI1U2xNN3Fh?=
 =?utf-8?Q?VHU2I06JQWgRjveARiEAYHRjTtmvnC3HpIew971wVOqQCU?=
X-Microsoft-Antispam-Message-Info: kUrup+aAjkDqAJMJz99eNHwmYOKPlQav0vzQZRGTEveWYg86iAxT9eFe0nSDOFBmkEi1sM5Bz6glXuVDdgAey0Cz5rkIOJJXTgYYadMTN+wQCWy4mD09VZob4aZBRt559SmfYAjKH//aaH+CzqLoMlDu5f36o9ZP+cYQ9Pz2JdZX1D00FkjwlCPxNO93eE1S
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1942;6:k6blnHsQuitOOGP95AR4lRqyTlw59Kq7zJMcHpxRiuu4aHb07Z7baoaCADm+eZqF0XQLnm1gcr5acqZzlIkUhJEqxqvqGbEmVR7/m7gDVcXSKkROGo7WjCcAca9OhXVh3hMR+TSBk6d1eYd9t2i4T7Dru+nGOpjekmP06StBIcIebr5o3BoahW1DHENS8duSIUyiv65txbxpyO8Jn3qkmNvotjTP4XPCTUnMGmZTvcRtE6OQhqV2ywXcR5OzGPvmsQxdzEMsuvbPp6ZkNuCPeHeRIrK4wHU8wc28yeDNY22sIn2apZQBQPGD1+E9z6BGHY9H79Hpjp4fkSgBXcrBQwSv4WNCKqAev3KdGG3X1BpRld/f8nZiS9zRzF710CTxJIHinipcwlUeUnQgRdPnbSTpx/61ICeQ7sAMH0qvH3LONLekRiBJRB/HstJUsaQfleIDoqahciZzgJYpWWUscQ==;5:Joe7fp2sV35lm4cbqYNMnvUTDu+mNPp1EGihhl4PqeG+jfBfYl6Lfi0wWoucAPnkDr2j5XHSmPGJIoKPQnFYCDHtP2KcQvOTeymT5yX89FiIEzaXQMxSvnNnbFkKiljvx+N4Lgp92KE//qDUcvmaKAXaR1/6UUUaEkmQn75YvCg=;24:PxCHnLK/LAeSLaXAatbZLcN1XMgtEOBlOY/uWzVHpxKZMfKk4NH2jg25FtHnCH8vHN9VroXyQTCthGzrLYbjTi8/DiZX1cCX+9JtRLj7sMk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1942;7:nvIZ2Mxq7Mf2pqN1/cVmRqS4v/GzPhXKPTLMBC8t95RPjvcmqxUIwVFPyLU6AnWlpOMW0ChTM4TphMKMDRmyijbGG4rFicWVTfRetMbt7dLXPe6hSLEsRTER8tlO1fF3zHeFLdJeOuSOg7pN6/wk6TyMv1UcYQC3iUYbbSb3IXVNGYcYOIYJrVpq3+bdag80ZSkHC+LqUzPCSZL56eGW+UkBMDy/6JxWbV90O1EkI28NwpaQUCJKMlwP0E/VaR7i
X-MS-Office365-Filtering-Correlation-Id: fbe6129d-ce56-4539-7281-08d5a5179ef4
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 10:32:00.1975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe6129d-ce56-4539-7281-08d5a5179ef4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0301MB1942
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 01:23 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Oleksandr Andrushchenko [mailto:andr2000@gmail.com]
>> Sent: 18 April 2018 11:21
>> To: Paul Durrant <Paul.Durrant@citrix.com>; Roger Pau Monne
>> <roger.pau@citrix.com>
>> Cc: jgross@suse.com; Artem Mygaiev <Artem_Mygaiev@epam.com>;
>> Dongwon Kim <dongwon.kim@intel.com>; airlied@linux.ie;
>> Oleksandr_Andrushchenko@epam.com; linux-kernel@vger.kernel.org; dri-
>> devel@lists.freedesktop.org; Potrola, MateuszX
>> <mateuszx.potrola@intel.com>; xen-devel@lists.xenproject.org;
>> daniel.vetter@intel.com; boris.ostrovsky@oracle.com; Matt Roper
>> <matthew.d.roper@intel.com>
>> Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy
>> helper DRM driver
>>
>> On 04/18/2018 01:18 PM, Paul Durrant wrote:
>>>> -----Original Message-----
>>>> From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On
>> Behalf
>>>> Of Roger Pau Monné
>>>> Sent: 18 April 2018 11:11
>>>> To: Oleksandr Andrushchenko <andr2000@gmail.com>
>>>> Cc: jgross@suse.com; Artem Mygaiev <Artem_Mygaiev@epam.com>;
>>>> Dongwon Kim <dongwon.kim@intel.com>; airlied@linux.ie;
>>>> Oleksandr_Andrushchenko@epam.com; linux-kernel@vger.kernel.org;
>> dri-
>>>> devel@lists.freedesktop.org; Potrola, MateuszX
>>>> <mateuszx.potrola@intel.com>; xen-devel@lists.xenproject.org;
>>>> daniel.vetter@intel.com; boris.ostrovsky@oracle.com; Matt Roper
>>>> <matthew.d.roper@intel.com>
>>>> Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy
>>>> helper DRM driver
>>>>
>>>> On Wed, Apr 18, 2018 at 11:01:12AM +0300, Oleksandr Andrushchenko
>>>> wrote:
>>>>> On 04/18/2018 10:35 AM, Roger Pau Monné wrote:
>>>>>> On Wed, Apr 18, 2018 at 09:38:39AM +0300, Oleksandr Andrushchenko
>>>> wrote:
>>>>>>> On 04/17/2018 11:57 PM, Dongwon Kim wrote:
>>>>>>>> On Tue, Apr 17, 2018 at 09:59:28AM +0200, Daniel Vetter wrote:
>>>>>>>>> On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
>>>>>>> 3.2 Backend exports dma-buf to xen-front
>>>>>>>
>>>>>>> In this case Dom0 pages are shared with DomU. As before, DomU can
>>>> only write
>>>>>>> to these pages, not any other page from Dom0, so it can be still
>>>> considered
>>>>>>> safe.
>>>>>>> But, the following must be considered (highlighted in xen-front's
>> Kernel
>>>>>>> documentation):
>>>>>>>     - If guest domain dies then pages/grants received from the backend
>>>> cannot
>>>>>>>       be claimed back - think of it as memory lost to Dom0 (won't be used
>>>> for
>>>>>>> any
>>>>>>>       other guest)
>>>>>>>     - Misbehaving guest may send too many requests to the backend
>>>> exhausting
>>>>>>>       its grant references and memory (consider this from security POV).
>>>> As the
>>>>>>>       backend runs in the trusted domain we also assume that it is
>> trusted
>>>> as
>>>>>>> well,
>>>>>>>       e.g. must take measures to prevent DDoS attacks.
>>>>>> I cannot parse the above sentence:
>>>>>>
>>>>>> "As the backend runs in the trusted domain we also assume that it is
>>>>>> trusted as well, e.g. must take measures to prevent DDoS attacks."
>>>>>>
>>>>>> What's the relation between being trusted and protecting from DoS
>>>>>> attacks?
>>>>> I mean that we trust the backend that it can prevent Dom0
>>>>> from crashing in case DomU's frontend misbehaves, e.g.
>>>>> if the frontend sends too many memory requests etc.
>>>>>> In any case, all? PV protocols are implemented with the frontend
>>>>>> sharing pages to the backend, and I think there's a reason why this
>>>>>> model is used, and it should continue to be used.
>>>>> This is the first use-case above. But there are real-world
>>>>> use-cases (embedded in my case) when physically contiguous memory
>>>>> needs to be shared, one of the possible ways to achieve this is
>>>>> to share contiguous memory from Dom0 to DomU (the second use-case
>>>> above)
>>>>>> Having to add logic in the backend to prevent such attacks means
>>>>>> that:
>>>>>>
>>>>>>     - We need more code in the backend, which increases complexity and
>>>>>>       chances of bugs.
>>>>>>     - Such code/logic could be wrong, thus allowing DoS.
>>>>> You can live without this code at all, but this is then up to
>>>>> backend which may make Dom0 down because of DomU's frontend
>> doing
>>>> evil
>>>>> things
>>>> IMO we should design protocols that do not allow such attacks instead
>>>> of having to defend against them.
>>>>
>>>>>>> 4. xen-front/backend/xen-zcopy synchronization
>>>>>>>
>>>>>>> 4.1. As I already said in 2) all the inter VM communication happens
>>>> between
>>>>>>> xen-front and the backend, xen-zcopy is NOT involved in that.
>>>>>>> When xen-front wants to destroy a display buffer (dumb/dma-buf) it
>>>> issues a
>>>>>>> XENDISPL_OP_DBUF_DESTROY command (opposite to
>>>> XENDISPL_OP_DBUF_CREATE).
>>>>>>> This call is synchronous, so xen-front expects that backend does free
>>>> the
>>>>>>> buffer pages on return.
>>>>>>>
>>>>>>> 4.2. Backend, on XENDISPL_OP_DBUF_DESTROY:
>>>>>>>      - closes all dumb handles/fd's of the buffer according to [3]
>>>>>>>      - issues DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE IOCTL to xen-
>>>> zcopy to make
>>>>>>> sure
>>>>>>>        the buffer is freed (think of it as it waits for dma-buf->release
>>>>>>> callback)
>>>>>> So this zcopy thing keeps some kind of track of the memory usage?
>> Why
>>>>>> can't the user-space backend keep track of the buffer usage?
>>>>> Because there is no dma-buf UAPI which allows to track the buffer life
>> cycle
>>>>> (e.g. wait until dma-buf's .release callback is called)
>>>>>>>      - replies to xen-front that the buffer can be destroyed.
>>>>>>> This way deletion of the buffer happens synchronously on both Dom0
>>>> and DomU
>>>>>>> sides. In case if DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE returns
>>>> with time-out
>>>>>>> error
>>>>>>> (BTW, wait time is a parameter of this IOCTL), Xen will defer grant
>>>>>>> reference
>>>>>>> removal and will retry later until those are free.
>>>>>>>
>>>>>>> Hope this helps understand how buffers are synchronously deleted in
>>>> case
>>>>>>> of xen-zcopy with a single protocol command.
>>>>>>>
>>>>>>> I think the above logic can also be re-used by the hyper-dmabuf driver
>>>> with
>>>>>>> some additional work:
>>>>>>>
>>>>>>> 1. xen-zcopy can be split into 2 parts and extend:
>>>>>>> 1.1. Xen gntdev driver [4], [5] to allow creating dma-buf from grefs
>> and
>>>>>>> vise versa,
>>>>>> I don't know much about the dma-buf implementation in Linux, but
>>>>>> gntdev is a user-space device, and AFAICT user-space applications
>>>>>> don't have any notion of dma buffers. How are such buffers useful for
>>>>>> user-space? Why can't this just be called memory?
>>>>> A dma-buf is seen by user-space as a file descriptor and you can
>>>>> pass it to different drivers then. For example, you can share a buffer
>>>>> used by a display driver for scanout with a GPU, to compose a picture
>>>>> into it:
>>>>> 1. User-space (US) allocates a display buffer from display driver
>>>>> 2. US asks display driver to export the dma-buf which backs up that
>> buffer,
>>>>> US gets buffer's fd: dma_buf_fd
>>>>> 3. US asks GPU driver to import a buffer and provides it with
>> dma_buf_fd
>>>>> 4. GPU renders contents into display buffer (dma_buf_fd)
>>>> After speaking with Oleksandr on IRC, I think the main usage of the
>>>> gntdev extension is to:
>>>>
>>>> 1. Create a dma-buf from a set of grant references.
>>>> 2. Share dma-buf and get a list of grant references.
>>>>
>>>> I think this set of operations could be broken into:
>>>>
>>>> 1.1 Map grant references into user-space using the gntdev.
>>>> 1.2 Create a dma-buf out of a set of user-space virtual addresses.
>>>>
>>>> 2.1 Map a dma-buf into user-space.
>>>> 2.2 Get grefs out of the user-space addresses where the dma-buf is
>>>>       mapped.
>>>>
>>>> So it seems like what's actually missing is a way to:
>>>>
>>>>    - Create a dma-buf from a list of user-space virtual addresses.
>>>>    - Allow to map a dma-buf into user-space, so it can then be used with
>>>>      the gntdev.
>>>>
>>>> I think this is generic enough that it could be implemented by a
>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>> something similar to this.
>>>>
>>>>> Finally, this is indeed some memory, but a bit more [1]
>>>>>> Also, (with my FreeBSD maintainer hat) how is this going to translate
>>>>>> to other OSes? So far the operations performed by the gntdev device
>>>>>> are mostly OS-agnostic because this just map/unmap memory, and in
>> fact
>>>>>> they are implemented by Linux and FreeBSD.
>>>>> At the moment I can only see Linux implementation and it seems
>>>>> to be perfectly ok as we do not change Xen's APIs etc. and only
>>>>> use the existing ones (remember, we only extend gntdev/balloon
>>>>> drivers, all the changes in the Linux kernel)
>>>>> As the second note I can also think that we do not extend
>> gntdev/balloon
>>>>> drivers and have re-worked xen-zcopy driver be a separate entity,
>>>>> say drivers/xen/dma-buf
>>>>>>> implement "wait" ioctl (wait for dma-buf->release): currently these
>> are
>>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS,
>>>> DRM_XEN_ZCOPY_DUMB_TO_REFS and
>>>>>>> DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>> 1.2. Xen balloon driver [6] to allow allocating contiguous buffers (not
>>>>>>> needed
>>>>>>> by current hyper-dmabuf, but is a must for xen-zcopy use-cases)
>>>>>> I think this needs clarifying. In which memory space do you need those
>>>>>> regions to be contiguous?
>>>>> Use-case: Dom0 has a HW driver which only works with contig memory
>>>>> and I want DomU to be able to directly write into that memory, thus
>>>>> implementing zero copying
>>>>>> Do they need to be contiguous in host physical memory, or guest
>>>>>> physical memory?
>>>>> Host
>>>>>> If it's in guest memory space, isn't there any generic interface that
>>>>>> you can use?
>>>>>>
>>>>>> If it's in host physical memory space, why do you need this buffer to
>>>>>> be contiguous in host physical memory space? The IOMMU should hide
>>>> all
>>>>>> this.
>>>>> There are drivers/HW which can only work with contig memory and
>>>>> if it is backed by an IOMMU then still it has to be contig in IPA
>>>>> space (real device doesn't know that it is actually IPA contig, not PA)
>>>> What's IPA contig?
>>> I assume 'IPA' means 'IOMMU Physical Address'. I wonder whether this
>> means what I've termed 'Bus Address' elsewhere?
>> sorry for not being clear here: I mean that the device sees contiguous
>> range of
>> Intermediate Phys Addresses
> Still not clear (to me at least) what that means. Are you talking about the address space used by the device? If so, that is essentially virtual address space translated by the IOMMU and we have general termed this 'bus address space'.
this is it
>    Paul
>
>>>     Paul
>>>
>>>> Thanks, Roger.
>>>>
>>>> _______________________________________________
>>>> Xen-devel mailing list
>>>> Xen-devel@lists.xenproject.org
>>>> https://lists.xenproject.org/mailman/listinfo/xen-devel
