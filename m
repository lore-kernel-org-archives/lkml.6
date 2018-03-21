Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCUOuC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:50:02 -0400
Received: from mx143.netapp.com ([216.240.21.24]:8090 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeCUOt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:49:59 -0400
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="249200623"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com;
Subject: Re: [md PATCH 0/4] Minor 'cred' improvements prepare for NFS
 conversion
To: NeilBrown <neilb@suse.com>, David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
CC: NFS <linux-nfs@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <151737571564.14845.2874586176125198504.stgit@noble>
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <2ae93c98-108e-c687-4e21-f346515f5f66@Netapp.com>
Date: Wed, 21 Mar 2018 10:49:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <151737571564.14845.2874586176125198504.stgit@noble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.9.112.69]
X-ClientProxiedBy: BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) To DM5PR06MB3164.namprd06.prod.outlook.com
 (2603:10b6:4:41::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db6c231-f98b-43ee-039e-08d58f3b0340
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR06MB3164;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;3:phJ3fvD6p65xGdqHIQeR4CiozW0FhYmIpEmbYkSVoI55/ek42yJduPtb2QmY0r+5dPR15gMit/CP37TyC1fXPD5WcdqUKOpqGNXCGh33ahP0XtYjUtJSnu4KLJ+Sh69sNem2BW423mryL0HWifdGODRZ2vgBDee7gMX64rzx2niT/rvdDgZDJKo/r9NI2gjpRrvUn+uj6Y1KgD4YER47jFnLCcs0fQ3e1F3JJUh+ZMIJJMwkpRzOBeHH94nqZElc;25:aRuaU8olG4sWjcFK/oY53jtGiPxbE1fsQmeOXlT3dt2xDNCUlDy1WCiIkQERR9iAZCE/KD9R3atFfXwat58QeyEPHH5PcrucFFiGZdLqkrZpNLTF6+shZF/SeFhUBYL0zku4PmibaJsFwmKvK22gV7vLOiXNz+8NW32Hf2nBEbgPesgUP9gKJr4Q/deVUaE3vCwOCSmTpXqKjMpuc/u21ThTm3wd22OgqePYR+Ov5Hb/M5mmRAAlhKjfpvcW1IlPMxx/qKc7HTVzZy0MHnUDrjILqjHEb3F/ffvcmabRVoT4N0pAN21xDWTlk/AzEu7/fjqCUdx4Jri6qpHEWJgsuw==;31:zubccGCkdzmTZW4r+L6eKJJbfpynQdwwU/7wyINuEOMj7+mH8gJg5DvdWRls/4rpL1l4Ldt3TaAhtv+tM4iQ3yfJhH2Dvgtgmd6g8fX2WK6+IH3Jgw1tokXLnRz1fUtYkfU9BXJhB6LT0gEJ6k42VXVjRMOlltHbHomAf8DoSAf+cxSy5OlvEPowjIpeWGfFqsK02A+V65KbMW6JPeqD8T6gu2V7klef5sLUCIdm35c=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3164:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;20:Qsi9+V4zFVZImiGexZOFA2dFO+MlQbmEkooe+501uWXB//s2/rvlLjuWYItNcph1j6TAO2mm2bOuBFnqz1Kc1iErpNXy5YAVXexjYxLYcOEeGkUa2j84gfGWrDMuFeO7DYQqIGMXZhUqu0lvVAwd+s/3+qTNaPzp8bocIJatqhquphvo1qMeHGK29hbVU68R5XjvaqpKs9GKPTvjuVs/9wfK+OtHJeQsdSBtqYj0nzH48sbSJ34n4jxt26c1PA8a3aC42G5O/PGw/1ibabEVJdoSlno2655ehxCuDtiUv/cdoh53hgacpFL8FnQEeBGV7QAbs1G2zcYJ7GRb2bXbUr/bZh18uzD8w38fZpXzyiT1MDyDAOB4awghK3DH8Awk/5z+xRIuiESZH656ry3lY9KLepvIhlxc8Wf3hFIOPeLMAy8gueYrfRm1tiGvHdtVIuIKGImIPKvDbn3vb7grrBLTWgIuI48qR4qlCEpw6Gc9E8oh5LJp3Wb7deU4CNyG;4:EpAUx7/KrPzWuJoA+dQ0bvCAdIvdhq44q0lYceT9x8ENvU6+40jkOxqI/DCSpUBXHe6Bc37Iuu6l/tk8GzCe7vWM0c++QpTWuxCRrkwS+4teKaAEXIEEDgchj9tVevsb2CMPrGcGNZeivH7SWuETjB0MK/xqLQn0qUe1S4nMjBnhq0mO1G4gbKqiKrJgLFW3CK061h66yid4ZBTt8cnCKuJ/QCWa81wj5mJ+am0PDDHCsCkJjEEu2kl++Meh0cbwA0yj1C+nqKEKiAN0tYdTrGGeiD9XWHkC6g1TK/4wzJavsbcFdF25cCZla9SsKnti
X-Microsoft-Antispam-PRVS: <DM5PR06MB3164C3C891A455D0BCB1F4CBF8AA0@DM5PR06MB3164.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501324)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR06MB3164;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3164;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(199004)(189003)(23676004)(65956001)(65806001)(105586002)(66066001)(7736002)(69596002)(229853002)(8936002)(305945005)(6506007)(53416004)(86362001)(65826007)(16526019)(26005)(186003)(106356001)(53546011)(58126008)(31686004)(386003)(2906002)(316002)(47776003)(52146003)(2486003)(36756003)(6666003)(2950100002)(230700001)(6512007)(6486002)(81156014)(81166006)(6246003)(54906003)(53936002)(31696002)(76176011)(4326008)(110136005)(478600001)(8676002)(72206003)(5660300001)(52116002)(3846002)(64126003)(97736004)(6116002)(68736007)(25786009)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3164;H:gouda.nowheycreamery.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMTY0OzIzOitVb2tCUnZIOEZDUWp6M0ZTUU1PRlY2TERQ?=
 =?utf-8?B?b0pDaHlxcmlUeWlKeEl1cG5IR1ZFNXpMTWNGZThLRGZKKzFLdEVIc2JRSUtC?=
 =?utf-8?B?cFZHQy8yWWlpL1lZZnREbjJyQUx3NVJOOVM4Rno5VkF0bzRObjRTd2RLOXh4?=
 =?utf-8?B?dlduZkNHTDgxZWpNVzRiN2JvZVQvclZSNjFtNUNUN2k5Y3NSRjBIVmZWRW04?=
 =?utf-8?B?UHU5cTN3a29ZMk9BRS9IOURBWDRmc2RYRnI2SElxc292dzl0L2kzV0grUlBJ?=
 =?utf-8?B?TUMyeE1DOWFyeUx4d041b2ZQdUhCNXFQMWErT2FTYUYwMzlNWWRyY0t5Yzky?=
 =?utf-8?B?NU5abUNSS2hmY0s2YVZ6enhuZjc5dzlVYTFPT0V4cnBMaDZhcm9EVGUyOElv?=
 =?utf-8?B?cDQ2VVJtVTZLZGZQSWNNeXJJeVEvQXpFRGlsQkNuMXRiY3hMLzBHaWtYZng0?=
 =?utf-8?B?cDBaVDNPMFJzVU03blVVbzFOUlIxTjRQNWxGdDBodVg3b3gycW5LTVpSV1Mr?=
 =?utf-8?B?cThJYmwzeGp0NzZGUTRIL3RCYTRRbWVPa2pjNDhVTUVlL2o3eWRQNDJrdWFs?=
 =?utf-8?B?TUl1REsrRTk3dTB3K2h3cUNJZmJRUkFLaDAwUzVucVMvQTRDNDVaMFFycVJI?=
 =?utf-8?B?b01Md3JvN1d5VFRmcVd5U1k1TXNSODJKbmo5KzNReFRvTXN6aFJTMkhSd24x?=
 =?utf-8?B?UUdXMEdRSEtMU1E0ekxieVJ1cC9CN2JFdmI2dkt3MHhRc1pqcXY5YlV1L09v?=
 =?utf-8?B?cVZZQlRhcmxuV2tKbVFVMWZhTVBBenczYlE2OUdSeVllZVRXK3h1YU1UVk5X?=
 =?utf-8?B?Y0xYY3lCMmpRREd3MzhUT2o1TnNpM1J6TzhEWVp6TnlHVnR4VXpxL3JTVHov?=
 =?utf-8?B?RVBTRXd4MlNKRVhmSitWZ1p4MzZ2bG1KdSs1REFvK3BvSDZrNDBGanRCWmtH?=
 =?utf-8?B?T3B2UjB2MTA0bWorQXAxaHhhK1Q2THZTUWMxTGltcUp0SkU1WUp2bGxZTDNm?=
 =?utf-8?B?N25wOU8wNzlyWkp2Q1Bkb1RXV0VZdCt1T2prdXdjZDBEOFh6dTZsLzUrL2d1?=
 =?utf-8?B?NThqWmRtQWdrbFoyaENpN2F2NGp3SkhaRlFlRDZnRlVHbXVxVVhhUmFLRitz?=
 =?utf-8?B?dHZiUjNPK1BDZ2k2Sk9NYWxzYk9zNXN1aEQ3MDg2RTVsRS84R2EzZElUclow?=
 =?utf-8?B?ZXg0QjMxdDk1a0U4a1lRMjkrdG1sQTZnUUVIOEp4K2YrU0pwL0tzYnFySVRD?=
 =?utf-8?B?WUF2VHlPbXhYZVRrSGxsWHBFMVMwZHZnMHVRZmtpam5WU1hsWVRzYzh5WTRS?=
 =?utf-8?B?eG13dENENmxvUXZ0YzAvVjY0eGdOVENvdTZLaG13MHRpdklQQzVmbzlscDlF?=
 =?utf-8?B?T3hzQ2phU0hwTjNBWWVGckQreDBFa3A3QUdhSGNRcVNjcHZJWXlqSS81K3lR?=
 =?utf-8?B?bEd1S2J1ODl6b2J3djdMNkJNMWkrQ1hGSFc3ejFOcEhvdENrWG5ha2xlOVJV?=
 =?utf-8?B?VTI3UG1TZWZUWGYvTW15R3RPRjlDNXJSNnVydkNaYkdlbTlqMStGYUZuS0ND?=
 =?utf-8?B?RGxwbDU1VVE2UXFCYU9McnpqZHR2UVJXeWhWT1ppMU1FaGxtRXI1ZXl1M2Vt?=
 =?utf-8?B?eWc0VjlVMG5LUU9xdkx0bEQ5eHFreFA5eS9wTElsbE9ldnFLVDZBN2Mzbjk3?=
 =?utf-8?B?SE5WZDNZalJ5SG53MHpoVUZ3SUR3YThTQ21RTnVmaS85dUhTRTh4ZzZ4WE01?=
 =?utf-8?B?OVlWL01WYWYycjBTUWtUVjM3UzBUL1RLc3crQXUzOG0wK0xzMXhJUER5bEFS?=
 =?utf-8?B?NmVxa2ZNWi9pNE5QOUdMd21HVy9BOE1ld0Fxc3lXK3ZWdmdXTHlXTDNKSjFF?=
 =?utf-8?Q?2v27S8Hartib6kqg8dgxwT+0V1tbcaGn?=
