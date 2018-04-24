Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756276AbeDXOg6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:36:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756187AbeDXOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:36:37 -0400
Date: Tue, 24 Apr 2018 14:54:15 +0100
From: Roman Gushchin <guro@fb.com>
To: Vladimir Davydov <vdavydov.dev@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180424135409.GA28080@castle.DHCP.thefacebook.com>
References: <20180423123610.27988-1-guro@fb.com>
 <20180424123002.utwbm54mu46q6aqs@esperanza>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180424123002.utwbm54mu46q6aqs@esperanza>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:8959]
X-ClientProxiedBy: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:qcp+j3TMkGgeAoo0jX43wFy0z1G2orc8Spv3EleRQwqo6qCNQxDQ5tCY+pBxNPe6s1W+t79ikN+5H4eeUdkGJOnumDOKYQClBj9aBOTVW2MmpApz+0NtVwe4DIxgLE/HSkm9ud+0rlE/QXGlLw5kgyxHvqfjhodz7ACMA7svw3jBUWQUzfD+de44PlwN13dqZvaqJ96vvaqNR+ZN3xKMQcIXCd8m7OdA2m8Hr+AHHaAp2foTIBSg+mMgYax3wNWS;25:c4p+dEVV4H85mp81mjmqGVS7OGpLp3u5O6ZofhdukH2AL8Z0NCpO34wUTmuLo8eSrqblYHEJh4I/IIT59npkH0JQrR4Xyyfdo3fB0auOL7ulJJTXhPc8UpVEsxMT4u9alz6Uk5PKP4BV6ar5SzupJy+NcGnxt5vHTmYnEZKEDK7jh2yvlfuIGmttxb4f2urDtGCixneallht2G4PI5YckcdcLKqjlcA6YLqIPY7igTB2B4gmX2ZykKzddX/mMvHl2rJNj7BuolUFkbFpwD1a1ck32mhEYTO2l5DZFLjPwoZ98bNG1IKU3GvgstMfg1nQ+VsyKUDarTr5AFxbSRnjaA==;31:OwMgUYpZh2zMe7JL2hCXFFXngUYiKh18EEoRsXpRqwoj7dVl7ZvA97tuK2I2VUuUPJsgaJU3bfbPxmwcxl2KsXBpjilYaqVYqRezfUfTOyF2RmKHKYQ9S7Ku8yUu4w5x5UJE9n+j8yI2jBnimzl1GGg4/PIog8PS0oY2DMepdQd7dSV0oDoajFMmlgSWxA0hSZjWofzbPTSTJkUO1DiJSO4uZvBOl6OXrnQiOaaCITU=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:9eLwMyaq8eNXoQsKDPawaQImTBNCVXiJkIVhr4YVff/FlrNj7bI8RftDLph+n8he4sfrWFJDAO36BdBvrlpggbXMdK8+5CnRQgIIDqqBHYo0GRIJQG+uJD2d2lLob/Ha3dHPcNCYfjTJh8Fs3Y7D0wJ9NNrp7n2DfsZ1IjA2TE1B3sBGuhUWa4hgZIuyfl+sdyh6rmBYMrhSQe5788nFq4BXCz6M9V7tpM7Bon2i6GzrGfOWzb1xLp9DljgAo/BkV23n5qF+/cUwwbhvHT3sLaqgg4seaJo5zj7XQq54SOXQ0peanPoGtTqBeCcrOoz1iwWVSlsRe++rjoK7bbIW02wnDJVdFI+fK48SfVvrLA3CA2T1YT+KvmyNeFIG1yjcXLy2wBlRwjfwSLtvav0Ouq0DZP4GynulBYCF78pASU7UYINANc3PSC4SdNDez0FSO8AdzMDGcOfWYEzN7iC63kUMoRF/gnFZlw8aR2j5irqaJK6lqSNvKYwhTg8/JWbs;4:EtzcwCrgdUbATdpw2x7YWUE9o4G3Gd7zcysjRUK6MbdxpV1EH2uuha1BXM/I6KTpkUSaK15StA0bsOs1EOgUFSkwrD2WRCft12xSpKnZzS0/6i5SXik/+Jqg2TqxsR8vVH79cqyDT9nYtbuxD5/1+AQjeN2fQdkRC8Lfjcj15/+xyOA0jAWOqYG3fCMqzh66GDPhmXxKOyt1kMF1tA5xCl5z57NkxDgdr1sF2saebTapMqlK0JOh4qPQLIpdiYTa8k+5RNYw0qf/LXsOL/tppqnYymuZEkpGZlAMrJZWJ4jzbsw3AjVMEiHXre+zLFzgWS1HPdqpcPISRpAr0hJ5GBlKMFGsdQqTES4aQil3OFI=
X-Microsoft-Antispam-PRVS: <BL2PR15MB10766CEE421923B425542D0ABE880@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39380400002)(39860400002)(199004)(189003)(53546011)(6666003)(7736002)(59450400001)(305945005)(53936002)(7696005)(6246003)(5660300001)(6916009)(55016002)(52116002)(52396003)(386003)(76176011)(33656002)(6506007)(25786009)(68736007)(39060400002)(9686003)(105586002)(6116002)(316002)(50466002)(1076002)(23726003)(5890100001)(97736004)(54906003)(2906002)(47776003)(16586007)(58126008)(229853002)(46003)(486006)(476003)(575784001)(8936002)(81156014)(81166006)(8676002)(86362001)(186003)(16526019)(106356001)(446003)(4326008)(478600001)(11346002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:4hxAfxgKuJKG98Lf3aTH9vtQRXNJAl4Q+ZOM2MC26?=
 =?us-ascii?Q?HEs3QWUZE/2RFL5zpiBvqUsyXHyAbfwTa/TsbpvvBDAoA81lpmx1AF9bVEXU?=
 =?us-ascii?Q?KBhPy9Fhwci/Q0I32iZNUzDJWm+quHqN/Jb9nMXHUXtaTAZNJx83pQLGGpMJ?=
 =?us-ascii?Q?jThiCcqUudeCTZb5RVZpHmMpT251K3+YfPWCSeMAZB/gsTiWLzETX8+PpE/9?=
 =?us-ascii?Q?Lsa1SDqKrYfoVrP23xA79cxO/6UU1GCR0yC0vT0Bm1f0ZgHWHkPfybyoEBMp?=
 =?us-ascii?Q?Ei7kUQGDl+8sNyzCIwkA5ZAMfWL0Awjh2eyQ76YTW6sGO8f3NUdlcDcMaJ/l?=
 =?us-ascii?Q?kaFDmiDsrDPzmLV/Asym9qcFX1x8npANt3/xLkyCun58+VdsEoe1MK2ZUuEh?=
 =?us-ascii?Q?1FgBQXe3Vl+CBIFERM8ZvwaZUU+opp2SE2pFDErGDEKGRzHpCp1pwtbU+u2B?=
 =?us-ascii?Q?VvA2l6c9qTPjdTHPwcaofqpeM88oWbrEMSoMFepj/YJn3KSY+451gCAfahG7?=
 =?us-ascii?Q?U9Rgv6qV3pT8CMGPYiF/iKYGizomNLwaNhe+/Cs41eOWsvmXr+ZGjDZFAlZ/?=
 =?us-ascii?Q?ZYaMVpdguw/cpvt/PJF0WiAklPGWfcb2vgxiKTXhGSHc5QOZ8onCDKsuM9R1?=
 =?us-ascii?Q?Wy6CQkoiV1ik74bZqcymhHJxIQICevbbPJyUROkO9Wz3QvDo2jt+v43Yn5b3?=
 =?us-ascii?Q?ozKwHcBsawDJHOc6pgqB+1C5BFo1o8NK+lmCgEj8QuMl8qachKS+2v3Vtiyh?=
 =?us-ascii?Q?kq84H0PVoMrAHMDgsJQ/jXUSemC1aNkvkmqHQgGJdXLDccY/fRckXFHrjdzS?=
 =?us-ascii?Q?9m5UHzkeaXV9bmf8jv7bRuULnT0ceD75fs7MWCxDrC3OgRrukDABqr7koion?=
 =?us-ascii?Q?wIfiG26RLpFS3EgOOm+92C1TlNc72et1TyEAM6JRwUSYGsee0qkccYasV0Zr?=
 =?us-ascii?Q?O71RHNnljs9JWIzMxzeqjD4gQmipeJgkPHRILXskVNy/+I1M4767WEdvyirN?=
 =?us-ascii?Q?qMnQI5jD4ZkNHnxvu0TMA8YTQX7FA51kDmV73ATHuyQcNRWpR4uw0r8pSNR7?=
 =?us-ascii?Q?rj0UuVm7BJIUZ8hIEauoWdgavxSQ9vgqnZVV2b+iHGgVtTqFJQPhNuL+tkW+?=
 =?us-ascii?Q?cpympeOnPfgfdgu9jumShgcr0qTeqHdBxykyuZRHBIfalaZNW5I8zKHrT4a/?=
 =?us-ascii?Q?2O/9YLlXQqyIV0V9YX1ASr874mHAQ1B6zD6fI7Qw6ggEd8/sEIpaloBlttGn?=
 =?us-ascii?Q?EWGxDrqUEB1PjWz1NLZXquTsC5cMKReWIWt920UcdNsnJKg/LHGf/PdeyGsa?=
 =?us-ascii?Q?dV9RcYR9pJGzJxE86EdQthbRGx56PM0ngcmsFVlOZuaWESSIwC8crgqfBUv1?=
 =?us-ascii?Q?ni5HwWr8IY900X0kvbHFLCsnFo=3D?=
X-Microsoft-Antispam-Message-Info: 5AgNZzYDl3UGeKe5dm4o/4rkdTD8a3eKVO0BnEh/vijy5LOBXzTm1Qo/D/5JuVTOgzTHpqGVIUx1XcaIfDVyaMA0PZIvlg8WZhkqt+egoyGilw6LsVMT22yhYJ88fc5xm32UgqMnzNkaSPkmCcyTxbY7cHIeO4DMDnEmCEcDLggS2QtDa200Qnf6Sq9LRMer
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:wSoNhSZafzM3e77sMucBdCrSJNVG/Qgw9NMj2LfiNwa0oULA5f6Fz5VrQg3VN4JqFhtfuCtBdZIEj0cnMKOcK7HzwoK3nQA7rp9cIQj25j2ruWFhu73GcoUmL30E/B+RYNPyvbegbr5cphSITTH2W713vf/3BN06Bg6PnC6dXr+VmfE/92q8CRoqEk5z/0SMeBNRCawNrT91JQGPRcdh0bmoIjGrzekPZNkqtvgP92BuB3JjhMIv/LSsaSqYCSJb/sTL/Q65jGMywb2uMHnRsAaeRRxQ96Xo7qbLm2Jp6FFqja7w0dikLXlVHZ+rhziVXn7+I6gJYR38AQ+c/o0iR2Motupwj8/GK4hEzQj0IDDTSLzlXqryuNgInH7ix0dD99QejT4qFFdf3PKxU21aVR9XitYaN+xd6aabfF4fWP9fDzB7EPfXwuCic6lO2oNpcR/IQs8rEr1RaSvX+fKpxA==;5:qUsqwI2ByQRQi/H/xsEMGDP7h+iWOPd5/Q2YcQ406NjJcS5CQaE6xObDBF/KlR4QcLP+0exdN5I8HifWQ3naV4FmwOV9hdS50aKTGfkmXN4SFbI4bDIbfLkcDImErdoDOYuSv/xLII76lqPcmjXCzWZeEuT8BSjt5mPy4CQ9aw4=;24:ELtdlHeQKBthG1OlxZPnVTpJN1GSd51AqkwP+xgqD2A+1kGNavXrW8i7HU8JUZ4o/Ug5Kn77meG+aCoLP2HkQ7oGoW923tFr52b5wz08n9A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:RDrvOGGAGxYDjraXUJfpwOflwzA/FHS8lKLp9ihBiUTSXklajRz8NEX/kercWLwSklaUGtMNGtE4ngo1Wks5S8IW7HM+OR4e+ygoVcyhdizVAx2JRCF3em2ZbU73foZTXrrXOQ5FOHEWui0M2o3yVNlyjXz1Uzk/XSMp7GIyrRL2owCmKcq+v+SU0d/s4PprwU+SG44Xu70UApsxyFD5r+aa+tbrKYLH2NKvF5omoCt3L2lhJLSLqwc7yp455yy6;20:aw7Klf7SzSoxvxgLJbaINYrIU1TIdf48T6/hVH+v1VDzEaYEDSraUw0YvnHzv/63Xm2fFvg3s2VGNlDNEbSWeCt2Km6jNXvLR4YJ4E4BOu7hp4EKf9QOmE7FdEJaLPTa6jU/8kxXgL0LQYrpWL0uVD0TYYW8HAm/qgN7tTeddW0=
X-MS-Office365-Filtering-Correlation-Id: 241ef3a0-0eea-43a0-80d1-08d5a9eae644
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 13:54:27.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241ef3a0-0eea-43a0-80d1-08d5a9eae644
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir!

> On Mon, Apr 23, 2018 at 01:36:10PM +0100, Roman Gushchin wrote:
> > +  memory.min
> > +	A read-write single value file which exists on non-root
> > +	cgroups.  The default is "0".
> > +
> > +	Hard memory protection.  If the memory usage of a cgroup
> > +	is within its effective min boundary, the cgroup's memory
> > +	won't be reclaimed under any conditions. If there is no
> > +	unprotected reclaimable memory available, OOM killer
> > +	is invoked.
> 
> What will happen if all tasks attached to a cgroup are killed by OOM,
> but its memory usage is still within memory.min? Will memory.min be
> ignored then?

Not really.

I don't think it's a big problem as long as a user isn't doing
something weird (e.g. moving processes with significant
amount of charged memory to other cgroups).

But what we can do here, is to ignore memory.min of empty cgroups
(patch below), it will resolve some edge cases like this.

Thanks!

--------------------------------------------------------------------------------

>From 54a4f4fc9f8a6847c8a5814c53f0b575010808e5 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 24 Apr 2018 14:44:14 +0100
Subject: [PATCH] mm: ignore memory.min of abandoned memory cgroups

If a cgroup has no associated tasks, invoking the OOM killer
won't help release any memory, so respecting the memory.min
can lead to an infinite OOM loop or system stall.

Let's ignore memory.min of unpopulated cgroups.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0a42ab1ce42b..e563d67de787 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2549,8 +2549,11 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				/*
 				 * Hard protection.
 				 * If there is no reclaimable memory, OOM.
+				 * Abandoned cgroups are loosing protection,
+				 * because OOM killer won't release any memory.
 				 */
-				continue;
+				if (cgroup_is_populated(memcg->css.cgroup))
+					continue;
 			case MEMCG_PROT_LOW:
 				/*
 				 * Soft protection.
-- 
2.14.3
