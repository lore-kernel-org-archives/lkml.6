Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeA3Kkm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:40:42 -0500
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:64444
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751391AbeA3Kkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:40:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [RFC] Per file OOM badness
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Michal Hocko <mhocko@kernel.org>, dri-devel@lists.freedesktop.org,
        Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        amd-gfx@lists.freedesktop.org
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3026d8c5-9313-cb8b-91ef-09c02baf27db@amd.com>
Date: Tue, 30 Jan 2018 11:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: DB6PR1001CA0039.EURPRD10.PROD.OUTLOOK.COM (10.168.69.153)
 To MWHPR12MB1310.namprd12.prod.outlook.com (10.169.205.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e1d1e78-3ca1-4cfc-148b-08d567cddc04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1310;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;3:I6ia0av8z3jyswLDCgzYqLdnT4e8js0zJWsJ7O6vTXNVZm5ZXz+9CZNbPf8oZDjNuzgGEmkhz03f6FMeDWIjMiLbNeMRB/OxgT0A4UhbH9zF/Cds6dbyKU7Wtlk90gLU2O8gZSOOSSPC8R/5MaDrsCwNqv7zD3RKD36vNZaZf9AjsKN+/4h8bRQ4wzt6y+XggwwSyq0COF5Avk/rTs4oVC0kLgHiLs0tv7A8+AC7aNI1ayLYmX7YgwU24en3pHcJ;25:+4ZoS0dtdffYnIkGKR0DyvfAgwWbZ2n1Yqzjq/FkHE6KpEm+tG3iXXHmmrYGuG8ezkzmtov2apoTyyO6Z32CXJRdc9tq/jWoAFBaEB82MhwlxCAkEhHgGPJ58uWNRrWNkpHsdiFJisd09MHrnxH6SXQ2pdEvjyrpYwgtKs7Xm2tKeMMfI3tUX6dY059wj/+i50uM50FpEW7m0WcMVLBSHIaORTHEi5n/Ud4CdFy+jaOldHxz4iryqhYgh+U55L6nfnMZphet8kc0vKzjBxzspt4Sn08MQqKS+B2XCzGKMig92SzhkQe1ZNDQu0uLbYuALtP+Vxd75Hsgk0NQFTPSbg==;31:EyGFecMhX9AVSASLuFZDEJsvDSVkBk36slnoTLO0KBqFrvxp50PQ+oUXKp+qaucc+zdHFO3HVYin1Fv29H8xCL/QsPu7KkiiWBWuHXXfD/ZFlFk87RamRqO1aC7RHWKuCYlDzLDz03+6ge1ZwoByWwaWYhuPK4mfmJoluwCtHS1NOOiawUSX6M+jxc/Vp4i2ACa1DKVoB1gAo1fmz9kYrEDL03QV30fsX7+JLayEejE=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1310:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:M9LGzBWIz6kWyxRG+Fo4GHb/kXfd1i34n3QLGLktS0dzJlJ3mcTcLGi36Ej9pq9YTxfWz65FlukjpL9SZb5koIH5i+i5N+an8qfC6+Zp0qhs4VenW6Xl1ux6tKce2DIgUSryn8yDSmv5IVgWTFFVEkXD0yF6YeFcbBXRvAX/++rU8i5xpeh4ub8oDTPkJO6ydJYotcsIpqF1PHmu5rMffCVmehdG6z6Ba7yZMpTkgV6bFdoVZrVM7FbEGJ6ndTPnqvsgxkiPLwAGtjwzZimRVjvQLcZQb6sjg6999U8oV2tsegGt8gSH8kT+LhppgTBPA7jzv93iJ5u0AK3YSfr+0hf6rEnzwtASzGVgvPlkEVnqShF85U/UfkSF9BQyCSVXbVDIdLkmUd0D9f8zADmcElhlNxlklTVeWtzrDA5yLjt9m9W5AAzApaIh9BYUDMdne3pY/LC+Il+qhKrDDU28zESCP2T1SPBC4oz7c2EefDTiWiPmKG9uM4TAGfuppYpc;4:LwWVM93lVxbn591p3AZGQUVapFM39efEaW9Wc0xnMM8r9Q4UXUR4V5saPGs//Qtm+Vg5evB8NsxHElr9m6K9sL5++LmXZV+XMn6ttG6oOA7KfkI5zkecau2AoKqN3n9yQaNs/Dse9s2ENFHKdkjheN2NgasPwB1O/4/w+WK4lXQbaUIbMbiOJt4JywIBnkoddV8juu8KHGreKe0FKKO6+oWlwHL76Fc7sIck4h+Mn3z7Nv/Y5y8ws5yfmFbmHY9Sb6cjmpeXpJfpJChSWDwn1A==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1310CB304F0B6CA5EDC396B583E40@MWHPR12MB1310.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1310;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1310;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(7736002)(68736007)(50466002)(31696002)(97736004)(6246003)(6486002)(4326008)(64126003)(5660300001)(16526019)(67846002)(36756003)(31686004)(2906002)(2950100002)(6666003)(25786009)(93886005)(229853002)(65826007)(305945005)(47776003)(72206003)(106356001)(105586002)(86362001)(59450400001)(53936002)(110136005)(81156014)(81166006)(316002)(58126008)(52396003)(52116002)(8936002)(65956001)(2486003)(52146003)(8676002)(65806001)(186003)(76176011)(6116002)(2870700001)(83506002)(1706002)(386003)(23676004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1310;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzEwOzIzOkNFakNwKzhobjRKME43b3VtV2MzVFE4ZytX?=
 =?utf-8?B?R3liOFNDM0JHcE9HNDZSN0t6a2d0ZkhnaytPOUpyWTNvUXVpbVl1K01YTkMr?=
 =?utf-8?B?bTduMTFLam9JenNLTkRYWllpeW1ueW1iNzZWd1dLZ0pQdUNuODE4eEFydVk3?=
 =?utf-8?B?MWYrRnh2OGJoUHMvRjZpYzMzbERsVkZEYzVzYlcrcGFjRVlXU01XbkhmRndX?=
 =?utf-8?B?RXlRTVVmSWdNY3Npc1BYM3VQUUhPRWQvZ1RWS3R5dVloZ2RvUTZoQUJsVlVG?=
 =?utf-8?B?cENxeE1FNWJFN2hEYmxDY3NkT3ZyVld4WDBJamkzYnByQm8zeUt2amozTXF2?=
 =?utf-8?B?Ly96TGVCZStvTWhWdkFBL2pURTJuTDVpYS9rVUtRdWIxV1hSSWJ6NkgxN3lP?=
 =?utf-8?B?YU9UTGRmV0dEN01pcHdKWE1rN0FvQUdxVW5GUWxkTkR6OUJkQ0ZYdDc5Uk1m?=
 =?utf-8?B?eDZwRkI4dVhaM21XWS90UHNlRTJtSmV3czBqSUJVYW4reGU2em11MFd0RGRO?=
 =?utf-8?B?TFVUSWF4SzBiVDRMSzF3SG03YmtWaGtKR0tjOXFXN1dZUkIxMnFFVzg0aloy?=
 =?utf-8?B?MkphWDdSQkxQdllwQk0wdVNMVmxxRjNlQlJLd0M3RkMvNFhPNWFDd0cvTUhk?=
 =?utf-8?B?NlVZeDVsWEZUamZqbFRPZVIvRkRPSHVJU1E5eWV2bFpBZHM5bVA5TXdQMGRj?=
 =?utf-8?B?Q0grc2YwRHZvRWhLVjRqRGU2OVUzamgwbmkyQW9PT2RoclF3MlBKanpSVjNT?=
 =?utf-8?B?cnQveXhaZ0J2Um1URzZmZXR0dmxRSTlZbEd4bm5SVGwrM29GYytRR3VBb1lv?=
 =?utf-8?B?SU42RU1Ob05yZlorZ1U1Ym9TcndTWXppNGFHdXlwVkMwQXBLRjMvSVNsdi9W?=
 =?utf-8?B?cG1WV05DWXAvb0hxaUE1cDlzZ2l3QkpvSnN0WFNYT1N6Y2U0VGZkbDN1bHJx?=
 =?utf-8?B?ZHNkdU4vNTZuTjZNM2t1QlZvcEZGTlNqVWthSTQ1bVpHVEhVNUFGQ0VhZWVI?=
 =?utf-8?B?S3E1SU9XcVFUdEJUd0IzMWZYWE8wNFlYS3RmMy9scHhtQm4vQkpTNkV6Vktw?=
 =?utf-8?B?RjNXV2k5NDlaTjJobEFWNUdOajd1VlprbE9iWDNXcmxmRlhqZHVuT2xVaVhH?=
 =?utf-8?B?aU1zTkJjT215YkEvQmRYYWF1aldGSFRPRWZQRU5qeEJoNEFqcC9zMGJSdDJi?=
 =?utf-8?B?alRwTURCcnhUVU9YVkFuNWJYeUVSV2JjSFB1WmdDZTRCT3NWY25yd0hNSGx1?=
 =?utf-8?B?Qzd4NUJiSGhMbGtmY2tlY0hwN1BsUDJ5TGZNVk52cXRvZzRsRitQalI4c3gz?=
 =?utf-8?B?N3NQbHRZdjc0d3RaVEYyMTRlVFQxL3ozSjRsOGd6ZTMydUM4L2NPOVdKQXY2?=
 =?utf-8?B?aGRaNUlCV2JJcGtnbHhNZjRYSUM1MG1MNC81L0s5Zm1YL29vZ2NnbzdJeUxX?=
 =?utf-8?B?SXJ6SVJmem9DWGZhQVVZQkdmK3RXYUtZNWRlaDg4M1haTTFkcVU5R2VtdFZZ?=
 =?utf-8?B?TEpoY0MrY2p4Y2lhc3BtRHZ0TVZoUVZlV2dYZEtWbjNTWjhFSktWdVphSDBZ?=
 =?utf-8?B?NUsrVDdEeGRZL1VDR1czTldJTDJWSkd4bGcyNTdSTEZ6S295cnZaZHJKZVBP?=
 =?utf-8?B?cnl3Qm1ua1ZEdlJzamtac052R1VzWSthd1pEUEgxK1F6NnkxdDN1c1RyejBv?=
 =?utf-8?B?N3JxNDhPZVQ4NFhLVmRWUUpFUHczSHlucU5HakJEMnpwQmgrN2VjYS9hQ25F?=
 =?utf-8?B?RHZjWDdmSWRBTEo4NTg2ZElUVGtvdnNNRkE0b1BMSTFoMjdwOHU0SkI0YUta?=
 =?utf-8?B?Wk05aUQxNGFtejhDRGQ0aDFDS1paWFE5dC9ETmtKSHpSVVE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;6:m71RLwkEgxRPrwsi51ib4Qgo5kcZEWCnqXHnE9IlDASuKbfWkurlpSz495ys1Bx0UnYo8regXJPUW9UtMarhiWSpG5SIKoi0358Rzfj1Not2CODw8/abwcwQaqz4GfGdgy/e0gtljQg46zH+w2RBHXdhtMQcwaGoVuBF/t0qrZxNzElVHnV/cL73ji+V/Ei57/HGDrMW3ylTQ0CXW1cuES/yqSkl+DhtVwCssvrgqSo5TsXLj2I76P2j+65VQJvr+J0BADHjtMsubBWS1nnjq6J0yXujA7yYL5mm63h9ykS1Hhz8INlfXobCXou4EcXvlqPiP9W1LFmbasuN63PEA4szhNPbyMtJ2qcrEBv9bs0=;5:ph7bzBpsyAZtgz3hjIxAzFK65JIEy5/RdqKshVpRgCUrjkC7fh73AsrDFx7g5sbEFqen7go4J0U7dIhqGLa5KfiTwFcvSbs1kOA0zPmtqKOWeU7kLRutAexeSifnyhUUAbPiJm5DFNn7FAmSFJ5xH+xhC0IJv6QPrEpSahzTp2A=;24:ox7zn6DUeDviaMk+ct4+nlY9UUa7q0x5BJLv9F9vI9U6wgx/pDdaiPCE5X0Zc2Q7D2qZXSQljOFiJtc3lVgpPDhZ++I/WLhKXrNlcNvdDWY=;7:3Symi6TlmdzCqpXgp2IF1FkxBCuuNc4nEbxd0eNOESqGj6KSU60ADrIKMX0Ev3nUzY2hRYvrIF5/kpNcZ1sM3jJGj7yT8oxX/bQLC6L7KhIMMvGLBuBEhPnOlXnY+I8G6fYkdz4EY4/AL1uzE7L8l8kS2zZmV6YJZIAkOBeWBEFCgjxuoBmoIEaWHiJ6286I1fQ6tTV6JhagQO+0vKcQCMhA/tloZRe6GSYni5mt/0ZoHzfOqVRIl2wGSvSYGIzE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1310;20:BfWjbRPQHOEirstj17YAPYj0J8E2FoFG58gDotE2HIGFczv5NR7ii6DXCSgINhDaKp941z8meV61N15Tt5oY544E7Ak7+dnwKDTY9K2drbE5CzlhA0x7wykhqvOtrKyJRLvqIy+lrePEGzxIyLBoMJ6O1Z/Un+bg8dvNYHsvxICSPuPFrPJZDebYzCtNtk7+GTmg4P0bCZLVJzd4WvyVQLtLO9eBV3HX9d4+VRex7ipUR3pFa4IEClVIlzAvPSG9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 10:40:16.3598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1d1e78-3ca1-4cfc-148b-08d567cddc04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2018 um 10:43 schrieb Michel Dänzer:
> [SNIP]
>> Would it be ok to hang onto potentially arbitrary mmget references
>> essentially forever? If that's ok I think we can do your process based
>> account (minus a few minor inaccuracies for shared stuff perhaps, but no
>> one cares about that).
> Honestly, I think you and Christian are overthinking this. Let's try
> charging the memory to every process which shares a buffer, and go from
> there.

My problem is that this needs to be bullet prove.

For example imagine an application which allocates a lot of BOs, then 
calls fork() and let the parent process die. The file descriptor lives 
on in the child process, but the memory is not accounted against the child.

Otherwise we would allow easy construction of deny of service problems.

To avoid that I think we need to add something like new file_operations 
callbacks which informs a file descriptor that it is going to be used in 
a new process or stopped to be used in a process.

Regards,
Christian.
