Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18166C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C3E21901
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBGJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:39:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfBGJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:39:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x179Y3oo070038
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 04:39:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qgfjy6ufy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:39:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Thu, 7 Feb 2019 09:39:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 09:39:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x179dW1a58458280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 09:39:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D62A405B;
        Thu,  7 Feb 2019 09:39:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B65E5A405C;
        Thu,  7 Feb 2019 09:39:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.205.132])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 09:39:29 +0000 (GMT)
Subject: [PATCH]perf:Remove P8 HW events which are not supported
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com,
        peterz@infradead.org, mpe@ellerman.id.au, acme@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        mamatha4@linux.vnet.ibm.com, namhyung@kernel.org, jolsa@redhat.com
Date:   Thu, 07 Feb 2019 15:09:28 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020709-0012-0000-0000-000002F2CCC6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020709-0013-0000-0000-0000212A3147
Message-Id: <154953186583.11022.14819560028300370163.stgit@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to remove following hardware events 
from JSON file which are not supported on POWER8

pm_co_disp_fail
pm_co_tm_sc_footprint
pm_iside_disp
pm_iside_disp_fail
pm_iside_disp_fail_other
pm_iside_mru_touch
pm_l2_castout_mod
pm_l2_castout_shr
pm_l2_dc_inv
pm_l2_disp_all_l2miss
pm_l2_grp_guess_correct
pm_l2_grp_guess_wrong
pm_l2_ic_inv
pm_l2_inst
pm_l2_inst_miss
pm_l2_ld
pm_l2_ld_disp
pm_l2_ld_hit
pm_l2_ld_miss
pm_l2_loc_guess_correct
pm_l2_loc_guess_wrong
pm_l2_rcld_disp
pm_l2_rcld_disp_fail_addr
pm_l2_rcld_disp_fail_other
pm_l2_rcst_disp
pm_l2_rcst_disp_fail_addr
pm_l2_rcst_disp_fail_other
pm_l2_rc_st_done
pm_l2_rty_ld
pm_l2_sn_m_rd_done
pm_l2_sn_m_wr_done
pm_l2_sn_sx_i_done
pm_l2_st_disp
pm_l2_st_hit
pm_l2_sys_guess_correct
pm_l2_sys_guess_wrong
pm_l2_sys_pump
pm_l3_ci_hit
pm_l3_ci_miss
pm_l3_cinj
pm_l3_co
pm_l3_co_lco
pm_l3_grp_guess_correct
pm_l3_grp_guess_wrong_high
pm_l3_grp_guess_wrong_low
pm_l3_hit
pm_l3_l2_co_hit
pm_l3_l2_co_miss
pm_l3_lat_ci_hit
pm_l3_lat_ci_miss
pm_l3_ld_hit
pm_l3_ld_miss
pm_l3_loc_guess_correct
pm_l3_loc_guess_wrong
pm_l3_miss
pm_l3_p0_co_l31
pm_l3_p0_co_mem
pm_l3_p0_co_rty
pm_l3_p0_grp_pump
pm_l3_p0_lco_data
pm_l3_p0_lco_no_data
pm_l3_p0_lco_rty
pm_l3_p0_node_pump
pm_l3_p0_pf_rty
pm_l3_p0_sn_hit
pm_l3_p0_sn_inv
pm_l3_p0_sn_miss
pm_l3_p0_sys_pump
pm_l3_p1_co_l31
pm_l3_p1_co_mem
pm_l3_p1_co_rty
pm_l3_p1_grp_pump
pm_l3_p1_lco_data
pm_l3_p1_lco_no_data
pm_l3_p1_lco_rty
pm_l3_p1_node_pump
pm_l3_p1_pf_rty
pm_l3_p1_sn_hit
pm_l3_p1_sn_inv
pm_l3_p1_sn_miss
pm_l3_p1_sys_pump
pm_l3_pf_hit_l3
pm_l3_sys_guess_correct
pm_l3_sys_guess_wrong
pm_l3_trans_pf
pm_l3_wi0_busy
pm_l3_wi_usage
pm_non_tm_rst_sc
pm_rd_clearing_sc
pm_rd_forming_sc
pm_rd_hit_pf
pm_snp_tm_hit_m
pm_snp_tm_hit_t
pm_st_caused_fail
pm_tm_cam_overflow
pm_tm_cap_overflow
pm_tm_fav_caused_fail
pm_tm_ld_caused_fail
pm_tm_ld_conf
pm_tm_rst_sc
pm_tm_sc_co
pm_tm_st_caused_fail
pm_tm_st_conf

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
---
 .../perf/pmu-events/arch/powerpc/power8/other.json |  594 --------------------
 1 file changed, 594 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 704302c..9dc2f6b7 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -348,18 +348,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x517082",
