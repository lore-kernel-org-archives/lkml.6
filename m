Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754825AbeDCFoN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:44:13 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:58810
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754331AbeDCFoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:44:10 -0400
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho> <20180330151129.GG28244@lunn.ch>
 <20180402091232.GE3313@nanopsycho>
CC: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        <netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <viro@zeniv.linux.org.uk>,
        <ebiederm@xmission.com>, <stephen@networkplumber.org>,
        <akpm@linux-foundation.org>, <torvalds@linux-foundation.org>,
        <ganeshgr@chelsio.com>, <nirranjan@chelsio.com>,
        <indranil@chelsio.com>
From: Alex Vesker <valex@mellanox.com>
Message-ID: <0d106ece-4669-389d-da30-63a630ca625c@mellanox.com>
Date: Tue, 3 Apr 2018 08:43:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20180402091232.GE3313@nanopsycho>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.8.14.19]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(2980300002)(438002)(189003)(199004)(230700001)(93886005)(53546011)(478600001)(36756003)(58126008)(67846002)(65956001)(31696002)(23746002)(229853002)(65806001)(64126003)(6306002)(966005)(16576012)(31686004)(316002)(50466002)(110136005)(54906003)(106002)(7416002)(106466001)(65826007)(77096007)(2616005)(81156014)(305945005)(8676002)(4326008)(6246003)(81166006)(7736002)(356003)(76176011)(16526019)(8936002)(47776003)(3846002)(6116002)(86362001)(126002)(11346002)(2906002)(336012)(476003)(486005)(5660300001)(446003)(486005)(186003)(26005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB3108;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT062;1:fnF+chC9emMVxCymc4OqQ4Dn2uAcY9h+ZZconYeJbCKCJe4e98c2DF353bRiu4DCkjJ74EQsuynu9RexFoh24tZbfwkzsFxlzhTuH3hoTvqeO/u17Dx1Q0VWSva9bp11
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e44129a-53fb-43b3-81cc-08d59925e93e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0502MB3108;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3108;3:Kn1aJPEfmS76WihTlWCzrZGJi1MhOK9NGGJHxT6fOiBDoySnd2LYn7AE/glq5irR9JjSNM1z2ScTQ1yifoZbeKOVqvMpfkVt6LJCZ0LEMHNt5MCYtuLAdUQRgIzOTlYjHa9OnCooeqi4LPDxMGbzhjCDKGtlJ6SfPswqzhTLpY2/XEsDBDPRh9e2kUuJQmz8GiSgbhnI2U8D129ZQsc1v6YpZVGbnd4vBPbhLo3dTW+9YJ66Zy0MorZu92KHCDXFFgyc1bXMqe7q6ldE6sWuLd57b80zyhTXRAPWnR2+Fx/qK6nEMfYNpG8dMdIQYJ3st/7RsDbUlSv+A/1/eBfBzWM7XB5CZMTBfiz42UYI8Ls=;25:QQqdi9bATV8NpkBB+Xjsq7j308i9JDwZC3k9gshFc1/3NCUKpVsTI+Cbn5DMwer2kk8tDiE5f4223nVTtIzRvZxNiz8+DyvlkC4p+Si0wsWKsofUBYV1ldlSLlXm6oc61nBRhALDgziSFo8/N/K+BFw9PD69GghAcOs7ogaX8iL8YvXU6GKrwmTYjmAdfxEhXxHFrg3Os+JsKahtD2jtxnpIYqb3zw6w30SRpK5CSBktsfBOyRn6tfpR69wFWNDNweidoG9cK/vTVfKsnC+hsdXkm+OdQWu+sXZtUCl6WHcJx2K2ydGDa0s94FJjC26qhN3z3AlrwCVHk7EFy4jHdQ==
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3108:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3108;31:LkhbsK5WymIpdFTbBFnrNoTZurFN/o93FM5zs65FW300C+M/6JCrew9QgUtuDfsdVuvg1BWGLuGkHAsRFZcF+ydL6OpUHr+SSW1j5eSfP2flrKFpjX0m9tgbWnl6z3iNFwOxLxNPBoZMqKxogwtvpvixXQ6xxtxqfCIG1TykaWM2IbJCsyDvsfmLekER9xrtOtzdgJ/waDwGZ5/PpoKH3CbPEVkREmFiGu3fyefaGHk=;20:sDJcMbGQS99N5SlpiKbgViFDaH0VJRdwhPlRgG0czm5ElrWjyWgLVe4MDXWd+7D40cPlp/SjozYWWejPZQUUdVAAyGeeqs8OxPDQzf6yz12mvtr/gL0t95LviX19s07ST5wJGM0ykUCT2+z3mj7R5MKysQrsl2E5ZSnaY3upKj3Q31dmTek0K1vnVQ/AuCyVAoRr3oiqgE6eFJjjS/lya4ioMCVAHY+6gNsndxjYJcmbgYdHywtRJJa6rTuCkSgGrpEeuwAkJaJgy5YV0AN58yZxgTYYrtK6yLOl9vrCbnc+fvP+HAo5+OoIPqjfOOrlfPOYzNwLemPHYZ3sSnAoWfiGHDfcK1Cb7ATqWRS+IcfkWWevEodpDBs/gpj7SjeKCVxF3mMaTAVUUQSKtSnO3SqsT8mofBjW6h9Ws9oj4U2C9oyEeRLwr8yLMHPhgOSM1BN2TBAjkErMu18bPROYunLgSpjgMelFLnT6U1APlDyWD4JRNmiulLirBa3u9mta
X-Microsoft-Antispam-PRVS: <AM5PR0502MB3108E6FE83D88930CF695C05C3A50@AM5PR0502MB3108.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0502MB3108;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0502MB3108;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3108;4:0Dfn1ShQA9Mh49lEJtibVVx3XskR6LPUh3h80WfRxsSBJB8kKeVoftiV8P0HL67VFvinCAdzIwOHUHfRj2++/KBLr3inuJUk7nk2vfJS1CpScqz2XDpz8iwiVgsdyvpM8aTd43GhWYs3qzQd+Z0+xfMak/bhyIHetLxXYxsrtvD2y02AOW7exktHXmIlaiJqN855NMwPenpF7iTXLGypsyuv8nOQX/XyK1DR/0pdwnnc5A0CZlzz++FEeF/SA6+rrxLFL06NDI7jbat5hGjTkg==
X-Forefront-PRVS: 0631F0BC3D
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;AM5PR0502MB3108;23:Fr5++yqWsgFd/+pblTtKIa25twNumAeR4ru?=
 =?Windows-1252?Q?rm2h7qRhGuFNed9a7NFmSj6dWvFKwIWmH6GsReL3dQzf/7qv1ZVO5NW9?=
 =?Windows-1252?Q?OlQWCqwbCz7ehsREiUKUj9U5iZfVM2hMmScGP3HHHSVk+8W4y+Fr0boj?=
 =?Windows-1252?Q?cTlXG5z5JULDxnm0sGxWcJe56n5aYj0Qk+brbtKzgavfaNSkoCUKMDIH?=
 =?Windows-1252?Q?Dfa2oz5wgtHRovuNTE+mnxjMV6Zl3NHe8G1SFTHKO1LVHokVcsuu/i78?=
 =?Windows-1252?Q?62rLlc8+T668CEBq0iOy66ObSwMZkZWG0Jqe1bN0ADt5ltbOe6zoBclj?=
 =?Windows-1252?Q?c1N6NGqCP1DLDnMpBLYkKIEsM/0hfSdKypTCkDP8TaYBvlQf7ZBD71v4?=
 =?Windows-1252?Q?Y+it8Zoo1Bh5odLAUMCaSUwVAcdPYWG9M4QdHIHbqk4l94u8hAbQmnOs?=
 =?Windows-1252?Q?61hielDoanFLFzDSS5s4cGhpQaQwG1kySoAQOxu2xyB8MG5z4ifYCoOH?=
 =?Windows-1252?Q?Laaieu4dBo0LMNflQFUoVQrCkbOT4BGTrSo7Cjgfr5CQuSjiHmVg51C5?=
 =?Windows-1252?Q?61q2044JEgr7lQ/ZB3BtZQNZ3x+YGciWgzwwnRqEMhng0fA1yjeU+IfJ?=
 =?Windows-1252?Q?fbV2/sECkHaHvfsHbW71o6Tz3s2GMZ5NFTlYAzlIEhIjMJbgCP0DK+nL?=
 =?Windows-1252?Q?fgYn1Y1mxaTqw9QruEPFvRb17QnuX0TT2eJoIV5ZqEQTvmGP8mINjf88?=
 =?Windows-1252?Q?cCD6UHyG2z8vRDXC/RUhwee7FuxYU4SQAHV4PQybgPpjJ2geH63hwltF?=
 =?Windows-1252?Q?iiXy4Ovwt0GOjAN7lypiKYgvEe2b9m+8F0C4l8Y/J2MhjsH6W7nZ7B7F?=
 =?Windows-1252?Q?nvALS32MSnZT1q5OVKwdvMGazGqOk508hrAk//jmDRRUWgdy9eoEVt4Z?=
 =?Windows-1252?Q?3AyBAQJo46sm10cs4X8yMc5gNFfZzClWKLGRaqHbeISxDJ9SleiKtpSL?=
 =?Windows-1252?Q?TvNtrz+zzpkJUNodYPRSiRPCEocviDNkUA0+lDowsnbOzqKrA2+Xsni3?=
 =?Windows-1252?Q?6OlddaP90+PIlG5VTHnnkQcbhCP6NFWh5XAUiLBEcpiGKxFVzU477FlV?=
 =?Windows-1252?Q?1edZHrgo/D1fLPzJnZynDqSYLuFyCE/4kePTRlKKu4GtrGQSRXDetb24?=
 =?Windows-1252?Q?0AFu5Rak6ubaCAACh+pWkTxxeNJ0g4kICKp9azgeWROCZmGbZ8cx12l6?=
 =?Windows-1252?Q?tx2uMkUIDIFXNiE5TetKdK5fcwEHWMcsHG6S14SCxAZmWmYUqvVyEzNU?=
 =?Windows-1252?Q?+WSr+ELbtrS1VEVTGis0FqvUeJGvZEc6Dns/lSJWN15DR4UAoc+ikV8g?=
 =?Windows-1252?Q?DpSmdayokd7vmKkCSycjeSqAVjzjk+cVOsfKxaFB3+UswqCxPsmCLzN2?=
 =?Windows-1252?Q?OFSunYxt3JWu8mnXZbYBd73ccxnzSO+T+xZ4XCz3U7UNYIq3IlqcsU3E?=
 =?Windows-1252?Q?4AdH79fU=3D?=
X-Microsoft-Antispam-Message-Info: R+so/AN58LcPuIbknljhg+ENG0BzY9JjXf3bj42epUpjVNPVJNH0eUBZGzDAcLqtbTHl05ZaNg1GZFU/nAdNyzM2tT2Zv9PHKZHPOhQ83k/7eQXOToKt1AocXIUuOM4f8k9R4LA1UkVnmP8kzNvZ7vOxpRibmq/2s/cG3SXM5glv3zt/CW8qCe/ExwnTkWgu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3108;6:fSkbVydAwS0SdRjayWOixCTPGNtnXMxtQY6JKDFBEvYhIgl4K4ar2brJMOqXDFXjUBhqxRrKTOcqIGiosWlvwwZ+b+dzr2EbmQsyL8BvRrTo481UEB7th8yCjPnIePSgDLcBunpVbF7vT+7S2elGXsDmOh7H/fdjW+DhVv/Uy6yf5Rmcrmd6Ah1+PET0cLxKSBo3x7Br+YSIkOd3xoZnLf+ClQHEKoX4dqKPMf+JzNLZdkNhTQnaA7SFMIF6gd8ZpPqgQW0x7086rPLoy5+lUx+TAXpnsz9dVh1+iVI8XIo9uOzGEeZMclRZcCsBxYNHP/tGlA+Jc10SRHx2rjcDXKI2Krns4e3WLeAoatl1esln2at46R6qzRLY3RD7N5nXJfT02/5t389R6J6+8TMCiISjUn/C1DEbF90fdN8EghGkfeXM8eGg6bzOO32jc8/dRdgcXYghh019pXkOqZ0MwA==;5:wR6MigZ9W3ICG6PD5tILQowzimBbbFdVEi1wW5DyBdmZCs1ZbbOkLJBSMR5WFzDEHW6OV/A2Bl/d9QXCrBfjbz/72N4PEwBKWyLQDoY1fcFm04/7/orUwlWToHAV9jWqLfsgIphvTq4+W9L7eXzuhV02DOknuXlZP6cPMdxsiBg=;24:ODqhCJIVF6K92rZKfVQyazOc17MXir3VcJU4AHm7AVcJTwyP9eBGKHELs0K8cso1w3LGSTjr39vmadtUjg1V9O2GG2MWAhbxBDtHRVbw0SE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3108;7:XPpCsEgr7Sh57/2P7lEYkGtK9mTfSUVpeiYCNDopWZBxcQbN9MkmBvKL8TTPhaVJkW1cCfL4uN9NwaDHc6A6ENf4Fgd5wlc+Acipg9LtzhQXk+/TOGGSqOGFaIwAtuNjxBJb/eyejdMu27zk9KMD4/64wKbJl510ZunLmvQg9VRz4FjB8JPk+KVpZUsHJ5OHqf8apeRRs+fg/Xy8dbbMHlhDkiakj+NtJTKvfI0aWAuAEnIBILRnViHipSTirY19
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 05:44:04.3976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e44129a-53fb-43b3-81cc-08d59925e93e
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2018 12:12 PM, Jiri Pirko wrote:
> Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
>>> Please see:
>>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>>>
>>> I bevieve that the solution in the patchset could be used for
>>> your usecase too.
>> Hi Jiri
>>
>> https://lkml.org/lkml/2018/3/20/436
>>
>> How well does this API work for a 2Gbyte snapshot?
> Ccing Alex who did the tests.

I didn't check the performance for such a large snapshot.
 From my measurement it takes 0.09s for 1 MB of data this means
about ~3m.
This can be tuned and improved since this is a socket application.

>>     Andrew
