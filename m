Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48nG8TVXGWLRdXOS+iCBMyi7iLf+d1RGPCghEbPYuQ/gWYKlCelvr1VDqBPO4GOPO1fgdVd
ARC-Seal: i=1; a=rsa-sha256; t=1522248584; cv=none;
        d=google.com; s=arc-20160816;
        b=NHa1u20gHlyii4S6F4FnSOzWKpOX6r1fGhq+3ZydkuXfB8vViwylaIEwwDK/rT5eEW
         WqHeoSi/x+LH3wh6jCF0S0VBa9HHK/1EdgVEl9VuPhL318egDdTcoF07P/Iak6PovNMB
         f5SsD9mhOhDsQAQyY9Vvf3ssMQnlw1gnVIYibpDFC/2qAyj70vgi4SGDe3y+yF9Lb0he
         LmKWiQv6U9zSDGv5nCJtCbKPPqas7FAVRI9vpJ+hdHModbFl2BGxsb+CuKO7hZh8HOH9
         BJSv7kCWIITJvghjc37+5JcPbMLUCqVbJs638cOHI1CQSFZ5AWWf8r6HkJcf4K+G4pVC
         qi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=dehHklqD83KaWkB6IY6pfGkMU2MNVnY/jReJTDTN2GY=;
        b=eGwfrrjvthHasBVaOlRrbaZVWSq8waWCXewBcpC1C73aB9DKQx+95hEDFvHGPjNmSG
         k7QWnIoMBAo6NuhX48nBhLKDQl4hvD67cr8Ak0ax1QGhq1RtYsb/h1ymYNNU/e5/Mt4z
         /tCGiO4J5djXrMAdDGB+YV8BrSbf7YqHc0u6UWku1d2s7QMMj9kujIcrd5i4bkxzt8Fe
         mAaRSdfdaP9Pi8Cq0+c7B9wCxUshZe1mcCYtCaT7Io9ovR43CgUp6IWEaVqeoJNV3oLi
         zS6ZkR5z7ASKp3OGUEy5IhZDy3LbOqhQWDo6MbcqP6Z8A6HfhL88o6EAW4puLAcxP+z4
         bQlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=XWgiwiCT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=XWgiwiCT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH 06/10] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163853059.21546.940468208501917585.stgit@localhost.localdomain>
 <20180324193253.y653nm4z6sh7u2kd@esperanza>
 <0fe02df4-3d55-2ee3-95af-156ac63f29be@virtuozzo.com>