-    "EventName": "PM_CO_DISP_FAIL",
-    "BriefDescription": "CO dispatch failed due to all CO machines being busy",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x527084",
-    "EventName": "PM_CO_TM_SC_FOOTPRINT",
-    "BriefDescription": "L2 did a cleanifdirty CO to the L3 (ie created an SC line in the L3)",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x3608a",
     "EventName": "PM_CO_USAGE",
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 CO machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
@@ -1578,36 +1566,12 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x617082",
-    "EventName": "PM_ISIDE_DISP",
-    "BriefDescription": "All i-side dispatch attempts",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627084",
-    "EventName": "PM_ISIDE_DISP_FAIL",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a addr collision with another machine",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x627086",
-    "EventName": "PM_ISIDE_DISP_FAIL_OTHER",
-    "BriefDescription": "All i-side dispatch attempts that failed due to a reason other than addrs collision",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x4608e",
     "EventName": "PM_ISIDE_L2MEMACC",
     "BriefDescription": "valid when first beat of data comes in for an i-side fetch where data came from mem(or L4)",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x44608e",
-    "EventName": "PM_ISIDE_MRU_TOUCH",
-    "BriefDescription": "Iside L2 MRU touch",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x30ac",
     "EventName": "PM_ISU_REF_FX0",
     "BriefDescription": "FX0 ISU reject",
@@ -1734,222 +1698,36 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x417080",
-    "EventName": "PM_L2_CASTOUT_MOD",
-    "BriefDescription": "L2 Castouts - Modified (M, Mu, Me)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x417082",
-    "EventName": "PM_L2_CASTOUT_SHR",
-    "BriefDescription": "L2 Castouts - Shared (T, Te, Si, S)",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x27084",
     "EventName": "PM_L2_CHIP_PUMP",
     "BriefDescription": "RC requests that were local on chip pump attempts",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x427086",
-    "EventName": "PM_L2_DC_INV",
-    "BriefDescription": "Dcache invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44608c",
-    "EventName": "PM_L2_DISP_ALL_L2MISS",
-    "BriefDescription": "All successful Ld/St dispatches for this thread that were an L2miss",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x27086",
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on Node Pump attempts",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x626084",
-    "EventName": "PM_L2_GRP_GUESS_CORRECT",
-    "BriefDescription": "L2 guess grp and guess was correct (data intra-6chip AND ^on-chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x626086",
-    "EventName": "PM_L2_GRP_GUESS_WRONG",
-    "BriefDescription": "L2 guess grp and guess was not correct (ie data on-chip OR beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x427084",
-    "EventName": "PM_L2_IC_INV",
-    "BriefDescription": "Icache Invalidates from L2",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x436088",
-    "EventName": "PM_L2_INST",
-    "BriefDescription": "All successful I-side dispatches for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43608a",
-    "EventName": "PM_L2_INST_MISS",
-    "BriefDescription": "All successful i-side dispatches that were an L2miss for this thread (excludes i_l2mru_tch reqs)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x416080",
-    "EventName": "PM_L2_LD",
-    "BriefDescription": "All successful D-side Load dispatches for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x437088",
-    "EventName": "PM_L2_LD_DISP",
-    "BriefDescription": "All successful load dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x43708a",
-    "EventName": "PM_L2_LD_HIT",
-    "BriefDescription": "All successful load dispatches that were L2 hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x426084",
-    "EventName": "PM_L2_LD_MISS",
-    "BriefDescription": "All successful D-Side Load dispatches that were an L2miss for this thread",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616080",
-    "EventName": "PM_L2_LOC_GUESS_CORRECT",
-    "BriefDescription": "L2 guess loc and guess was correct (ie data local)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x616082",
-    "EventName": "PM_L2_LOC_GUESS_WRONG",
-    "BriefDescription": "L2 guess loc and guess was not correct (ie data not on chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516080",
-    "EventName": "PM_L2_RCLD_DISP",
-    "BriefDescription": "L2 RC load dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x516082",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x526084",
-    "EventName": "PM_L2_RCLD_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC load dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x536088",
-    "EventName": "PM_L2_RCST_DISP",
-    "BriefDescription": "L2 RC store dispatch attempt",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53608a",
-    "EventName": "PM_L2_RCST_DISP_FAIL_ADDR",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to address collision with RC/CO/SN/SQ",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54608c",
-    "EventName": "PM_L2_RCST_DISP_FAIL_OTHER",
-    "BriefDescription": "L2 RC store dispatch attempt failed due to other reasons",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x537088",
-    "EventName": "PM_L2_RC_ST_DONE",
-    "BriefDescription": "RC did st to line that was Tx or Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63708a",
-    "EventName": "PM_L2_RTY_LD",
-    "BriefDescription": "RC retries on PB for any load from core",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x3708a",
     "EventName": "PM_L2_RTY_ST",
     "BriefDescription": "RC retries on PB for any store from core",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x54708c",
