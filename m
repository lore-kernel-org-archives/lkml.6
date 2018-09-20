Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD34EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5593A2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DReRU2gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593A2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeITVrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:47:48 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com ([40.107.2.132]:35865
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeITVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCB4AQskVeGAViMfNWfEflBnprYQRkLNUoIJu5ELrI0=;
 b=DReRU2gEqANHTvAUC0yrDO/J96orxYbrfGUr8eOWBhqSTLSEMD+OFssHIgp3tbwwmAjhoaUviUS8yp7BgvyD8o7fqioounhyh33L+9N867rXzLQBT1pyxc6hx+CVMuC9ZIM5O3XGq5U9U9GqE3macpYQM3rFlj71RxH+D/yPUdk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 16:03:34 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: md: dead code in md_alloc()
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>
Message-ID: <3003e71d-ede0-0d55-973d-47c1c06e05ba@virtuozzo.com>
Date:   Thu, 20 Sep 2018 19:03:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d357a21a-673e-42e2-1707-08d61f129ed5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:XjzktjwjX9f1mcWLEJsTmln3eIxy9NeBWjsTFEflY/9pyS0T75swttsRUrkqqcM/iW0klbCgtMdf4IwuOeOpKLZxQPAx/j+KU0VDzag70ArcW515XkTDHfrNzMy2ScLzAlzXH7kVikE5IEFgiQIGcV0r22pPO3lECUcPnKgLZTQ7P3WkQp7gm/YUng4WmsVNczVTJbvYfLJRm9EDmpWI+0R0f0ej4q4MukG17C1CWntzNqyiG0lLqEjOxIURvvh+;25:9b/VOrjka2hNsMqMEYjy9tG3LxjweLNnIPeN9jl2iyyYhstGVpBV17LE4wNpqqFz275zaw9EQg7pdRe3G5x9jmWzTe31MID8Bx2UyADt+kKRlXUvkqDH5ArKdEusieX98uf4ibwDwc4+0OQI0m2sEvdkcKBDqG6EnPYNUXJ7HdV6RjhjqEYZMd6KU9IaqpRa81Eo4mDeYbIywb0IzHn6hmWC5AVIM6wZooGQfbjsHqrxk+qq7S+JRFRUoKSyyC918+/S3guk3bRmHdqR1NQ7J1VgX1MeT3Hsfe0vAQyTrrXjU1q+6O81I1phh1fYQ9kkvEPN0zQMkrh3cQFggbTCEA==;31:w/A8OGrEkHsLiRIG3gnCcHSDfgJ2+p+oZEr85n19z6e62cn6SEUDzBzrX+XJmCL9/Phmw6dMVW5wqwagVxys3tSggNbFX2YaMABM7b6q9e6QBgAJYjZ4gzhrDGGiGin43jlfP1gLsG3q7E6Y/OG5O8LSieepxUS2OVS4aPHa6B32PTN0v3eiaYRk+g+BYG4WsKzGDbGriNapQmqam0e3/ApSPW2k2z9lcyYA2XYO82g=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:zsLVECKK/Q/cZMBeJZp7cYwtXivSHP4W9Ir/hchOxMikf4sF1Lutx0sPMAT1yqULaPOzeIqvpPnxJSNIEMy39esAbThfCR0uElnS86Q+jirT64tyETdJUrESnKT78CAI9Rv+pshJoJTIGeITbAOlusSZSamJkNdFlEocQRg0igKKjfdKxszD2M3MoNzrPG1OA81ZN5B/h/RlxyNxTQvcskj/nPHBnGMhgjmrzF3YLX1JvcQsxd1/2aOxJY5nA8meb/MZZymcLuME3+hVgOAf3Q2sJpeXkk5HYr/71J0jePlLx8+4eVKqNjC7chdNIfa8vChLHqDVz4FE842Q7ihACsDMzENqXGbcmI0qXEvRe0G60lOAhfsVu1Nx6col2Fzddpnm7WnFiZFZVDqPHek9arOBKHB3+DDzCsPVG30/2UdGGSv8g3uGfKrecTDamY38n4WbTtsvuRVzSGKUDskTGIzG/1YQXSJx5IMEbfBdudGIHoLIcHFPJ/P8XXlr0who;4:gf500ZhKAcOvOPVst5HPqJo8KXwxpZJodwHrincdZfA26BP57dGVh7J4ENXOoLGl67do/GVMJRns9V5o7VUVDQN//SIyGygbf3mN8c4eh77H3sCbNGILiRfVgqU5L4OWG9TuzmGRvFsG1dmNLj2bEnJgIV0dZoPoTC7UxlVNNBU9mGkdraUrxf2gisyDV/aJEjpIoeeEmWDDBOQe95/y/DPVo0MI/DvCcFzkCMR9J9+VtRa5JMfZxxsbTqDdOWJs+PwwJrMWF5xqHtvieUBzbg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258BCE9C6D67C8FE7B1A6C7B0130@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39850400004)(396003)(136003)(199004)(189003)(65806001)(97736004)(486006)(16526019)(305945005)(478600001)(186003)(68736007)(4326008)(476003)(66066001)(5660300001)(64126003)(6666003)(36756003)(6116002)(3846002)(31696002)(65826007)(16576012)(58126008)(7736002)(2616005)(25786009)(77096007)(65956001)(956004)(53936002)(2906002)(230700001)(110136005)(86362001)(26005)(316002)(47776003)(8936002)(81166006)(6486002)(105586002)(81156014)(386003)(106356001)(50466002)(23676004)(2486003)(52146003)(52116002)(31686004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOlhmTW4zMnAwYTJOQ1liMXYyQW9FRUxvMG1m?=
 =?utf-8?B?ZzBtMmJaUWNoTlQ4Z2tFV2MrVzc3U2pFcjhhT0FGQlpBRURvY2xUd3VINEd6?=
 =?utf-8?B?R05uS0N4bHZYQUY2K3NRWTUrekZZMUlhZlVaaDJXa2tRMVZobFkwdmhpcmFv?=
 =?utf-8?B?emdYbmdjN3lyTS8xN2NZK0wyVmlKdWNna2lkZklJNVY1Q1ltdGNxdks1Qzls?=
 =?utf-8?B?TUxOUFVkU0VzS1lOeU9PeThRc0pHT0hXMkhoVEM1Rit1OXJ0N3RUWk81NHF5?=
 =?utf-8?B?RXpSM1JXUTlVM3Rkc2dBWUV2ZGJudTU5NlZXZ0J0R1FhWkFocDZldkRtMGNo?=
 =?utf-8?B?VmRrWlJUQnk3U3hxMGVMZHJ5WUJDZzYzSnBPaWt0akdZY2ZKRjFybFJtN3pP?=
 =?utf-8?B?TVpuY2FrUGlBYXljWC9IeUtlbjhqTllrR2NXQm96SVJGNUZXZmtyYlR4cGhq?=
 =?utf-8?B?SnNENjljbEw3THdrcnRSNE1heW5MQkh5UjJxMmNDZU1oQTRXZzZiUDRLVkly?=
 =?utf-8?B?M0tKYlh1bTlXeno1SDN0VWhNTlh6bDdndUtBSFErRXdIZXRDNkE5TmtRN05Z?=
 =?utf-8?B?VENKcTRudXBaY2hJdk1VQkRFZ21HVUt4bXRIcUlZMUpZd2lvYnhuTjdOaXc3?=
 =?utf-8?B?a0FUTGVkTFB1YjdBTHhvMHJpa3JpM3lNYTFGTTVTc2Q1TVB4NzFIYU5SMEt0?=
 =?utf-8?B?MFJGVXNDYXJuUTh1ZHdORDNXNzRsTFdVWUNiR3RmelFET0xTaGhuQTgrTG0w?=
 =?utf-8?B?MURzc2JJNFVtKzA3cHpnVHhpaTNnMUFmMXFCL3hJVVZmOTRzam8yeEQ5WFhM?=
 =?utf-8?B?cjlLWE1JL21yRkQ3U0pRNklPTUs1WDYxY2FTbjhQWHlmaWNaZHpzbVJoN3pH?=
 =?utf-8?B?cU5Gck0vTEdIaEYyckc1UDVZWjV4STdCU2N5SHZXVThGb09FSnZVeXFQTWNy?=
 =?utf-8?B?bjhLTTMxQUVzMEN6RGNyeDZWQkRRdXVrSWxFL0Y4d2lYQjNTTDVoOFp6d0xY?=
 =?utf-8?B?VG9qTXJETkNqMlNla20vZ1A4dzlWdURMZVh3eDdYOFFjZzIrV1NtbjFYeUZ2?=
 =?utf-8?B?Y3Y0TU9IRmhKTVU0WE1QMGRxUkFoZXdPT0xTcjdteVJ2ZkZaR3NydE1pMk9m?=
 =?utf-8?B?alNQdnA0MkZ2QVZINTBIQytiaWRUVkFCa21RKzkzd2RCQUp4QnoxaWdGdFcz?=
 =?utf-8?B?bDhuRk1rQ1dGdnFDbFpWKzI0d1o0NGExdG9Lai8yQ1gzSHZudmRCcFBZR3NW?=
 =?utf-8?B?VE9qWDhDQWtEMG9GQkcyK0Jha2wzZy9TdEtkSDJ2RnppOTRtZzlkZGZPckFX?=
 =?utf-8?B?cUt3Slo2U0IwRnBpVHpQZVdWbE9acE82aldHRnVIbkpGQnZDNzluVDFyWGUz?=
 =?utf-8?B?Vk5QdUVtV2hHM2pQZ2xJMHgvWFNvcG9oQTZmTk9FczYyTkROR1lNMUtwWS9F?=
 =?utf-8?B?M05LZzVaOXF6MHd4L1lIMjlaVjNVUk1yV3NnUFhDaFFPQVRpQ1djQVNWVWNu?=
 =?utf-8?B?YUhCcmh2SjBaOTU4L0VQakEvSzR1Nks5d3NMVVVUeTJVT0diRVZkYlAxZ0x6?=
 =?utf-8?B?QzB3WUhaelFFVjFiai9WVUkrSWR1QTVQb1FNWWlHSHVVdFBTeDVTVWNPTUdr?=
 =?utf-8?B?aHFnZUZzOSt2b0Ztd1BrcGZ4dEkyQXhvS2RhTGJPOHA4WFVMZ3JSaTc5Rmpz?=
 =?utf-8?B?c3g2YVpOZGUrMVN5blN3cEhuQTMxcGFMR2VzSXRwWjJpUHVRT21mdFZDZGlE?=
 =?utf-8?B?VnJkSTBDSzF4VUgyakdUZz09?=
X-Microsoft-Antispam-Message-Info: 5CEHRoUVA7b80Nh4GTsD70FBXqaEiSlxCcm/qi+e+BuRm+YmeDQKEv8fdXwwDLL2Od/xF/I27d34wlElXXPpBRL/+UClK8hrpCMSSWbw9BtkLZ1nUqV2w8X5lNYs3xnsXQvnlQUR825wpHyUQ2t3U/NKjtgRnixwJYZthI94dxgX0SrPdv/+cUlER1v72B1QjTXxVdkLrp8VU6o9DLv3cy0PdHaPmPN5lHAj86fFkeiy5I9HaIXGc32Hjk4ynhBB2MZjBnpNtorJXVfUZaq+ViFfZAPvVSb+orXVJfkPBr9K61UxeNUGSH0RXw2YoLRn6bTGi8GUymaQ94mOafoKE0F8ZP3tHD+A3/yf7E/el9c=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:qlsxpbChEASATdv592yoZdOY/vvQxl1oNXiuRlexImp6Q2UVnVkwtG9+zEI2glxEDPbds4ljsBx9ZntKt20R0Gq9XJ84GQ02tOoPEWDgijY/3NWbUozTkaQbZkU5CQ8cMxxCxi2PwXCt0j/mZ4qsdSmto6GJ6Ukl6Jq1s0QFY9T/3gYqO3u7oCyUf9W9V80nwWTucBKrJNDkb+EJHrDdt0RhhkPZUWFuQY7lA3asemj/7GgUGJq1I2LjnHB8BXkTFTlaBCoI9XVdmUnm1dQYc6+JGGFW/FVCZND02AOJObCRx44u4icfNacPTDARlxePmUbF6FMKUDQZNKvfXTGCyCiEBM6kGJJk+qQfdgR+jum1Q1kYlON7ZGf6z3i5gSnIXgRfZ4ra4/PJpwKxs79PJ7Sg9nBxlJLLUU7wvgFFf7Oj5pnZRfIDEWUmm/8fHiSBhSs1Cbq2CNbmR111mQbQAg==;5:qAW9rGYMh2PoJDMrZE8KJaaazNg55REJH+DHPupqSMVuDKIYVjiBKjHe3UWwwPWBd0kYwm9F4gOKkQyRqZgzD6Bx3aIb/Jm+JpR/CMHZdrsdvClkpeFpl3KjmNkD/iNhHJTIsR/rzu2s0UvjBTjp7GjBNapU0Ti9/Npj2B96qLA=;7:R5r3wT5UORi0blWUeku8RTNXQYmsiO65ITP5C2UDP+U2YSHlQjcVz9FmVLSlgZ9A/UY1WNkSi0MB7LMHYlkjUjIj5xY3X3LqnmIl+6X3DAxdBC1zXamafBkS8kNPaMxAsIcQsoLl6o7qCrp/m8zn0jHe+AEG1Imv2ZiiFWu6Qrxa/Et0uXsoRnf/Uxu+VYuRChHKmHbYpUU2jl6q31FuDR7WdAmZz3sTK02564I8BF2QisjgcyAXAAVVBIBhYNeS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:iAStWihUt1wZymZW84Js8SD4jKXsiI8iKDU+blVON8MdMOvJiQn2/aqseUTzRYXJhul373J63uJbzTaNi+S0NFpd0FvOo+I/aFd5arbB6qC0NCTXzkTPhzLL9nZx0TOGy+kOi7LFNxBsVqu72IqPMKPVzea9xoZtLNznRfY3PKE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 16:03:34.9548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d357a21a-673e-42e2-1707-08d61f129ed5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Kirill noticed that the following piece of code from md_alloc(dev, name)
is dead:
	if (name && dev)
		/*
		 * Creating /dev/mdNNN via "newarray", so adjust hold_active.
		 */
		mddev->hold_active = UNTIL_STOP;

md_alloc() is always called with either dev == 0 or name == NULL.

Judging from the commit that added this code:

039b7225e6e98783a7a7e79c52b29c437f29967d
Author: NeilBrown <neilb@suse.com>
Date:   Wed Apr 12 16:26:13 2017 +1000

    md: allow creation of mdNNN arrays via md_mod/parameters/new_array

and from the comment, it seems should be "if (!name && dev)".
But that would also change ->hold_active for created-by-open md devices,
and I'm not sure whether that would be a desirable change or not.
