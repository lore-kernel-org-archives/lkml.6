Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeBVXLp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:11:45 -0500
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:42477
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751432AbeBVXLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:11:44 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
To: Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203656.25C9B4EC@viggo.jf.intel.com>
 <57A9625E-3F25-402B-8B54-129A68449C48@vmware.com>
 <61c68587-3ad5-edf7-539c-8af99c6220ea@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5b801b73-bedd-e7f5-765a-6e00759a5786@amd.com>
Date: Thu, 22 Feb 2018 17:11:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <61c68587-3ad5-edf7-539c-8af99c6220ea@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:0:57::32) To MWHPR12MB1149.namprd12.prod.outlook.com
 (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8679bc97-c1db-42b7-0c85-08d57a49a196
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:5eR7RSIqNiV8gZesuxOw7rzDXjwoE93N1KD6vdiDrf0/rDgCkft81H1ytrsvivGoZdJrANwWuW+CMxhFeUOQC9HVWUtl6xz+qeoRzv1FJJhVG+FxoyL20X5qB+n33HYpxsEBJ7k87rtvDgaT9mQvrJVtZ/I0gfLhPU4+4APW8h+R+pOOhey2rw+bioxwNW+X2qBiVzvYDnPgCpPQf4Q33lKF7XvNPJz/DAUIYrjWznFt91F+MMgElUCIpnjKrrqZ;25:9xJTjsEc2O8bmJqdhHiXmXw6wnf9dQbh9RAESMm90nMN/RcyA8Kbm34Ux3d+VBa2TRzLU8pH4hJEMWA+Pubxhm4/+16f0h3v84G+u//zkoMnFXFK9VNtCRoF/bNEOJceYPqz2QCKLC8cbqq/DWkWSAZgrulT9s8bInXOvv6ZhciiUAdq+B3T1NDxT+UHFENHm1HXpUDZx5nNPZIR1S9ER4i2cerAlr+2mzu0hT3YtINoQPY15K7ohq9ncEIbuJOx7IEcVnOHGevdTcjDBqK2YZpRhcW93jBaOy2uZlFZwDJEfAwotYu3PUOFIGZkAxPdEmckQLUPzxJvjz5PxawiOA==;31:u8I3BJPHep/TKEI6pVRR/NVfDa2BWlBJlyyRljIC3KLUXARac6DL7QdgynsKK4vBaSgQMDyJ8S3dsjh5zZRMN+f1kkhvPq2SDy5bXfxtH3Gp1OxqQpm4U5/pE7HV/gbvafwPBoKNPoKupimH/3W9vHkKdxMjlaOsa6sDGgJZELqLb5Hxwq8gFbD6JAVbTNfaXWDHuTiWZXlVPtMOaUMQ7kF+ZBRkCIq9iv0gg9Pj3AA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:iUh6gO1NBH07eOZb6FHEBzQBy51SDr3iJ2j/JjYljxUkyhKjGJkqo8cG5ZUpufoU9nPNkjvWw5MkhyBtix8h2KObRKTq7hJYBnCrrk/PZyfmYZJT4KRAbknAWX9VVWy/VWUlbo/abM/Df69ASkDaZnXqi9pOlkRZgigsLehq8F8+w1dca14s8oMKHRhgUFO+4jId3+AKdCaYRbuwA+hSRWa/O/eAHaan2C6c1P+bvyT8xhcpYGKsWR44Tz8bKAyEKAiSFEBULpHL/398w0Zid0jl2gH3iWj/sGCpy9msckzsqQpDQiZy1pHHbqvPfzzUsoLm/O7N7/UxuEj1j9BOxwtSzwJDU/s8/McDM8qH4RU0omJi0oWLLC6/8BvlRvy7g11er+KE/Tbf3Gpv+kYMOZiaopQEwZMztPRPrNIC+50R9OoSlpBCREXK2eTFpCkZp+LnbBdUgnqUWO2jjqAvXXSx78lthC4ALmnsbXDzyJf8C+r9xB4yr5b0jv0HhxCz;4:VQx53T7iGdDA7d/Mc6VGobNuOW+kk7IypqFqJ/fb3RBFYcxneCna78oeX/6b/GmqCPZU53GPDaA+vdMO6JewOzhulJ70C4BRc1Q8DDhmGh+iwkDnWZ2sUlW3iT5UeBbhSZmLPTS6vxqT5h5RjqIH0pgpqcnd3vJqxk6WDtc6C6Xowwq/Nord6bK1w3nJpI6pIJsOZ80KpXViVETdVCvl2xRHDbeE7iMKFAMsijQlyUGRXVCVRAE3JzULQdyBT5yYannghp334cgQGE0SGemlfLercpCI9Ta4AUYOYSHsaThopt5db84ip0ocpSozoM1X
X-Microsoft-Antispam-PRVS: <MWHPR12MB11494E740AA55D9DFB9269CDECCD0@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(346002)(396003)(39380400002)(39860400002)(189003)(199004)(65826007)(478600001)(6486002)(106356001)(36756003)(186003)(26005)(31696002)(16526019)(77096007)(2950100002)(53546011)(386003)(7416002)(6666003)(93886005)(2906002)(68736007)(50466002)(47776003)(230700001)(6116002)(3846002)(64126003)(72206003)(97736004)(7736002)(65956001)(65806001)(66066001)(305945005)(5660300001)(31686004)(105586002)(76176011)(229853002)(86362001)(6246003)(2486003)(52146003)(23676004)(8676002)(53936002)(8936002)(3260700006)(81166006)(81156014)(110136005)(54906003)(52116002)(4326008)(25786009)(316002)(58126008)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOlR1aXVIUURkcTFDa013NlBjZjIyd3Y5R2NR?=
 =?utf-8?B?MjBDWlhtdHJhU1hDRHlpcmxpL3dHdzVSMk9xWUwyY2JuVkV2SnpEVWNDVXhW?=
 =?utf-8?B?eEN1WS81NEo3eEdpNEZocUIxL09EbEVEUmdjd3FlUDdvcTFqN3drOHVlRE9V?=
 =?utf-8?B?aTdxSGlDK2hUYjE3M2hNclM2dERqMHpCWjlmenIvZUg0R0pwbzJHejBmU25O?=
 =?utf-8?B?bXltd0d0bnhxNldQYUpGSDhnbHI3eGdnR3BKd1RnbjNGYncwL3VIZzVlMVdR?=
 =?utf-8?B?aDZUWlFnTFozQjFRMGZmSnlNM1o4R2VGUThBUWVyUEJxRDVNYlBxMUVqQzZw?=
 =?utf-8?B?aGhXRTU4RE1qSFBiazAyU0tRZVZSTEJnb1JvWGNqRjA1bGExcGYxU2FNd2Va?=
 =?utf-8?B?d2x6dFBObEhxajg1SHRiQmhRaWVrejgvdHlzeTk3MUREVU9yT2NmUm1IS1BW?=
 =?utf-8?B?RVh1SWxocTUxYldtYkNPVXRvWnBkNTZsdlFOR3p0bjJCK3NydmlabUIySlg4?=
 =?utf-8?B?UFN6L29OS1VyTHcyR2JHRDB2VjBsK0x1ZHdoNEZRdksyclErcXRDbHFGV2NT?=
 =?utf-8?B?bXozNk5EdnYwTkVSZjhCNVA2REdydXhLTjY1QVgwSG9YbjRSQ3NsekJzT0c3?=
 =?utf-8?B?eTNKczl2T3p0MkJRcTBYOU5oV1BOaXp5N0F5NFVvaUhqUi9Ca3M4dDNjWkJ0?=
 =?utf-8?B?Z3pWT1IrczkzYnB5bjVPTXdKdHZyVFROUzZHcW9NVDl0M28xUWRxM09EN0s5?=
 =?utf-8?B?OE0rMWpEd25BNVhJN0JZWGlReGxLaUNrc2xrMVRSN1k3THUzOUFUS3ZPcURa?=
 =?utf-8?B?L0ZGRFJ0NjBpK0RnbDNaQlNobUJseXJZWDNZVkxzSmZpYWlZZEt3VEx2U0RI?=
 =?utf-8?B?aFJGc29QcE5yMytrQ0s5akNKMmN5UmJuS08wT1hJYXhiTEFlK2lNaUhKUDBD?=
 =?utf-8?B?eGI1dENoZVFUNVZRTll5d21CL2hXOW9nRmhSU2hRUU4vcHFtYXBxbDk3NXU0?=
 =?utf-8?B?RUtXQzRtZTM1NHd1MEtUT29RSUlveTlYaVZ2RWg2UmpqYktaZUcwdnFpTW9p?=
 =?utf-8?B?RjNJTUZnc2VTV0daS2FtRU5yZ09JT0kxcXZDR3NzSWpnaUUvK2txckpYdWMz?=
 =?utf-8?B?ajAyeVU2cVVaYWxjdk1yVDRORGtFVUJFdU5INHVOYVB4TjFlaXBwVUhDNWRW?=
 =?utf-8?B?MXNUU0RFSnNQa2Q3MTF2L1U3b2xyZElBUlBKakJPeWZocU5GM1lFSndVSDQ5?=
 =?utf-8?B?NWFVZ3BrLzdOVlVZWGZkVDZxODFiLzMra0ZEbklMWEVyLzgxYytOY1Vub29J?=
 =?utf-8?B?RHZFZWxMWUtGWlhPWnZGekRad204aTN0TXFCYU0ra3UzR3ViZWFZQmwvZ2lG?=
 =?utf-8?B?aUJtR29vTWtkWk1KVG5SN3kvOEpWNDVrOXE5MHFwODR2Y1B3eVhvbjdzM0R1?=
 =?utf-8?B?R2l2cDZ3S0JVaVV1OERnL2dwb0Yza29uTzQvZlZucW5VMlFlMUNvRmNLeU5l?=
 =?utf-8?B?NGtvNVg4azlqUlYvNmg4TFJ4cEczaFNnT0lwWHVQQ0phWHkvNm40VEJ1QlZo?=
 =?utf-8?B?cUY5Z3g5YVgxRUtRblVIOGhpTFhJNUN0RVVuZDlJOHVWd3BiVEhCL1ZrQTBQ?=
 =?utf-8?B?Vks5UThCNmxuaG54RTBEY1c3YXFJSUxYdnBaYyt5TWJ2STZWcDd4Zk5SMkFB?=
 =?utf-8?B?WS9tRTl3S1RpYkltVlJhN0tCUUlUaFlsWVBxTkU1NUZZdEl5R3c5UzJiajFV?=
 =?utf-8?B?VDBvcGdySFgvamhqR21pK0w0YWlBdGxaV0p5TTFlNXNtNktvQnRFbVlQWDdZ?=
 =?utf-8?B?bG4xcnZCUkdFVTJidHBwc0g1dUN6NUhHVjFkKzI2YUdPTVNycmtRRXg5MW11?=
 =?utf-8?B?VTU3UHI1c2N1NTZNRnh2MzlkbEhLV2JoWU5wY2pRNER3NnhuS2JsaVh6a0l0?=
 =?utf-8?Q?zkuENAncmAnxrCAOXMs9fu6RhIaOZg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:GSAHhk36SAg2xabGVnZUWJKyIeHDCL6uDe6TTeELiO6D316qL6Uq6CYV95t99A1a9j9Q9hakxUzrO4ntazeG84PowUPSlYBST/YRd617wRBiCsWaRF8vijjlBQwonetZVkGHwoeP0zBOdMLlhGbgAVAuNUEhvSkqWZFtxDiPFqoSkew8CeuX5HBUmQc39tUpx5FMby9nNXVFkaSRRERv5HfWtX6J9HbaUd3SDUdp8T0fnZQxtT38zC4i+oVsyFIE/0CXqHVqHQOAZlwE4qI4O9xfhwe8CIvJhf7eFM+J1lH1jyui2OqteZlk+UivTPOjl26diE/J7HRoHs7GKRpDxARpmixjPPlp58kPDQD7xyE=;5:5AIQxob7Qw/3zARreDP4TXoZcI0ki41csinXu9oNIo+mP5BXLjW8X5L8UEKCIVfWkWUJIEKAwBHe1kgKsgZVgitHSVsdWnqV95N43LjEe5XaSbIl/YVaH+1HhIGxiKeWzWCC/LNhDKHvtXdF4JEkRYT5VzKu2pbaIUCLHHIuKGs=;24:Y/xpU+/kzfRAeNqDJ99DR9JETU+M8YoBgyhqVW4cCJeONLF+V224KvsD4zCU6XQ3nhaRk5XEy7/338KgouS72bMXDf0FvCcrYob1yjzw8UM=;7:Td1TpakuVGjaqNjTeXPTsh4MBtLtXNeXpS5za6D22DjYfkc4vOmvS1cvP9xqjA81GS3OpJ8hwLPXAMCEwdomOGXBOABLeoET7lz6Ckyv6LmkbauKHWJSFuVg4TAZpbjmI2NaKd5gtEXo8knaS5+shP+fFv48gag2vtIkekKHwA2KMEmzV0U2G6qJXGQ9rKdNnU6kq1C1Bg1/FkbC1sugHh0yqJ0OHyUPKxMdfDsS9pY9VUpxx6kxYZzwRjCqaJ/L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:z63YiE/FjdxX5dKnNFzBJynsTtwlNtAAk5QSL91x1B+arlxe6lPQzAuWUUy2IprF0hOH39lV/mibmSguyuhRN57NTrl+CGgn+mqMCz13nGrL+eF3JYQmA8KeCZ5GiCJuZ7CD/o3Sisfhd0tLHsYjdnyXLMmHyyMY6GJ/9JRLLa+4hAtzNLhZ2h0awiukvSn+hx5YOJ+dxxVVxRWT3qPiCzcByuzNAAanLeSMQJGpK7bvLSxT2lFNti9rgBPhF5Rf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:11:39.4022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8679bc97-c1db-42b7-0c85-08d57a49a196
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 4:26 PM, Dave Hansen wrote:
> On 02/22/2018 02:21 PM, Nadav Amit wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>> The __PAGE_KERNEL_* page permissions are "raw".  They contain bits
>>> that may or may not be supported on the current processor.  They
>>> need to be filtered by a mask (currently __supported_pte_mask) to
>>> turn them into a value that we can actually set in a PTE.
>>>
>>> These __PAGE_KERNEL_* values all contain _PAGE_GLOBAL.  But, with
>>> PTI, we want to be able to support _PAGE_GLOBAL (have the bit set
>>> in __supported_pte_mask) but not have it appear in any of these
>>> masks by default.
>>
>> There might be a potential issue with this approach. __supported_pte_mask is
>> exported, so out-of-tree modules might use it. They therefore can
>> unknowingly use this value to set PTEs with _PAGE_GLOBAL set.
> 
> I don't think we can help out-of-tree modules getting this wrong.
> They're OK if they use PAGE_KERNEL*, btw.

You will probably need to change __default_kernel_pte_mask to be an
EXPORT_SYMBOL instead of an EXPORT_SYMBOL_GPL for (some) out-of-tree
modules.

Thanks,
Tom

> 