-    "EventName": "PM_L2_SN_M_RD_DONE",
-    "BriefDescription": "SNP dispatched for a read and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54708e",
-    "EventName": "PM_L2_SN_M_WR_DONE",
-    "BriefDescription": "SNP dispatched for a write and was M",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53708a",
-    "EventName": "PM_L2_SN_SX_I_DONE",
-    "BriefDescription": "SNP dispatched and went from Sx or Tx to Ix",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x17080",
     "EventName": "PM_L2_ST",
     "BriefDescription": "All successful D-side store dispatches for this thread",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x44708c",
-    "EventName": "PM_L2_ST_DISP",
-    "BriefDescription": "All successful store dispatches",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x44708e",
-    "EventName": "PM_L2_ST_HIT",
-    "BriefDescription": "All successful store dispatches that were L2Hits",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x17082",
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-side store dispatches for this thread that were L2 Miss",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x636088",
-    "EventName": "PM_L2_SYS_GUESS_CORRECT",
-    "BriefDescription": "L2 guess sys and guess was correct (ie data beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x63608a",
-    "EventName": "PM_L2_SYS_GUESS_WRONG",
-    "BriefDescription": "L2 guess sys and guess was not correct (ie data ^beyond-6chip)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x617080",
-    "EventName": "PM_L2_SYS_PUMP",
-    "BriefDescription": "RC requests that were system pump attempts",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x1e05e",
     "EventName": "PM_L2_TM_REQ_ABORT",
     "BriefDescription": "TM abort",
@@ -1962,36 +1740,12 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x23808a",
-    "EventName": "PM_L3_CINJ",
-    "BriefDescription": "l3 ci of cache inject",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128084",
-    "EventName": "PM_L3_CI_HIT",
-    "BriefDescription": "L3 Castins Hit (total count",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x128086",
-    "EventName": "PM_L3_CI_MISS",
-    "BriefDescription": "L3 castins miss (total count",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x819082",
     "EventName": "PM_L3_CI_USAGE",
     "BriefDescription": "rotating sample of 16 CI or CO actives",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x438088",
-    "EventName": "PM_L3_CO",
-    "BriefDescription": "l3 castout occurring ( does not include casthrough or log writes (cinj/dmaw)",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x83908b",
     "EventName": "PM_L3_CO0_ALLOC",
     "BriefDescription": "lifetime, sample of CO machine 0 valid",
@@ -2010,120 +1764,18 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x238088",
-    "EventName": "PM_L3_CO_LCO",
-    "BriefDescription": "Total L3 castouts occurred on LCO",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x28084",
     "EventName": "PM_L3_CO_MEM",
     "BriefDescription": "L3 CO to memory OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0xb19082",
