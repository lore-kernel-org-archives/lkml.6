Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966143AbeEJPDx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:03:53 -0400
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:35040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965215AbeEJPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:03:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
 <20180510133808.GA10943@lap1> <20180510141836.2qlm676j4675buti@mwanda>
 <f29e851d-c4d7-cd04-dbb7-582adebc2854@mellanox.com>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <49d89081-95d8-e7ae-2903-372a201ff92c@mellanox.com>
Date: Thu, 10 May 2018 18:03:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f29e851d-c4d7-cd04-dbb7-582adebc2854@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::18) To HE1PR05MB3258.eurprd05.prod.outlook.com
 (2603:10a6:7:35::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3258;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;3:QEVUlOidk92vjjsoNz7GOxvUbC+RMPQn5sFGIjMvSljmFTHl8e5iZaq3sUufd+vnVML02G0oJUd1fmjNDgiGMjW5YRNYx5eZ2zctCsbNOnysl4aIc3+f25CEuCVTukZl15Qz7HRmRlaiwCI9BCzEHL6KjUOHliZD0s1LPwMY6dDx2OPUF1f0HP7AHtw+s/ypKbLxGuzSJSXuvinWnAWd1qYnLuxbmaI2k8SXcQKzon3VpWgVxucqC7V16svyLy72;25:0qMBZLnMiDFS9HimhqoAX8DtnkPH7TTkr+CjT6OTHtqydf53adp9C6kVxS4UpgxErMGuiOtFZOu4TE9V7Uq4n5i41R1ptH58BktXubNE4MoUOQTG9C4eX7vdR7jrFs3ZC6GvEa1Kflqk9LMjzOPMdrUlYAB/5A0jn0Az4vvqCW5NBUetqBJ3gfVB1gSLHxvpGGVqDzRiyWy0pCRzSPQZrLLLqIkVvspnZKTu2v6bDv0yAxauUKOCETKQqDq5g0MjrVVYT/46+7PbP8XBV70aoW/BaJgpboeUumf91A6kUmSNOZcoFKyNoe+o5+5glX7ArWiZb5i0XfAPNF0ptKdl8w==;31:LAWGZcEFsPhzlbvsXGBHT5JQ7eYjr5ftqxapFmHSG5GshVilF4oIuudPQ/Bx5woeZ0oZ2DmOZOx+5fdFKFkJowu4CWNJNuXoNdMFPHRAxnwQEkZk9h9BAaIVUXF6Vq1sw9JMf1+2mgadFb4Kc6HGT8lVm7fVQiVtf+/oY8U0CZ0ho07GENarRA+FT/g6/irrmW0pr+ScS+lx/hst13USB5cGh9DXOf0/Y0ZwFF8dC6g=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3258:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;20:gEeohrKPMq5jOmbELuFLX15+qwCe2JCz/bv/4sBkwJ5f2VzVNDWI2GXjyQI6RYnl1QDVj6Jvz5gBVDg3RDXaa+qlXBOti+7MSwTcGDCBjpkmtdSXt9M196ovAY/SKQPSD4/FVC6G5D6sUH9DtdEz7zuYRfhDu6LzlCfqlqtGixsCAYhJON0kkp45zUhpn3D5q9uLYyYUG9nXIB5ZQY8MqlHIsJY78xMZuPq1JQzQ+CFTpTd6CKEpgGg2K/21Soqk1De3jSEExqVN1TiEyk1Hd/ab7cwz1uo094LC8roc16OME4pjKJVNt1GRrP0n/1nJQUhw/GNlDNssnSTJkYd25/XP1tTPgOFG37cDsxwF3W7ZL5iik49oprtIBJRulGaqX5YiolsK6vKDcX1C35jJq+fGDQz70oUZ56hNdMUYWIMtiFEe5HyIn0ekRpse6a7N0KSzXIPSeB9rqm/NWwp0xxKopxGrop9rWUchfDmKvc2ICMVFKYyEgZo0DRXqrlCm;4:KftcQzgKh+F3PJ4F49rL3/rcJPhlynuKwkf4qIXmW3rznbBGY9pPiQ+bR8O/e8bXUkEahMjzDQEbCvdz2aJufKt5sGWLXGEnuXe5cn0i5yrWqCXvcsRauq/Wx/HOTJCdRAvJaGibd1o+mh1q4rFSeJIXwXkqhwnLtu9oC2UEOPeTUAViqt2G+Y4pa4hbYtT/PcSbB9ZfN1GyLDtDGyFhSVxyid9bhy8LX4DNquto3o4z7jh8bCKHbpyIXDBBlf4Zpz6nCQCa3Sedv8nVEIDvVw==
X-Microsoft-Antispam-PRVS: <HE1PR05MB32584BBA3124893090148E2CAE980@HE1PR05MB3258.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB3258;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3258;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(52314003)(31696002)(229853002)(15760500003)(110136005)(316002)(305945005)(7736002)(16526019)(67846002)(478600001)(68736007)(16576012)(58126008)(8676002)(11346002)(446003)(956004)(476003)(486006)(2906002)(2870700001)(2616005)(186003)(93886005)(86362001)(65826007)(8936002)(36756003)(53936002)(81156014)(5660300001)(81166006)(6666003)(65956001)(65806001)(105586002)(66066001)(26005)(386003)(6246003)(53546011)(76176011)(97736004)(47776003)(4326008)(31686004)(64126003)(6486002)(52116002)(25786009)(52146003)(77096007)(23676004)(2486003)(50466002)(6116002)(3846002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3258;H:[10.8.1.14];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU4OzIzOmMxTmJsM09BTjF2K1JEZkdvcmNEcTZRRUVX?=
 =?utf-8?B?UFlVbVZkb1g3ZEc0NytRWnJpNklXNjdwSTlZL2FYQzVyUU83cXdnL0hrZE5F?=
 =?utf-8?B?Z1l2eGNCdTBBS3JWVnVTWitqS2tBWFhBVmNvY0RGTFVsWUJaRzRZTUM3eUQ0?=
 =?utf-8?B?V3J5ZGd3MmUyblF0STB2VU9DMVB0K2I0d25VSnFvSVhBVVpISHRGcFpZd2ht?=
 =?utf-8?B?Z08wYjB3endJM3F1Q0ZoV3d5eG9RSHZBNy9Kb3duTDZvbWZaZmZmUXZIOU9Y?=
 =?utf-8?B?Ly9vcWRsWndnUXV1dEdVR1llK2RkRHRJNFB0cDhLQnFzOGtickhYZnBYK0Nx?=
 =?utf-8?B?aGF3dTAvR2NSV0F2eUFWQnVMUkdCL3FucmZRUlF3NTBhRjBKTURpUHBUeDhr?=
 =?utf-8?B?TWhDb0tRaDBEM3hsUlZoU3VZTjAxZUoycGZqMU1PMm4wUDBxNDYvYy9LaS9K?=
 =?utf-8?B?K3FBRE82UVNLa2VJQ1I1V0dqRGhJVXgzU3VWUGltNlZmL1VpQmV4YnBLM3ZZ?=
 =?utf-8?B?bFU5N3pvYU9UbTFKYVp4VHNwc2FodmYxVlBBNTFnaktsb0N3bEZwSnRRSDN4?=
 =?utf-8?B?TVpQN1g3bEVNM08rNk1XYmlKOWxrUFI5eE9TZ1p0NFlSdUEvZklFcjZKSWRt?=
 =?utf-8?B?LzY1NllJZEdBMW9LKy80TEhzcTh3bnlWZTB2UmJ4NmtlenhTSXJhc1lVWGpS?=
 =?utf-8?B?UHVpUERUUU15MFR5dDhQc2VHQ1ZwaUxob0pwemFmVVpVU2h5cE5CMmxBMXJU?=
 =?utf-8?B?SUlzS1kvRFdSNWNwWWtqaXIrUlRoMVZBbktaZ1hIYnRuK2tNKzNIMjNFN2lp?=
 =?utf-8?B?UjJsVWtNLzBMQXE3VUtzZXFLUTMzRVovK0hxQzhUdGNyaW1pWkpHd1FtMHpG?=
 =?utf-8?B?UnlxQUJJaXQ5K0ZJWGxPY3J0aWJ2eGhpZ0VNS2hYS2hEaFFHV25uRHg0TVpk?=
 =?utf-8?B?SjMrZGpNYm05a1JYajJDeGFyVk9OVjFuV2JnQVhuaVhBM0o5eCtwdkgxUWxJ?=
 =?utf-8?B?NGQ5cXZxUVZDK2tZMU4wZ25OOHBXVW1FM0JiMDYvc1ZjelFZbVp3THZuYXln?=
 =?utf-8?B?dkZGNkMyNm15Rk5ZQ0dnaE9JM3FtNGxEMHRHay96bm9Kb0h1NmF0M0lRYjIv?=
 =?utf-8?B?T2trL1lsWFJ4N1B2WWdQcVAvMm5UMTJpenpCazBTcGZqZEkxbGltSXFUSnFC?=
 =?utf-8?B?V3VtaWNOUlNyUUR6UU94SWhJaWlnV0pGamdPRXh3UGlrOE9UWnpoTDhwTDNz?=
 =?utf-8?B?ZXlGckRvVmkxeUNKK2dwK1dHcTlTVjVtZjhpYTcxSng2WTY3NXhSUHZTcXlj?=
 =?utf-8?B?ZW0rKzNXaFM5K0NTdVRYWjI0alZ4cDFyYUZpMnMzUlgwaGhnbzFCVHNmbGVq?=
 =?utf-8?B?WVFsSW81QUxaSi83RWNnSmJtK3RYSHF0T0FWTEx3cS9RLzU4blUzQkpCaVRp?=
 =?utf-8?B?TmN3TVJLSkVEUThLaEQ5ZmFobGNQbnJJUzQ5VHRYaXkxWEppeGRReTBaM01h?=
 =?utf-8?B?UHhQbC9lVjJPdm1lUlBVV1BNdWV1aUZZTUtXN3lSTVIxaFlqczB5SGJBRDVa?=
 =?utf-8?B?N2c1bnZCMkw0RzlEbDk2TmtlRHg3amJ0dkdNaHpyYS9ldXl4UWt0a1lvMTcv?=
 =?utf-8?B?WEp1M0VsYXJxOWlnVTBwVDZodXYvVnpnWmhYaWdsc2JYS3RpSkl6eUp3Yk5x?=
 =?utf-8?B?NnNJZEVlK2hmWldjZklzSldFM21paWlLeDdsMFlzWDhGTGdyYzBMSGI4anBH?=
 =?utf-8?B?VTI3TXVGR3VZZTFnb3Y3RWsvTUN1QVBuOGYxMUVweEFaTUtvWDB6dkVDZ3V1?=
 =?utf-8?B?NndPbk5FT3o1SDFjcVJ3eldNWnVxaWVmVU1rS1hnZnMrNjVoamIxdm1BZ3Ro?=
 =?utf-8?B?UWpKZFlRaGVvakFFNHJwWjNGd21teHYvZ3g0N29sNVMxRFJ3aTUxRmdkdkRH?=
 =?utf-8?B?VnRCemtRVHFLTXBRVlN5OHRRN2xON3U5MnZKaUpGa29ta1hmbEo2anZ2Smta?=
 =?utf-8?B?Ni90TmN1akFLcXl1Y2Qyd0dyR3BReDkzdzhSNnZBQ3NxN3dwVjFPQ3Z2M3BE?=
 =?utf-8?Q?WQjo=3D?=
X-Microsoft-Antispam-Message-Info: RGqojeC826395kzlATWlzkgXLeVO3G1w2h8fgWo1YHgYelVIkVGBTJeGv22hzzgOQwm6RLBZaCQZThFVlqxRGxvvmu5KhW4SX30bSGgHD9c5aCN20QncoPwCwTZ+3OJnYyAKvYPjPhl9C3eisJltrVWQcwagsp/G5sw2O6A80DlpLooRyQE9pkYKakIyDoAf
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;6:N4Uw/srVP/FALeQVRPCch6Qmb+RMnQyReh2FMebaZWZov05ifBUFilPGA5dzEmS4+hY2N+a+KJmlb3BtHqjOkeImIx703Tv5ACg1uPy8MF+gkUY+z6Q/tkAcz6yLHRWL5LMT1VZ7D1qBI57BOO/8xEwYM0B2SU1xgf2ynDJlcDOrp+qdIXHk++/tUc0dbkO0SV1kQcIvPzmrPt3SVzJh4onCWUD9l81QcphHcnG162oLMYR7FVU/6+bNkpxyY+zYtkJMH0sarX/H08oVhFZfyO2yFVOv1azxJ9KRZOjF72aVin7An0T/ZAyaVBDX+bAkgcaFe9GMSuc+uaXbyBjmeBu+57VCQyKoJespn9J/7ax/8cDRRQRZGl9wuN3RGHwenq4fDZYXxOTlw+vLl8/CTBE3zECf3hLhpChls+6pkUJTeCKo8d4RFqaeN2Z2Ghu3oPyBxDX3MA6Gs6T3sCUWBg==;5:bMst2UkNtrJLNvLQJUH9pLKiwdWqQ/+gFIiXMgvexBJpavM3iJXBn3PX2p/6IoI17GSqIEWl9udUUJkJPsJbxB3bkSMkP70OXNYr7KdvpjnpS2dJS2jfnB30bMWKu8ydvLAYod/O4JnoBpYkfEx+jdqs61fwRHvOGzajkWTOGYY=;24:wY4jDrHI2XLxPj+liE63My+lkbADapgYdguHIknkMO7qz8QQ0uQmUJfequIW1MJ2hpv3sY8SOGJHKxdQAFza4a8WHWNHgHvUMmmJZh7CBfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;7:mjV0734LVIwts4JJ+eelfLPWsmQEaLztf4JVNHGBuh4QXjK8r6dG9nrVuM/09Yw4PlFd604QGKh5R1NhlmNqjVrkenvIvZNzwi3GmAvH2p+wLGDdRngOfV6as2wE1Qc4IhZE4317s9/ptzZ0GlPQiZ6DDjML5383J/J7ZeEWRXuoC8vilM+WFyorXFM+Mssty4OGSUFK+Pabc+VMF5V8NZYZRijZ6KMXoeOSHeQ5RzZextCSOJBSs2x54zMIUZHS
X-MS-Office365-Filtering-Correlation-Id: b414e921-df7a-4847-60bb-08d5b68739bb
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 15:03:43.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b414e921-df7a-4847-60bb-08d5b68739bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 5:36 PM, Tariq Toukan wrote:
> 
> 
> On 10/05/2018 5:18 PM, Dan Carpenter wrote:
>> On Thu, May 10, 2018 at 04:38:08PM +0300, Yuval Shaia wrote:
>>> On Thu, May 10, 2018 at 09:02:26AM +0200, Christophe JAILLET wrote:
>>>> If an error occurs, 'mlx4_en_destroy_netdev()' is called.
>>>> It then calls 'mlx4_en_free_resources()' which does the needed 
>>>> resources
>>>> cleanup.
>>>>
>>>> So, doing some explicit kfree in the error handling path would lead to
>>>> some double kfree.
>>>
>>> Patch make sense but what's bothering me is that mlx4_en_free_resources
>>> loops on the entire array, assuming !priv->tx_ring[t] means entry is
>>> allocated but the existing code does not assume that, see [1]. So i 
>>> looked
>>> to see where tx_ring array is zeroed and didn't find it.
>>>
>>> Am i missing something here.
>>>
>>
>> It's zeroed twice.  alloc_etherdev_mqs() allocates zeroed memory and
>> then we do a memset(priv, 0, sizeof(struct mlx4_en_priv));
>>
>> regards,
>> dan carpenter
>>
> 
> We do zero (twice) on init, that's right. But I think Yuval's comment is 
> valid in case of the driver went into configuration change, or down/up, 
> that reallocates the rings. I'm double checking this.

Well, the flows in which we need to nullify the tx_rings pointer (if 
any, I still need to investigate this) is not related to this init function.

Here we're safe.

Anyway, a V2 is already submitted, please use it for your next comments. 
I think patch is OK.
