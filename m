Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeFEKQ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:16:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751488AbeFEKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:16:24 -0400
Date: Tue, 5 Jun 2018 11:15:45 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: don't skip memory guarantee calculations
Message-ID: <20180605101544.GB5464@castle>
References: <20180522132528.23769-1-guro@fb.com>
 <20180522132528.23769-2-guro@fb.com>
 <20180604122953.GN19202@dhcp22.suse.cz>
 <20180604162259.GA3404@castle>
 <20180605090349.GW19202@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180605090349.GW19202@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:e650]
X-ClientProxiedBy: AM5PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:206:1::17) To SN2PR15MB1086.namprd15.prod.outlook.com
 (2603:10b6:804:22::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1086;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;3:lb/pPswgHWHTgUgv2z0u1OZkUUAZ987wVR2Q+eKrsuNtDwOZ439CrFhNuQ0xrmZCl1G0fvPIF2aJTXinaP5rnHJAwhxY71vvX605LUv7mkmAe9a3xiwIeS1whkUnlwrFhoSUiMUSfQicPsIEtTZJK+tXIBKh4llOs/nogQfg4LuUKZDr/ZAZZpEjDDl30l8ggEiompW1EgleOG0ihKR6h7dBEwzVN3r5s2goUCrkYzjHHGUV1tZcen8Nui64jtKh;25:IqCdg451UhtYKsAtU+YsSbj47vgauD0aIcyUhUjTJs/fjUxR/CmrRrzYhkUpQjOl4jillybzAHckX6fUtUNT6nwHmGX23+5/i/IKSQLxCsp7BJ/VlmYW3+cR/5qFV7GOnFetluLdmOtPKcpvBYaM9nPQzTZNkdE/GgCDEBZZoOAHBPts2ubks/A7v0P26n4PXXnsfrQ6rAyzK3Gq2d7HLmi4T0OH/jyERZHl3spx8ETdXQfSOMPlKsrrSrDKwh4N467BebkZ1S+DidJif+jd18Z0ZZY5Y2SvzAuu1S9m0gINGEwkSFxTpw5nAArVpCGRsuPUQZ/I6WkXIgdNLQm9Ng==;31:8p6KDf2nEm8k0OD1S8ha9k55epvNtLEa+SN0nwhBvtsjM2eZVd6jtaRy2dkABggO0E45oWgQ5Zts1CpyQ/EHB+MT+EDhWdqpX8qtvjPQhFwpdUKQqkMLxyfe3LMpxLCGzVDsWqXgxiuXJ/0xL5978ZWuU1KnOxVJil5SBe1IHLVh8rnW6mp3QN0DRMyl/tt2TGmAij42hJuJa9ydM2yOdLm3tL+kR0JBAwTV7qxU9HM=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1086:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;20:lhCvOFQQ3sdnF2XoRAvOnXZf463Qa4HOG9FzAghrnic8wH6qtukq387TQA8FtsVB29BclY3HtjCuFHNOqXUTPn3AUF6nvYvS3OpfB4+TVHuXTQmlxSEXhujtiQf/GbvWdrD9FKn23sOYb1h2RFJyvLIdqThq7cLOmQ0+jV3vJq+SrSKn/UIeFTJIxt9K0rz9JBufKPrlRplUvS6/ek5dKEGevs2pnfKDZMgRh4DMnLpr2+gZTAqHFgnDLoz8TINhHHcmfS/FsyVlER18pnsXZPKWDegH1iN9iRasjkO2DgIlMhNaKjs3SjuhQzrBLe6v5aur4cbp3EWEUTD++m8D/eTqIHAN+NovMeNkuugiBwlkAchWXDkFRUAv+nxl2IIRV5ncB44GW+Q2w4xAyjWq/T9LlVx1PJonzNu7adWcZLzh1dVmRB3DCGxhOjPEM1idagWhO0ncetFl9KNG0a/S7o9dUClGEMnmbICfjWDMv71LpL821yg8Id+CY5/ihDOe;4:yVdl1cA5AScXSf++88tfna4T8vbgR6NAcU3/w2KYoDHFyyGEFm3OocxVbWgOGxUCSxtqzYxxK8jPl86fX1pW4AV0JYRIi/afGGmcxEBMTfdvpAFXfLgCD+NUHjae0ykKkwy1fOj4QlDiutPtXOWZD5Rifrq0l/rkYCXItpYPJqbA6q9lWtFLzctsCFnLM4DWBgduz+fH6DxEFqGwtzSWZUd3HZ7zoNFXfNaZfR1yOyqKnSKkhNwfYn6iQU7S5jyxkpAjceHQ+vt2cZsOuJeq4w==
X-Microsoft-Antispam-PRVS: <SN2PR15MB10861E6314D30BFB89658768BE660@SN2PR15MB1086.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN2PR15MB1086;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1086;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(189003)(199004)(6916009)(81166006)(53936002)(81156014)(7736002)(55016002)(8936002)(33716001)(9686003)(86362001)(6666003)(50466002)(5660300001)(8676002)(229853002)(305945005)(16526019)(316002)(54906003)(6116002)(16586007)(52116002)(2906002)(76176011)(11346002)(476003)(186003)(39060400002)(6246003)(23726003)(33896004)(1076002)(386003)(58126008)(446003)(68736007)(47776003)(25786009)(106356001)(52396003)(486006)(4326008)(33656002)(93886005)(105586002)(97736004)(46003)(6496006)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1086;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1086;23:oyMScfIcuXPyKeoMDqmTGvSrGbi6TIfzQS4GwGhnr?=
 =?us-ascii?Q?0a2R5iLZzfmVGBADILnOqFN9Iwof4ErrhDm66i4sLA30REmc7V92ZdU8yfsx?=
 =?us-ascii?Q?ISCLOH9t75Z1y55G5t5T3jUrp2lZilcVaTktVb2UM2oQlGD+uvf0pS9jqaB7?=
 =?us-ascii?Q?M4aYL/KmjzIF/Nj7skYf2QwpNm3uCXdE8Yzzz0uzu2yayD2AZfnIqNBWYIsC?=
 =?us-ascii?Q?Q3s2S6KsWnBrITEjGKSvgHELnKdLYscT4WdxzE/E9s0k7ZScGMqZCS2DfC3g?=
 =?us-ascii?Q?oJ80lcIkaRE5jbqiafiw/t/fxykMUkEDJA9i4M/kdT3DtQRvlQu1yEwEjsEH?=
 =?us-ascii?Q?1EGVw1cupEClgGdkrVfCGehlR8H/GW7WPDDVHKrBaD+vBoMRylXVVlJ2Wwz+?=
 =?us-ascii?Q?YZ2L9mfdi643GHCo64A1XRgLbPhoAAc7wHZDyLHZ+jzmkPkG/UKFuPx8a2km?=
 =?us-ascii?Q?KMcYqJvdgeZqd21wwB+pLYtxP6o/0xmLGyBCPSpglrl0j0oAjc/1JpH/r/XL?=
 =?us-ascii?Q?a9BOThSlEX2oA/DCxHIPmBwyKo2enGTq1382qcTwLag4MqSYGFpLhRq29Pv0?=
 =?us-ascii?Q?K5tqua0pndeIl5ZQMwWe0INB6kP/4G7fAg79yqR5gX33p6HZY+dfsorhJgSM?=
 =?us-ascii?Q?iquIY26W5bJsz5uM1aiG/f6mzuiJKujPXytHdybjM0l1OWXmaAGSVJkej0Xj?=
 =?us-ascii?Q?Mjjyhu7NflHB7YKOlbrglJsmbhr80TLxCO3yM5BjSvZy0VKVfEAVqqh9V3/J?=
 =?us-ascii?Q?bMJvLVKbRxklV02ekc9hpR8yRoC5VtgTb0mqTDsZxKTPfCKsSL06ZREYjZd3?=
 =?us-ascii?Q?0MFrCYdbDjzCxKq7m6iGSVQkQYTFPj4KXmDRTVZa1f0eeasDCHGrSEjBle2e?=
 =?us-ascii?Q?BDBwm/+IXmS+LV0pJqYH0OQ5hZzcqXfdDzFFtw0L2Raw9aRZ2f2q+S9elENg?=
 =?us-ascii?Q?IgUVYyOevZG9DB7WYJmBWb9hxY3m08BZuoh/IjMn5dKXr+T0LpPNIwzv6zQs?=
 =?us-ascii?Q?2W6qrQyuH0mswuS5sVj9sbX7wuNQKXXkT0qj2wXmeJzxKeJy3bqHgGg+pdd1?=
 =?us-ascii?Q?NG8ld2LNEeSxsgvuadQpVxfEpXimVgwlQElB5eiNHPW3hA+6drSJiZ1vn7C7?=
 =?us-ascii?Q?kOTKgCP3N3xyPAjqQcS4OKRQnSdDWksFfumfrqunwZDjCM4EwnMDvYCa4Z4b?=
 =?us-ascii?Q?R1bWAUyJxjrLuej2LC3r5+spGoApr17O2eoJ31qPiOCQPk5kf4BYzc9+g95W?=
 =?us-ascii?Q?JfaKbFJnxwm4e+/5YD9guc9CcH1/txlc0UD9ggRo61gVQbuLv4bnQy7LJk6a?=
 =?us-ascii?Q?gWAgoXXfAryWnkH7wyFKDptln3yRazup3vPVOqMHDc3?=
X-Microsoft-Antispam-Message-Info: nOeh4hmKHpJ5L4xikGdaR/HS8932opSgakkr4TViRkh+oJXdcnyn2lGl64YbKt1X54FeUaN0u9lhMht2Ozf5ns4LR72QGaSpoFK9eo+I+zMaAnihn6ZFgs8dsOhKsINzqYgmWAdG99p2cz1cbDmy2zDhQcZgAwsswetOQqSmGc0eLQbKlDmRwbbY7Dz1pOr4
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;6:aDkv8/us1545s1NiZ+IMFeLoN9Gx2k1r/HRqjDw6LfbL814lesof0resm7Yd8JQeorKQYu3vbGr2/z/RaXehDGT26G+mt0K21E59Um3x+z6TM3OlHNDnfZCVJELOMuHzsLSe5BeppyPdRjz4SmGHEKEnAI1GxzVDVzwkX/D9QHXd2mYbtERJfkUie40mltzeiazzE+/isVHBmt7DCRn+90do1zjdRKhaMT/l+rZFM4VVhLK7ln6q7F0Y/MxC3CTaGhwEbNxC7351vxxWrG4Q1XsVRggtRyVX0wy0dAxKChLQROGHOAlS5e6sH6Wf8kQdhgLuP/UVd/NBgw9o+pXUBiZ4u6at/Q8/haNgTqytyk6tC4VxylETCCYYnPCynqR5X4faulebYFqNvb+tfkuskPC1duKY77meo/luP5kXQY8D4SnZy9BlGCsbBkF/NKeStsv8NmjCJBcshf1Kpu8KgA==;5:mraz34yGX8X2zLCWtWaUosV7n12YjQtMFRtAk36lGaq0+cLE3aIgTGdnd0o+w6r9O0rdH+PMFH5kDUNrsYpxSEps8ViGLPaYJznBpR0svWM3Z1AzvSfOQ+Czsxnd7eYOU8bnRu0e8luTvAyLO2T35Vj6GRzyWgpfiEtBF2LECRw=;24:wy35IvUTSf2d+jwYco8q767/K2QFrligGwNkVgph3uH9CfTO6uVIkavyMbog/chVPN3LAhS92TZrfoEi39MkaytX4EDzYFc0nMJZEusLapU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;7:3kHS2jkvnkWNUy9fk3fi3P1tBVHTrYl3Gr77cTh9O/W4qhJ0OeGDTAovHUrOgdpVgqSt7mHtvQe5yWKrdcOT02raJKgn9yAPL53ACYz6rmQ6GjwedwzxzUl9tSM/fdPEyhij4tBPfUDxJZ7WQpcoBxmNsqeUs3MGg6KXyzniqCHs30x9ddGkDGjU8R91xjnRUw5zYTB1WuDJe6yTJsZftuS0hXchbeIiJZi1y0T5KrdCaSndptZsLYbuPq1fg1hJ;20:gYtlJHorLPA9+DILR6TNmQNJRUz+hiSeg/HtoYz/QxMZ3vW/WMjcAYYrxpnC5YY9Uzug2Vioint3FkrAx9gbDH4JU0GV2X0m/PCTSRsSSIOM5czdulPKxpdKnPZaTiVG+8WJDJLeH0EiwA5HN3YTFRxRczxLffdyebZrZ1wpFps=
X-MS-Office365-Filtering-Correlation-Id: a1177884-a6a1-4381-0ccf-08d5cacd5854
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 10:16:02.3989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1177884-a6a1-4381-0ccf-08d5cacd5854
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1086
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:03:49AM +0200, Michal Hocko wrote:
> On Mon 04-06-18 17:23:06, Roman Gushchin wrote:
> [...]
> > I'm happy to discuss any concrete issues/concerns, but I really see
> > no reasons to drop it from the mm tree now and start the discussion
> > from scratch.
> 
> I do not think this is ready for the current merge window. Sorry! I
> would really prefer to see the whole thing in one series to have a
> better picture.

Please, provide any specific reason for that. I appreciate your opinion,
but *I think* it's not an argument, seriously.

We've discussed the patchset back to March and I made several iterations
based on the received feedback. Later we had a separate discussion with Greg,
who proposed an alternative solution, which, unfortunately, had some serious
shortcomings. And, as I remember, some time ago we've discussed memory.min
with you.
And now you want to start from scratch without providing any reason.
I find it counter-productive, sorry.

Thanks!
