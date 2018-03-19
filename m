Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELu3GX+hMr+7Cxvq7fV4c8rcRBNdQeNIOWf2Nz4oGAD2iWZrV2Y1iwHg8mRNDgJ6GJrmxonm
ARC-Seal: i=1; a=rsa-sha256; t=1521460399; cv=none;
        d=google.com; s=arc-20160816;
        b=HKg/am4Xrmvu+KH46OHFirJWm11A8y6gZ04Zc4hO/6jgOitbHlyDPHIKSAfk7Mr0NF
         X/kwnji9uZjL+LYpnJsl4ZcfSInGrXdGka5XzQU5Az4lcJCAK5lG422Bsg4Pd+826lCS
         Ew3/KBBVxh/pOdS4hG5IwQea//aEEfiFc3dsQ7VknGpwck28+2IdKN8m1H6wBd3q9n/A
         +Lgxx+w9qdxGgZjA/+qUEChkaOihahiCBf/mfCxq2htlvE9CLc7dZq6c6ExbA2ZqSTrI
         4849b8n793POig5Sqor+C8LSm/ubcw+kIsMdwWcaZzgOOsy3eE0YAk9fTUIutdp2S0UO
         Gcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=O94hBKPDNEknpITgqqjuTFoIwLWrVrIQXYasNQj7ggg=;
        b=G9GvWbp5FhkCXDTE/ZthuszgqGlAJsG7nSxcX1lxrYU4SA5y9wwga7uSOQ4qC+fAgP
         Ns17n4M5K9pIVyxnw5AxBkLufBxqRox0wHlpxKb+Io7HHYqsz1oJY3C0BG+sKfK9GACL
         eOZDPBS7Ht7nmTc+q+E9sl5Hoxtu8TAFUhrstJ68YUW4oRCdC/rgk6hklmfXieMt7Lfx
         mCtjZ7y2ljCC4KTLc1ON4D31J6ZEZjowmGJmEhvGs7jAeEVneB0Y9ZQLL6kLmK0bDCCh
         Mlghd98xPNBuQmLHzxsEkrD81BBbe/c+WchJthYnurg0/ulI/mkOPJNbYmq4+Xwb6l0z
         6TVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N+psm4im;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N+psm4im;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 1/2 v3] net: add uevent socket member