Message-ID: <b7d605c5-6fda-c846-e5f6-c3b4bb32684e@virtuozzo.com>
Date: Wed, 28 Mar 2018 17:49:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0fe02df4-3d55-2ee3-95af-156ac63f29be@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::11) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d357181a-f740-44b7-5ebc-08d594bb220e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:NKdFhCQleMyts5uEXMFta8OmwW6inscNXHbIzI3JTSJLIf/7UjBqz4FKAlqJX6HZfUhJbevRMkKPyG5yFOdYsoLrneRREwccJLjgQwwMHkVVXxK8CslQzFLkKcszJaif05WHAXkchHvu43M9TaM3Et+aOkEqwaq8RcfE45rnrrhskk9/wSjM1eobanI4/Aw/HVvB0LUvGe0tJsLA5ccPDu4+GyK5heVZsNn/VhiBHerh5jvbPS6zBa2awqgdmvsu;25:IVV562Fi8Y7wE6gAXe9Mp+3wgHPJ0ukotivnuU8bqJ71dHxKBHAgYf/InedQAXfmo46ZOgJI0wkghz1+K5b4Beck7pbxRFh2RNav2Y77nK15vGqc5WcVTCLb8RaFo5ow6tUFZofduVaEvTFQ+6fXf4OXSea+oZSMWcAV354TU6/Hgm3EZGxeq45izdZNDYlcEn+cuShslhvZ1T64jYLcGx1fkn9zg0MDJg/jBvwX0Gh85c/7icMf0wKs9fgFCpL/4+It0vgnLT9z5dwEHUWGQ0lZQodUJi80J04UqHiab3U3NUPjRDkhRXyWqJjGpJ4ygAq+Hpj5zFaejQ4dMZLN3Q==;31:s4bwpl7vvPjhzOEExuArAgJztcRn727tTswJPVQpeaPLJp4j7TM1DtuDZ+aibXXAfmt2qbIc7apJFs2AfSKAYNb05+ZXODWaKWOWJhJ/JnST3WHyiZYGs0YBEBk0oIMf2/PN68o0Bz6a37UM572EGvERmWb5ArYeH26tgTiBXKQ1lnac+d+NAsXA9oKv6Gof1FWTwgVOnZsJbE9KXE8BSaFBaZdcwR1O1GEMOqCCDGs=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:v8yGP18zYuR9a995ywD1lGPw4NsfUbDWKUnB/w2SOwGP/VX4byDCL/I5ZTQHDaciDtYGVLzQ7wB0E/lOsUwbBPIrKIvvJsae7FiXIdV/3vZIpl0D6qyOoxjnT72ZMoKEM/9+hM7vSolzUlAz9hkJEZln6WUzj6kBcdUxJHHkySSUY2g4UXZKI5nvz0VlsS5vL4SSyyukAOfBxeDySJRhf6jbx/DhheOPOkUl13hN8mez2dE8Sl7jfcvODiY2hMGB7Z9GysXzZcWrq2hsJ49YoV5N7ImO0RtL8yiyjNWnBptpIuwwVKhnxNzpgXB7i0tNgvDj6ewBGbVLMvI5QlU/ZUt4HFIA6DNcCFSXEiYLMfrcoPmcf9zHg1izqA3qZqfMCEa5X4j+DDNQSJrSOTiqQwhsoHMuTZKhBCPPzkmDgwNV/cPnsfg6NdIOH4zhL+IZona+tbFZABDWpRTQpWlcdWH7etljpVkG4Unw6rhq0gc0Ph53uSOs8wlu5nmOcZbX;4:OPT0GnwiTgiZslu0mVUw+bE0wcoPubO/lm6n72w9oxMjIYQYGpVEjYkbnbtgdyA8acwb2Stp4q4X5/n31e9pEgs5qbFAlq0NNOZpashtgUDpAxE/BqxLSBSVTSdtWyy1qd3su2ARpytLeb/o92alqYFZ7BVPgnhlpgKAGsLOYE6Nb/sBl/rbevTHbAYEMilrYu7zWVqoht25LmSBklTWnOdYNOtkUXYqTQ/5SydqBcj6pcvvM7YI15FRyuGMUgmTy3VA+yiw4CeOnYBwjhVo0g==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332175C8C4B59E01D0FE764CDA30@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(396003)(366004)(376002)(39850400004)(199004)(76104003)(189003)(6246003)(36756003)(55236004)(305945005)(478600001)(53546011)(97736004)(386003)(11346002)(93886005)(52116002)(59450400001)(6346003)(7736002)(31696002)(81166006)(26005)(106356001)(81156014)(23676004)(64126003)(8676002)(52146003)(5660300001)(2906002)(53936002)(58126008)(68736007)(2486003)(16576012)(39060400002)(65956001)(47776003)(76176011)(7416002)(65806001)(25786009)(66066001)(65826007)(31686004)(446003)(316002)(8936002)(230700001)(6486002)(956004)(16526019)(186003)(2616005)(229853002)(77096007)(486005)(3846002)(6916009)(6116002)(476003)(486005)(4326008)(105586002)(6666003)(50466002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6THFoZlpucTdsTjkvVEcrTWFWSTh6S3ZY?=
 =?utf-8?B?OVBBOFA1eDlBdXlvdkJla3NMaDluQ1N4MEV3WmpIT2Y4dktOM3RIUTIvM3Ri?=
 =?utf-8?B?TW9Ua1hHd0E2RmZycWVBNDZkRDBLWTFibHVRMHBJRjl1ai90T1E1Qk8vWEZB?=
 =?utf-8?B?bFdLYTZqSHlHTnJjSmdSK3UzaW0zSWU0YnV5QUlLMlg1Z1g0VEp4TllOWXFP?=
 =?utf-8?B?ZHdOa05KeU9GYVZ2VUVOaU1pay9STWJ1VnA5SGxLRVFqNTNmeHdDcmdLUHVu?=
 =?utf-8?B?cVp6bXNiTDd4RDdxeHdjUU9Gc1M2SE0vWENOMlNPalJtMS96d3dMQW96Zk5H?=
 =?utf-8?B?UWlFZHlzeDZncU1STjQvWG9aYzcrZVlDL0pTWktsUS9ndWlvdVdUaDRyMnFl?=
 =?utf-8?B?WkZTa1N3RmRyR21CRm9wcjFOM3RidVJQaGJ6MC9VdUtGbE40Tm03ZmJ1YmZI?=
 =?utf-8?B?TXliMTVLT2xYMjZmdTNhcnhyWkFCVy8rSy9BenhFU3JQZ0ZMS0VyQVRFZFor?=
 =?utf-8?B?bEVxK3RqWmx2SnBaT2p0MVA0M01UTGFpNFpvdkVQZmNoaS8yaC9senNxazVU?=
 =?utf-8?B?NUJ3WTk4WTNLWmRJRitSSHIrSEROUWxKYS96c1JvTFNKcFNGVDRWNmhjajB3?=
 =?utf-8?B?VkVDVzlxM1VkNzVBMGNjV0JWRm1LbnhYUk5KY1NYOURXQlpvMXY3WHJHUHhi?=
 =?utf-8?B?WnB4UURUR0tkbERyQ2tOVVhVMGwyZWJTa1N5ODJrM1BLMVRXdVhiNjNZeTlO?=
 =?utf-8?B?QlppaWtkSWRUVmRySzA2M2V4TEpRcGVKQmNOU0lPYTNObk14M2JzeXdhZmNE?=
 =?utf-8?B?NmVuU2pybTVCa09ZaVZXbXo2WWJWMUVMOG11V2ZkWENwY2hYcUpjK1R4SmtF?=
 =?utf-8?B?aTYweGE0Qi8vMERlUFR2N0YzL29JS1N0QklOMlV6dm04ZkJzQ2dYOXRMNGdX?=
 =?utf-8?B?cS9QVEI5ZzlOTDh6b2Nqd3lkRmxBUVdqZXdaTThpYWcvbGQ1Tm5RNXNHS3B0?=
 =?utf-8?B?aStaWkdvaTJpM1JtV0RTTy9Nc1o5K2YzaDRhVUdUSVk2a3UwbG8zVUV5cUw0?=
 =?utf-8?B?UnJwV0FyMHF1dTdPN1k0V2hVL3FvYVBhVjByT3pSSC84MVRCQVRKNmhDd3N2?=
 =?utf-8?B?Ykh2dmRFNXFaczVnbmhTMnFyb3FHbmNEUURkcStLK2V4eGtESE1Mc0FmbHJE?=
 =?utf-8?B?SFltbTdoVVR5aDJpM0xtSUZ6TlN6QjBOZldVS3R1aDI4dzViWExrbkxYZ0Jo?=
 =?utf-8?B?UktlUWw0ZGR0Ung1NFh5VGtiSk9xeVZTckt2WmI5S0txUFJ3di9nMXBzalVw?=
 =?utf-8?B?L0h3cCtyZzJpY29TT1diMGtqOUV3alVLOTQrT1hSU1VER09zSndLR09PMTlz?=
 =?utf-8?B?R2h5ZGV0T0ZxTktBaXVyM3Z4bTZ0b2E1c0xyM2h0OGJQZmdMaHNTM2s5WGVZ?=
 =?utf-8?B?SHJZOWd0RElkRm5Mcm82cWJrcitVV3IrMjdEaVdialZLNmt4eU9nSVBCMnlH?=
 =?utf-8?B?OEczelF3T1Z3RS82dWV0djZKM1M0WTc0K1lTV1VXQ0p3NDFIMWJJK29rQW5N?=
 =?utf-8?B?aVM0VlVjNFNEemhsb1hxS0hUOWtSRi8zVEVEaDFQb0w5R3VUSmZBSVdyNTQz?=
 =?utf-8?B?OGJ6emRaSGpFYnBJTTlxRmw5RVVNN1BDcXZZZnZxbjMwTkVqS01aK1BqWUlD?=
 =?utf-8?B?aER6ZTljK2xiTFpKcWVtcjNLaXBJLysySFk4bS9HdnZ4V0pBUWJMaUFtd2FC?=
 =?utf-8?B?NGFpZ1VqeEdSQ05pUjdpK1BwR1dZTzB2TGQ4S1Z4RmhOM2NQeHh2MkV4VzQx?=
 =?utf-8?B?UWtqQm9MN0V6aTVxVFl1MzMxNnFZRENJTVplWnRiMGVCYXlxRXFZYW1Zbmha?=
 =?utf-8?B?cWpkWFZhd1gxS2hGVnRteHVKMnE0SEdFOXJRM0VKZk1CQWVwZ3Z2T2FPZHZ0?=
 =?utf-8?B?YVVrdWNsL2ZhODVTR1V4blhIS1dHdG5tcks0N0lxcE9uSWhlOXIwMTkvVGZp?=
 =?utf-8?B?YmtLNC9TRlFoOUd6dE9sTThCY1h3eG9hQWV1WksxbXNxaVNlMVhxaHFqK2d1?=
 =?utf-8?B?RXNtUG9hS0xLdCs4ajlHd2lGd1R3ekR2NUMvWFBrL0YvTTh3ME5PSURTQ0VP?=
 =?utf-8?Q?wF+k9xaFYrPsHyII67N94dCQ+tPbh01ftPud4v7cyoVReT?=
X-Microsoft-Antispam-Message-Info: d87zKPNXkvr1360XkDUkn9BJL2jMvDxVDL3BPcSFX6bOUEJX5pznQ19w2KNDd36eLcrEkE9lcgCgY0qZsCTMj4JuVADkisPJnbudDCsVpc94xPi5wuZxx+FbNrmUfhJ1uDzsqMjoE0G3Dak7VO8kIYQQMEOtaFpqb/yGfZBseQ6tY0u5F27oNTDUmvylZlaQ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:tGodBp28/3/EItBUHXZ3gdLPMLiHIwGz9Tr68NHKYv4g7LdLmGorWDzet9J4iomy7Jw6sT84AXUBGZkTvg191arhiKiVMnCaa2t57WvGUEZVWZDF2yrm1LIpPEOrz1aV5UKSJmKZXhNYJyflQcsQe91LGkzUM6wcTbree6iPy58zbm3rwDcBA/0jev8fBaF59YkvsdCQQA11dW7+t8TvmE4q1dzReu6I7Hq1qAMzIT7Qs7/0QVCttNH53sLOGGVQOktLUM4SiIlt4y811F7PQrYAZZodpHiR10uuxu1M2mYLd4QtJNNrTyGQJmZM9sCdXlKgSutmnjSdC9xVmG02efQC0KMjNRYpJ96m3aQY4YmJmarrwEtOL15cSRjUmmJYRKXkW7QYTtA/b5UVbrxSkFUTTmysttOtpn+DbA9kkXG7sQCqFkAoii5IX0JjAb/ruJZ7rUpea+lXBkUz3ew8YA==;5:iBtcDhQ6H8CfX9zGc1Ra0gYTnysU/Y9yJ4lvBhoDlqe0RGT4CISNoAsXSQCxC1vNI0I8igrHfYIuXhkp3N+KfTJK9QMWjj+j0NNSBgShNTG47TQwUmVA6He4iz2QIkQIAfg5oWPS9jjM5WslrCZk8AvUfOBufRyV21p5wBz/q+o=;24:dc7xc4teQfnoTHkKAiYZ2tJXjl9FZco3ggNUEaz55RMaY2B3yhI7688nr5LxH/lZlQSyLOk7YpTcMD+JR8eFIWraDJ8wGbhWpzX+fQQRxIs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:BVFxqi7iFXFoKfs8mS0Ydbh5cdlnV8n4AJ0olEymK+TcsXXgAwaaEOwQ1Sa70oTcm+5ZFvRwnanZigXBL5L5f2zHVJzxM2ZBHc/irrmUKFwLPqMZYGv4vMJ1ZCF+F+lpmntYIl8rUocto12Mk47BFjVzl6YfawRDqHvmZOs2MGAB8Mq9XqXkdnxqANEnes7vROc9n6ZNLqOx/7yokloNa83t6Fueh/T09S9yCOG6VtunTTspQV0sKZNSb/IM9TmT;20:kdvT9c+0idAUvyhH4DWokC+Sdz+QUqJaaOK6jPQB8UXesXpt8MboQYzsS0Bck7L6yvFlfTE7N0vmdiHIaVc8kNWJHul/pS7JYDwgf02EZ3TkXO/4AApxeRKUJLhgJA+2/4gl10pWi3K8/lFm375R0xKA4WzFWXlcE7ZwGoxpCDk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 14:49:37.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d357181a-f740-44b7-5ebc-08d594bb220e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553658469578349?=
X-GMAIL-MSGID: =?utf-8?q?1596193330913903384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26.03.2018 18:30, Kirill Tkhai wrote:
> On 24.03.2018 22:32, Vladimir Davydov wrote:
>> On Wed, Mar 21, 2018 at 04:22:10PM +0300, Kirill Tkhai wrote:
>>> This is just refactoring to allow next patches to have
>>> dst_memcg pointer in memcg_drain_list_lru_node().
>>>
>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>> ---
>>>  include/linux/list_lru.h |    2 +-
>>>  mm/list_lru.c            |   11 ++++++-----
>>>  mm/memcontrol.c          |    2 +-
>>>  3 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
>>> index ce1d010cd3fa..50cf8c61c609 100644
>>> --- a/include/linux/list_lru.h
>>> +++ b/include/linux/list_lru.h
>>> @@ -66,7 +66,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
>>>  #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
>>>  
>>>  int memcg_update_all_list_lrus(int num_memcgs);
>>> -void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
>>> +void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
>>
>> Please, for consistency pass the source cgroup as a pointer as well.
> 
> Ok

Hm. But we call it from memcg_offline_kmem() after cgroup's kmemcg_id is set
to parent memcg's kmemcg_id:

        rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
        css_for_each_descendant_pre(css, &memcg->css) {
                child = mem_cgroup_from_css(css);
                BUG_ON(child->kmemcg_id != kmemcg_id);
                child->kmemcg_id = parent->kmemcg_id;
                if (!memcg->use_hierarchy)
                        break;
        }
        rcu_read_unlock();

        memcg_drain_all_list_lrus(kmemcg_id, parent);

It does not seem we may pass memcg to memcg_drain_all_list_lrus()
or change the logic or order. What do you think?

Kirill
