Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeA3L42 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:56:28 -0500
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com ([104.47.37.74]:55663
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751735AbeA3L4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:56:25 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [RFC] Per file OOM badness
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
 <381a868c-78fd-d0d1-029e-a2cf4ab06d37@gmail.com>
 <20180130093145.GE25930@phenom.ffwll.local>
 <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
 <3026d8c5-9313-cb8b-91ef-09c02baf27db@amd.com>
 <445628d3-677c-a9f8-171f-7d74a603c61d@daenzer.net>
 <dce6d244-36c7-7452-97f5-7437bd78cfcc@gmail.com>
 <e511ba10-7032-36cc-f22c-2f6bb05f9f6e@daenzer.net>
 <82d5894f-f4ea-98cc-068a-5d470f5267df@gmail.com>
 <aef7f1f3-f7dc-21d5-bf0d-3145e10e2226@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e1ec9d7b-99e3-1e2a-cb47-5e9a0a383703@amd.com>
Date: Tue, 30 Jan 2018 12:56:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <aef7f1f3-f7dc-21d5-bf0d-3145e10e2226@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: DB3PR0202CA0033.eurprd02.prod.outlook.com (52.134.64.174)
 To DM5PR12MB1306.namprd12.prod.outlook.com (10.168.237.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a4f6343-ac88-41e9-bef2-08d567d87ba4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1306;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;3:Wgrkr4yipjuYV5tJEwZxEoAh9UCdKJJ7CDERyWDEwXSPGIqI6KhuIfIvOErwJnmNa8Tc2D1VA5TU1R9bwdk0daAocr8DXm5aGJ3DhRkzIHqF1xd1GlFKzYOKYUbkaINCaoOcmlcT6ugKsduj7Vq9sKwVV/6Ykp5lHQMKjubTVn3K7GHquhRqt7A9dZpkvZ0PsCZ5yjkrwt/spo6DSThBUiJ7HZT5e/YVMMRdbXu4VWtzLGD61Pt2dSfqtHyHkwpq;25:+hGJp2ibGQ5q9BEQfAoxNGCe9YiTc3DFqBwGdih1yrbBJCAwVN44f/MeNMY4CoC3HmkYr1S9zyr3hbpV6InDTNxDbRuTyaEuMghzQXfOB9lvUtTTFta7ud01TSyfzNshAi729u1JS+sTtY3f5gT94zyOzvzUfxKeYezGbjVRj9D2l0rE9xMUZZs/FaFaacyhbkSczXmu9fVL5d/uzPnfEhWrtPvFk5m0P6ghAMSEdy+Bbk+GHO9Q9Q1ifcSsrbFXPIakLhzjrWvMCRXW/NHhENd43xO+Cx+fnbmue/f1aXMqYPt9+TJ53Ujf6O6AsoEXXl3RRJ3JCl6oVRwpHEOaxQ==;31:S19SHQqSx2/QXYlBi5JveFwTHiUwuruC2cgtkQPiUJP4yyGPfwuTYRioR5BMmmd82Ey9l1jAzp5dY2TzP0RH38cxxdHp0bhWtKzDa0Y77/I5+xsPLn47F/8kZ0elKAQ6Gbl86oD9y/ohXa1iPmLd3xc/BuBPXkhLavxKKvKCvT/etded52TPKCTEDzjKmdySITnbOvTJmnWzjzcM5zV8h2bg0XxOFH4xmR4IXWFqLt8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1306:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;20:wO60MJwdxLH6dkMTAkRU4yerVOyCkvUGYZie01cO7ZIlFo+ohlArCdSQZPcT+EXx6ViWrZquQNoUAZrF6jfCv9rcc2ay6/vihkdiVwH/9fA9zhXqXGGDGRiWTMJMutOeopVWX/b8NvxQyXtRnAzAIbCJ6U4hOWemai23IiSSr5rUq/Q3/zx+Tq2Jp0L1vyuf8z+p60NWaDdTCUifmBC5F5yYfknuO+jreR8JYQhZXkRVVIC9ivTNjGyj8eJ77n75/2hofthjzvW81YxSlpgSQeYudOpp9/l4U9Q0S9os4wGuQn88l3pZR9mfXgxpctgKUIcv06GcwRBUva1SHjnmgbp2v7FEijClnOmgneClVHy/I70GD86YEakDUm6SB2EiCJxguA1sTyxsMSQ6ZecVrGbMflk8nA2xR79U1f5vvCsg4qDlVOQ+onAWK+5gfPEb5hjc9ZD1TowrpQkJpbe47O0znwEOnSbDwvUxEoSKQbRsfu9KD1CXXffRluPEkjWr;4:3UOSJA8gehspozobWQkTQsSarXGDm8fRMjKsA4rk6lTCGIJMISFpwOspF9z/fXBt2E3BribdLsjIuld4tV1PfV8Xfp3bI8E2UI8YJZVUzFlm4ofY23937x+XLNcJKrIKmpqtnlhoSNYCIp3MQmIwAnki8E51hU1WaYJImAIV6C+anABeyDJtXaKdQSFh2THskdHgg2r8a5AL//uTclgb56V7R3Wym2ZczdGkR3+tBbxeG89e07jC2lrb7N77Mgpwzlp/jtHIWcbMveVpLmoiyPGyWPRsy4YcFU7QFkO/grzyx3QcVsAv9WvLHFWpYBc8
X-Microsoft-Antispam-PRVS: <DM5PR12MB130677E0C8F26083D758586A83E40@DM5PR12MB1306.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1306;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1306;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(377424004)(199004)(189003)(76176011)(2486003)(23676004)(86362001)(52396003)(64126003)(316002)(72206003)(6666003)(52116002)(47776003)(50466002)(2950100002)(105586002)(6246003)(52146003)(39060400002)(106356001)(8936002)(81156014)(16526019)(65826007)(4326008)(58126008)(110136005)(478600001)(65956001)(65806001)(8676002)(81166006)(5660300001)(186003)(83506002)(6116002)(31696002)(6486002)(36756003)(97736004)(53546011)(305945005)(7736002)(68736007)(53936002)(2870700001)(25786009)(93886005)(59450400001)(2906002)(67846002)(386003)(229853002)(1706002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1306;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMzA2OzIzOmZCRldVTW1DM25IT2lWRVF0ZFFKdzExT0FL?=
 =?utf-8?B?Q0FvaHNkMGt6NmNMMUdLWW9ZRys3MXVScmJsdDNKak1LeTdXajMvVkVmY0Nm?=
 =?utf-8?B?SHBsRlVWak9WOW9rTXJnZWJOOUpZNjdTTUdPb2VBTDZ3cFRxeGpJUG1FdWxE?=
 =?utf-8?B?cGI5aVZsWVQ1QndvaHdscjh5cnE0bGZqaE54QjVhMWFUdDhZcCs1S09pMW93?=
 =?utf-8?B?bEpyK3g2OVl5dldXK3hPL0QyUnhLNlBGNWN2eURxNXkrK1dDNHQxYzYxNDlH?=
 =?utf-8?B?SWxRbnV5V2dMU1pTNGpjaHNkN01qNzhuY1dpNXVuZXVYK3NMSW8wNDFlOG13?=
 =?utf-8?B?VXRrMm1qZHdkV0xyclVpbkx4T09mZHNMUVRXbWJxMkowbFQ2OVR4V1lyUldH?=
 =?utf-8?B?VFVVck0wZy9Bek9ad3lnMUZ6TjBqZElVTVNLQ1J4TE5zMHhFSnJwcVdQenow?=
 =?utf-8?B?MEJ6eVVoK3BITStNME5rcStCODAraGVybnRia3NjSVhNMmJGS1dGVFhNcm8z?=
 =?utf-8?B?MWVGNzBCTWo5VW1FNmxoZThOUEV5U3kwby9CdXVzZE1XQjVJd0dxekVqanRr?=
 =?utf-8?B?Q1NGNUZ6S0lkOVdDREk3aVFWQkdTTm5DQ3k2V3BIdTlxR3hCSTFjenVSUjAv?=
 =?utf-8?B?MDdYaGhBSk96OVN3OVhNbnFEQ1pyRmxGQ0ExaTF1UkdmWnNsYkZPK1ZLZExk?=
 =?utf-8?B?L25MWEE0eHBJUUNEaFhRVjRBNTBNd2U2a3NFNFc2aTdqUU1FdHdqZEpyZ1Zh?=
 =?utf-8?B?R1BpemdrMW5JOVUzUExPaGhBNnplSmQ3T0NqL05mTEhvdGRuSUViZUNURU9I?=
 =?utf-8?B?d09kWXNhemNEYVpJRzJLYjdoaVpMSXVxd1FCMmtmcXJBL0NHcURvUjhXQ1Z6?=
 =?utf-8?B?TWRXY0cxcURPNVdOQ0U4eWpERldaNkwwOVNZTDhnNGxkQ3ZHYjV1WXNickpl?=
 =?utf-8?B?ZFFpZzliSjd4KzJMZnlEMjJmRXIzRG85OXA2eERuZ2p2TzJTSDA1TzU3RVVr?=
 =?utf-8?B?K2tpaXJDS3MzRTBuMnE4UjJuVjl3SDVvNGZhMTdZMFh5ZkJtWDVTNGRjMHFD?=
 =?utf-8?B?b1ladkdKaXprdFVaRHR4bUZqdGsxSlZvd1ZKN0paeE9ZYkxRbzM1TzZwTXZN?=
 =?utf-8?B?MUZnazN1b2JqY1dNZU9JQ2tPbGt5cWhzQXVpUkVqTlFYV0pEN3A5RU00bVV2?=
 =?utf-8?B?N3VhcXpUSFNRVGUyQ3RaMnIzQjl3QUhVaWpndVBlUmtYUitQb3FGeEozWi90?=
 =?utf-8?B?ak56M1dmZkVJSG56WThaRTQ3enFjOHljTCtmU2dGUG5kbHcyZTF2RzRRM3lp?=
 =?utf-8?B?SlQ2eWpqWVIwdmZhL3R6ODAyK2dLNmxXWDFOYjJlcDhxNlRvV3o3MU9tQ2J6?=
 =?utf-8?B?MVZYVDJwVlh4SWZUZGRscUx1WU5GMFhFMGpMOERic1V6WUlKdHZaeTREZ1p2?=
 =?utf-8?B?Tk94TmprTEhtV3grd2w3YnVoZW9GUlpVZzg2dnNYdTU5azlQV0RwcXl6akk3?=
 =?utf-8?B?UlVRaGQzbjNVeUx1MTFaNHhCaFFoNXhFelVMS1Bvb214ZDFRaERkTmZNbUJu?=
 =?utf-8?B?UmV1NlhaYU4yb3BwbUZiZG91eU5KWldZNlZWdGU2aTVrVWZrL1k3bHI5MUkx?=
 =?utf-8?B?TjJhelVlS1NZTlBCRnU5ZkxRQUs3cEs2Z3RLTTNaVjVNNi9sdi93eWVyWmpk?=
 =?utf-8?B?clBLbFluV3c2anJsL0JBM1FMS1o1RDZZenY3a2pDa1IwSytKUmtqYWRnZnRT?=
 =?utf-8?B?OG15V21sMXFkMEN4RlltYmtlcXMxV2U1ci81OURTSlBscWE1anQ3WUdORUZB?=
 =?utf-8?B?UmpKY0dkYWNpbE5HWUFZekFmUUZSSnBaZ0Jna2FVcm9haTBxdS9Ucy9zbFl3?=
 =?utf-8?B?d0F0akRPaCs4MjJrRWl2amhPb05PUFVmRitpZUJSbzdiczdsQ3E3dnBEZjVq?=
 =?utf-8?Q?xjnKTeYS5iGApXwVad4sBQpdHFJbH0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;6:sV6BWNqtn3M3NM9q4y1g6yKcAUpjfh8ZQwYExn2Xx4FFN48cqQNcvL060VgXVFH9clA2YVKFfVkCyNXXYawRXBKxixNpkocTznAni8V8K54e0SAXI0mHvDe0MQy7aoehb/piAFe0efXnuDC9LDAF3D1eL1KoJHp/GDOqWTbRpY5CxSAGJcRgrKP+2ft/nbahD5OetjoFwo13McQ52QmFDlP763As5BKvLNg5/nbkdgAVfo9IuSwHR//kgWWwiwhqJmRAC8E1c2/EujpO2IDIQg7Ho9YPTobQRyDJVAKgRKhTy3vH9eSFtUfUjnKnnM6Sxl24h71Zma3dcUt6JIpehweAIq8cT6DPDhDCtPbLYmI=;5:Y61gnc52MtBrATZ+118XXhBlt0iMV9xB2XcngZtAHPv8Q2QhfnPn6H+oe7hI+HWTQL2CSS24FCIyq/8HGV3ddDPsgYGGxM68rFOyNz+1BE8SqxM8sCydCUNOJnu96CYzdTcka0DE18etTelGEM01WtGewSUE1ksm7UGAS/63dFU=;24:4Qqbqj0rrlq3wVUvsBsp3/V5hPM8WUP1wKGYcJl0wf1vJ/n8LYLKuAw4Egh0eNyYR/bah06OFTOj3FJ4p0azhvSDkV4f/orO1nSj6H7nBaM=;7:Q+pBmkU0j8KaccRJsHDG5JO1uW0s8qfvxv27CzCSUz+9yauqjreDYhkB6YDJJIeqMXrseh1hP4v3LNrzRh6UuH5+j7niie0oy1wH5t+i1O7eZXQc1UxUG/ZSsUxJQzm9mqdHBs0Hr0ORYdmgaUBhKwuRCLNWPSZPpndeWsd2kYOpQbb75bO90So7o6NzvF+bGys35K9S6jhV6OyZvZGkzkhujgBdouAk3LNnfRd2c3AcxqtaKizQey8fNhdKEow0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;20:ulvjdcmPT/M2TmnCf4Blv/O3BfyM8N7DK76fcNdgOG1vzbqMbYyhwOAkUTdj6KqHX2FQHusup9WIuZPXl/CaMIu53DMPOjk2gtlEC9pfZD091OD7y/ADzENAEqVBegAuAMKV/yXvgLv+2yJ/dV1vv6+O1vgcMt1W4YOBUsXZI0Zz1BG1pyjLKVgkfVqtkM6u9ddT0AntxAtspSRCBjDo7SUFdpszRN1wnNSsKp/cn5jSgF0mQMY7DBsCohtf9gXg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 11:56:21.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4f6343-ac88-41e9-bef2-08d567d87ba4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2018 um 12:42 schrieb Michel Dänzer:
> On 2018-01-30 12:36 PM, Nicolai Hähnle wrote:
>> On 30.01.2018 12:34, Michel Dänzer wrote:
>>> On 2018-01-30 12:28 PM, Christian König wrote:
>>>> Am 30.01.2018 um 12:02 schrieb Michel Dänzer:
>>>>> On 2018-01-30 11:40 AM, Christian König wrote:
>>>>>> Am 30.01.2018 um 10:43 schrieb Michel Dänzer:
>>>>>>> [SNIP]
>>>>>>>> Would it be ok to hang onto potentially arbitrary mmget references
>>>>>>>> essentially forever? If that's ok I think we can do your process
>>>>>>>> based
>>>>>>>> account (minus a few minor inaccuracies for shared stuff perhaps,
>>>>>>>> but no
>>>>>>>> one cares about that).
>>>>>>> Honestly, I think you and Christian are overthinking this. Let's try
>>>>>>> charging the memory to every process which shares a buffer, and go
>>>>>>> from
>>>>>>> there.
>>>>>> My problem is that this needs to be bullet prove.
>>>>>>
>>>>>> For example imagine an application which allocates a lot of BOs, then
>>>>>> calls fork() and let the parent process die. The file descriptor lives
>>>>>> on in the child process, but the memory is not accounted against the
>>>>>> child.
>>>>> What exactly are you referring to by "the file descriptor" here?
>>>> The file descriptor used to identify the connection to the driver. In
>>>> other words our drm_file structure in the kernel.
>>>>
>>>>> What happens to BO handles in general in this case? If both parent and
>>>>> child process keep the same handle for the same BO, one of them
>>>>> destroying the handle will result in the other one not being able to
>>>>> use
>>>>> it anymore either, won't it?
>>>> Correct.
>>>>
>>>> That usage is actually not useful at all, but we already had
>>>> applications which did exactly that by accident.
>>>>
>>>> Not to mention that somebody could do it on purpose.
>>> Can we just prevent child processes from using their parent's DRM file
>>> descriptors altogether? Allowing it seems like a bad idea all around.
>> Existing protocols pass DRM fds between processes though, don't they?
>>
>> Not child processes perhaps, but special-casing that seems like awful
>> design.
> Fair enough.
>
> Can we disallow passing DRM file descriptors which have any buffers
> allocated? :)

Hehe good point, but I'm sorry I have to ruin that.

The root VM page table is allocated when the DRM file descriptor is 
created and we want to account those to whoever uses the file descriptor 
as well.

We could now make an exception for the root VM page table to not be 
accounted (shouldn't be that much compared to the rest of the VM tree), 
but Nicolai is right all those exceptions are just an awful design :)

Looking into the fs layer there actually only seem to be two function 
which are involved when a file descriptor is installed/removed from a 
process. So we just need to add some callbacks there.

Regards,
Christian.
