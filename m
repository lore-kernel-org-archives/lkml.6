Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966966AbeCAJhC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:37:02 -0500
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:43840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966675AbeCAJg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:36:57 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
CC: Chuck Lever <chuck.lever@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
 <0f90134c-3d40-1d24-711f-e4ab32802bd8@mellanox.com>
 <c1bcd5cc-381d-2d94-1278-f9fb5c9c0b14@grimberg.me>
 <20180227220958.GA21714@ziepe.ca>
 <193aaf91-c9d1-38b1-a89f-45f129ca5798@mellanox.com>
 <d2875648-20d9-43b9-abf1-8ecbf049c4bf@wdc.com>
 <1e7c373f-21bd-4d45-3dd6-68467bf09d0d@mellanox.com>
 <1519844114.28560.216.camel@redhat.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <efc0302c-90e2-2e09-7525-dc9b9e247e73@mellanox.com>
Date: Thu, 1 Mar 2018 11:36:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519844114.28560.216.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(377424004)(51444003)(189003)(199004)(23676004)(65806001)(64126003)(2486003)(54906003)(110136005)(106002)(47776003)(36756003)(6246003)(26005)(77096007)(336011)(53546011)(50466002)(67846002)(93886005)(81166006)(106466001)(31686004)(81156014)(65956001)(76176011)(8676002)(8936002)(2950100002)(31696002)(356003)(4326008)(230700001)(5660300001)(7736002)(305945005)(16576012)(16526019)(58126008)(478600001)(316002)(65826007)(2906002)(186003)(3846002)(229853002)(6116002)(86362001)(59450400001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3249;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT063;1:R7Di+PtbFvO5xdz0jdwTi4YmkpXzulxksOJfFkZGPIf8sF/jRJCzK7RKiAMnv3XxPJPbA5enaGyTLy7XwUYNXedrpY2QI2W/iXUzTKzLDm4dNUoz9+ZBX5LItsxX2+T3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721b721a-a347-4506-7567-08d57f57f752
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:AM4PR05MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3249;3:kMOpa481soaPLqmHsTxZlghmIfYboI2ULZzPJWQq4jaRfNSMk21Ogzc0e2tNapx2hivDPzTNPAVMXhn78kcCkU+7kiM7xj43/iniA/uebpxbqKGcoPh974Aa8pLYUrIrbwsfmXBVMKxLH4LVAmBcKHTtQT0Atre8lhnShpQWoOwb9YbN9YjovMqR96bY6HYQf17ASTWFmEV9YJmjaj2icu1EKc+pv44ldSyJAxZvQ0GhD6/XAgAbfGvqKxqYpIC0cGl0RStBJojEZc23z4tlJMgo1kPXMfwSOfly2EaJ0Pg94rgypjafFWbBuqkmZJfY66C54BtlNhh4zIWCbUEuLUNOVvauSCmFEjyjTkTUOC0=;25:WNtoLQmShniB6Fjbqzvn96NpHr5oY5/8FT9KKRXg1qPgELUJ7hEiINXp5DAYgbCSA+9dTNu8xW0yaoLtiNQkcsYrvHOxvcyLWrEgRAiaQD9toc2devjNBLep05q7OxVgUXiA6fZXAGtZlDrQL1nWkXaxsojAELtsp6IKQWxjtc1uaXGkDuMI+F78PuSOvwe5f7KIWCgHAJfu1Vd1lqQu42/cGJKf1fLUpsMHW/YRTgDwcug3kGfVyTlf8tHCgba2Y3O8x+aqMDZolyn7Bd/PUs6nAhY5xLqNI43IQFaCkzZj6jq7HfhAgO1gbL2hkNYnrvnJZEtoxV06BDYydO9vOQ==
X-MS-TrafficTypeDiagnostic: AM4PR05MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3249;31:K3ojL9XJQrvUiGH9EIakg010gEWgzJcU8CYor8rO3jKkieFMqVZU63QIndSDlM2/NyYQDTNTeKlCqtQxoqzZaU5fPfSswkBoALC2B4nSgZpPbeI3rwEkp3CstGUhxbaaV55euQ9ZfJ394GmZAAcURD4YJXUiePk+ygiWhgtaZnjVaQvF4ktakMGwsNc9J7F0ALGVb9ddt1s+VECzUgE6KIOky+KSUGWzp5Njs+/gmmU=;20:ur0p089MZNoknXGChXwGgNL0Nz1awlTa6iqe9DJuQVuuhZX84H/JZK32iws3JtMo4pVIgbvBBUjFm5Q0so0zfxO/PEef8pkVDgRU7wnVGV+cEWNuzfJoiLyNAIKzud6nG2ai6ikqEHH1ZsGXUck6qEhqKZFGicLatCpWdfsf/ZOinm9jzkRiDMvcsmiRj/1gDed68o5h0umbDP2FludQo9zbOwzI7Q1z+ovJmVYerrGraYyVfzvLKWAzOwNh7YYeN0XNEeRm+CaCwA8tl608p/wQkQaC8yCDxHI50OPrscgPgYUXJ72CANHGfipwD7++kR22VfwfC9wq7lx4xKB9YCAeUQ0HHp5TkWXM5ocObYIyeGXEJLdd0NOfRWulDqlXpzeli2mW/IIpZcPJtyAPoPu5Nx/kaMpsJxsWVc3woWFVLqZKl9KKN8YUMIdNhzgwGFZ1LEKHZz53Qhqf/QHYlAks7xL4nGyno866Ui6P0qCZZhYIJt9F4IUTpoiXWKuF
X-Microsoft-Antispam-PRVS: <AM4PR05MB324942E144EAF5CF1F972ABEB6C60@AM4PR05MB3249.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231220)(944501226)(52105095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR05MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3249;4:BnEoqoiJRRxuEpC3Xk6gF1hZtfeBVbmyAUjJ5zH/d47qSwmjCDdM55XlvzPrCFxuigJXZu5WFvHuuEjMybhywT3nC1t+R/MBPOzLcYywDA7P0m2pcpQY/cCgpoIgiOD3i3Hn6wlX9npJaGo+amY7zH0mn+h2TM49gjBDcPbRiGNqDOiAmbWH2PB4ei0txN5rnwauZL3kdHp+pz0Tev709vlLZsuHutVhS592Bx21Z2+OGw+BhEeb+D6ILCt8/S9BwXK+kvA3rImQyd/VFTT8Ivk/eLig40/5QqV9ecJ+h+2j0z9d19vfI9cB1S7WANXS
X-Forefront-PRVS: 05986C03E0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA1TUIzMjQ5OzIzOjZlSnpTUkFGcVJRQVc4L2hDRmZJRndQUHJ5?=
 =?utf-8?B?UEYvWjNMZmg4TkIxQVQ2OUw2LzQyWTJwK1pPRmwwQ0QyZjNaMHplM0JoVW9t?=
 =?utf-8?B?ZC9id0ZadXppQUlxeDh2eXkrUllDbUkvRHNzS0NOYXFkYlRia1F4Uysrdjgw?=
 =?utf-8?B?QVRnRWlOUHNOd3RCak9XT0NLeEtqcjYzTjF0OTVNRUxMQWlZSVJHVlJack9G?=
 =?utf-8?B?MVpLa3MydjRmM3RuaHV5VXoxakc5YVlkNS9YT2p4NWcvZUFXNDZacHpMektV?=
 =?utf-8?B?RDFHRHpVSVUyNFMweW80Z212ZWludXhocnZKYzIxc1prZTBFbUw3b0h2QXhG?=
 =?utf-8?B?T1lIdVQwUDJsMllncVJ6bFpnZ3JKcFNiNkM0d0JmcnhyQW9FNzR2RGx6YU1T?=
 =?utf-8?B?Tm1CUWttWHdyMG1XUFpCUk02T043aEI1MnArRWdTd3k3Z3pxQURBYnJXajlU?=
 =?utf-8?B?K21RN2pJTjNrejBJY3FCeElrbzJqeE1McndwYTFKV1BQSDNKRERQbVY0aGov?=
 =?utf-8?B?ZTNkMkFEcVhwVEtyVnhiMUhEU1VHTkp3ZVU4NUlrdG14Tytkajl0U2NhaW41?=
 =?utf-8?B?Tm84MXQrLzRRaWNqRkJSTEZBdzBWNkdLaDU4OW5pak5rdFlBUzl3bU1FeXI1?=
 =?utf-8?B?VEIvTGRIcXdDaEJPb1VUOUNnUHlsNHgvTTkyOE9Mb2dSY0N5YmJnZ25xYytT?=
 =?utf-8?B?Uk5kNVFRaklaVDBnR3pWckxUMjNEcVdYNWdlTVRqQWlMQ3h1VXZ0cFc2OTND?=
 =?utf-8?B?KzJmRk5BV0M1NUt2VmdzOG5tQmYxQVJYbHd5TEY1ME8xSTVZYTMxYUcxMnRL?=
 =?utf-8?B?YnlUOTBHa1FuWkRYcW9wbnRuMTVBOG1Nc2cvMlN0WkFxMmVQQWhsY09za05y?=
 =?utf-8?B?V0hZTGRDZkZrQ3UrbXFSUElqTlZxa1lNb1JqRE83bTZNZTY3RE1XRk1jUENM?=
 =?utf-8?B?V1kwUk9aWHo2NkZDRjVHSGtacUNXTUVZN2JjR0VCd0FPQk5CK2o1MHVrTXd0?=
 =?utf-8?B?SHBCbXhxSG1maWdiUDZWbytURXllcWM0Sm85Z1BBc3lDYmNoVWV2RU5oVmNo?=
 =?utf-8?B?RC9UQ0MvYWZGc0ZHNDh0NFhyclllQWpyblIrdFhZZGFRd1ZHcEdWOGcrVzVl?=
 =?utf-8?B?NEMrMTRaVEx0RkNmN2N0alJOdDhvVnN2L09yekwzaThRUWhWdkZ3YU9ObEpm?=
 =?utf-8?B?Nm8rZUc1eklTb3phTmp2clRBNDBPaFFtVFpYNndXUFpMSmpjR3hYSnhyd0NR?=
 =?utf-8?B?MXJVTjZocjdzQS9zODlidUgrNmZnZXhpcyt5aDV0TmNRWTVzdGx4YklSR3Rv?=
 =?utf-8?B?WjRHQ0FkMHBsUXZEdWsvSk9nYW9DTVVOeVJlTlBudXFnOTM2QUFicmFvZW83?=
 =?utf-8?B?QURxTUtVSmdYZGlXVG84SXd5OVFMcDUrdmwzMktjWElOZUVVRkJNNitiaFND?=
 =?utf-8?B?Wjd5dzJWOGZPaTljelRRMHZCSGVqRDBWQTFPbVhjVCs0NzRWU0FZcmJ4Vy9E?=
 =?utf-8?B?QS9ra2hXN25TYlNHYTNXdHQ1eWg2R0dhV0dTODBveWFvUSt6bVRWUldJTVd4?=
 =?utf-8?B?dkV1ZThkamVDMlVQQmYxNVRMTVlFWmx6L3d6RUhxeG5SSXhBcXJ4TzV5UTNV?=
 =?utf-8?B?UTQ1QXg3QlpuME56dkVFekhDRlVwVmk4V3QyNzhneWdUWEJKMm4xL2d5Z0h6?=
 =?utf-8?B?SlVTcHhLdktheDRrN1h1STdQbTR5UzdVb2VsandhSlhUbVBZVGZPVlpTU1A2?=
 =?utf-8?B?ZzZpZjI4eEd3SlIyaHgzQTAzdXFlZUwxNnErMWR0bzczOW9CYlBLankwd3Bi?=
 =?utf-8?Q?vGSKefAJ1URwa?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3249;6:B03FtYP90iImd+VHfTlC4RofNTS0G6fJpoflWiCg6E02XiQEl9yNWzR+6hHbYBDuwtuQ/PVLwVhAsW4yyHpjpnwYy2A4tCV0okMOr7s/3yrNnNtq7mMTZP9EtI0GVt5koS0JtZonqVOtiUvCrazuuf360WViBalXn21OTbP19uhbvPhvFVOdHBF7zHHP7m0w70X0UBsNu8aEXFrh6H7HVZ7Z/6VJ5xj1iil+lIrReny77rZDWK00c/v3h3S+o3hIoKrjW2RZassxZcX6f+cTXyUdTyAPhumxBE2rbhacYM9jYHv6U+7CIoupQNxujlivULHmW5yiEVIdtT31IdiMpF3nvTpK+TzwlW+8lAe4cRE=;5:3dkAl9e7y+W90ROXGblQPorWWYSE08QaC23T18DshrzQtynuOqVpPIENfklM56pWVrFlprTPxf44h1WJRsqQiuNG2t4EneSiGBrVw90eWUWQ25ejQaKNkb10lGSigjTjSktLBUb+hDmQqVIlTPKqduPqDH7j8xYBU4sRfIXK7E4=;24:9dAWPqZlFec4w19KdjUhF95dXch/FAd+15/BZo1J1mFGlFA0dQkcCd/lRLwfdcK1dmVxOBwzwY8XBrHMN5ZtXy+r9gPyAy3EhMOsbnvQcog=;7:0HhF25jnnc641nLB257ro0WQCVtHa8VtOwYCXKgSjXchXWCI6Wex9xu7DPzetZ9+LxC/A3j5n82d49Uy/D2cWINm150ayOvSHzTqlFfKGmF2/ktuIpJKu+WvohXlIYC8+GVr1Gij+20Goc28AFHsxieS6PUso5lQGBNQ7rxRQ53fxENivxLP2acDaNF8Mw+rttN4KDK0aBs6PGXXfOx5asP8t6pRXoqQE0lGFPd398hxB/cHDMGyiJZtEbfrBGWh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 09:36:52.9333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721b721a-a347-4506-7567-08d57f57f752
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/2018 8:55 PM, Doug Ledford wrote:
> On Wed, 2018-02-28 at 11:50 +0200, Max Gurtovoy wrote:
>>
>> On 2/28/2018 2:21 AM, Bart Van Assche wrote:
>>> On 02/27/18 14:15, Max Gurtovoy wrote:
>>>> -static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc
>>>> *poll_wc)
>>>> +static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc
>>>> *poll_wc,
>>>> +                          int batch)
>>>>    {
>>>> -       int i, n, completed = 0;
>>>> -       struct ib_wc *wcs = poll_wc ? : cq->wc;
>>>> +       int i, n, ib_poll_batch, completed = 0;
>>>> +       struct ib_wc *wcs;
>>>> +
>>>> +       if (poll_wc) {
>>>> +               wcs = poll_wc;
>>>> +               ib_poll_batch = batch;
>>>> +       } else {
>>>> +               wcs = cq->wc;
>>>> +               ib_poll_batch = IB_POLL_BATCH;
>>>> +       }
>>>
>>> Since this code has to be touched I think that we can use this
>>> opportunity to get rid of the "poll_wc ? : cq->wc" conditional and
>>> instead use what the caller passes. That will require to update all
>>> __ib_process_cq(..., ..., NULL) calls. I also propose to let the caller
>>> pass ib_poll_batch instead of figuring it out in this function.
>>> Otherwise the approach of this patch looks fine to me.
>>
>> Thanks Bart.
>> I'll make these changes and submit.
> 
> That sounds reasonable to me too, thanks for reworking and resubmitting.
> 

Sure, NP.
We've run NVMe-oF and SRP with the new patch.
I'll send it through Mellanox maintainers pull request.

Thanks for reporting and reviewing.

-Max.