To: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: serge@hallyn.com, avagin@virtuozzo.com
References: <20180317110826.1581-1-christian.brauner@ubuntu.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e2f7c92b-e9ba-14fc-3ec4-7da78ca4fa4d@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:53:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317110826.1581-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: PR2P264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::31)
 To DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9708d34-4f0b-4a65-3fcd-08d58d8ffe8e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:q6KzW8AbG5xmpDGGzdg+zzwi24+dFxWhGI1gKY82f7oPkv+ra8m8A5KAajwX9yRqpQDN/34PGKXw0zkN9Npqm473XAxMB49jXuXx2SEANqjWxb7z0tg+X6LC2ehiBga/UkpwU4iNWyXxABUCD1238ULXOlMMRdOoxJkpoGqiIiqMPke3Sdu6TUogMgGB+Z5EyS92hSU9mRgX1jiJ/d02WZ7n2Kq3MFM6MLKbKdU7uKYi9UzvabNJt3nEP7PLHoxB;25:VhIueonza5nw4egu7CXXpRdDnQie6xDRBIDUcwmeCkjNGzwV6Z7F6Sj96/N/9XRszpZu2wk+/oSJklh7EW/8Vpv6w7aMhKlKZyuQfoYh4YOwj1+YNAdeamEhBJiGQ8ygg+8oagIrlO6SfUZ8IiGtmQ8sXSop6NhZW9v3QClXaj6F3huDhY0jL+fWICfHcyTuPSrJEOQ3TmT6m83xNXqG4Mp5acLu1MAeY26zpIwuJUervdMGNHanAlcWT4kWS9Us+dIsZoa2FJGPv7G6UIlps3XIIpCAHhhMI0o5+qppqTGDrfvVFpiICoGHmmujdxawj1SRINg8yIj6vkAT7zkq3A==;31:6GeGdzqwU/U36KeMOs7FtTCouiBEGhFhdEGoQIf//8N47OY8ho4v8i5Gs4tkNe/vNoJg+RdGP45qMOIu9paPBMYxKGeNlW4M4VtkoMUyx4c9ENoQqrCHEq8G0rLMvenuhsrbUNW99U8ekWJ55vLwl+1WIZ5ZgcF3Eedb6viR9rUmwRY8kXe2TT2oa8VN0QVo5SdxFHD5h45zQZ/i287rnwAIasrO9UvGJ7IEUr+cRH8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:/F29jApXyCRvH8eGp2QJ8RDmrzM3mqEphyQSU8fUrzqL/GdlXH0fh1TWz1SmyQyWmdvwfr0Cn2D7cAaxy7FPxNoCL0p/Up/OkQCq9kM/bodH/jsiaVPoptZzZUKWutEfimdaLg/sNPXMEX2IOBabIEqLvRi5oX1LSYi3Chga52iq7JEOEH561T5NCdqSrqYEse6lfIqVzVvotcV1yuksSGe1WUIi8sQVBNbDB1XFhdvTQK57jV3nONMI+vGDiB6iUnnokupOFAZ1kAyaCqnzC0aah0/8kvZ5GTf1lF1Pr68Cfgs7IhJNPd1xReW8kkU8kUawl7rFhF7TFnDVEGj0EU4WN+aXKH0M9GKywU39UjPVKASxSGbvsKtdNxz/+M7Re8Ne54z89tknEynMdY1bEM+exLx9Cen2/k7hgAA3yMwqyZSsAjCuZ9b3SMLM0a1RHx97BpBB0RVKZGOPgYctKRuo0JtOxDfYXcIO8wKp+dGxr45OY8+VDVGXuQGScZyz;4:3h4ukQsnpW+Pg/i9bBjkYZD4aRqIK7h3opj1czG5QiKzvxL+QQsXMKsCkE+si5m6+DWCl4OxcvLo8e/49yP06SPhrD8KZi4uTj9ZvfRCJVkZp9+Zokyd1/ls8yFstkGkeE2aaubOVutyh5k1S7bCHbsHBoeoKkpgJ/TxjnQRN6b/Vd7HGNMcKfi1WidRxnCmWq3PjuS4zP5zP1OeRTxSjTFUOZpym/fDaHrT5YoV7RKSrawh/I8ZF9ZH/oBdeMTmmrsUK5Rx+dJwEe6mvtPeOg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336C65788E97D53762511CFCDD40@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(396003)(376002)(366004)(39840400004)(43544003)(199004)(189003)(54534003)(6116002)(3846002)(8936002)(8676002)(81156014)(81166006)(53936002)(31696002)(2906002)(5660300001)(86362001)(105586002)(31686004)(16576012)(316002)(59450400001)(386003)(53546011)(65956001)(65806001)(66066001)(106356001)(47776003)(229853002)(65826007)(36756003)(6666003)(2950100002)(76176011)(107886003)(7736002)(305945005)(2486003)(52116002)(23676004)(52146003)(6246003)(26005)(16526019)(68736007)(478600001)(58126008)(50466002)(64126003)(230700001)(97736004)(77096007)(4326008)(25786009)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6d3dYKzRveWFjeUtuRTBUUXNabDM1Ykht?=
 =?utf-8?B?U09BODRURzhNcXhBMlcvdXVpSUZuUzludFc0MmVLQjhzb1JzM1M0QWVXbFpI?=
 =?utf-8?B?QlFUNFExMTlaNkVMUW1rZmxHNWgreE9QZVJ6bE12YUdnc3NSSlRYN1IzOTdU?=
 =?utf-8?B?OXFLa2taems2UVpETXovUVV2U2JrUzVyMWNNWmY2VWhTay9SVTZsMkFQZDVG?=
 =?utf-8?B?a3V2eXpiMS9sdE9JdXI0Z2Y3VHpadTFZR0IrandYb014TFl1UWl0eTBJRzZF?=
 =?utf-8?B?bW1yUExQWlprTXkvZXV5bXlFWGN5enpENWhBZURidFgxRUZ2NmU1anNjcy9k?=
 =?utf-8?B?ZzM3L1JZUUt6NFlqVFdMMUZJT2Z3RndoSkdmcjNVQ0FBYU12VG15ejFrdGpM?=
 =?utf-8?B?YlNKSm1wUmlWdm5OWFY3SThzQlAzNWhPeFVFc3h4NWZsZnFZeDBDUGkxMTEy?=
 =?utf-8?B?TXgvemtiWjVGamh5NmhtbEtYaFNGWDNTWCtlVSt5Y0hwTEJOK3NuRG1WVFZk?=
 =?utf-8?B?c2FFN08xcEYzS2YwWmN3ZG5sN0F3NW5SUlpkQnovWnJ0YytzZWNBREE4NkFo?=
 =?utf-8?B?d3dhK0dBckhLZjh1T2l3Y3lmWUp0Y0VwZmVuUFVqUXJha0NiTGtaTUlCNWU2?=
 =?utf-8?B?eFk1YmNIN0d6R2luTW1pQTFMckp5SUFaZm9xdFFVcmxRNnc5UUVTVjEvcklo?=
 =?utf-8?B?SnYzZUZkL3ZOU2U2WHhablFaeE9YWnpZMEpjUmtqWGc4dlBDL0VURjJ5Mytp?=
 =?utf-8?B?U1VVKzc4VW1rUnpSK3czNWtWWHl2ZHhzM1ZZczhFWWkvcVNPd00wUlNPbVFO?=
 =?utf-8?B?cG83SURHNnBycTJRZE9nbFNnenozYWN5Vk8rYm5GVFhGTWovbHRGaGV3TXZV?=
 =?utf-8?B?WUQ0Tzl5U2dpVFpaVmNnLy94SzdFSGhhcnZVc2RLZDZuaUgxSW4zRzA2OWJQ?=
 =?utf-8?B?V0VWMVdoODU5Y2hmMGcvVW8xeE1TTEZyMGZCUHVhQkF4Y0tOQW5rTHVWbmNw?=
 =?utf-8?B?cHQzYXVmWW9MVTNpOHNnWW9aeHQzYTRLWmJxTHZHMjBuVjlUL2syMDZwZTMy?=
 =?utf-8?B?SlFWZkdvUW1KS29lWGVQcEVkWFJJTXhaS0dnRXBZbWd0ejFRdHZoUlpXN3kr?=
 =?utf-8?B?VUJXSUtoaVZ0QkZldDZxOHQyQXhMVG0xVlBEcW9kNEMrRXNISTh4KzYvSmlm?=
 =?utf-8?B?QXY3aE1KNTRTSjE1aFJBQzF5TGJSczlBOTlrL2ZpcDJqbno3ajdSNzE0em1V?=
 =?utf-8?B?LzhRMnpKMU1ZQWFVc2dNUmdab1lVenJ4RzV3dEZ6bjhpSDJzV2xRbEp6ZGtW?=
 =?utf-8?B?NXpFWHNQaU90YkpUVmtCTlFiK0srK0NKdmhDT3V5ZnluQ285U05tWWFqS1No?=
 =?utf-8?B?RExoc2grTm9teno2ZkJ0L2lEZW1QVVgyOGc5TkNDb1hHdTZScGxXWmsxNWFM?=
 =?utf-8?B?ZWMvblRIcTNqMklodktPM1V3Q1R1SHdLY0VES0VpNGJmSll0TU55MDF6aUo2?=
 =?utf-8?B?Z0NkaHpGMUkvb2ZYYTQrdGw1Vm5FajUzSXVBZjQ2RmJEbWl5ZjU2UkxsQTFX?=
 =?utf-8?B?NzVoZEI5Z3JSR3NMaFlsbGFZQmJVc2xGRnFSUGMvWkM2Z2gzMlF0eTd4UTMv?=
 =?utf-8?B?YnAxSEt2SUkycitEK0prRUthNitJUmpkdVFSNEYwV1lrc1RrY0lKdWgyYVZp?=
 =?utf-8?B?aXFkbS9kS3FTS3FVV1YxcGgwLzZmejQvMXZXSzYyR2xUWjRYRDEyVTFCQ1Zt?=
 =?utf-8?B?NVdNbHNYTTJDTU1zU0JFK01mem1GdDJGM1ZvMFdjK1hnSmhlMVVjSUJLSERq?=
 =?utf-8?B?NGh6Q1JHN0pjR0FsOWhSN2dLOWRUeGFxTFNTOXRteFRkTm9CRkpTUm42eHlH?=
 =?utf-8?Q?68lf9NLrYPCibmHFHvdTXEC4NIDUwS9XF8?=
