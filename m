Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+SxktqYTuXJM+fHoHoxHd4dVC3UEiOXTYhDSGDke26gpXtli+9IyLWuyCWqG1lfnff6Jrr
ARC-Seal: i=1; a=rsa-sha256; t=1522938427; cv=none;
        d=google.com; s=arc-20160816;
        b=U6wakuToYUuM2sVrPcpu7GI6sHmrHcXwX/B+wNRkACU5KnoZGhOmS1hnlCmUYHwkGo
         1U7bUIUmI+KJgVJ3XllJTtw8ll4++JcmpntT44aPbwsvhiWJtlXlFfNwmA2IbdWk+WNC
         k9xo5vwWxwYs8hTroABO+6tuojNXJ9BDE5IkmyrvcHzSzQ98adjC/azOcQGAjQP52adE
         KGKLTEvQpijZcZow4xG+QYfug735SOA2ghvpRKUVtIKkW302HjRt21Fb1CpR4LD0pX7n
         Q3yJsfC8XLEoj2aXz8VsI2pkHIP+Eiz1PObC6po44ZHVfUy0LRwQQsXQl79mol+n7i5T
         05ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=WwQMaT/bx/2Py01EOu08nyOFVdnoCXfoYAt9o76cH8o=;
        b=VXaD/gkogVlKcawlBpF4ZAKW4Wzo/zj0OvI5Xoe/qPTncZrOQFBxOtymGaX8QIl3C7
         IfDTunSmVHj8xKMh9ogerPmGYi69FE0kq3yZr6MAF63l5/8jVmdcmNBmFXk2TaNXUbc2
         srMOuUvAlizSAwJ7XKgwAF/r6IMnbNB0SVHg4U1PHme+1FlUPaykCeW2GB/bmgoAaTXH
         c7+wy2uP1z/vv51KxQXSgnveiNscjXnH2lQZg33BaU5jDMWvgCj3kycbI/0roIUU0K9/
         P6gk51UDnL1uNU+s8ABxsr/4lyRlWYr8QaWBEL7mYczsbSk6i48gW901arnQ8ytUYpzk
         ZFLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hvxWXJQG;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hvxWXJQG;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH net-next] netns: filter uevents correctly
To: Christian Brauner <christian.brauner@canonical.com>
Cc: ebiederm@xmission.com, davem@davemloft.net, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
 serge@hallyn.com
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
 <442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
 <20180405140709.GA1697@gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <941de2b9-332f-75fc-f8ac-4059a9b5426f@virtuozzo.com>