-    "EventName": "PM_L3_GRP_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=group and data from same group (near) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb3908a",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
-    "BriefDescription": "Initial scope=group but data from local node. Predition too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb39088",
-    "EventName": "PM_L3_GRP_GUESS_WRONG_LOW",
-    "BriefDescription": "Initial scope=group but data from outside group (far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218080",
-    "EventName": "PM_L3_HIT",
-    "BriefDescription": "L3 Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x138088",
-    "EventName": "PM_L3_L2_CO_HIT",
-    "BriefDescription": "L2 castout hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x13808a",
-    "EventName": "PM_L3_L2_CO_MISS",
-    "BriefDescription": "L2 castout miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808c",
-    "EventName": "PM_L3_LAT_CI_HIT",
-    "BriefDescription": "L3 Lateral Castins Hit",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x14808e",
-    "EventName": "PM_L3_LAT_CI_MISS",
-    "BriefDescription": "L3 Lateral Castins Miss",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228084",
-    "EventName": "PM_L3_LD_HIT",
-    "BriefDescription": "L3 demand LD Hits",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x228086",
-    "EventName": "PM_L3_LD_MISS",
-    "BriefDescription": "L3 demand LD Miss",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x1e052",
     "EventName": "PM_L3_LD_PREF",
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0xb19080",
-    "EventName": "PM_L3_LOC_GUESS_CORRECT",
-    "BriefDescription": "initial scope=node/chip and data from local node (local) (pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb29086",
-    "EventName": "PM_L3_LOC_GUESS_WRONG",
-    "BriefDescription": "Initial scope=node but data from out side local node (near or far or rem). Prediction too Low",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x218082",
-    "EventName": "PM_L3_MISS",
-    "BriefDescription": "L3 Misses",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808c",
-    "EventName": "PM_L3_P0_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x538088",
-    "EventName": "PM_L3_P0_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929084",
-    "EventName": "PM_L3_P0_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 0",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0xa29084",
     "EventName": "PM_L3_P0_GRP_PUMP",
     "BriefDescription": "L3 pf sent with grp scope port 0",
@@ -2148,120 +1800,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0xa19080",
-    "EventName": "PM_L3_P0_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919080",
-    "EventName": "PM_L3_P0_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x939088",
-    "EventName": "PM_L3_P0_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118080",
-    "EventName": "PM_L3_P0_SN_INV",
-    "BriefDescription": "Port0 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908c",
-    "EventName": "PM_L3_P0_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa39088",
-    "EventName": "PM_L3_P0_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x54808e",
-    "EventName": "PM_L3_P1_CO_L31",
-    "BriefDescription": "l3 CO to L3.1 (lco) port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x53808a",
-    "EventName": "PM_L3_P1_CO_MEM",
-    "BriefDescription": "l3 CO to memory port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x929086",
-    "EventName": "PM_L3_P1_CO_RTY",
-    "BriefDescription": "L3 CO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa29086",
-    "EventName": "PM_L3_P1_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528086",
-    "EventName": "PM_L3_P1_LCO_DATA",
-    "BriefDescription": "lco sent with data port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518082",
-    "EventName": "PM_L3_P1_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908e",
-    "EventName": "PM_L3_P1_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa19082",
-    "EventName": "PM_L3_P1_NODE_PUMP",
-    "BriefDescription": "L3 pf sent with nodal scope port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x919082",
-    "EventName": "PM_L3_P1_PF_RTY",
-    "BriefDescription": "L3 PF received retry port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x93908a",
-    "EventName": "PM_L3_P1_SN_HIT",
-    "BriefDescription": "L3 snoop hit port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x118082",
-    "EventName": "PM_L3_P1_SN_INV",
-    "BriefDescription": "Port1 snooper detects someone doing a store to a line thats Sx",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x94908e",
-    "EventName": "PM_L3_P1_SN_MISS",
-    "BriefDescription": "L3 snoop miss port 1",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa3908a",
-    "EventName": "PM_L3_P1_SYS_PUMP",
-    "BriefDescription": "L3 pf sent with sys scope port 1",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
     "BriefDescription": "lifetime, sample of PF machine 0 valid",
@@ -2274,12 +1812,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x428084",
-    "EventName": "PM_L3_PF_HIT_L3",
-    "BriefDescription": "l3 pf hit in l3",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x18080",
     "EventName": "PM_L3_PF_MISS_L3",
     "BriefDescription": "L3 Prefetch missed in L3",