X-Microsoft-Antispam-Message-Info: pmv40wLAVgDZvBsn91NHpt3ViGGu5QVsiC6jQPi3qivx99LsE3z+239kVtqFfjnumi0UlPeI8S9Q5+Q50jMm8zgiZFaxDQMzGQ0iinauhBTA8FBuxnY/dJWNWk8satA8B/HljNmLLGaKmXAXPQeDc4V09hBQBlYkVE+ZQ7AQ9jlDpTjyTuJisAsHduOp1ZU/
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3164;6:veWEFuR2F+g6NRGQahkIiGTr8Om7Py2ZsNNG3MEXyvttyqWBRtDxoYgpalAL35ukzD2Ras/WHXwQRufZSuoXVYgwnRP2Fw0x73+1uE0KkGfBKTE+rtTkQkXo8uJx3d65V5Kts7TZxyEDOYRr9UneESe8Zyc5b6cHasjO2YP1jFW04MDcs1XA9xhLpAip381xAJNY2Xgfk7gJt98vMIUBX+MO1YeX9sTPDQDvLrn/cbyzOisYW/7FNMKH5Pypod0gEUg7GZifgDZkJVqkKFL6CSwiBbBiDv9jv0iKYKkspwS5LO8+G+p0eawiPyPh7VippTRRPeJy/NFkn6JIaP5zjd3w1L90vCchhcnSwV5V8BM=;5:lQEiOt2sEfCkxQOAtvXcCj+tZwjS0C5zskS/GahBNP4xQ7wERy4OrF3ZiyLjMsW3VEtCwEA7m6rX3FCNcUkn78nSZF9sb/H1GbkswmKfbPdn87bxnPxsAfxK+SknEyk6EILaKgKgNaSE0GDtW0IYeRc7DM1EGHx7UPnQx3doMTs=;24:gHbKaEUvdUX+zTEtvow/pKRV38dc0qKUYusuGfyqK7JQ28Jc2A4/d3xqCKFlaghE6Vade1go5/GAE+RIax3z2BYxKkPFEreBwXjqRYtQRtk=;7:DSG6OI+y1mvYoV2CEgLhBVuqMDDlVk+bntas+KkcNVdukOscSOrAyy087v+n8B/PS/SU82vD7S9ZI5lgKUN0qr5uElJJswVmYDt96FlGWTEE5LEkhiRVd91tKJvekqihimkozab4lirBwuB4AXelMRcVJBf8eyLGJnhPrf1I+32buOU0s6rvQacCublaoq4mS9TcXc7RkZ4I7qGm12ALZhZsIkXz3fpIrq+VfU40nACDm7jSOMROnba3mjNi6EFb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 14:49:54.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db6c231-f98b-43ee-039e-08d58f3b0340
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3164
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/31/2018 12:15 AM, NeilBrown wrote:
> Hi,
>  NFS and SUNRPC have an internal "rpc_cred" which plays two distinct
>  roles, one of which is much the same as 'struct cred' (which didn't
>  exist when rpc_cred was created).
>  I want to replace that usage of rpc_cred with 'struct cred'.
>  Doing so requires some minor improvements to cred.c and cred.h as
>  follows.
> 
>  It isn't clear to me who "maintains" cred.c and cred.h, so I'm hoping
>  that Andrew Morton will take these (if no-one complains).
>  Alternately if I got one or two credible "Acked-by"s, they could go
>  upstream through the NFS tree when the rest of the patches are ready.

Neil sent these patches out a while ago, and I haven't heard any acks for them yet.  Does anybody have a problem with me taking them through the NFS tree for 4.17?

Anna

> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (4):
>       cred: add cred_fscmp() for comparing creds.
>       cred: add get_cred_rcu()
>       cred: export get_task_cred().
>       cred: allow get_cred() and put_cred() to be given NULL.
> 
> 
>  include/linux/cred.h |   26 ++++++++++++++++++----
>  kernel/cred.c        |   58 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 6 deletions(-)
> 
> --
> Signature
> 
