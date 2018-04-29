Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeD2HDC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 03:03:02 -0400
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:21728
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752128AbeD2HDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 03:03:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
Date: Sun, 29 Apr 2018 09:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:7:16::16) To BN6PR12MB1713.namprd12.prod.outlook.com
 (2603:10b6:404:106::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:czi7p15sE3WPIdRpp3bIs6VTsOEQi2056xIkDDB/q2Rt2ieCCHwKCtSOX11JkFKKTquCxjLLzAVfaa0d1edR2Q/I6WJjcUK1sHJ43QT+DzO7s3V0/enQ7jJXfDiqVWy0/IsTgb3JdkYgD0aHxGIviJocqLPdVUJCbsaiYNEtZbd5KJ488YtbutpA1pmVfyUtO8woEovRSOnXcKWeIiieplMs+KdLxKtrcO/W4tQ9rP/pa+Tx0G3ZQK6yPn+P9+dy;25:UNcekb4fCq5A5rFAHqBk3jFL4T+Ad1nTcVrEKoW0iIXErr9nU6WZtlWwx6Gq5w5AQ27Kv8JGoq9B0pzl+wDe1mIHGipbp8sU7Ns4gUh0/SuH14vgemo+YvNbqzZayl0sAz/vINytBhdnOY+1yD60OUC+K/U1MNbhnRNavc10vZLpsqnZtUY05Q7QNUshwTpBJhIptuz59LnV9SODGICC9j3CEJq7RES5tlXNPh9bMTWBRwMTrUwoDTJ8cEbRLSTrZMuil1pmtpaHv9mShkAAgGqca71AEEkSVjZ/15EgYT+Z9RydPTeZxIoSJ3Pk5m25/Mzc9WyKFeRQGUnJwG0JjA==;31:GN0tnuOmq+/kXnytnRs/re5IfkfGAXY9sD3/kuTPi6RptNNMnq4GSVu+hBWfD1UIgE8PkHz/FwbkWgGgbh/GMa3mpCXs8PGQAsFKSuvnvkQJXQ9dWexJ8n7UBeA79vIwhRTMfGUT20eQZG6fuXVHjPfrJYZ2bKkg7ZyX4zRN5VOGkT2cF+UPYxFuHnBV6mEsEsRP1c1qT8uogQcrwEFKtC4gkiFLTjVpDNpY8rixJJ8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:UitUudKj8zlswVeVj2qWAYyLaA1NLs/eYKZC1xLNW2fPjBHKiYhYs0jMojBdw1QUqrjdr+DD0+tSLlPgRI3FJNUKnLx+4nwdh02Y5omoE/B1KM0ImtE1CRBMrUSBpIsGbcHCFrAYDRNV62H+R11VW1mELLMDw6Z/r0jZJ6uAMuM2ZW+9UBGtnU1TY7g/uUhZUwq1o2vK9PcBRz7gtQ2bJXSm4pWnQXv1z55jghCR6nNMg1W/Ks0/z+Ej2ZBW2Pvync6z59ktoOYg6rx9ki5bzQXFXQXwnWxrzEG/QK1Wt4WYCrDW4PWsomZgGlph6kgltFXmU2lkdKSlGa067jy/riBGxyj2jW34BJBLF5w+r8PkRxTKYBedvy3AfAPE7wJpFu6jnAKxWgbeXfdplTSXAmrhEGTl+ehmblDIq/M9gBGskJMPA1COr0xUBSwFKb3B2uCrWXD7JgDVrYt2EU53qcoOGFDrBFzs52n0FW6V1otHLxaurCrTGFSho7j0SXM8;4:ooVPlYvTzKAlws3Y9esS6A/CVvVge/OXeheAj46THGc+gc1OAI8sM9Zkw8wloxpPquYXM9lPjMXTXqGvvoGWPWUO6Y8S+z9WAjOPVqITd3Rk9SSeyWh/80QouBAuYEjMbjrC4pUI7onDAawZjJKCfYI6mIpQHS6E+q6krTsTR7TUa5niYucb2qxFwoN31VPzAgd1VEam8ziJNHOkipbqDdYcoWcV0/b0cK/h7d1N5P9waqpMyzm6NPKc4jDM8hMZpC1ymFuxi3y8gLvc+pv8X8wypqijK0+qdxee8zJEtkI1HFARsoC3LhRFh4wcyqyhespQUGHjE06oPNNp2VMnnotV4FMCfXZdkpiGOoZsWgW8rHDO1vCxpu66FSXF/RwX
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713B08B7A14E279B918CD8883830@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 0657D528EC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(366004)(39860400002)(396003)(189003)(199004)(377424004)(106356001)(305945005)(1706002)(8936002)(5660300001)(36756003)(52396003)(23676004)(2486003)(50466002)(64126003)(186003)(16526019)(65826007)(110136005)(52146003)(76176011)(8676002)(81156014)(31696002)(4326008)(6116002)(86362001)(97736004)(7736002)(81166006)(575784001)(93886005)(52116002)(25786009)(72206003)(6246003)(59450400001)(2616005)(966005)(46003)(478600001)(65806001)(105586002)(446003)(486006)(6666003)(11346002)(53936002)(6306002)(58126008)(31686004)(6486002)(53546011)(229853002)(54906003)(67846002)(2906002)(386003)(316002)(476003)(2870700001)(47776003)(65956001)(2171002)(68736007)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOlZjVmMzUVdWcEZXK04xWHhkSHZ2UFcyVy9I?=
 =?utf-8?B?b2dlQmdWazdaTXhzazBJcyszWVM2aGJCdFJBcENaSTIzTThhV0ZESGg5MXlx?=
 =?utf-8?B?aVRnQU91U0hKNzU3OE9ROUdVMDdQU2d1RmtSenhOVUZwWSs3Uk9Kdk1scmFP?=
 =?utf-8?B?bTBTam5FRmk1T1hDM3dPQTlIWlZwcnVhYXpOYWRyLzdGL0ZWSFdiTHBWNGZ5?=
 =?utf-8?B?S0NjaC9aMCt6TEVNaEJjWW54VkNGblY5M2Z6TTNVL0FuNEZBYk1kaUNWWktI?=
 =?utf-8?B?a3AwM25EN3FUMm9FbUE1Zi9LNW43VkxPTElORXMza3JnaEpyaC8yYjd1S0pY?=
 =?utf-8?B?MG1OQVVQSUlMeWFTMFVrcHBNaVh1dlJocmg2dnRNS2R2NjRidXNXTGJKd1JC?=
 =?utf-8?B?NGJxbkVkY2lCc1c1eGc0OHR2RHBrYVNvcUZWUkEvRW9PREMzY2hFcVVGZmVl?=
 =?utf-8?B?YWNTaFRsbldXZWVmV3JmdHZudjc1U2VpN0lOQ3lJcEh6S2RmeVFYcXpEVXJr?=
 =?utf-8?B?QjhPNW1xYytubFZlR3JIRzB0cFVqNThaeXM4UXNZVzZOdWZJRnE3K0F5SEI5?=
 =?utf-8?B?NldCUjFNdXltV2JLQXF0bDhSV1MxYlJaSXpTeTdkUzkwV0EvUCs3bloyZEpR?=
 =?utf-8?B?b05LMm4xZ0VWT1drQWVqR0xmNlNZdHI5T3N6YW5BQ0FQSXpDMTVCWEtNS0pw?=
 =?utf-8?B?amc5L1Q5TlVoaUNzOWtLUnlaU3hnOUNFZnd2Q0FnTnJKaDJzblo5R0ZMR0FE?=
 =?utf-8?B?V2JzZ3VRYTZPVEl0MnlKUE1ucUNnU2VaRFgwekJvRFM2UjBxbzdnM2ZmejQy?=
 =?utf-8?B?Z1M3dGZqbVR3bDduVWFvU1pvM3MzUUtuNFJRSnZlOGMzQ1FBaldLMUNDU0xq?=
 =?utf-8?B?MDl3VldJVHFpbjFIbkw5Z0tFWTIrbTUzZUpPVmJCQ3luNzRsdWhXUGNsYlhO?=
 =?utf-8?B?NWxyL3ppWDVuUE1QMVVUSU40MC93ZC9EN0FNaE1mZjRmamJEeVhISW1xYTBu?=
 =?utf-8?B?TnhZcjV2UTNNSzhZK3V3bFBPREYyZXBOZXdoYXNlb3NkVU1YQndqeVB3ckQ3?=
 =?utf-8?B?b01oV1VWeTg1blUzNXZVUmIzSUo4cm5MNGN0WWowODlBMUltNkZIZkRyWTdB?=
 =?utf-8?B?MDBMNVJNeUlPaDh1SzNOSnVyMU1NM1M3MXE5cjV5NEZYWWdXZGpiWWpVMktz?=
 =?utf-8?B?Q0kwUkRJNlphVWh1a0RHZzE2d2pXOThOcGM2ZnFIOW9IM2E5NEFNKzZxZ3RP?=
 =?utf-8?B?QWFtUWZzUXFSSjd6T1VQUlhGWUFWam56am1BSTJjV09mNTZGbURtUWVXaXVz?=
 =?utf-8?B?VGk1K3NEQXJseTdjaTJJOFcyZ1ZhVlpnbmpxd2JSTzUyWFovOHc1L2FlWHJt?=
 =?utf-8?B?d1B2NHZPN1Raa2c3WUdycnBCNWFLRnlSQjBvaENuZHlDOE5kYWZMRjlZQmxT?=
 =?utf-8?B?Q2RXZDBiQ0JyVmZMRS9xTEtuOERCVDFpbTZRRHFkbUllOVBBdjk5c2UwQTM4?=
 =?utf-8?B?eVcvd1J4QWRISWxkQVlpZlVnSXVpTHRTYXdoL0s3WnNzMG9zMnNWckEybk8x?=
 =?utf-8?B?TStlV0o1Z3NpWlRaSlU4UjN1bEc5UUlnRE9jdGFYY09MaWlKSXgwVjhmaVRY?=
 =?utf-8?B?ZU5WUVRSTURvZitnT0NCV25UbFF0aVZhejNLNzBqN3lzcDFvRmR6Wm44Q0I0?=
 =?utf-8?B?OGp2R3U4cVJmUDdocjBCL2FhWDM2OTRaRFhjdjQrTk9ycW5KQ2dQeVpRTERv?=
 =?utf-8?B?MXFzempyRC9OMXRwQUo0T1E2ei9mZHJzcXl4Uk05SGNUYWY5N2pvcFBUQXVo?=
 =?utf-8?B?bHJYV3NZZVVSQVZDTVZqOEpzeGxiUUl1eXpxaU9pWUVmMTdSTXR2RklPRFFI?=
 =?utf-8?B?RUVHNkFlRHNyWHdaK3pXWjVHVmVHb3RJSklOY2k5cXR0VldhS3V1Q1Rod3Fp?=
 =?utf-8?B?QUtKRGVpQklNQkFhZVBOYkgwajcvRHFJbXc1MHBnTGQ1bDh3N0E2NFRHdURm?=
 =?utf-8?B?RVlPNzczRzk2eEQ1R0NHdTNIRGNJL1hZY3dlRXVmTUdTUTNqUS8rWEVDL0Qy?=
 =?utf-8?B?VjZZZnZlNmlybHMrN1AzSCtDNyt5SXRvYTIzSWk1T2UxcHVXbzc1QW5xM3Ev?=
 =?utf-8?Q?X9KLs+E23bgptrqZ3UzfAYQ=3D?=
X-Microsoft-Antispam-Message-Info: 1Ehr1TprW1lzJcf7eb7RNp6leKbJ7iHLjDOM4fHoJN/LmB33FaGss1JV4xOjYkGM0kHjv9Q6Uy0s7DwqisLFCAzduoeY/RbJKaucXPiTY4gNGQ31B/YT4c3y5OsxT9Pe3kpFK3dJ26EKReKeFidgRaE64CNOqkIN5B250wptx4IBKaJy1sgZdscY/0DIWYM+
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:UNYkQqh9SldwNb/aqTU76dzwZxpBjK6NUUahqgrKzknJIjokmgbflPwA1A+p+9wAXreqbxThkMBR9sXN1ppugxFTrP383EBDkrwE+8ZuljNa3HVJ1+F2lpu1yT738tieqQ4v00WugXEinS83DPgMmOkHLQ9j1I23/bbPSaC0Szr8dmOm+71L4C1n8Z5uIS/O7/zPciTpixqbdX9tdCluRK2ri/FYjl+DDKhF9w3ljRHlB8d1Q2i3666Yb1k2SJ+/mFJxoZACA/lXcE4OnIVkUJk0/QGNFYkkVPEQ0mGvdJC6B9GGD7gh6s/H1DIP6WA5Swi+C4oTW0Jw/xVrNuqXK+nPCG/YEHIVBDrBPNzWAX7FXmFeDt7O+bo1dr0LeXfMj733Eb3wHUNY6FYQQ0KAxGwgPYotGqSk7HAy2ztApvyCWd7sI9chiJbi8+0grIKArh6L9KDVwUkMPHw/sPpVAQ==;5:ycWVeoJoXc7iZiIr6RRAZpQhttWCu/VxVQ87/nN+dN/mhavIvMToBCNjfB80ioBGiH4b86dAiNyk4Lo5OZTwWM6eDyWJkaX4sXRbwrbBoTrJu6aeS5Z6tbrkANHHXcfNM8ZCS08ghiK8nOOSYgJP9kn/C1ydWfRI0IJlyTzGIjc=;24:+XEhz+9WBonxyPYpIdQfS88LOM/3uUnVa6mFIsrpbzrxUGNZYDi6zwEK5OgLyUtI4oeHOkqHF+eiVCk6Dvgv6BCbYZvZ0zmZGvE6uFwL3VQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:xMLPBi5VcTBXcobw/IrdqOClOmzwwMlAuQBbMieFRnN8wKZLMsD8R7tHr5NwiLobBWJOZgTkumcJv/TF/MZVzcpZVg54h91UCinA2jzwzWkwV25ttoZNbZnWrGAP/I0N5S/xV0OQDbBS16hKk44rd6Smy085qfJKsCvbGqjsGMYoWW9rbeSh1zUSpRPKE3QwvnZiHVs8pAexQjITpHGJ0EMaLev1TGgY3AAxtWtPN14oEcKj0kBrjmeOzOPTmURQ;20:XT4d/PcxzSML/fRZtx8XIhKx2gLetrby+uWPYgD6eEWvN9oOWoh19MKNRa1+yanCIepiw6PO+2HwxDyQRki91j3QcFymAsjtkODbxhU/laRkHp5ynY6dfD6lPfq7UNz/yNLIXBTumdA/4v6j+fnYhH6H5VgN+DeYQeZ6WFAIwl0qECvVY/rVll8oYiN40HDheUr9HPqW1QH2TyvCzqE0DdOFEMmRVnPnhZGZJ2r77r32wkEFrFeUvAfNUp17Qe5w
X-MS-Office365-Filtering-Correlation-Id: 8e92634c-8072-4b3e-92d7-08d5ad9f3c49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2018 07:02:55.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e92634c-8072-4b3e-92d7-08d5ad9f3c49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.04.2018 um 01:02 schrieb Michel Dänzer:
> On 2018-04-28 06:30 PM, Ilia Mirkin wrote:
>> On Fri, Apr 27, 2018 at 9:08 AM, Michel Dänzer <michel@daenzer.net> wrote:
>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> Previously, TTM would always (with CONFIG_TRANSPARENT_HUGEPAGE enabled)
>>> try to allocate huge pages. However, not all drivers can take advantage
>>> of huge pages, but they would incur the overhead for allocating and
>>> freeing them anyway.
>>>
>>> Now, drivers which can take advantage of huge pages need to set the new
>>> flag TTM_PAGE_FLAG_TRANSHUGE to get them. Drivers not setting this flag
>>> no longer incur any overhead for allocating or freeing huge pages.
>>>
>>> v2:
>>> * Also guard swapping of consecutive pages in ttm_get_pages
>>> * Reword commit log, hopefully clearer now
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>> Both I and lots of other people, based on reports, are still seeing
>> plenty of issues with this as late as 4.16.4.
> "lots of other people", "plenty of issues" sounds a bit exaggerated from
> what I've seen. FWIW, while I did see the original messages myself, I
> haven't seen any since Christian's original fix (see below), neither
> with amdgpu nor radeon, even before this patch you followed up to.
>
>
>> Admittedly I'm on nouveau, but others have reported issues with
>> radeon/amdgpu as well. It's been going on since the feature was merged
>> in v4.15, with what seems like little investigation from the authors
>> introducing the feature.
> That's not a fair assessment. See
> https://bugs.freedesktop.org/show_bug.cgi?id=104082#c40 and following
> comments.
>
> Christian fixed the original issue in
> d0bc0c2a31c95002d37c3cc511ffdcab851b3256 "swiotlb: suppress warning when
> __GFP_NOWARN is set". Christian did his best to try and get the fix in
> before 4.15 final, but for reasons beyond his control, it was delayed
> until 4.16-rc1 and then backported to 4.15.5.
>
> Unfortunately, there was an swiotlb regression (not directly related to
> Christian's work) shortly after this fix, also in 4.16-rc1, which is now
> fixed in 4.17-rc1 and will be backported to 4.16.y.

And that's exactly the reason why I intentionally kept this enabled for 
all users of the TTM DMA page pool and not put it behind a flag.

This change has surfaced quite a number of bugs in the swiotlb code 
which could have caused issues before. It's just that those code path 
where never exercised massively before.

Additional to that using huge pages is beneficial for the MM and CPU TLB 
(not implemented yet) even when the GPU driver can't make much use of it.

> It looks like there's at least one more bug left, but it's not clear yet
> when that was introduced, whether it's directly related to Christian's
> work, or indeed what the impact is. Let's not get ahead of ourselves.

Well my patches surfaced the problems, but the underlying issues where 
present even before those changes and I'm very well involved in fixing 
the underlying issues.

I even considered to just revert the huge page path for the DMA pool 
allocator, but it's just that the TTM patches seem to work exactly as 
they are intended. So that doesn't feel like doing the right thing here.

>> We now have *two* broken releases, v4.15 and v4.16 (anything that
>> spews error messages and stack traces ad-infinitum in dmesg is, by
>> definition, broken).
> I haven't seen any evidence that there's still an issue in 4.15, is
> there any?

Not that I know of, the fix was backported as far as I know.

>> You're putting this behind a flag now (finally),
> I wrote this patch because I realized due to some remark I happened to
> see you make this week on IRC that the huge page support in TTM was
> enabled for all drivers. Instead of making that kind of remark on IRC,
> it would have been more constructive, and more conducive to quick
> implementation, to suggest making the feature not active for drivers
> which don't need it in a mailing list post.

I have to admit that I'm lacking behind taking care of the amdgpu/radeon 
user space issues just because of more important stuff to do, but the 
issues affecting other drivers should be fixed by now.

BTW: The user space problems for amdgpu/radeon seems to come from either 
the DDX or Glamour.

For example try playing a video user firefox with Glamour enabled and 
take a look at how much memory we free/allocate.

It's multiple gigabytes for just a few seconds playback, that strongly 
indicates that we allocate/free a texture for each displayed frame which 
is quite far from optimal.

Regards,
Christian.

>
>
> At least, please do more research before making this kind of negative
> post.
>
> P.S. You might also want to look into whether nouveau really should be
> hitting swiotlb in these cases.
>