Date: Thu, 5 Apr 2018 17:26:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405140709.GA1697@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6f2219-dfe0-4071-71d2-08d59b014d17
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:wZ/5v1C+FMjl5hM2spUh1PQoknotFMs68tT6+UFA+HCCbky3plF7XWHGkPYtCVKhxc7z/SgryK6dNUgyQrp5loDv/ekgFwaLOaFcU8KlvdHIgbmGiAcyKCZDuE7u1cLzFEspUkH/y/jJVkNxhfykNhKXRvXABUxBCQuRFXj/XH4mmAeLanbFAbkDE3zBJgXSC1hPFIyZvIljmF6HXqw1aYv2gjjdFgkeSCrfpJxa3gwYqQCGBvl/NvLmhTvXQjrz;25:KNoO31L/g3ZG4vftsf+A0/dzhdJ7eAEfDQH6Goog8kh+0/6pyKGKlTPnku6JKPzgpCAmx6DNFJ+tFOmyfWqpB/RN/keS4XOmS/PLvEhjvJ/QVD0UsV88OsJCVEYcXfPWOKZ9oS2P3xuPuMcO6AzJEPzFbU/V7YgiZQpoTFpf7W7qbKHKyfbWoDN71E3FDaKmgBp8UUrb6zWTL7PFrrufOwI2sYakrV1ZkMivqSkuDVZ6YcTwKSLnBHaFsizTnsynF1vK/6RCAxjq2O1n8jtqOZu/WJxsXABFzRE9EVOoebOQn9WtbKLcesj1y4GvPGGdXv9pWXYASc1KV/1KdRJGJQ==;31:lhQlB3CiJ7qMhoB5C34/Po5mqQN+7mjSWajr3d3wMsiZF7/lkFh2buqDKRhcnqGwA/J05cxTfbQKbYiWfxaerFaShnP3cQyEP1MhwidhiwMJ2kyZJ4yNs5btMzEVyiV5uA1dwOcaM3FpYoLf2ObUA8zUP4ulBZ+NMKizxUD8qJv1/3nL2FL+EPdGWBLI+wOLw7ZElNhUmRl9nACOWsdSa4qwVZ4gMvyWt3PKzWoeYWI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:J1/XjrH3FkI83bTkNM1vG4iJg1hqvhuaHscgAFKnA6hOzoXVuTh+RyCZIy8jG9+aF8SkeqpqbmSiWkcT4UG8d3wvo5wVBe0KiZvsSN8cg0MCMbKhv6K8SdmOvJbQqbpNo5B3VScqKHSklNuqA/XTnblSCoIZ3/k8GOB+d9R+GCW+uFj6nFpbfqfg1t6AMXzHwgOLaGRETDRecqq/wDxMG1+mhViNJGKfQ9244Y14sIJzbOhShMpyCz8svx7UOCzwOUqpg5Xi3fNuC9zvCjpbjUQvDU6IKeG3/1idDg3ii5RVETc4jFPixixxBzNSNPLgEi+Hi1HJZIjBJoOz0RCi7HCL0Fp+wj6PPQETM4Ao1lzsPvkre2ijQMJwJuIv8SmoyGtMGt16detdOK/2IsXhDjcluPK0D4sV6TmimBN2TktSRS0KHyUruOFVcPj2lr0tWsDPFi9nZ9lsqPh4utUbW9JNDD6P5L74Ooy60aJjc8m6tr5EhcwoB98eK8shUiP+;4:rUnUsp36FqVLXozeF63Af7a0gjCcG4q5A9QYPuCKAx2Abq4dANUxD4uMXZc55lGF/d6U3v+iBAA5L67QSZSasWx9es+tle4itI807V2JnamA8g+zbxRCRUJBNfTWG8G8dbPQNoGEbtTpDNju7hwfHXUgLNzAWW+gCDj+RhQWTyM7Ih83IJ3jI2+474kVZIuXMYJqI1FCfEZFwylI3/eWZopKg/JkMx9ldLWL1Nrj7ZRRnRNJH5cgRsHEf6aclLwJEkQAMgVHv9Rv31yNC00hIw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342214CAD2D16D9006DABECCDBB0@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(39850400004)(366004)(346002)(376002)(199004)(189003)(2486003)(4326008)(6246003)(8936002)(36756003)(3846002)(956004)(106356001)(25786009)(7736002)(305945005)(476003)(68736007)(230700001)(31686004)(6116002)(446003)(53936002)(2906002)(8676002)(2616005)(50466002)(53546011)(11346002)(105586002)(31696002)(6916009)(6666003)(16576012)(81156014)(64126003)(5660300001)(59450400001)(26005)(81166006)(66066001)(23676004)(16526019)(65956001)(229853002)(97736004)(52146003)(65806001)(186003)(52116002)(47776003)(77096007)(6486002)(55236004)(486006)(86362001)(478600001)(58126008)(386003)(76176011)(65826007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6enRqdFUrOEhrM2E0VWF1UUVOUkp0OVNo?=
 =?utf-8?B?Z1g0S0dPV29EVkFZazB4M3VxK1QwUkIycWJGSXFWWm1pcjI2d2VGY2FNVkNY?=
 =?utf-8?B?amZMalI5ajIxUTdNd1J1MGF2SCtSQ1YzNHFhUDZEdTlQNzJ0RkNhTW1vQTVo?=
 =?utf-8?B?Z205bFFYTnRCQXhiaUhkRFdUNXRuREsxT2VXc3pWcXhZL1laSnlyTEhJWkd2?=
 =?utf-8?B?VHJ1aUcwYXdSb3FPTkJzSnJhM2ZzT0ltMWptdUtKUW9pQ3lQUG1rUzIyZ2Vu?=
 =?utf-8?B?K0pPRVk4Nk1JMzhsNGEwLzdMRFM1QTl0UmtseTJuR3pXMitTVVFLamJBV29T?=
 =?utf-8?B?eC90Z1NWczc2clN5UldTT3hSNi9YbXNUOVJQcTRRYnI4K2JBdWlWdy9xb21w?=
 =?utf-8?B?V0k0MndNTi90RTM2dWhEUnd5dGNVd0lORUk4bUN6bnlHeUFaR0JETk9jWExa?=
 =?utf-8?B?dlFtL0lkQ2FvNTJBMnR3YXJUMjRiS3FwVGFYeUNEazBlcXhkWkJJY3kvZzIy?=
 =?utf-8?B?d2FSYkZuOXVYbVpzVEUxa1hNV1p3b3JRbFNiNXhOeDJMZzBxM1VhdjBvVytr?=
 =?utf-8?B?OEN2M0xoTnNlUEQ2QTNvZGVPYWpWTk5DMEw4VXB1dDJERGJCQm9pRTJ0UU1D?=
 =?utf-8?B?NFdlaTU1Q3N0bWVVblRjZlNyMG0xa3FTaEhVZzJueFZmcGFGSURZd0psUjZi?=
 =?utf-8?B?azUyNnY0THh3bk1GdXQ0TGNIM21WVEJxMkhEdnRuTFM5d3dpTkhFd280VnpP?=
 =?utf-8?B?OHp1L3NnMENYN1lmYkZnVE56RmlDTFRBa3dLcFh6VXpNcnhZajFLT01GMGI3?=
 =?utf-8?B?UTRwSDBPWUNjOVVSZUZ2TmVSL2o3bWxjSzRnVXpyOXZCVFhwb3MyTHVyV2Fs?=
 =?utf-8?B?M2kyTnlBdFRRY2V6QzZxeEttVXJlbHlGeERUT3ZreFlPYWZBV3hJenVoR3FZ?=
 =?utf-8?B?Q3d6QlBuUFNXQ1lwTE9SOFc5SUs1dEFWYXhGcklBZUxBc3l2VTd4SXZ3dXVF?=
 =?utf-8?B?S0M3Y0dTbTY0akUwOEtyU21xNXVZVnZvT2Q4U0JyYXN4cU5JVkdESzdtYXFI?=
 =?utf-8?B?MVBwM1hPcDFqalphVmRUemVaT0piTDUzSHg2SEFIMTNCR09UVXZpelJYR3hh?=
 =?utf-8?B?Umo4S3dqamxQN2YrNUtjYlI4UmdFak9ucGdUdS9aTXJCNmxuVHgzdUJKQ25o?=
 =?utf-8?B?MGpxaGI1dEJwV2pXeERneHZEb0oxTXk5WE9wQzN4dDlmR0NRT1hOeUJiRFMw?=
 =?utf-8?B?RTBzZGZ0a2pLdExqQm8rRkw5MnJRSEZDKy9PK2xiZ3FSK1N5aWYwKzBOMi8x?=
 =?utf-8?B?allrbGtaWnU3ODg5ZUhmNnhwNTBhbEhzOTR3MzlvOVIxMjU2VTJnNCs4YkZm?=
 =?utf-8?B?VWtsN2IwY3o5a2hlME5wYUJXOUJJN3lPZkZleFl3d0djRnh4QURUcHV2WE5F?=
 =?utf-8?B?bDlkMloxZlJZc1ppaGVRR2ZoNElUUEJLOHVsaVA4V3h0MXI1M05saC9uUGEx?=
 =?utf-8?B?UjRRczd5TDhZSk1QVnJGMXJUdXVrQjVmZ29oRTMvN0JjNHMwRkg5MGIwQVRM?=
 =?utf-8?B?blU2c1FvanRERXZRZGtrTEhNMjFpOVJSeStSWitDd0crc0lPK28rdEQ5NWhm?=
 =?utf-8?B?YkVIaDRGUTZEbEZmOXMyOHFPYi93SGhWcWtVak0rai9Cek9ROTIxUUlVUXNq?=
 =?utf-8?B?NFM3Ny9wbklLQXNwT0sxelp4QnFkM2M1SjBMT3hUYURqcGZoVXVWTlVLQ1lC?=
 =?utf-8?B?S1N6aTNZSjJxRmZINGhFeVJIeUxCRzZveG8wbWxmMFdUb0ZEVXRSRnpoOHNv?=
 =?utf-8?B?L1RXbGszcVpGT3FGUzYvamVuUHNzWWtlOHZ5VjZwSGlYRGcxVEtodnRwWGx3?=
 =?utf-8?B?WWdtTDMrYjhlbGx1MGhubExZa0NLYkRhN0prMHlVRFB5UGdLVDV6eUZZL2xG?=
 =?utf-8?B?RFJORHNwUWZiNFZoYWVEYnVmQ0xaa3Z4cit4YndtTWtyMGhFUmZBMU9Icjlp?=
 =?utf-8?Q?vjOnXSLu?=
X-Microsoft-Antispam-Message-Info: Crs6YCU8uYrLm0bqgqcIjAKFt5Xxc/B0TZ86z5XaYH7eAbnCklAZZR45BDLEmvXseet5jyDFeWtW6/+sUzxF19Kkbzw6r/T/v9dKdMCzAbudA63CxyjyRS3B6zWH69/Lr52W+3aAF239zmBO345XhsB0PLm1+4cHoAYLMIxhJyITlEgd5ZQE0qlQnwMtD3se
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:Xs95TEc2iekHvJcuFlsozHiUfAcRIKqRQjZJg//8w9B62lpW8Li2pnJQ0x7AOToqtGO6w+IPgaT2BUlr7hvTSXS+AazYupy8TS85PjB0VkgIYPqwHPKafeyWU772iVI+Zt4u4Y8WtK+BkYU7lMdqNI255fv0bMZpMLAL2w/Pz6KKAZMYPU1jy1dnAGN3Vb7KOpaGJKpd1TaIgfPseauy28gvN5867S73IJOx1iy80vl28NEcwt0LiInfVRRdlMBdi9dX49C9rvevGBUG4i8KECPRhXfa7aTOTD7SpkUHQTvt/CFM/koUa8qlo13AHrSjlZ5YsVgpFFe6rx1naGPu16WqUhVt1Sv6lWsoXAcQZDA5BTvliIyZ2lih40T21KrGCXKhIeM9N2dwlzq2VDwH8maoonoKxj1YMUg0E6ve/VixIXXw3Vj6yIsq5V5hysIHazA45Oeq4uJdFBx77s8xVQ==;5:6Ph6+O88KN6vl7Ff/Z6t7Sk+wOPdcpN0gq2O5Nj2wP8KG/unOZX9tGHC+5aWyfSpVtzYRDfZy6h1kYHRRGS3Ceq7RE48fMsJJUQKZ/uHb1E3upCSH6W/tHwk7SF8EjCCT6dZ2y0NpMll6T0Rs4/4x5mi7UgI6wy8ziaOSPorrsg=;24:7W7ZnbrorI2xPp8qtpc+ZqEU6zzVwAu9BsNDGeJVZOJK2jDTZW/quIilUm6cg3JlSvBt0c/c4N6BKAmrZivU6jOQDqs6dTvB97TxmNW1Dcg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:X3N2eO5Q0Ec2vw1Hl5Md3yrJZxnUmZIs+bGN2ATm3DLt5cmkr73L3PBDrgrK2NCSH9WcoXvqFZflJ+dEfmk3EWdOYDQYYvea5AmMgLiCJx2HTfhR0dL/CWyTXnSCcYoFyXm+A+IIGF/rRObcfjBTdsrdHtVTPQtu+QbTzxdknLWPQGBzjgFhNRyiVtMO5tgNXiQXvWUUDbQcKjx9vztRYfFJ2TaDHT75sU0t4yZMwTpBWotix1BFPpTln0vkUY88;20:bn4o48yU2qShEJN3m+agfjpbsP6kKlSG4cPNgkwlqInMI2ghiNJOGZXI1ElDl3aoavYdzDk9r+Vk7zH517tyyypKnxJaCGexi0agUK+zWnXjvw+BpdYPCnQP+4dJmy/4dHVsehcNebimDgzaC4ZJ/brh+jYl+YvYawEJnrCUzi4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 14:27:02.7666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6f2219-dfe0-4071-71d2-08d59b014d17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596916685141599145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05.04.2018 17:07, Christian Brauner wrote:
> On Thu, Apr 05, 2018 at 04:01:03PM +0300, Kirill Tkhai wrote:
>> On 04.04.2018 22:48, Christian Brauner wrote:
>>> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
>>>
>>> enabled sending hotplug events into all network namespaces back in 2010.
>>> Over time the set of uevents that get sent into all network namespaces has
>>> shrunk. We have now reached the point where hotplug events for all devices
>>> that carry a namespace tag are filtered according to that namespace.
>>>
>>> Specifically, they are filtered whenever the namespace tag of the kobject
>>> does not match the namespace tag of the netlink socket. One example are
>>> network devices. Uevents for network devices only show up in the network
>>> namespaces these devices are moved to or created in.
>>>
>>> However, any uevent for a kobject that does not have a namespace tag
>>> associated with it will not be filtered and we will *try* to broadcast it
>>> into all network namespaces.
>>>
>>> The original patchset was written in 2010 before user namespaces were a
>>> thing. With the introduction of user namespaces sending out uevents became
>>> partially isolated as they were filtered by user namespaces:
>>>
>>> net/netlink/af_netlink.c:do_one_broadcast()
>>>
>>> if (!net_eq(sock_net(sk), p->net)) {
>>>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>>>                 return;
>>>
>>>         if (!peernet_has_id(sock_net(sk), p->net))
>>>                 return;
>>>
>>>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>>>                              CAP_NET_BROADCAST))
>>>         j       return;
>>> }
>>>
>>> The file_ns_capable() check will check whether the caller had
>>> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
>>> namespace of interest. This check is fine in general but seems insufficient
>>> to me when paired with uevents. The reason is that devices always belong to
>>> the initial user namespace so uevents for kobjects that do not carry a
>>> namespace tag should never be sent into another user namespace. This has
>>> been the intention all along. But there's one case where this breaks,
>>> namely if a new user namespace is created by root on the host and an
>>> identity mapping is established between root on the host and root in the
>>> new user namespace. Here's a reproducer:
>>>
>>>  sudo unshare -U --map-root
>>>  udevadm monitor -k
>>>  # Now change to initial user namespace and e.g. do
>>>  modprobe kvm
>>>  # or
>>>  rmmod kvm
>>>
>>> will allow the non-initial user namespace to retrieve all uevents from the
>>> host. This seems very anecdotal given that in the general case user
>>> namespaces do not see any uevents and also can't really do anything useful
>>> with them.
>>>
>>> Additionally, it is now possible to send uevents from userspace. As such we
>>> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
>>> namespace of the network namespace of the netlink socket) userspace process
>>> make a decision what uevents should be sent.
>>>
>>> This makes me think that we should simply ensure that uevents for kobjects
>>> that do not carry a namespace tag are *always* filtered by user namespace
>>> in kobj_bcast_filter(). Specifically:
>>> - If the owning user namespace of the uevent socket is not init_user_ns the
>>>   event will always be filtered.
>>> - If the network namespace the uevent socket belongs to was created in the
>>>   initial user namespace but was opened from a non-initial user namespace
>>>   the event will be filtered as well.
>>> Put another way, uevents for kobjects not carrying a namespace tag are now
>>> always only sent to the initial user namespace. The regression potential
>>> for this is near to non-existent since user namespaces can't really do
>>> anything with interesting devices.
>>>
>>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>>> ---
>>>  lib/kobject_uevent.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>>> index 15ea216a67ce..cb98cddb6e3b 100644
>>> --- a/lib/kobject_uevent.c
>>> +++ b/lib/kobject_uevent.c
>>> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>>>  		return sock_ns != ns;
>>>  	}
>>>  
>>> -	return 0;
>>> +	/*
>>> +	 * The kobject does not carry a namespace tag so filter by user
>>> +	 * namespace below.
>>> +	 */
>>> +	if (sock_net(dsk)->user_ns != &init_user_ns)
>>> +		return 1;
>>> +
>>> +	/* Check if socket was opened from non-initial user namespace. */
>>> +	return sk_user_ns(dsk) != &init_user_ns;
>>>  }
>>>  #endif
>>
>> So, this prohibits to listen events of all devices except network-related
>> in containers? If it's so, I don't think it's a good solution. Uevents is not
> 
> No, this is not correct: As it is right now *without my patch* no
> non-initial user namespace is receiving *any uevents* but those
> specifically namespaced such as those for network devices. This patch
> doesn't change that at all. The commit message outlines this in detail
> how this comes about.
> There is only one case where this currently breaks and this is as I
> outlined explicitly in my commit message when you create a new user
> namespace and map container(0) -> host(0). This patch fixes this.

Could you please point the place, where non-initial user namespaces are filtered?
I only see the kobj_bcast_filter() logic, and it used to return 0, which means "accepted".
Now it will return 1 sometimes.

>> net-devices-only related interface and it's used for all devices in system.
>> People may want to delegate block devices to nested user_ns, for example.
> 
> That's fine but that's why I added uevent injection in a previous patch
> series: I repeat no non-initial user namespace will by default receive
> uevents.

Thanks,
Kirill
