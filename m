Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937895AbeBUOqA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:46:00 -0500
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:11776
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932639AbeBUOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:45:57 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0f90134c-3d40-1d24-711f-e4ab32802bd8@mellanox.com>
Date: Wed, 21 Feb 2018 16:45:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(377424004)(189003)(199004)(36756003)(966005)(54906003)(31696002)(81156014)(2906002)(106002)(8936002)(81166006)(110136005)(8676002)(5660300001)(7736002)(65826007)(50466002)(305945005)(229853002)(4326008)(106466001)(2950100002)(2870700001)(64126003)(93886005)(16526019)(186003)(23676004)(6306002)(77096007)(336011)(26005)(76176011)(2486003)(31686004)(65806001)(65956001)(3846002)(356003)(6246003)(6116002)(316002)(16576012)(47776003)(59450400001)(53546011)(58126008)(67846002)(478600001)(86362001)(3940600001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR05MB115;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT012;1:+QCmwcTMg5R7sedz7EyepunNaxaS622oRdBjFQY4aEwwfFklQFIlVxYq2slQa1RkUUjUeRmqWL9sgMv3oeQlRuyh7TcbrTDvAQBsG0JS7vAO5F9o28EU1s4CiUibhYYx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84aaf13d-ba72-42ba-2239-08d57939ce62
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:AMSPR05MB115;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;3:wIhp7gDT++29GSueVjzr3Exhsva7Eiji4axn5tbnoZYtN5w0PH/lkN+UhOwwP3xe5CimNT2cHtO/AaXmy/nSarGMHxMDRgNKqoRDBa95HpiD+fpGq3A051/tkYFuvb2gi6cM0ya+t3UKPrBj2Zxi/xxP1iUT5hOsQ6nnFWHolLz4xwJQnK7YySSxm3QV+4/cgm7u/wkXzWM0teKXK31J/4y8zrv3iUH7JB9xXqzL3bs/FxUorLBXAzcVvIP2Xw9Rur5qWOqoPAzk06+W62a62FSwka3/4B5pTFXzbQe+uN1Ou2Ixn1Q1JPuIVnAoogZewDosSOb3jltj8MkDFbexOf+BxQkUDhNafUmfJ5bv0xg=;25:VYz7NL8GT2th9ZVzzZCNVnpgTZ1YpoyZtqC1EEdmpFoHXWpdDuIrBZjUHiY0E96ocWFaU4/t+74HjzT87ddX+3su2zw1R8KFJmpfEgNXYvS4g4joJvMl6L1xXII2+NfeRuUqlQweE936dhFdgr9AkLnGRBf4ySzWb3cDYJ4tq+l27BtKDNN69yIuiL610XX+uxN1Gy4n9YZyOqL4UK1lMdvqDuCKT+X7XSM91Q0m2spZNPJESTMgZVla4Inh1xyLHegX8MmAQmTtLzFq5GKoHfWm1146uKCyX0Uff6PcRIvxH45W/oYhwRpICGNUdYR6/UesJZfHeNMA/SMmTwGrVA==
X-MS-TrafficTypeDiagnostic: AMSPR05MB115:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;31:XFuneIvf9xGaIuCzvLriciL3dI0S3EMkFGyvfFmparBR0eX8rbtB5jjwAidqregYS1jZ0rodI/6BAN665mtpgBhviyoPEV1jiq75mTY+NawlQz33Z5RNxBMpoRkgL+S9jBjhHFTd55MLUMRR2rFpg5w4rZ/H/lxH0HvchTk2qaI42Fu0aMfERq2NvE9aDWLZUvJzlNWeFp7kCV5Stv8LiSXKRSE2uj5598TijuYaZqU=;20:Lks0tws/zu3ZyYW1H7CJCFR9/kuqwER+dqBDhw8nvF2p9vw2oG8PpYdSAgL6uVOuYQiRHk4pmGPkneXu1CfCShHyToeKs1++3uzQwjwWYLe1LYPd+jMlGqPbDAAzkqbSMJFIZWOhqfoxoFKWA80RMzenHoZbinC086IXclcCwTWl2GhepZ+GXAuqunz8j9QR9tLmtj8R3ND523q57t5/Jd10Sr9JV7V/zCKa+soCr2aAW+1T76pqI7LFqpUJ5kw9cqwPzU4NRTx2hLRhWhY/60PlfhXBj8pPMra0Bw0Z7DZI+sytw3Y+M58TwzeVhoS2eH35S2RwN6DJV2D2LcvDa9U2dug8VGSR2sOI31GjvNdGbBU2Fc0bBv2TWHDRLcERNAdEKnkGi2OyhbntQ9gWqkchVWo6yM76LGPSMw5Z2VxgKbUmH5lE7U53IFg1UnlRgwmt3C7E1AUWZAA0XT3gKiBVDJmfHO4OYmrrMeWWSrYf3cyUtWDEfxc6iRqSONKB
X-Microsoft-Antispam-PRVS: <AMSPR05MB115F2569AE2A3282294BE60B6CE0@AMSPR05MB115.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(3002001)(93006095)(93004095)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AMSPR05MB115;BCL:0;PCL:0;RULEID:;SRVR:AMSPR05MB115;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;4:kEy6wP8wcEYaC12H+Lvr60XD8fOW1jPdXReWVrerGkfJF5T/e4t79XgYNugBQyVGqhp68oQFO5H0Zz9bUgncsFkCldGpas2rSNFE4fGbc/C/w06bpyE9v9wDBRaGk1dtZzmMUDjBvjyigN7DEijCz024J+NHuQWyA9Q8N4pgPqdqASFBCyu+bq3muBstY33yrNhntucWULL4y9SO45wsnJ8/cO+kI2bvdkSxyCAVxV0hDdlXRWB1YRAlD4DDea0O5NqOFRRs7JpdbL0WfJkB1i8RyldD32/eVMnBpS6Ltn0TsIIj1fdFFcRNhOZk19gv
X-Forefront-PRVS: 0590BBCCBC
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTVNQUjA1TUIxMTU7MjM6dkdESERNRDd6MDNXU1NVRzNRTmFsKzc4WWx6?=
 =?utf-8?B?M0FJaFl6UFZPdVpiSG9YQTJKc3VMellmaXN2T1Zyem1nY25zNWh5allLR1Jz?=
 =?utf-8?B?NXp1WjdTUGVxUk5IeTBtUGtEUU9GQWxMR3F5U01ZN0ZsM3dBQjRmK2E2M292?=
 =?utf-8?B?V3Rta1hqQzRWQVljQ3pHS3VyR3piWFNKMHcxNVNRWkNZQTJnbXBPVUJ4c2pQ?=
 =?utf-8?B?YjU2aktzRE44d2VsYW9UNnFFc01xMWRJSUtrcENZeW5lRlcwdkdyUExaNnJ6?=
 =?utf-8?B?QjBlM0ZheFJLa0EzYzBuUWoyQTl3eXg0YUdSUHEyRjY4OUJvV2FhZ203MmVN?=
 =?utf-8?B?VnlqZnN3VFVwb3FoV1hzMUJyTEJEOWI2R3paKzdlQnhWa0cveVh5cVIxeEN1?=
 =?utf-8?B?VDYzVnZiVHVZajlHNysxUktMMTNGdExad3h5ZEpZQ0Y0WHIzOE9yNlJLY1NG?=
 =?utf-8?B?VUVCV0lTemZVQVpLbUdkOW1aRlVpcnFuSnZ0MDlkWEl4NFd2bURCUSthRThz?=
 =?utf-8?B?NHNqOXpvMWc5VW9GYVlIdmdFNkV0cy84SFdINWQwVEtVeGQxNVp6TDdlemhK?=
 =?utf-8?B?RUJSV09IUnNBckMxL1ZSb3BJU2ozTGxsci8rTTlIeW1OTjB5UWxpTFlXNzBB?=
 =?utf-8?B?WG5lUlJkSlRYdWNHbDFKWGdIUUZrMjgxZUozYVNKS2U0bFZQUEVsU2pqbmF2?=
 =?utf-8?B?S3lSY1BUT1BWOWZFRUlaS3BsbFdWaDNjMHBrOXZhWTF6YnhmcTcrN001OExn?=
 =?utf-8?B?aWhrSVVwSStqTGRnZ1FkbjJ2RTNRTThybktiOUsvN2VmT1BKQ3VCTmp4MERY?=
 =?utf-8?B?T0wzVDlJZFJ6VzIzcGQ2cVpuNzN3UjQxRXdUelpxU2tiOS92RzBBU2YxZ3Fk?=
 =?utf-8?B?Q0ZRYnJFZ2hBV0ZJZWwyQUx2NHBUZERwcG9hbnYvQmlPckE2R0VPKzdJbXFz?=
 =?utf-8?B?TlMrKzFuNHNjTm1VOUJTTERQOUpkY0U1QzJ1emV1RGl0eWNGY1FGbVMrdUlq?=
 =?utf-8?B?TVZhWGV1S01LZEpkV0ZsenhMeEFpMjlnWWEwcy9pWXgralNYV2pMZzRCUWhX?=
 =?utf-8?B?VEU0TEdZZDJXT29VanBIS213TzV2blZXZ0U2ajFONit2K1lQdkM5RXVGOWdk?=
 =?utf-8?B?UCtza3dsUnNPZnpVaDVweThnUjR6TnJwVGZSeC9VUFVqUXlEUVhvK01KZ20r?=
 =?utf-8?B?YzFDOEFPajFxb0syT1l5WGcxazZobTJGTjhBQ2loc1YwWXZDeVdZYXVmQy94?=
 =?utf-8?B?dndpT0s3NjM0UkdWV0Ryc2JGNmFRWWFEY3Z4eEZIRUo3c1diM2dleHJURXFE?=
 =?utf-8?B?SDRCVTFRS091WXdhNTZXaFJHNmF4RmxrNWdRRW5Pam9nczNiMUZzcXRjOWEw?=
 =?utf-8?B?SDZYaCtyWmV1S2EwdWJQUmtBTWQwSVpCTWNxSlhkY2FxbTV0RjM3UEkvaitF?=
 =?utf-8?B?VXFXaDFyMDM4aGMxczlMalBIemlWQUlIWjd2aXY1cEZ2cDd5azdQOUpnVmNN?=
 =?utf-8?B?QlZGaWYxbWhhQ2haMExCV0NBblFHbkoraXRqL0JJWGhUNTNiZFFiQ3NFU1Z0?=
 =?utf-8?B?RDd2bmNlcU1lQ21wRFQzWVgxWFRoZFdZRGphVEtuRGphWkdIcUhma2x0akhG?=
 =?utf-8?B?enU3MzBwcFVhMHBXeVVtanVlZU5tWjZOeWFPRkM2N3BCUG1hQmh0QUJua05w?=
 =?utf-8?B?RXlyUlFINXhrK1JKbEQvUWlJZmQwNVA2Rm9BSW03cDZDbk95eXBGcDV2YWgw?=
 =?utf-8?B?bnpuNWVhUjMyMGJiZjBEOWV4blptRGtPY3VjTWxYTG9DdUowc01yQXBWcHVr?=
 =?utf-8?B?N1lJS2tybHFndFFxWFJZTDlJR0hHTFVQZ0MxaHBCVUJZUT09?=
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;6:weVY/qVnaLEKKrCbl6OdB9EDZ6FmoRR9Hx2b9s8xxSIdvI1kicBdFxL5pnTA8aG8dgc8oBQWb0ChQd9TVZKA0xG4uICZY9neJ/Zr9/CfV1i/NAoD0o27veTg/0A8WKEVgHbhYoI23H0p4s/ijWSSrbivUt9BFKyPAFPSg7x1fG1735YvJT41+eNbOAoO2IOj38uGhXbvaiccGmgYvZTmCC0BVy7rMk/dh4Sf8jC2v2Zr0Q0qRDpbzMrWVXKNFTty0ZenP/Ur9Nkc/UzZfApircgrVOuatYYMlYcIVCqWO5HzOAyizx7q/Zo58iPqFzh73YAGRCdwJ3wMOdXU5LCW4rOOFy4nRtEmuNrjqCYjrM4=;5:pTjMtpbwwYPT3qCW7XDWicjqnfCNC/9x2/AmynDDuGbbcoSJvhID0kUAUYIFVyMAnxbM/RVeP3W5q85X1vLiGBtmzR9YiQrVmQ3QhrZmkp/tcTIy/oxUfMZjLP/ztnfEgUZp1DWnYm8LX3MkVztaLM9quIiUomxQPct/5zCcZ4g=;24:HEJoGyjW11FZGJBbsBQn88alrBtIZ9ZPpbnPz6JsIFt6V6MFDBBJKx02UZUiLjkfXvtIP5At+iPkwDZHz7lEP2/HA8LYeBFQK7zkIsebT2o=;7:zCg5mpJeX+i61pYYDG2gwHvruSpOR78ALAFVqWSfd0FhbzKn95U64KV38wEbA6dlZx0GTa+rZjtZRniuIKkIj/KyZ4KhbiRI/36bk2Rc4fJJwIXOmRCZUJqT68K2TBSuq0tueKd1J92o2H7BmGvAawJqqafYhTiPBjlRyvb7KKzBIi8cXMQssofaBiWiev0tIKuZDIuoMhzmRHyyeCS6xgwM366rbe4To5KM1zNGvl8oVrwjmF6DsG7ThapCCHMK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:45:52.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aaf13d-ba72-42ba-2239-08d57939ce62
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR05MB115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2018 3:44 PM, Sagi Grimberg wrote:
> 
>>> On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>>>> /* # of WCs to poll for with a single call to ib_poll_cq */
>>>> -#define IB_POLL_BATCH            16
>>>> +#define IB_POLL_BATCH            8
>>>
>>> The purpose of batch polling is to minimize contention on the cq 
>>> spinlock.
>>> Reducing the IB_POLL_BATCH constant may affect performance 
>>> negatively. Has
>>> the performance impact of this change been verified for all affected 
>>> drivers
>>> (ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB 
>>> Direct, NFS
>>> over RDMA, ...)?
>>
>> Only the users of the DIRECT polling method use an on-stack
>> array of ib_wc's. This is only the SRP drivers.
>>
>> The other two modes have use of a dynamically allocated array
>> of ib_wc's that hangs off the ib_cq. These shouldn't need any
>> reduction in the size of this array, and they are the common
>> case.
>>
>> IMO a better solution would be to change ib_process_cq_direct
>> to use a smaller on-stack array, and leave IB_POLL_BATCH alone.
> 
> The only reason why I added this array on-stack was to allow consumers
> that did not use ib_alloc_cq api to call it, but that seems like a
> wrong decision when thinking it over again (as probably these users
> did not set the wr_cqe correctly).
> 
> How about we make ib_process_cq_direct use the cq wc array and add
> a WARN_ON statement (and fail it gracefully) if the caller used this
> API without calling ib_alloc_cq?

but we tried to avoid cuncurrent access to cq->wc.
Why can't we use the solution I wrote above ?

> 
> -- 
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index bc79ca8215d7..cd3e9e124834 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -25,10 +25,10 @@
>   #define IB_POLL_FLAGS \
>          (IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
> 
> -static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
> *poll_wc)
> +static int __ib_process_cq(struct ib_cq *cq, int budget)
>   {
>          int i, n, completed = 0;
> -       struct ib_wc *wcs = poll_wc ? : cq->wc;
> +       struct ib_wc *wcs = cq->wc;
> 
>          /*
>           * budget might be (-1) if the caller does not
> @@ -72,9 +72,9 @@ static int __ib_process_cq(struct ib_cq *cq, int 
> budget, struct ib_wc *poll_wc)
>    */
>   int ib_process_cq_direct(struct ib_cq *cq, int budget)
>   {
> -       struct ib_wc wcs[IB_POLL_BATCH];
> -
> -       return __ib_process_cq(cq, budget, wcs);
> +       if (unlikely(WARN_ON_ONCE(!cq->wc)))
> +               return 0;
> +       return __ib_process_cq(cq, budget);
>   }
>   EXPORT_SYMBOL(ib_process_cq_direct);
> 
> @@ -88,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int 
> budget)
>          struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
>          int completed;
> 
> -       completed = __ib_process_cq(cq, budget, NULL);
> +       completed = __ib_process_cq(cq, budget);
>          if (completed < budget) {
>                  irq_poll_complete(&cq->iop);
>                  if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
> @@ -108,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
>          struct ib_cq *cq = container_of(work, struct ib_cq, work);
>          int completed;
> 
> -       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
> +       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
>          if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
>              ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>                  queue_work(ib_comp_wq, &cq->work);
> -- 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
