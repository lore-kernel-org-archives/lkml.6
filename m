Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FD121730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WnqxJgCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FD121730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeHHMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:37:03 -0400
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:6533
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbeHHMhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGGy9tWT/qo2vWKnK1qR7OqgXw3m+ViOiXStLtCD1S8=;
 b=WnqxJgCEa5LUG1lHcJ4I9O7VkpTUCBLP/LDFXzlkxxRushJprFnr953EjmWT/5No0zm2YOvDy+JGZtOUsYA/Ia5uJFbK8LWlpkYaRHNjFr53tz0MQjU7/T+m2vViVq7bxjw87ZHQLiArUQPj8fMRWLxPGZhrIMfRbvnMr9I0y8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 VI1PR0801MB2029.eurprd08.prod.outlook.com (2603:10a6:800:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Wed, 8 Aug
 2018 10:17:46 +0000
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
Date:   Wed, 8 Aug 2018 13:17:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808072040.GC27972@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0102CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::19) To VI1PR0801MB2029.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88426284-4dcf-43ee-a487-08d5fd18317d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2029;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;3:K6braDo1IMwDkLnVYqHb6DYzf700xglEZWrrRDLETQArNrFWIptQr1IyCCYQsfgXEfR+htZoDxpSKS5F8aD8KVQPEKbkNznpyy5QZ5uN449mgCWNXqnIDivHyNageTYcFJmzIyjhZH3Z+6LeyYAXwFr5crH0ZaVawILwmgcGGSgblguxZFxColwsAYzEtB1iotzwU0+kl93b/ZP5NOw4dWqGXh7IX/Z9HMv8baAUPh14Adcp7r4VTUVZsXbsbJ2c;25:jrCjRbWWcZOEj3VQmguqcIXSly4wMBPUycy59I1CCA1A9mmLco1x9M3Hg8lYzG21KncD/kHZOc6kUDMW0GtertTDlLALOzwYcDNfdItWcBPqmnKqcM7ENnDAVpHXSztaomADup5cnI+gEDJ5IaIPAXYOvUWvN5XgvXMTT9/mkCcWni4E87bYdzsuzR17UZfpxScMTadSbVLX+nbU2SxrQSXpUpclISekc7jG7X3RzfAv5CTYK78k61F3Yq3oe1SXR7+9naberYxa3Uqh4I0EYgzp6fBluTkC1AGN3n1509aVepEhb4D83poqBWEMh1g6wBMiCgr/njNkmTAXRjt+8w==;31:3+j61/2TXCR4u5Tig2j/jtvk0V6SQS0PgyCqZ7oNNUin2/wSh6UOYipu70c+SmrUwT3rrsHlP+QgHUcu5s4TkZK+HnM5RkwRJH+Fn6J9Bi8cM+Dgi8EGCdiO8TXOt6O1y9My/y8nXxfQfD+Wp8nh3721KN2zCuz9UNOLEP/BRcrAlfVWVZ+1DOGM73MAJ2tdvcnhDFHcDYTIOmyi6Nrsp/KCd8zw95ADkAp4f2w2704=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2029:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:hFK2f7hZpZX4vMqLbY7qakikK9kMXqiCjyxBDeEUjBhdrKI9dFJ/6sgFAnvDLsjtef8CrTwy/QahQt7Bcyj5DZcyOfzA+xjjIu6kkVKoyMJOt1Q90CqEHu2cEpMSTRHo6Bp6Zkt25jinVWVYMZsry+tk7mBraiBN4aOOOX+lWzuXG7S8Hn22jFHx3gFE0MMefy48E8tPgvEquq/q9zJ5pymC1VTRF/zTRZWS24tMjizxlXMpe1WDw1LxYmwj0rxM48TS8+SR02g3PUqobqLuUtcfZCdkfQXww3Q0WNWtwPwee2dc/TFQVIbC0Bq5M5gI18dMrqURCqH5RxvkSrs0ekWeCNT7uc2mnyIIIygzoQrymmYlO0IUxHEMA5zywUhuo3Y+nyZXuQTxMAFcJckNkehUaGXwYT7qKn/DRLLJBo2LUX56khsBklrE52ItjBtm2s2gC0AH7jiSKqmFWQymkXkKPLsspxNIdpCIZE7jl/CijIgy6ElofqHvHT3ddlEn;4:lR84zNmujIX5C0kau0Zx6QbVIPKy2YkGosWYhFe++W1fSIB5wMzBTFo0wnABvmO8QO45owAsKZFO9yINp+/w25owoAoZMDVP8y5QYLtOo61oXzqds/qHu3fo2sHMVESVCmXXFZF6UTTpQsFlltP3Cw+9j1QVe9xvdaFKD+59FSzeScf5XaRfeqKe5ETCbmZQ+jf7QQrEKzRb4TdEFlh8WTnhEB+t25S7g3C8ZXfg4cGOs6hcS7563kSjcb/hLM1icYXOIZeAVUNcIS0boxVxZA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2029FA8A44ADF82386664BF3CD260@VI1PR0801MB2029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2029;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2029;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39850400004)(346002)(376002)(366004)(396003)(54534003)(189003)(199004)(230700001)(486006)(8936002)(6486002)(2906002)(2616005)(956004)(11346002)(65826007)(53936002)(31696002)(446003)(5660300001)(476003)(26005)(16526019)(77096007)(7406005)(229853002)(7416002)(386003)(86362001)(14444005)(186003)(478600001)(217873002)(6116002)(3846002)(53546011)(50466002)(316002)(6916009)(52116002)(105586002)(16576012)(47776003)(66066001)(23676004)(8676002)(81166006)(81156014)(68736007)(65956001)(106356001)(7736002)(305945005)(76176011)(31686004)(64126003)(2486003)(52146003)(36756003)(25786009)(97736004)(65806001)(39060400002)(6246003)(4326008)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2029;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMjk7MjM6S3huRDZwNklQUm5aYVFBb0FUdlRkZTlF?=
 =?utf-8?B?N2I5ZFFrVmlScjVvK0FEaWYrcmV3OUJDd1hWVHdOQ1JQamtjNHM3cWFGWG9N?=
 =?utf-8?B?VWVpTW9XM2w2Q1BwSDlBbU9TdnlXZEFrQVgzYXhqTkUxUEVTdWFDVjRuZGNI?=
 =?utf-8?B?QjZZM2dOS3J2RE4rTC9xYjR6VVc3a3lEZWcxV1Y3TjdUVDdZcWdIVWFFNStY?=
 =?utf-8?B?bFhXbDY5OFVVZ0V4NWQ4WnRVREpSOGZDdWlzR082M250dE80bFdiTFgyV1V0?=
 =?utf-8?B?dXArUDROUUhwMDk1emdhTGJNZVVNSkEyUjQ5V1NHUlBNakZKRTNFTGlSbk1Z?=
 =?utf-8?B?bTFJYjFxell2WEN5bFlBanVueGw3OFdzTzJ6R0sxUGlHNGZvbGx5M2N0MGtz?=
 =?utf-8?B?R216NHhhZ3FMSTNvVEJXdklYWGlKd0p4RVN4KzhtVGIvcXRpLzQ2NndIQ085?=
 =?utf-8?B?TEJkNytXNEpxUFFYWVdqT2xUQ0M0NjdBTUxraG1OR1NWZG5aVzdCOUI4OVVr?=
 =?utf-8?B?bkt6RURRcXVGek1YNVl4NXBUZUZwYUkreXVZLzlTSnZEV0NRTGtiZ1EvUVRG?=
 =?utf-8?B?cnlTc0Y0YWRUNW9Ha0dTM1BtKzU0d1UwTnJ0RzlhWmVzL3NsL2ErQmhDK3k1?=
 =?utf-8?B?VFFUelRtOFliYmFuVWpncDZpZWhMZTBQOURraUc2UXNaMnhFNHliZUdLZmNR?=
 =?utf-8?B?alJYQU9RamhpNjlFL085RjhwU296b0ZuS25aUzdQK3Z2aTFiMmFDY1QxN0FE?=
 =?utf-8?B?NXZTYkJnVlNMR1IyNjRQSVJMb3dBbDhMc1hPOVRtaEVnV0s2a0NVVHAxK0Jv?=
 =?utf-8?B?dlFrYkM2dUR3MUFKMXlHNE9HTnNyTUpoVjJyNXBQU2xyUTJaQ0pDdGdkMk5s?=
 =?utf-8?B?SEd0SDdVR0szUXM0VmNRY0VIdFdSeFN2eC9CZ283N05aTzVKb3J2dEpKekN0?=
 =?utf-8?B?NXI1TnpHQ0hZYUtpNllYQ2ttd21waWZGUytJdDAyVHU1VUcvbWp3RFlKZmxJ?=
 =?utf-8?B?TVVqa0ZlcjFxNmRrZmVuM3NXZ3hKUGJYOVE0VC93N3huYkNvUVFCRGdMVmU0?=
 =?utf-8?B?dkdraHBENW1LVDJObW0wNG16bXRPVERuNytSdUVIVXhPQWFKdVMvanV3WDlm?=
 =?utf-8?B?VjRpQS8vc0dTay9TOCt6cGhhWXQ0aWZNeUdpdjZndktyc1h3SC9JUkNXcmNZ?=
 =?utf-8?B?UXR6RVI1WTUzbFVXMExUTFdvbEticGZzWEI0SGhEekIvSU1HU3czL1N5QTZt?=
 =?utf-8?B?SFpUU0lvY3VneTU0YnIrTTJqR0pnL1RhMWl4UHZkNTF1YXpjTVhzSzhQdHJ5?=
 =?utf-8?B?cnhhNjdMWUxTTHJkZ2N6NVR5R0lBQ0licm51UkltVDFjZGxoMHEwdzc1aHh3?=
 =?utf-8?B?blZnck1VYkdHWkNqNk8rMDVzUVZaWVVLZzdSMTA4MnR6U3ppb2lCSFlPdFUy?=
 =?utf-8?B?Q2h3aFFmYkMraGtzTGQwZnNlYjA4Vk5VRXFyWEh5c3FJbGR0ZjZRNUtwQXdQ?=
 =?utf-8?B?VjFacytPd3pZYS8rQ1NkaHhDK2FEbmkzdGtmMTB4cE02c1dQbkdtWFJISUtY?=
 =?utf-8?B?VGdva1BnTXN3ZGlBS3pXWmRSOTgyY0dXMUNkUDNJLzBTeFkrRkwvNEhJTUEr?=
 =?utf-8?B?b1VlbmNjZklwOGVmMUsxQXQ5eGJ2K3lLL3ZnaFFHYXk2eW9jeiszNEZvbnMv?=
 =?utf-8?B?ZlRpeHI2K0h0OHYreWdIWjQwUUlPdTVCZ3BUQndVdU9oTDlKZjBab1pXVWdQ?=
 =?utf-8?B?cXZmRENha2F2cU5YTXk0dzBaZU9qNzFXeUhZU0g0VFgvNzZwQnJwZDl2TE92?=
 =?utf-8?B?Z3BYTUtrMzZVdjNvcXZsUFFPVXZ4NlZXNXJ6N2dsQVRMeFIrdEpFQkg1TkxS?=
 =?utf-8?B?TEY1UlhRcjZ3ekxwY3FUWkkwYWJ3REJrT3pYQ2NndDhZeS9OSXNvV1ZFVVNi?=
 =?utf-8?B?TkhVUlltNlgwQkFnSW5xaXdrOVhUUWNEVnlxV2Z4U3JLRW5vRWRVTS82M1ph?=
 =?utf-8?B?WW9Ia0kzKzlGNnhJNnVERUVlTFNMZG9kZlhaL3NNVzdZaTl6Ni9XQnBMQmM4?=
 =?utf-8?Q?jXV4Ps=3D?=
