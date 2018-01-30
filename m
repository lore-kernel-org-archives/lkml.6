Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeA3Mwf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:52:35 -0500
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:39648
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751714AbeA3Mwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:52:33 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: Michal Hocko <mhocko@kernel.org>
Cc: "He, Roger" <Hongbo.He@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
 <20180130101823.GX21609@dhcp22.suse.cz>
 <7d5ce7ab-d16d-36bc-7953-e1da2db350bf@amd.com>
 <20180130122853.GC21609@dhcp22.suse.cz>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ac13913-783d-26aa-ea5f-ab375f450f4c@amd.com>
Date: Tue, 30 Jan 2018 13:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180130122853.GC21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR0202CA0028.eurprd02.prod.outlook.com (52.134.10.41) To
 BN6PR12MB1299.namprd12.prod.outlook.com (10.168.227.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7929b866-9744-42b3-bb94-08d567e05349
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1299;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1299;3:1MmeMHMYIu7Mwdra39UpgMRSa1U18V/7qo8YaMR59tP+rjlAOf2duYX/GxGYyi5SFN9v30pK5ZX1mTfkJCj/korUsAUW5eL+Q34mkg5JjKM33o0VUemcaty3nWl6NXVvb1SwaJFFIM0c2ydeLHo7+HJBJhQsv16j5jQiDVUBnZVnxI0GRIj5SKklQ9MkjucmHnbN/JJMALtlQQvl476ilNrQr56TtC5iHIlgvleAJZD9GwKeutxpTVln16cHw1e2;25:GXQgVT56jF9IQ5oIWQEgzhDhRjDyxhlw/yNWfWMiIHzWmWSHTrceczRjH/Di4fz5CvWRnwMolWkAra36XzoVtys3MR4YCxx20iUM9aXlOi4CBRtHwADI5j8Immhk3KlUsxKcgNy3pSTTdeSMGxR+JZfZZCoYPOZAUtQBDxTn64rYjqYqx1QAwKaCKxm8W1KXa48vKhfPCu4Wk4hdEBMR9BT/RNEWDZtVFsJyw0yAtKw3pl7W2SCgBVEzZjybU/Zi6JcUdWX4UkLOXbIgGmZD6kTzd5r50IkJo5OH52VxmGTH5DMmOf81MBvSsZB5SekV6O/RrrtXwtl2bidN2fjDHw==;31:7MP4pxnidYNBJIvB9++xS0XeiHKCHJjqRL5WsBaqGZzAmH9f/pGYW0HFZGMIBOU8XF6Bs1yx0BndScT1/udL1nY1vOsZqgDrK1QZb9dUC/YxSR0vUVZNAjM6Nv8EOo0dlQs/VvLWMn5PBFq43iwp18K4ICVSm9vNxNT/7FLcN1ObyWDZ9aYwr/wsTMzppkJOuUhwCmrwVhXVU5BxpPbU0C4uAhzWUEbE+MotCpgwnes=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1299:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1299;20:J8xpFMuV/Go8XbzvOY7dLM0eAuEVoUBnq4XiL3YgU7y+WZfwHAHar//X+miNPz6reWDRU7mvKr24l7P2L56Kg/AqoUJ3zLyJC80jGsAl//AWGOOmKFKcSVjSEZRCkGd8KDTgkxUaSi1p3m/VJ0XV/gzGxwJhOfXMTlXUYnSLYzqmd3kgReVst/QAX0sfbsdodyYRJrBZvVLjWfQorOAivZIcL5OUYgvpPG0ZIRVNrB6aDt/ozHxOzJD5zu0ailBK7Fr5u/xib2jPWnNRWC3c7nuc5fZhI4xR202canM1T8IYtwuomdMbjZCs/YsirMQkQNZLo3OB9p1BiqI7fj7gvy+Rfp+3YSSRnyB0/3xgf9d0NFuJyu7jb2W7YsI4838CGS9Jz+WnftRXuAgoefDmxnvC7ta+lIm6l+NpE2y3zUVpuME7+7wXFAsoNGTsAGou13g5wDZYt9P8Usr0KcsA9JKMceE4Kw1O4qt+j0Y4XDrTevwQtJD8aQJl8TM27AlX;4:jwRaI0fUW85S5txsGNRCa6pz4nnsXPoqWlZV/IBN3lxAEg5B6QJ8f45GkrK8A1I2CILuyhKkYLDULS+zsfL9F3cVJjr3xvmmZ1JJvd3J1nKsXIQ4JPLVR5zCsosrHxAi/CcGQF0dZhiU1MP5E5v5YINTpNSak78aLvi5N0ekonZQ2S7jWzHUyatzBT4Cef1J2S2oMtEgeSMzUX0h+OvBeRX5Fja7MjVLDWIJUWCWEhrhOzr+xWB4hRmQRg+640aRAT/gPPO4i3nufMHrwEDyRg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1299DC644EB39A1FCFB18DBD83E40@BN6PR12MB1299.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1299;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1299;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(86362001)(1706002)(54906003)(6246003)(25786009)(2950100002)(5660300001)(50466002)(229853002)(386003)(16526019)(106356001)(58126008)(316002)(36756003)(230700001)(6666003)(105586002)(6116002)(53936002)(186003)(6916009)(4326008)(65826007)(97736004)(2906002)(83506002)(31686004)(65806001)(305945005)(76176011)(7736002)(67846002)(93886005)(2486003)(52396003)(52116002)(478600001)(64126003)(72206003)(65956001)(31696002)(68736007)(59450400001)(81156014)(81166006)(23676004)(8936002)(52146003)(8676002)(47776003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1299;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMjk5OzIzOjAwZjIwTE5PTEhOTndjeU5Pa1NiVmNEK1Uw?=
 =?utf-8?B?U0RHMWRTbnMwTTM2czFEbXhOZlRFTkdpVXBrWmJWeUduL3VHV2x5MVBJRDdJ?=
 =?utf-8?B?NENyL0NIblJldFlYb1JTeE1NMW9DWTRKa29DSXByMFpFcnJuRDBRUWhZSm8y?=
 =?utf-8?B?OVhJOG5SWGJnRmFzaEVQcHdxYmxjK3NUUWFISnpOSjIvVE1LNTAyN3pnMUlK?=
 =?utf-8?B?WHgvVWZvOGtrd2syOTJ5cEprY3o4Z1VQSGE2c3JJakpKK0ZTMFM5TEgvVnNs?=
 =?utf-8?B?R01MbGltaWY1NmQweEZUNERsQWVmVHA4VXlTWVZ6MnI2NERuUVBRZ2o3LzdI?=
 =?utf-8?B?ZXM3N3hVTEpubS9FbGpXeVpPWG5CdUtzZ2QvQmt0bmdOem12Qk8xMklXaTgv?=
 =?utf-8?B?QVJ5ZUNVajlhV201Uys5cGoyMlFQRkhQR0lpSGl2MWlwZWY5TEFPSEJHT1h3?=
 =?utf-8?B?Q29keFZSM0gvcEpkRFJSLzExNVpJQ0ZhbnJrOGNKQ1V3UEFPcmlBbUJqSXBM?=
 =?utf-8?B?Y01yejFGWEJMZHpvMEJycFJEeW5UOWtOSVo4R0dQSm5Bekl4ZGY1UFpJZ1g1?=
 =?utf-8?B?Vnlpb0E2QjhFaGhZKzI2WWdpZGpkSndpWXBaSzl5RjdkbzY3dG1ycXNxNE1J?=
 =?utf-8?B?S1pxUjRCZUVIWDcyYUFtaVJGc09uZ1gzdmVlM0hNMTR2TkdhNnBWUERJUVRl?=
 =?utf-8?B?Q3l2OFpPeVNaeXhGZkZCb0w2UW5IVlYvQitibG5Qb0Z1VDBHUjEwamF2dnpZ?=
 =?utf-8?B?UmtJcDVsY2JpNHNxeUk5Y1JnUWxnTUNuSEh3UE5yNTdMNko1U2MzM0hmU2Jp?=
 =?utf-8?B?YjVhVkt3Y0dwMEJPY0xRL1FlN3pzWUNDOVJEUis2TC9BTHc2SEUzcUNkZUE0?=
 =?utf-8?B?eGZ2Wks1K1VIbzVkZ2g4K0FLSVdqa1hXUk54NlhzWHB6b1R5V3JEOXhqaUtF?=
 =?utf-8?B?RXB2ZDNTSzdZTE13RXl5Zm5JcWpNQlc1a0huQXJDT3gvbDBTVjU3cjBLZk1H?=
 =?utf-8?B?c1NmMmp3R2FqN1hwSjRoR3RWaEZIaUlncktiZUV5RnVLdmRVQnRhdlZDdkw2?=
 =?utf-8?B?WHNta0NJaWlXdE5mMWhlRzhhODhOYURqTDQ0eFhJaU8xNi9FZDA2ZDcyZnNq?=
 =?utf-8?B?TTlFcDdUY1FFbUFlNGs3ejBJUnRZYnZuNWtaaEswRTA3YmttSWpwdlRlbXZC?=
 =?utf-8?B?dEFwRVY2UWNRckFYK29iRHA2OGJISDA1QW9pY3VBejlrdmdyZ1RDSmllUU1E?=
 =?utf-8?B?MUpaeGowSTVySTFkQVVHMjBKWFJZbEJHcHphRU5Vd1luNmtwWTFXQk1XM1dD?=
 =?utf-8?B?d1hwUlkwTVp5dWpPYWFwclBJdi9TUHNEb0hSV1drVDUzN3o4OWVjbERrdkFR?=
 =?utf-8?B?L2NFUUc4dm55QU53UnFMZTB3ZFVtZXBlRWZvNUFlWGh5djJFQVI2aVVMQ3c3?=
 =?utf-8?B?MG1OL1NqS1c5UUwzR2pBQXR5Z1h0QldYemVQMUZKN01tb0RiQVhuUFhKY3Mv?=
 =?utf-8?B?WEJSYi80b3J5LzZKaWc5OSt3ekJjTWpxalRrcGM2ZGUzcVZBdDU4aW9wWS9E?=
 =?utf-8?B?ZWFSNGZVOHJ5M01GYjJQQTVRUXRpcTZsUW12VTlQODN4L0dZL3U1c0pJd3B3?=
 =?utf-8?B?NU1LN1RuUVp1a1dNVnNRVWFxdjB3L0FzWG1Bbi9nS0lvQzB2a3hvOGVETkxs?=
 =?utf-8?B?OHRNMkJPcnV5WitCNk14TGJQUFhIa3FUTlRyZnVlN0V2eVErV0dwMStwTkVC?=
 =?utf-8?B?TW9Ma1Mya0lMQ0dwbHJSMVh6eDZsajVoY3F4aDIzaGhyeEVUM0NtTEVHYno1?=
 =?utf-8?B?WFVDRFB6cEVFZ1Q4K3krdDFmcExPb2VLRlJVZTJQL29jOU1CN1JyRFA0SzNJ?=
 =?utf-8?Q?CQ6XllxEWDc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1299;6:hecAGd4m8Uq1VMzo0rMeQyhv177Ey3FHI3/lq1dV7mz/moG22jrd1i5mND0bGlXHbYEp06yac3qua6/F5gRsWBS5hKMbwt2B6mQ/zVTSuh06M/D2piREkODf0WNY0GHukZq55TluPlnZe8a9UJip8FyzO0jp0cI03JeRYF3CMvptYr9VSKDUNXbPvg07s88Y7MJkZ8AQh9OJ3yLJrFj99TgfXi58/L5h4rBnDQ8yM34XTZU3Vmf421k7fdEgVjUZSjkGibNA7Xeg4k7JrY5kpYXQJAnpqbLzdpdvasa9Mj4lGdgjHWtXQP0tUWDQnMiZeexMQIjk0AkZFLbqUe6wtmJjRysr/e3JHhVvBCDhvZ8=;5:HW14cCHOPWtt6zpJW7+GKjsOueXmbhTyq4LxLJ0Xki7Ng1gB55M+7dq4IaqU+eg9k9f7vCY8D+2VA8ktty2bJ/arZtTLF8D48Y25xNIi3FsWTNl1YbzLSZ/EZ+Yy5i30UM2qXb9tQN3qvJ4nKkl7mX+nBRBH9dF0EGizRs32AyE=;24:kVfEDIHXdInKslcBrBeQTr3xZhHOAHQEbewvWSFOoJ0YG+hHnGY69BivI8LWFzCgh1Nrad/sH+GMr2d8Fg9w2fVUvkMP4cg0L4h7PVOkWZg=;7:90WAlTaJ5b4esOZCUWB6qeIX4Wb5Hi4RmLBbtgK7rnZsiJiQTHh9aEW3B8BqrceLq3AnWKG05pZmlfW9P6gidP99BmTewE4L8O6o/ecJiyidTLl3kcqK4HQBMeW3v9r5tv9ufITlaoBzJ44zcgg639C/ZsISwsyNkCMn8WjOuahdg/EGovDwAfDeVny+HRwOO7Xeou/d3pIN4XMTXWM9dHnzp4DjQUhQJMD2ZbYLLPsJsCzQMVnOKtzMbEPk6F/W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1299;20:9Q8ATypIpUM4ebqEUSKNMk5a1dTc8D65wzlQtmE/ig7DCctVQBxLLscKt2nbbpYTJg7udjDxAYzi/0rHMuDER44mPEQLf6iHoAFf/NbWCbU4q8kdP0GOo0x1T+BM0jLQb3Ty/fPCMaQTHEO0nbAbL5mE0uAV+vMW0XaBEr3Vzbt/+nOETt7C/SZR9rlxrKBhRQYJMpiFyXdaJYSoQ11p9otpxgo9yJjMZOEVtafh+Smis4s60s0vJ8pRufzDH+5A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 12:52:30.0938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7929b866-9744-42b3-bb94-08d567e05349
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2018 um 13:28 schrieb Michal Hocko:
> I do think you should completely ignore the size of the swap space. IMHO
> you should forbid further allocations when your current buffer storage
> cannot be reclaimed. So you need some form of feedback mechanism that
> would tell you: "Your buffers have grown too much".

Yeah well, that is exactly what we are trying to do here.

> If you cannot do
> that then simply assume that you cannot swap at all rather than rely on
> having some portion of it for yourself. There are many other users of
> memory outside of your subsystem. Any scaling based on the 50% of resource
> belonging to me is simply broken.

Our intention is not reserve 50% of resources to TTM, but rather allow 
TTM to abort when more than 50% of all resources are used up.

Rogers initial implementation didn't looked like that, but that is just 
a minor mistake we can fix.

Regards,
Christian.
