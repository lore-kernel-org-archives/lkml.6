Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeBBTHq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:07:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43866 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752050AbeBBTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:07:37 -0500
Date: Fri, 2 Feb 2018 19:04:33 +0000
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
Message-ID: <20180202190426.GA15313@castle.DHCP.thefacebook.com>
References: <20180202165754.8551-1-guro@fb.com>
 <1517594367.3715.130.camel@gmail.com>
 <20180202180624.GA11596@castle.DHCP.thefacebook.com>
 <1517596744.3715.137.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1517596744.3715.137.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:ff89]
X-ClientProxiedBy: HE1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::11) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abc6c5da-a2ba-46d7-6e2e-08d56a6fd637
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:BxjoB/DbNBnx8gMuC1659ABAnfdEoK6cocGgkA4zOzMY/V1ePntuO+21kywYSpfN4cGs98CKWii3P8S6B638Jp+jxdoW3QmeVEyTU+hIYwtS0t/zkVSs4jiLN88Gv6/oXcE+pNg4/qbpaY2DBcp/mttN42/dnqTbDrsqWB5uoessHtmZZSpuED84HNkMkb+9b06aw1N+ZzmY2dPNn0xtE37+MBGR6B9UA6xnqx5Su0n3G4ojWr/nH2z3Q51ar2P0;25:ExtymrKOyWXvfy3gjCFx6hQZtqrK1vsaC0RokAqAa+jlTnJ4BlbwUlQGw5LFhKMZXOzTCf9IYg7nKFg4YXnn6GzGhU2chqWAd99fODQHcX3MI9y1KGhSkZCzS5gm0D0bXOXfGKkjN7qg3QrlVRnEk3EKWvsXukXs5DEiJWiVSDxFHyx9Ab5q+Wt+w8aZxyVkyuV1o62nI2SqRA9N+jG8VKwbsdaF7jspzuaMJ7EUDfemJDPUCY4TOB/97eV73AVprP+BC2sOsXT0FVwFnXNXHSkNGBJZFp1uWIQnmCDZzldOjH0gSCMOqe6y846RxvpLw9fNoIv8NybngIpw8gmBIA==;31:ntrKYAjJCZVQqvSOLo9ZpUR8nZQDrFOy1RPdj/qg5DAN4VV/rUGw4k4JXQnKznHnDNXXnokWP8k7bG1Tr52n025SRMxttVG9aawDrTVjBsvY1YC2ovWATnaWlBsyzGyrppeP7439MlkTuNk/H4g5fTdTRwxTVsYZ17rLP5fkNeRA3WSvEPBnYzRqIDb8L9aTUXIISb6kpCdMZ+xen0SXnU8XHInTjJlCqvIYUqE2h+0=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:kpQdVUTjhCedj+AGQTiiMthYhuV8+lZ1dJeTr7RNmhXGlD8wd3wjJKkf2PYvwRUF/ZzPkcFFAQO0mHc8IJFfz6ARXr1W1HaTVa8kDZJJcsL4VatcyUhBralVwfUYDeTF6Ogw+bJ5aJm+qwhiNmxav8+UK0dY8a7dBwEwrfMiVWZ7JBfF0m2HLDsVpFgYbpmOfkO5HhzHSOqcYujXdBcE+A7Nqb0zHwzd7rpvLjTxqZnERwDsQTaeMbVEJvESznroe1PfDaaB4LWngJ41TmcOjKz++TtXQuBlPDvq4EIYYsxY6dk/Nh+va/1bbaCTW45f7K5vV7Uzzd0cPThMU4T70BR35vH6YhHKyJUYyPLNb9M5C+Xd5Qf4eQ/E3n5nyPvfgH/66MBnS5hIKIUnsFszRxRj5i8TDlqE+s5vHtEIVRNOt9q9mxdfET2/caY9qg19eNrauGrEkJ0MUCeJpLGgJZoSwnWJ1Ra0DCPW2oPMlew+h9ng4bFKdJm7muz5lSwQ;4:1Ej6PfCpDycw0R4/I+iGW3X32CP7jsKVEY5uMhit8JjZ/Z5OxlnuP5Sc89qltPhqDk9IZftgztKe+uk3gzcdpkWI8flYD/Ki+Hab2oeS1Lvniq+GW7G3TAmUMwxbr3ubc3oxjQZi5Ck3oEptdHcsFYJqUSQD1Xcwzax2V7VQo25CIvKSIij2PWeNYLY86f3nW5eqURbmZP+MbKyzOw+zLs0tjPWtr5TYxsIViU13wtLDBlq4JsgSTJwtU24c69jdSR2rqs/gS9GHHDxyJm8Utg==
X-Microsoft-Antispam-PRVS: <CO1PR15MB1078667DD25410113EFFD86EBEF90@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(10201501046)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39380400002)(39860400002)(377424004)(199004)(54534003)(189003)(50466002)(54906003)(105586002)(76176011)(106356001)(6666003)(6116002)(23726003)(68736007)(2906002)(2950100002)(86362001)(6916009)(5660300001)(186003)(81156014)(83506002)(6246003)(4326008)(81166006)(16586007)(229853002)(316002)(93886005)(97736004)(305945005)(16526019)(9686003)(25786009)(8676002)(6506007)(58126008)(7736002)(478600001)(386003)(52396003)(52116002)(7696005)(1076002)(55016002)(39060400002)(33656002)(47776003)(8936002)(53936002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:Z5beg47oQDaMt2R4zkgTaES+Y3U8D5GSLlJ1LFRoo?=
 =?us-ascii?Q?svpHgx0MrzgNiSrZ48LnMEc6u53FGqAqGlnIcTBnIY7HugpPD8jqsbCM23ay?=
 =?us-ascii?Q?FnNmFkeDrlyd3gC+492hWOYdG0YyMe9mABqxJvZK4EXTeUZyFSgJSzc6er+g?=
 =?us-ascii?Q?unGlyFtKazZRN6DEiZ5AAUDXlftWIX+UeolFbkAhbDeorIPDfdZXgRRRywVv?=
 =?us-ascii?Q?aL80aR+dRE6ZiiFWX3Cm+FEOy3FqX8e8yRXXf8Zmc9kM3GuJJDmGoripvIXA?=
 =?us-ascii?Q?2gMW33n/jcYG3mxkINxFvmRmzOvxNzEXoW2HXe7WVjesMO8pqtcujXMgxe6b?=
 =?us-ascii?Q?/Ye/nbFf2HMgcWPhU/SjHa/HsN2kEWsVvYCoaFKy9N+zz/VefEd8o4wQ5n6j?=
 =?us-ascii?Q?tmw6JcS8U0T2yHDEkDWmU9LGM7+Y0uO99vwPzAv2iBdhwhpi3Dop+6D0ASzH?=
 =?us-ascii?Q?/KBcluEph4BHiepnnsFa7aY/Dmz8+h9vRnswqVdtZ66+z6fb6hNsfpUwbeDg?=
 =?us-ascii?Q?FWX/+Ft6yG05zOfHiwFrzAcugbHnD4Nr0rwcLD5VLdKKLeoS8lAw+4MWhWNx?=
 =?us-ascii?Q?7uZ+wSgzpptehCCvWW233szepps017hm4m2woxCZV2PLH9jJvrkJBTHWzbpn?=
 =?us-ascii?Q?xDrvfSMZXsYWRojE9x1zLGUz10wdcLIvNUYbUEDoH68dAyb+haHyOzkp/l/n?=
 =?us-ascii?Q?dhI8XZyzT7miNA42A2/KHlnb0uHnX+fVqK9uY2vHQs92dIUNDi8C35Ijx0eR?=
 =?us-ascii?Q?XpMbEFmVpxTp3Jltwg1lAPjI7k4XMLI7KTG+xPnnZp10J+MI+03ZMIKkaRrO?=
 =?us-ascii?Q?G1IRfVg6HJ64bf2yAFGOxZ2LdP+9c9xkCA0hR0/Xzqj4WGrHZWizliKv37Ts?=
 =?us-ascii?Q?LP9in6U8vzdbazfJjIgZh70913I/y5pR5Rn4LRXQ2RxrbVTqz4J5X+z5Rw8k?=
 =?us-ascii?Q?PcPwdrJAbmwbL1/BHTAZ3SUUTfSp9lll4N0tm3c/QrAzE3PzqA+/j5MU04sP?=
 =?us-ascii?Q?TkM0dPtO4wDDxl5Quo2w+TPWnot+UDRyuUMIkvrwOXAd2JbECuYmloOMiqAF?=
 =?us-ascii?Q?KFqJ4apCetkf5Qcib0dwV4N4ZSfP2UHDsGY42Z0O+UtLOo+dP+8bKxLUiaua?=
 =?us-ascii?Q?mf3t2nhk4KeMzEaXHOZ5GTwOeAIswZm4xM3p0Eb2T93IOxmIX2VJU44fevgd?=
 =?us-ascii?Q?mAujHGBMx4Z1Dq5Z/3FEBXEOaDmizaOR6vIxk9Zu6nI5pgRt/rBcfASRdRwJ?=
 =?us-ascii?Q?MEa/MfzicF8vuzVU4q7SnUSE72J81bEcLcY/xLrl+97geLBdIqJSaIyyt+9J?=
 =?us-ascii?Q?agYYvK2Jx/VjMOe0tzQXC8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:7iAKgK4s9sOfvGo2kGAVe2BQfGWPpnNSrUhhDn/d0KxTA/i0x5TmDaVs2q4btVb3QUXvo55zTKkdB3BdDEyH4AQuqu5aMmIZL32UoHOdTU9ZlHHO7QU5ryyH9izJUapeegXqMuhYafyMa/0/HJG4SMKy79ZvGsy3TjjTYrG27p5THCvyzMZVh1yiarG6qu4ANflDbH8gbL4G5Xfkh9xLVNSHXnDmXpBD9nAWQcRKAjQl9uxbHzWEpV++c3YIBBlkOh3kNDyv4sA3Yg0ZvBDV/+9YvFBk9QjWW09FU4IAZuwHOmsnwYWRmMAYbgGycZN23bFvLIR5qwjXVIXPsGnmRGnauhHfjobV3ebP8ZGOxWM=;5:zk/mQI3Y8ZGstSLjBINuciQCYB2yLpnCtCtC/xn7vSDkM8oAH1gNM+8oHOgnU0oRKGMzxOQSE0R3eOitrmQn4+g2fR9/5SYKeN+Na+PVsZ6TYkd/OHjhy1RpVAO3VSGFiav5hKhq7SoLp/YVKtIl7INDWMXE/R10dVff502pQkQ=;24:YMZDYxEW9ymmM32YP3m3senuqbtZca5Tippp6f9n9h1HY628inaNq7l/0pvBkxB+C/XIDeo6RQ8jsOG1Om/uGJ6rAdzdY2xcbDInq1PJK18=;7:jypVErB8vmaAolDejY6bASX5hVnGiX1vKp2eJILNB6T6tiJu9cDHeZ22JEu2i83T5ImIaJ+3nWEKWK/MW8bxZCj0n6neqmSNAmNGD4ITOEFA1VcrqCujgVdKWiY8Fh+eObr9yqzzrBRKauI88W6nA/oWLuY5lT6pBmXTfRPRgxCPag5Q9VRNlQHzaU7teonLLF3W2jdoQx/lQ8qe6z18GdUXzBUFHKBCgrMiimmIkKHDE9NHWWqRUIYrauWc4uxH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:tydQW/FkAAYvRkpDH+svtLPPM1gjlDsLftjrDWZe4B0JVkhozHlP/SUxhu3aHck1l0N6TMxAgJmxVnWLdGyAIVSUrAyP5PYszRZbsr7m30H3zmYejKcrr1WqgjpRb/HuoVjHNA7sdt2nZrH7Nap26dAelf8YdLP6Y7iJkxpxnsE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 19:04:48.8007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc6c5da-a2ba-46d7-6e2e-08d56a6fd637
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:39:04AM -0800, Eric Dumazet wrote:
> On Fri, 2018-02-02 at 18:06 +0000, Roman Gushchin wrote:
> > 
> > Idk, how even we can hit it? And if so, what scary will happen?
> > 
> > If you prefer to have it there, I definitely can return it,
> > but I see no profit so far.
> 
> I was simply curious this was not mentioned in the changelog.
> 
> A revert is normally a true revert, modulo the changes needed by
> conflicts and possible changes.
> 
> I personally do not care of this BUG_ON(), I had not put it in the
> first place.

Technically it's not a true revert, but you're totally right.
Let me add a note to the commit description.

Are you ok with the rest?

Thanks!
