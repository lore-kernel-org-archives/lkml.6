Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeCWPTI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:19:08 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:55266
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751479AbeCWPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:19:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] mm, vmscan, tracing: Use pointer to reclaim_stat struct
 in trace event
To: Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>
References: <20180322121003.4177af15@gandalf.local.home>
 <20180322141022.f02476e1f76338ab9cecf62e@linux-foundation.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e223712e-0385-8bdb-3454-534fdfefac26@virtuozzo.com>
Date: Fri, 23 Mar 2018 18:19:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322141022.f02476e1f76338ab9cecf62e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:7:67::33) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f65146cf-cac6-4237-4e4f-08d590d16992
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:DodOF+oMhEGoqmqt2aMdeO9yP+ibu/5HEvLHzL59L3tmXfUK6uq0HgdbjPbfBZW3KlZ7Aqm2ldLE/QUecsanoT6F3PmgSku46FhNj4RACy3UXR0VFjiV0jRRAXvu5jaZQegHKCFF0UTI1mNLODLwpTNiqaLuVlElmYHUQyr4nb7iuV3MJhH1w9FRuPxENibn7sjBLPdpxmJjBqoB+X+05boYQTcXB6hFKh7a6mcjWhn96Rv+tD39UhZOQ085g25V;25:QyWs1hKjViv9pHV3SU7IWd7d/s4groBBxLzBRxcp8A1kSJR5rzq0UebQO6ZgOKZWt+p4CKbDTt6RS7X180crON0D+RLEv6/D2qOPEnznYJQnBIE5GD7brEO2KBY0ONmBfDzuTUsr1cCThFxyb+l1TVEzBhck2KXS/3xbpZGHvvIzCwk1U1LMmgX/GmnIOx3ixOK9t7LQ+bhu1VwHJCpNhZZORxJnSfFUKggfSajs/xHi3C4PS1GxzE1StRjddwZzVsfE8ygAuXcn6WJDRv3GxMdU7QzwKRBWlbpUjzvsCSqiN7VRSb8Td+Stb05CDzN0moyJ3ThhDX5r2UIlI0Q5Tw==;31:ETcYPluOyn63MuRAGCZJOdZ4A/a+cgQPsxW97QlvRr6eoq566HLNyGDjI9od7p83HrwWjSQchaPnaokWw9wY8r23MozEFPnBerUqyVPlsJ3yEN2/lyeioBamJpB1RhOkemz1vGWG+VOq9QpwK9la5La3HK4rJG+JrnoHmDSXRB0P0qgoYjw86+b0Y0vq/CfpYBWYlXkHuvvMTT0nAPvt6B521RtbFU5xBfezL7KhtTI=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:bXysw1taD1N6VYHzpMV72LO5h2pZ3/baoRdgwF4fI/HHpK7mw0xzRL7S6fIWp5xGvOIliuf31xz6a57SX0j8WeKPLEcKBdqh+/XjDcMaAktgw9Ee+x/KFjDiG4lhiM4VpIM0IBrUCpBkBIv3jf5db5CzY6WZNPqXDVylRof8o0TBVSK5wLkT5+iE62CZpTnD6jfXksf5uhn69p/X26+a9nPdhTBf4mzLzVl0Z9ai+YknlzflWWb4O+c2j4mhQFfY6VFUwZMFsnu7bEMJ2lIbTpxZGGdo9trHBhADZKN112Ec0FnNT/v1/INXBwRe/MQ1NutcF/Cnibpg0qZJjXqVWwKMQqYtyN+hj1mPf2hHssYCSL4aE7pGdVWjR/W7rJN8+gP1a+dE0p3uHMG9N6wXW/pZxW4xNlA+73RwPes+9jmzjZCA8FKHSGMuUd4J53+iY38/SaidfSq1h4sUejlM8xORh/iP3LEfb7bAQ+eZrMB37o1e+sErxd8PFbgvHjec;4:gJAk+uMOCpUSIZvY0YF7uqSw3rcQ/2VdzqSr7n/pmzyaRbHsdP0nuy1WsGK/+yMgvciqErm5rP0L7/RE1KiQrewBvBOLI+OuKPMO9QVU8FpA529TCjzocK3tA5LZeFxMHZWh4f0KsG3w25Ba3vwUe24f626QUZ/lEaqcugsfDAZqqeeauN265iiJ29+nro0rEHEn3eOUstkUlFmYRyCQQRpHIUoPOEW9jwBE4LvOaTa/1DsyTPqLHLiR8FwoIOeLS3G7dlCylh+HQYlSxgKdTEHGkdjn29oSUhYB7rXa+ssR0UWDw2zlarnmclaqf+1g
X-Microsoft-Antispam-PRVS: <AM6PR08MB325487E970CE7400B84D7FF9B0A80@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(2906002)(8936002)(81166006)(5660300001)(31696002)(31686004)(6486002)(81156014)(64126003)(50466002)(229853002)(53936002)(58126008)(110136005)(6246003)(52116002)(8676002)(11346002)(65826007)(54906003)(68736007)(2486003)(59450400001)(47776003)(52146003)(6666003)(23676004)(106356001)(77096007)(65956001)(7736002)(65806001)(97736004)(16526019)(66066001)(16576012)(4326008)(186003)(76176011)(105586002)(53546011)(6116002)(3846002)(230700001)(25786009)(386003)(36756003)(446003)(316002)(55236004)(26005)(305945005)(478600001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOlI4b1Y4Vk1MUit6TTE3OGpsU3FwaUM3Tlox?=
 =?utf-8?B?MWVpUXE4aHNjQlg5UmFSVEx2WXlsWnpBQ2pqUDRqMTkwNmsxazRnWUZKK1dl?=
 =?utf-8?B?QU1IQ05zWUtsV2FUVE1ZWUkrdTZXaDFHdVhBWGIyYit2U0ZuOW5jdWcrSCs5?=
 =?utf-8?B?eXBWVWJCYlBCSjNuZk9vWExOakQ1L2NUWVgxZjRmVjhVczV3SVFHZmNHWHV6?=
 =?utf-8?B?Qm5pYS9GendMNExzUmt0Q0crdHluQndXSmNDaXQ1WEI2WmJCa2RoQzczWEJS?=
 =?utf-8?B?bFg5WkJueFVtaGhDMGFpaDBDMHg5VGRiZGpKcVpVbGlncHp6NlN1eUVBNksx?=
 =?utf-8?B?RTBDbW5vcEt1ck5pSWc5TlkzYVpPMHFSV0FpVGpxSFYzTGtkQVpBMDVtQ1Ro?=
 =?utf-8?B?OXpJVElkL2xpK2NKcGF6bzdHbWQwSGdZN3dRVHRYSmo0emlHbEVaVnVxTkk1?=
 =?utf-8?B?R0xDQ3QwY1FSU2xtTStiSVlBSTdndkw3R3JYZWxGS3BibjBLV2ppMWtsYjVi?=
 =?utf-8?B?NDdhT1VqbGtjWGlCdTdlaitFL3l3ZnNZR2FIWkRibENKV3BjVXpLb2NTOEdm?=
 =?utf-8?B?dndwbkU0RGliNndMS3JZOHp6SXFNYk1Pb2VvYy9vZlpCS1YyM09veGpjclBX?=
 =?utf-8?B?enJ0bzBETzdIblNFeDBhSW9Ycko2TUVhaGZXajUyU2lrWFpkK3Z4dm1XZXpQ?=
 =?utf-8?B?VFRpN1M0ZHBYcnFoa0FTTkxkQkFsSkphUmFnYTN0UUZJcEl6S0ZJWkpQVUhz?=
 =?utf-8?B?Z1l6bHBTcG93Y3I4OWpLSCt5TDNFV3Nmd3doMUZ5V3Y4b3NoeHJPY2ZjOGlX?=
 =?utf-8?B?Zlh0a3hHc1NSdDVUK2xyUGNnZm1iT1d5ekQzNE5PMjFvU3JRQVB1d3hMb0ow?=
 =?utf-8?B?U2twcE02OC9KWjIxQ2hLOW1WMERlNFl0Y3MrMjZqb3FGYk43ZnZ1RDFFY1RW?=
 =?utf-8?B?M0Y2eW1JK2VDV1RrUk5WdnhCMFlWemdXNkEybUttZW40RnhKdkZGcXJaUTRV?=
 =?utf-8?B?VHVKNmxDL3pvMWFxNzl3dHd1aE03ZzNDdjB1TS9vVTNMNlA1cEFPcURReVgr?=
 =?utf-8?B?N3RTSTl0dWkvdDZ0MGliVTRtZWMxdTVtUytPT1JPMFUzeUJWdldlTXl0Njcw?=
 =?utf-8?B?S2tMdDdUK2FaVXA5dFUvTjhxbWFNeEp1NldOdkNWU3VWOXRRZ2lwQ0VFTlRF?=
 =?utf-8?B?WXBOSk5CL2ZJb3BLeVlTcFl4K21PSTVyM2N1WXhwNnhrZWticGJ0VnIvL3FE?=
 =?utf-8?B?NWMzaCtHamdhZkgzbEVlOGxsZTR2dkMvM0JQVmJJd2JoVDRhODdOMzhlcVpG?=
 =?utf-8?B?YVJwZk9QcElsN0xkT3F5dHl6c3Nhc0o3eUNwUEJMWWlkRGlpQVFrYlJyeDNS?=
 =?utf-8?B?amtRWm1tcTlwMWk4VU1wY2pVUVE1WU9pK3J5K2ducTZPcW9kaW05OXptRUFq?=
 =?utf-8?B?K1V5eDVTWkRVWERmbGd6dlhLQzlaNUxSZTQyeWllZXorZ2dQaXcwYThxbm5V?=
 =?utf-8?B?cHpheHJNc0pYcExla1lxMlRraThaQUFUeVB2TkNpTnAvN0Zmc0FOYWZCZ2hT?=
 =?utf-8?B?Ymd1N2dTTjZoSGJJbHpaQXZMcEx5am1BNHMwVUFDMUJpK1BYWDJxZXRDM1pP?=
 =?utf-8?B?ajRTekprcVRzcEhXMTkwYWRlTG1aMEZ3d3RRMXFDT29PMXNNMG5XS1duRFJU?=
 =?utf-8?B?Vk9rOENNK0VzcVlDaXh2QzkxbjUvZ09LZDM1R0Eyc1VhUW00U1ZHOTV3UGIv?=
 =?utf-8?B?RTJxL1Y3ZTF5YUtqajhoN3BNREtDWXBhNzNrbnI1bkFWT2hYa1hQaHkzRVhW?=
 =?utf-8?B?bllsMTZZaXFjMU16RGFvVWpRaTQ3Tzg1MU9QcUZPaVdPSlFTT2RXVkE2UGhO?=
 =?utf-8?B?dnIyQmhzTEZHaGFvNFlSWHhoeUNPeHVyWmtlMDV3WXRTczNkWi9tTHpzREto?=
 =?utf-8?B?dy8zOGJ0czVnPT0=?=
X-Microsoft-Antispam-Message-Info: CDlox5zXkAhzQuudORBtgL/VGaVOGXwovNxfsln36VJ7nOZzRDBbH5gvRaFzrOSUE4GlMC8bFjjzZdRtdL7uZMw9EDuEQQyXn9lvXpwTFsabKurTov3/7Nv1Vy1J1/hYfAMHQ6dtg1gl4L7JmPHcHoh/NrvcLixquKDLzOj0GgzgmLqLRzgXRlOGGju8f1JI
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:zlH7tDASa3n6T5sxHi9qPPpmfrMsdmrF5sagU5s0iVtGe4SAXw7qcK/BoL2IArYps/oQ66w7TLVFt4hop0EqqQsIbegBSPTF1T4+TvRmJpeWA6vce3DP8NgC6PpCFheuM7X3NUlDo4t8xR3tRjXA3tjt/SLYR4NsB486irPCrnoK9zFFpoBPacUwFRq4LntUOB7mU4h1AlLoye/TwIKDgpc5//TORZbBM19FWRxXqIY+TWZ8l0rfqpy/rf4X8sfWIFOOWeryKOe8c5wp+ZCBf3gU4Wfx1jknCIz2ri/vlI2uBvjrpJfNpjXMq/q2FK7y4B+hcxukVbNc5Wq1BHKHWa8gxfFBsQFS4Xmb7G7VSAzCR1KHPmKbnEaVhfdPnuGk2GcY2STt3ZLViDnwZ+cw+nhSChiPTtYc3WXX/21J+o0nmtL9SaBnzWQmwKk2c4NsrBrV/APJUd7Oxjgq89vN7g==;5:BaEtVtPv4dFOt3Gs4/KyUL5VD3G7vroxtqRoOg1d1BmZrR/INWaKHP7S3D3IrMqPcuNvrcwoJpErYbJ75eHCVrQMGreFK0lTKH46/UrDkoJuxkh0jVRsG5TSiEn+VZIrt4OTKPBUqKfD0THGWoiD1bdy+Vp2OaIUMKrSk5FUhLc=;24:jvmE3jv7udaGwE2JZowbr1+Tm8mLsZn+mLNO1hTkw0j6YvSshS4uNCw1Kf4BriY/SHxakt59/xRKq5ForLlfrZe5agKJPiBUlmtrXn5mCY4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;7:5E/Bg7ae2S636HYYI0QKO7QhS/GoMWFAacDx4XRBoAVmAtD/Tgo8G/C1hfTvkyeK5kaVshQf+1n5dxOzuMFWgBAZIsl+Te8mHdOKeJ6zYCaRplZChbjqaOlW7sB1As+y6aiRlcoEtzPcn1Yju28Ie8ugOifwauJYXgQZ10Hj5oKz4iuL6SJp27ab6+uFpmYqrgPeJQi6t37Eve6xA6osZnVOnd65sjolyvsMXTYkIVURkdSTlYvc0h9d3ntstbWP;20:yI8Z79YvFXWzSuQK6St3aOVkDYOMxPEJ9hxB5t3sT0YMMNl6oikM82n6kX/s36dNV2zHp//7DqyjmXMR5PJaW8XUaFLCmkQOITFNJNT0WpSFfrO8HxmALoAJrFVuZFuqA7VMVgN3oZ5VtXURd9KiVLXzpkVzDOsC0I8id3PbuKU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:19:03.0147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65146cf-cac6-4237-4e4f-08d590d16992
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 12:10 AM, Andrew Morton wrote:
> On Thu, 22 Mar 2018 12:10:03 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>
>> The trace event trace_mm_vmscan_lru_shrink_inactive() currently has 12
>> parameters! Seven of them are from the reclaim_stat structure. This
>> structure is currently local to mm/vmscan.c. By moving it to the global
>> vmstat.h header, we can also reference it from the vmscan tracepoints. In
>> moving it, it brings down the overhead of passing so many arguments to the
>> trace event. In the future, we may limit the number of arguments that a
>> trace event may pass (ideally just 6, but more realistically it may be 8).
> 
> Unfortunately this is not a good time.  Andrey's "mm/vmscan: replace
> mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint" mucks
> with this code quite a lot and that patch's series is undergoing review
> at present, with a few issues yet unresolved.

I slightly reworked my patch series, so that patch "mm/vmscan: replace
mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint"
is not needed anymore. Replacing that tracepoint with less informative shrink_page_list
probably isn't a very good idea anyway.

So Steven's patch applies *almost* cleanly on top of my v2, nothing that 3-way merge can't handle:
# git am -3 mm-vmscan-tracing-Use-pointer-to-reclaim_stat-struct.patch
Applying: mm, vmscan, tracing: Use pointer to reclaim_stat struct in trace event
Using index info to reconstruct a base tree...
M       include/trace/events/vmscan.h
M       mm/vmscan.c
Falling back to patching base and 3-way merge...
Auto-merging mm/vmscan.c
Auto-merging include/trace/events/vmscan.h
