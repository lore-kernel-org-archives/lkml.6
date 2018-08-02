Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74276C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8A7208EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YrouCAQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8A7208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHBKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:03:34 -0400
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com ([104.47.1.92]:30416
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731781AbeHBKDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkje5KObdeCL9Mg0m2BuDypAqtl41PK80v6lc2wQ36U=;
 b=YrouCAQcrzEIBLPilLobs4ev65kgZCaNkFNDI3PgtrwHnfpbLdJzUW2kRC1IjOqO6XTfiaMuI0//fyTTEUHtydPslVMOx5cZgodtmy19mA5yVF5RktkPvtZhQ5/wk+K66zAWos8kgrtcmA39dOw9X3C+xE5CUQnWnVb0uRU+8t0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2028.eurprd08.prod.outlook.com (2603:10a6:3:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Thu, 2 Aug 2018 08:13:28 +0000
Subject: [PATCH] memcg: Add comment to mem_cgroup_css_online()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
 <20180729192621.py4znecoinw5mqcp@esperanza>
 <20180730153113.GB4567@cmpxchg.org>
 <20180731163908.603d7a27c6534341e1afa724@linux-foundation.org>
 <20180801155552.GA8600@cmpxchg.org>
 <20180801162235.j3v7xipyw5afnj4x@esperanza>
 <7a836e47-f0a4-6802-9b90-cc473e5ab90b@virtuozzo.com>
Message-ID: <521f9e5f-c436-b388-fe83-4dc870bfb489@virtuozzo.com>
Date:   Thu, 2 Aug 2018 11:13:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7a836e47-f0a4-6802-9b90-cc473e5ab90b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0121.eurprd07.prod.outlook.com
 (2603:10a6:207:7::31) To HE1PR0801MB2028.eurprd08.prod.outlook.com
 (2603:10a6:3:50::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f4b231-0139-46eb-23a7-08d5f84fd4b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2028;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;3:mNclvnZSmgsuV7p8PNhNGrq6R6y9UWx2rK9xCnSY8W2JU6ydw0MKBJ6lOzlUOLr2YA1zvXv3OcJ7uejrfie79EqFyowf0rlSahE/0uknFmb7cueRVgMjxrBs/rqgZNPIYBIM7sdgzVTE7WIB6C5bgb0OPpBY+i/YFEvLRBqy54Te794OatzyfwYSViG8+g3EOegT8qgrAH/PzucR48BascC2GzuDnXiRXKflG48+5/f91I12UuNPHqAFUnti/i7X;25:ggT/oChDNQ4l2h6QLaFV8O7+mB/8X1LGwLyil4k76nhF0BHSreXgHgeyqGrXu00Qh412rzO6mYAd8Ourg+bGNWHCoGG1nMflGG3FB84LV0GE9lVgcwtYxAJ/Cf7XGv13FNVskrHc8xzgXmVRJ48qUtze+/kQsdxBy4AXY5DupALnzdfZ45PnwS/4SRfGyydjSgcb4SmG2TyCqyEUlCojZCJltf/Zm7mfjRFHu9IY5QkqGUZ4htbQ6s+nSp0p0PWjA72re9M+0CSsa11eg9i2WVLhtEMuoYrZrEKqb9YvhB5rZZYLm5U6b9wGM1b1k8SlNr0hfUnSgsZZaZ4dzTDR+A==;31:JLkA1GhWkEmdDYmqZuvrYaAtnyE/KkGsYmC8Q4jzFdvWpyd6LpPnIcWu1kE8f1ZKcaEk5o7OmDulo43Nmm0J6k67xeo/u7EkAPQOI/DkZJsjrW6lUP7P5qNw++i091yhuWSXOcvnKLJJIjsLGFKilMyblYlHEZ2mhkTiMIzKLIcPZust2NbdzLXfsgr7I+QTOnWfClVlAYYvl392KWS/IsbYIV2YWZ68ndy/3CEJwBw=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2028:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:fs3OBfaQ4VGo3TloNJQwDEuMgHSMOiIG3s8RDpB3pmyqr4j2TTXonj3NJnryMfhBUWYIWQ62dQ2f2uE1zDurSeDfukApTrTigJP4BQCZfOZhfG9RtMpx0uk0eSD1RT9+gU2VE6ZlO7yIzRsgyoaZJ5/DS2hjjvLciOe+QcfqsxRwraT4pNpEWfUFxLER8zzrwjaw9rOv1CqEU7K2AsWPsx6zeZPsmhLc6JOF5sKlWqQmj+0qLK0ItDFLXd04tWAw0H614+7zBqKctAX0Za+1NyDCmJmqPfRVvAc6eTD2XA5F2ABcF+4xa5MDOYnoTkmo9tZ53CiKHl3v+0jylOy7wXX/Ih/GS0WJwItBkppcdGncUb75FkuohmaF3b1vJXzqPtmIMU9Pmw9Xw+P6A52AikMlgV8sS3qTm/QFF9eN79X2Umcz32zsqGaL1wDaQsxSjrZ9HfT6eaQGXoQrT95OGQCxWpd4+EBj2L5fYO88aPqDh5++0MwxD4F8bAmco3xk;4:AZryrauT4Yt7/BsM1VhE508MXcssU9NtSfOtmXMCUOPQBSvLmcFe5/a5Cb2cJrhT2Eg1vCg50dkdPlMjAK4SIsz+AUVb4QV2RdPAurk2GVtSzLnmoAtHo2M2KRyxLG7aZ5NGUL8nHpV9jZQF6s1+o6QivAIEtsWkQY8A0uOHFtFiUk3XCktC1MDuZ/L2iVT/SwbjczHgFLivxB4Im/ZahzvIHY1JDA6XLo2sTe4sfAZf5IhrOb2aw4CrtCL8s7Ylnb3RlpMnkvDHFtUBNbYfa2WRAplCEtztR1FdT2mB0gNQN7XxYiFQEc5z5aEFtvfr
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20286E3F2C08FE56A5A1F3B7CD2C0@HE1PR0801MB2028.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2028;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2028;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(39060400002)(14444005)(8936002)(16576012)(11346002)(64126003)(86362001)(76176011)(4326008)(52146003)(25786009)(446003)(77096007)(23676004)(52116002)(106356001)(54906003)(97736004)(2486003)(58126008)(110136005)(386003)(53936002)(26005)(36756003)(31686004)(93886005)(316002)(65826007)(81156014)(230700001)(16526019)(1857600001)(105586002)(186003)(31696002)(65806001)(305945005)(6486002)(6666003)(3846002)(2906002)(65956001)(486006)(478600001)(956004)(476003)(6116002)(47776003)(7736002)(66066001)(50466002)(81166006)(8676002)(2616005)(5660300001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2028;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjg7MjM6S1JnZFd5Z1lPYzJPUlF2b2o5TkhMcWpT?=
 =?utf-8?B?b2wvalVJVGdnVE56eVQwSFV1Q3BsMU82eUdzTTdQenhzbzhUYnpoRUY0NmRX?=
 =?utf-8?B?Si9kekNnKzdkK2dlUUxyaittaUFVWGtZdW5rejdwOUtTbEJjeGZMMGZNR29j?=
 =?utf-8?B?UTRlcTZoK0tNR1RvVElZUDFQQ0Noa1BodnFwWFM1RUEvZmhQRGZCZ09IdG1T?=
 =?utf-8?B?QUNvNTZuSVFabE5ISE5UZW1ha0VZemNCTWRwWHVHRGFXcXR4a1d6UHZZRVZU?=
 =?utf-8?B?WDVDS3pNVEYreFJmK3BVU1Rtb0xLOVVmSjduSkhaT2RSM2RVdWlaYnhUQkFE?=
 =?utf-8?B?MTNoMGNQemJrUEc3NFZRQ0hUTHdqRFMvS1A2Zjhlc0NSTDNiaFVVd2g0ak1Z?=
 =?utf-8?B?eEZlUWpxemhvVTNOM2JEcDRyVHB2RDlwQjU1UmRLSCt4ckpMb2hrMmhxSDNR?=
 =?utf-8?B?L0V0WmZMOHFNV2xQOG1tZ2ZwbWgyQ2gyN1F0UTdmWUh3Ym5NRVZlR1hTUmVL?=
 =?utf-8?B?ZkVqdVZKVEhIUjRJME9aUzFoVTh3MExDNHhORlpEOGljak4rVzJ1dElHOGdl?=
 =?utf-8?B?ZGQ3MVVEUkhhcGZMV2ZTZUNlNzdNNk9ZbFJYSWljZzg0K1h4N3QyZkJYbklt?=
 =?utf-8?B?MFdkRXB3b0RCREo1UDh1OEZDYlMwK3VaNmlHU1QxTmdoV1dHbEF2TlRqTFU1?=
 =?utf-8?B?aEJ3VmxGTVZIRDhreDd3YUVkSU9xTGY4eE1YcWVmWExCUjZ6N0JNaFpjcWZT?=
 =?utf-8?B?TTc2WFdCbnVGcG5nbWh5c3RGMW5XYjJ6UTQzc2o3NWxTNDJncjZvZ2Z1U1JC?=
 =?utf-8?B?cis3L3dTRUowWG4xeXNudHZTOGFsQUNocWtkUWdCTHhwZjdhZ3hCc2ZUOGJT?=
 =?utf-8?B?QlpzYXpDZ0FCS2ZGamlDWmd5d1FPekdGUlEyZDNVNzBtbER6QUR6UjZYbC9V?=
 =?utf-8?B?clN2RWlFNWhza3NMOTVUNEpRSDFYYTVLdERRK1k0TENwK0VDQStzY0V0Yk13?=
 =?utf-8?B?bVc0ZFpWdU14dUxkS29VeHYvbjhrYldZRDljRUdNRVFjUXMvQ25WVDRidUlx?=
 =?utf-8?B?VjhGNHlqdURLb0cyYjhvQVhKV3RVb2VybUxXZVJBMXRRSnN2VUZDTW03ZTVH?=
 =?utf-8?B?V2txRVVjN2w3M1FrcncyNXVYZklhZTQ2S3VTMGVxQzJBeXkrNjIzMnRjOVhX?=
 =?utf-8?B?cGtFZThTM0xVb3ROclFPVFNPRnB6RStIQXA4Ykx2STN5TGx5S2VYdENpcmJX?=
 =?utf-8?B?cnZickFpcTgzb212aHl1ZmU4dWlBQjhSUXNQM1BmZHlXdkFqcTVQOFNSblVG?=
 =?utf-8?B?R0NGUVVidXJJcUxYZEY4eS9tM1NxRHdXTjQrS2tFR0htRHNCNTdob3BxT3oy?=
 =?utf-8?B?ekdOR1EydXgzSnJCcDR1czlBYnl0a2ZLVk5SbVd0QXA4TXBCTWRhVXhZZTRK?=
 =?utf-8?B?YWl5d3NUN2FUOUovcjZsN1RNMVV5eTRlNnE3bVBrOVRaVGtMcjFsVlAyZFNX?=
 =?utf-8?B?eWVRb3Y1UEs4YWJxTDR1T2JyWHI1a0RaOUxQaU9QNkdVeks1SUlLZnYvMDdC?=
 =?utf-8?B?SlQ0Si95ZDd1TmUrNnF1Y2hxTnV3eXArVmxtM2xydVh3T1RaTDZLS2UvdUZJ?=
 =?utf-8?B?UU9JQndUYjhzeENNK3lwTnZXeXdXTVRtRVZTZWpTNU1nVUtYT2lIVnMzamkx?=
 =?utf-8?B?c2p1Vkt2Q0N3eHFqT1p1MFM2N3V5RTJMbEYvNS9XM1VkSm9CT0ZOMDA1ejZN?=
 =?utf-8?B?MHlaVjVDM3FUWlpyN2hwUnBKdmxlNklSYVVmTk1HRDd4RVpnbHVZQ2pydlRw?=
 =?utf-8?B?dkREM2o1aUwydGpZdS8xT3dIUk1GTFkwWC9VdExTN3dIeUFaNEdFa0lsYkQ0?=
 =?utf-8?B?SUVqSWM0YjhxRTk4amdVeGttcTlPWkVya2Z1NGU0bVZ6QWdjdTRFa0cwNUZ4?=
 =?utf-8?B?Y3p6SWFJNlR6QmRUa1Jtb2tXeUFjUUdQeHJjZ0Y2N2RzZjV1Uk84bnh0MWYy?=
 =?utf-8?Q?NHpjXBs5?=
X-Microsoft-Antispam-Message-Info: jyav6J+DM69r91hwt6ZwqxFM88TRGYR6dNHswxBOucPgr8Y3Nhqqd3WUEj9YT/ZweYibhjkfQqOhVhObT045j5DYeIw3lq0C+SjvFBgzS4h9f8O6nmldYz2vzDM/wl1sPUh8Daf9UmQLza5kbDzEu+u7/Iyr9DGcaTXofLJPs1TBAunVFlQkSBPorGfnfV2dg3pBlo7eiLvyU17befN9xWGTBP+WFw6M/7KHTOWKs01YVQcUsSags2L4R/Ios9Fe50uOP1grMhg0gjDOqdY2UouDU2tL5mK/yEKfUvg/mY1aHtWQ/3GFba4N07sLyLvwgLwvoUcKQy64rRYcF1BIvEkfAYSzzeKaoelN+TBR70Y=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;6:/FykhygpBvNxBe8qQqeGkQBYKgWpnm7zR5euibURFI2WX73sVWG5qhNV7YI/waqknq6D7K0AEuYKn/ATrIZhfppjvAclacrkgC3NZKNAf4JQU/n4dMdCSs/aD2iVha+yusHCE3xcw6IFP8/YR46OUcws7J4IjhgbRL9cw2qPKR+6JjXo/01b3Rbw52YZg9zln+TBIGJuuLWjMyY8WoNvQSiMTGWoK0lcI8N+bUDe9VFDm4mRddpS20Fw5asYo0h6z/zonUmL+eijH+6c9KgYEEIOTcX3sHXY3CN0ML5IIp7PnC9mtoYdTCWm4GUHLtWKYvCfzTx9Z+flaKKN4jOdYbFV3jyx9w8PctXcZYPgpPjyYmENhfCV+mdYelMp6ZjOGwXYT5B7iUKrm6pNS1MaIX+KXVt/SYbfjfBiYyBp2VjbYeI3N/QRVJTUteYWTS6LM4HumVd84Z+tDbzyode3KQ==;5:/14zrCYn0zNxhUdET7pAXrhnh4WSBO3sEsumt9lViQJyxtghOXd76P6o9bYBs4DrDZq5+yR/9vxUzg0QoeAb8T1JykHFQJq2NzLme5t0GqFVnERuIY8n5+RgH+Ue7FC7mbML/XWN+C6D5tF2iJ4pUR2K/7YUGSNF2Bx/3YurCOk=;7:mKXjoJxvHiiY4iFHKETp2j1UCOuNq396lsEHr5eL0X77wCwGBnhWH8uDLC4p4ToNiVJRRCVikTca/dlxrCLT6PP4tYfxxewXwCDSJRoPYj9Y7hEToSRnun8o3UyisKfMu64C41vwBIeydrA7DKM+LR0IrYVPlcoOIYWClXoOo3KOEr+hc6XGkeikQ8cssfJFuYkdFaNv5DAfX2VZn593L2tPMgEICRhIYEFwEgCBdbFVrg00cnMzuUUItHtdXRM3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:vrOGZlSJNrYy0A3EAww/sXgwawR8bpmkfCV0bWBWg8lesIHpM+TjlXjea/xMVvz3aWBMGrzWnN3HTeBibddJqGIgDn9m3lodq3b4hCDZxpSj6KKiLTiFJfBrH2BW+BPsq12sVfD59bEWPCBx419b9tvtZRCZe4hqW2w06+KtcVA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 08:13:28.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4b231-0139-46eb-23a7-08d5f84fd4b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain relationships between allocation and expanding.

Suggested-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d90993ef1d7d..34e5ff72ce87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4703,6 +4703,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	/*
+	 * A memcg must be visible for memcg_expand_shrinker_maps()
+	 * by the time the maps are allocated. So, we allocate maps
+	 * here, when for_each_mem_cgroup() can't skip it.
+	 */
 	if (memcg_alloc_shrinker_maps(memcg)) {
 		mem_cgroup_id_remove(memcg);
 		return -ENOMEM;