X-Microsoft-Antispam-Message-Info: EXpt6HnKOA7iwc+JAEnd+yng06j5xIAb/nctzkzKuaWXZBUjcoLeI3ATUqcWVD0egG08amtoo/Jnwb/RDgVmenTYDVIjkJ6QUbuE/23zgjygcFAZLXTWCWCTMi0gyjYUBZ2cFCtQwKso/kI7WL+lEcHJMoO3k9gkH2A0yvflUtWDScIv3xYIMvp83VjKs93G
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:PAnEyv4vOssQsVtzhI7QFyQvdnKNWkLutY092G1ON6+BTo3nQfan4PGC8NnbSQsrCTvcIv5sb3FGgzFle07Zi0rFdVNcTjtO+yecfGXgxKLzezOQSSJxN5SQcf1ClyPqAVmGYfpdpxr57ganDKXFxsKk4ZpHyFpuMrahNFxxNxwCSToqWuk8oKKgO/Skj7Nt4MTO3bN8R59GNgZtXz9/kVKH+5X01I4snstTJyexshCP6M5GXs4YpeAEx9/Ur7dgFiWd5qVfz9hIsVTSX7PDTXQHvi6D3qDKALf1m/4OO8nQBtOoPhyhm4a+2yeXrt3Mb2ZiZEpTNUt7LoNMjLJXGnDCtEBB8jLhZQ9I2fT4+LQ=;5:Tia/wYF0PbaROWZCknfqcsBcGLE0nczF4+6SWB1WQkAHQb5djDQFzIEY/YfzAfK3c12apRZEmAIDvExHbv3tgnmEWQ2YEnh+IWU+ZllcFz8HDmi5VVnbSdnOPNOhDGS2B+XKbalRjsNEvXECMMUkl+tyDkP9v2u9nPeEcwzSJD0=;24:wOLMK6k+hfEZlrONMCTdqMumMOTQz+vS5Rv9iq/ktHykStsyRcEs1wr+RL4plggEjObDdY7NLWdbaTWdaWPYSRoUG4ynW7uZ5yIEnDHda8Q=;7:ozxDuVwReiF3tcXsGZudPqpUR+VMPreEtDLF+gNDmUTyuSMf4RANpVUBPFmCu6dmOjY0vhmGqm10OJvCQUENMdaklxbOpO454fVleX+caoNU8nfNE9BYJ16a+5cwgOisBkq3kzFtK0xxxOoj30kbO2Jbu3FlQt9bDH6xRL2zJ3mW0HkL3dXPVk1nyj5vQfHrgj4Rq4aEyEsp7+pEGWIla6OwP7y3TtnGK3HTANBfK1MjJwv4DBje8NdcsKxK/Fwo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:Alv4mkF1Ip38K9FHk+h1NPJQoSbawEjE50tWMcZDedz/WmMwmMYSTLAaIWkh7m458YpChZmEv2BdRGhPBW/rGx6kcOWdU0LUdRmGQPA6gO9k2l671T2jL44Lh8vvEXQaXkqrWVIW+6luMYRcg4IVrwTYh9Jbx9xhlWlB8P/OrZw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 11:53:12.5711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9708d34-4f0b-4a65-3fcd-08d58d8ffe8e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595182847034826440?=
X-GMAIL-MSGID: =?utf-8?q?1595366859613147929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for doing this. One small comment below.