X-Microsoft-Antispam-Message-Info: RFkCDXSyU+ORK6bBZIMsEPiX3okJnq38e2Ji+hQs6mwTQwhgDbbzTYTFGLB+HitO3ryjJeiAJSDWM2njKWtSQvuT48EHcjqndJ62TVDcPVvvJfh4pCxfBBNms/qVXTVEmZym4hUzy2U3L+j03TVSVLJu3nURpc4y5O5AyfRBFuM+1Tl3Z8VLlIYCPnX+6v1WQoaoxD0hOwaCQa9IroUIcSUhhZljheyJ0qADU/rA99hYZxItoTwMnUnehMKSXzVLAA7RWO7XLtilpmPKO8n0QQfrLHeA9HwJYv1nzkSLl5N+kehUu23Zcw4LkP9tJu64/bmtge0KXjHepNNZN2Nq3ji+iO2oICI10XrkiAkL3SI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;6:pwpmAhhXMIPTXAi9me40JZVDZ6z/6o3UmKeht/35Oe6qyPxcmJgQ/aX+U340TjAVqAyFKcT5svNtDeXJAG89E8rCz3EHPc+q5hVgwzjFc8luBIyRLLbXDYuPPw48gAY3oeQ06yjWknb+t10EoRlqhgdiScG9o/vNOXYYJIj1gh8QCXFYOPOE5wrdi2ZCrymJWoIsuACAaPS1MCz96kwEiB5hIOoil9zUfVroMs/FBlrfSsQF3uZXWbiAj6+eNb3VvhdTRIv8mP+0Q+vCGm0nLNcWz2J4DasaWqYVABwiTweOnoruIOsjirMW3bXgBbn/4RS1AYlsFzXOqyrEkM6Koq3qf8HnK8Hv0rhLBy7hLsOaJJ99ZEjDlspsbwPybQI1IpEF6+8IHhGnndpAmHZfd5QChZ2w+bWuAlU1YimmLhC0jADJ52m7sYZd1zbDRqxIeUSucRYNwgvTyyGMax4PVw==;5:L/O33gY+HqD38zzRd2jCcpcYwyBRj7a0IU/8CAn/2Gv8Q2w18ppzBeGPKgM4rXRtFw+UkneNg1HLvBP91DE6GhDAWqGBWvMHXNZjT2y1YBLMrySbmZxKfDLaJC+toQfzcG7QLxuqafB/93R11QK3r2DQCtD6X8dcGmVs/M7jJxE=;7:q0/rTVBUKlaJbQ15aBzS9NOZwRxo6D3xtNSr865Pe/Cq/Xr7IH8GO72lgR+ibIM08WMa3BV8L3amujow+qy6baNRoGQ3pPCTeSbW1tCjkJRjs+fx1OY6I8RBB8U1g7fhPUPjXVgquTrOISI9lbu2XFSGHTS5oq8n61s/vKmeUFnw6ABMAtn/bICIvjNZvoFmB8rjZH8ZBVBAGuHTbtrKie1e9eaNmN9NpH8xRDHPy+2yxvnG6BiiiF7cmA5OmO0U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:HtnLnlJGFXYdsMg5Zo2qZcolha/whK6DuRUOLMiHBm1qPY2kTG1nnGIVodIwTTkoQF1qO9n9Fl5IHLJw68evuOkAb42ilfuSwfeALa0r5vr3KsaXi0GJKNCXrEzyBrZmTEPD/hnlGPCEQgSR+2KCyzFB1R4+TVpqx6FxO7jFDTI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 10:17:46.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88426284-4dcf-43ee-a487-08d5fd18317d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 10:20, Michal Hocko wrote:
> On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
>> This patch kills all CONFIG_SRCU defines and
>> the code under !CONFIG_SRCU.
> 
> The last time somebody tried to do this there was a pushback due to
> kernel tinyfication. So this should really give some numbers about the
> code size increase. Also why can't we make this depend on MMU. Is
> anybody else than the reclaim asking for unconditional SRCU usage?

I don't know one. The size numbers (sparc64) are:

$ size image.srcu.disabled 
   text	   data	    bss	    dec	    hex	filename
5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
$ size image.srcu.enabled
   text	   data	    bss	    dec	    hex	filename
5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
The difference is: 15158625-15116156 = 42469 ~41Kb

Please, see the measurement details to my answer to Stephen.

> Btw. I totaly agree with Steven. This is a very poor changelog. It is
> trivial to see what the patch does but it is far from clear why it is
> doing that and why we cannot go other ways.
We possibly can go another way, and there is comment to [2/10] about this.
Percpu rwsem may be used instead, the only thing, it is worse, is it will
make shrink_slab() wait unregistering shrinkers, while srcu-based
implementation does not require this. This may be not a big problem.
But, if SRCU is real problem for embedded people, I really don't want they
hate me in the future because of this, so please CC someone if you know :)

Kirill