@@ -2370,42 +1902,12 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0xb29084",
-    "EventName": "PM_L3_SYS_GUESS_CORRECT",
-    "BriefDescription": "Initial scope=system and data from outside group (far or rem)(pred successful)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xb4908c",
-    "EventName": "PM_L3_SYS_GUESS_WRONG",
-    "BriefDescription": "Initial scope=system but data from local or near. Predction too high",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x24808e",
-    "EventName": "PM_L3_TRANS_PF",
-    "BriefDescription": "L3 Transient prefetch",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x18081",
     "EventName": "PM_L3_WI0_ALLOC",
     "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
     "PublicDescription": "0.0"
   },
   {,
-    "EventCode": "0x418080",
-    "EventName": "PM_L3_WI0_BUSY",
-    "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x418082",
-    "EventName": "PM_L3_WI_USAGE",
-    "BriefDescription": "rotating sample of 8 WI actives",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0xc080",
     "EventName": "PM_LD_REF_L1_LSU0",
     "BriefDescription": "LS0 L1 D cache load references counted at finish, gated by reject",
@@ -3312,12 +2814,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x328084",
-    "EventName": "PM_NON_TM_RST_SC",
-    "BriefDescription": "non tm snp rst tm sc",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x2001a",
     "EventName": "PM_NTCG_ALL_FIN",
     "BriefDescription": "Cycles after all instructions have finished to group completed",
@@ -3420,24 +2916,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x34808e",
-    "EventName": "PM_RD_CLEARING_SC",
-    "BriefDescription": "rd clearing sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x34808c",
-    "EventName": "PM_RD_FORMING_SC",
-    "BriefDescription": "rd forming sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x428086",
-    "EventName": "PM_RD_HIT_PF",
-    "BriefDescription": "rd machine hit l3 pf machine",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x20004",
     "EventName": "PM_REAL_SRQ_FULL",
     "BriefDescription": "Out of real srq entries",
@@ -3504,18 +2982,6 @@
     "PublicDescription": "TLBIE snoopSnoop TLBIE"
   },
   {,
-    "EventCode": "0x338088",
-    "EventName": "PM_SNP_TM_HIT_M",
-    "BriefDescription": "snp tm st hit m mu",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x33808a",
-    "EventName": "PM_SNP_TM_HIT_T",
-    "BriefDescription": "snp tm_st_hit t tn te",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x4608c",
     "EventName": "PM_SN_USAGE",
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 SN machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
@@ -3534,12 +3000,6 @@
     "PublicDescription": "STCX executed reported at sent to nest42"
   },
   {,
-    "EventCode": "0x717080",
-    "EventName": "PM_ST_CAUSED_FAIL",
-    "BriefDescription": "Non TM St caused any thread to fail",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x3090",
     "EventName": "PM_SWAP_CANCEL",
     "BriefDescription": "SWAP cancel , rtag not available",
@@ -3624,18 +3084,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0x318082",
-    "EventName": "PM_TM_CAM_OVERFLOW",
-    "BriefDescription": "l3 tm cam overflow during L2 co of SC",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x74708c",
-    "EventName": "PM_TM_CAP_OVERFLOW",
-    "BriefDescription": "TM Footprint Capactiy Overflow",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x20ba",
     "EventName": "PM_TM_END_ALL",
     "BriefDescription": "Tm any tend",
@@ -3690,48 +3138,6 @@
     "PublicDescription": "Transactional conflict from LSU, whatever gets reported to texas 42"
   },
   {,
-    "EventCode": "0x727086",
-    "EventName": "PM_TM_FAV_CAUSED_FAIL",
-    "BriefDescription": "TM Load (fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x717082",
-    "EventName": "PM_TM_LD_CAUSED_FAIL",
-    "BriefDescription": "Non TM Ld caused any thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x727084",
-    "EventName": "PM_TM_LD_CONF",
-    "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x328086",
-    "EventName": "PM_TM_RST_SC",
-    "BriefDescription": "tm snp rst tm sc",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x318080",
-    "EventName": "PM_TM_SC_CO",
-    "BriefDescription": "l3 castout tm Sc line",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x73708a",
-    "EventName": "PM_TM_ST_CAUSED_FAIL",
-    "BriefDescription": "TM Store (fav or non-fav) caused another thread to fail",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x737088",
-    "EventName": "PM_TM_ST_CONF",
-    "BriefDescription": "TM Store (fav or non-fav) ran into conflict (failed)",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x20bc",
     "EventName": "PM_TM_TBEGIN",
     "BriefDescription": "Tm nested tbegin",