On 17.03.2018 14:08, Christian Brauner wrote:
> This commit adds struct uevent_sock to struct net. Since struct uevent_sock
> records the position of the uevent socket in the uevent socket list we can
> trivially remove it from the uevent socket list during cleanup. This speeds
> up the old removal codepath.
> Note, list_del() will hit __list_del_entry_valid() in its call chain which
> will validate that the element is a member of the list. If it isn't it will
> take care that the list is not modified.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> Changelog v2->v3:
> * patch added
>   This patch was split out of the follow up patch
>   Subject: [PATCH 2/2 v3] netns: send uevent messages
> 
> Changelog v1->v2:
> * patch not present
> 
> Changelog v0->v1:
> * patch not present
> ---
>  include/net/net_namespace.h |  4 +++-
>  lib/kobject_uevent.c        | 19 +++++++++----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index f306b2aa15a4..abd7d91bffac 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -40,7 +40,7 @@ struct net_device;
>  struct sock;
>  struct ctl_table_header;
>  struct net_generic;
> -struct sock;
> +struct uevent_sock;
>  struct netns_ipvs;
>  
>  
> @@ -79,6 +79,8 @@ struct net {
>  	struct sock 		*rtnl;			/* rtnetlink socket */
>  	struct sock		*genl_sock;
>  
> +	struct uevent_sock	*uevent_sock;		/* uevent socket */
> +
>  	struct list_head 	dev_base_head;
>  	struct hlist_head 	*dev_name_head;
>  	struct hlist_head	*dev_index_head;
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 9fe6ec8fda28..cbdc60542cab 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -32,11 +32,13 @@ u64 uevent_seqnum;
>  #ifdef CONFIG_UEVENT_HELPER
>  char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
>  #endif
> -#ifdef CONFIG_NET
> +
>  struct uevent_sock {
>  	struct list_head list;
>  	struct sock *sk;
>  };
> +
> +#ifdef CONFIG_NET
>  static LIST_HEAD(uevent_sock_list);
>  #endif
>  
> @@ -621,6 +623,9 @@ static int uevent_net_init(struct net *net)
>  		kfree(ue_sk);
>  		return -ENODEV;
>  	}
> +
> +	net->uevent_sock = ue_sk;
> +
>  	mutex_lock(&uevent_sock_mutex);
>  	list_add_tail(&ue_sk->list, &uevent_sock_list);
>  	mutex_unlock(&uevent_sock_mutex);
> @@ -629,22 +634,16 @@ static int uevent_net_init(struct net *net)
>  
>  static void uevent_net_exit(struct net *net)
>  {
> -	struct uevent_sock *ue_sk;
> +	struct uevent_sock *ue_sk = net->uevent_sock;
>  
>  	mutex_lock(&uevent_sock_mutex);
> -	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
> -		if (sock_net(ue_sk->sk) == net)
> -			goto found;
> -	}
> -	mutex_unlock(&uevent_sock_mutex);
> -	return;
> -
> -found:
>  	list_del(&ue_sk->list);
>  	mutex_unlock(&uevent_sock_mutex);
>  
>  	netlink_kernel_release(ue_sk->sk);
>  	kfree(ue_sk);
> +
> +	return;

There is end of function. Doesn't return is excess here?

>  }
>  
>  static struct pernet_operations uevent_net_ops = {
> 

Kirill
