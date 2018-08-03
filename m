Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ABCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A2821700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A2821700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeHCIJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbeHCIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EGg9134497
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:14:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kmfrxbndc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:14:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:40 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736Edqa34406424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF40AE059;
        Fri,  3 Aug 2018 09:14:37 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57740AE04D;
        Fri,  3 Aug 2018 09:14:36 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:36 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/6] numa-balancing patches
Date:   Fri,  3 Aug 2018 11:43:55 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18080306-0012-0000-0000-000002933433
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-0013-0000-0000-000020C5446C
Message-Id: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset based on current tip/sched/core, provides left out patches
from the previous series. This version handles the comments given to some of
the patches. It drops "sched/numa: Restrict migrating in parallel to the same
node." It adds an additional patch from Mel Gorman.
It also provides specjbb2005 /dbench/ perf bench numa numbers on a patch
basis on 4 node and 2 node systems.

v2: http://lkml.kernel.org/r/1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com
v1: http://lkml.kernel.org/r/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     199709  209029   4.66679
1     330830  326585   -1.28314


on 2 Socket/4 Node Power8 (PowerNV)
1  218946  221299  1.07469


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     180473  195444   8.29542
1     212805  222390   4.50412


on 4 Socket/4 Node Power7
JVMS  Prev     Current  %Change
8     56941.8  60152.4  5.63839
1     111686   111458   -0.204144


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      12029.8  12124.6  12060.9  34.0076
5      12904.6  12969    12942.6  23.9053   7.3104



on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg     Variance  %Change
5      4968.51  5006.62  4981.31  13.4151
5      4984.25  5025.95  5004.5   14.2253   0.46554


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      9342.92  9381.44  9363.92  12.8587
5      9277.64  9357.22  9322.07  26.3558   -0.446928


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      143.4    188.892  170.225  16.9929
5      160.632  175.558  168.655  5.26823   -0.922309

perf bench numa / time / lesser number is better
on 2 Socket/2 Node Intel
Testcase         Time:  Min       Max       Avg       StdDev
  numa01.sh      Real:  403.47    420.68    411.27    5.80
  numa01.sh      Sys:   5.20      8.75      5.96      1.39
  numa01.sh      User:  14583.44  14832.05  14699.23  83.15
  numa02.sh      Real:  70.61     73.80     72.53     1.10
  numa02.sh      Sys:   4.61      5.08      4.80      0.18
  numa02.sh      User:  2634.28   2690.65   2669.69   20.80
  numa03.sh      Real:  328.53    374.61    354.53    17.22
  numa03.sh      Sys:   9.15      11.78     10.34     0.87
  numa03.sh      User:  14828.93  16646.99  15693.92  758.08
  numa04.sh      Real:  404.31    424.15    413.53    6.45
  numa04.sh      Sys:   5.70      7.98      6.33      0.85
  numa04.sh      User:  14608.86  15002.66  14812.80  156.89
  numa05.sh      Real:  432.00    449.59    444.57    6.52
  numa05.sh      Sys:   14.80     16.94     15.67     0.74
  numa05.sh      User:  15679.60  16048.79  15911.45  133.39
Testcase         Time:  Min       Max       Avg       StdDev   %Change
  numa01.sh      Real:  392.85    415.77    403.96    8.33     1.80959%
  numa01.sh      Sys:   6.19      9.81      7.89      1.19     -24.4613%
  numa01.sh      User:  14219.55  14733.04  14511.33  204.30   1.29485%
  numa02.sh      Real:  58.77     63.41     60.01     1.74     20.8632%
  numa02.sh      Sys:   5.28      5.62      5.42      0.11     -11.4391%
  numa02.sh      User:  2302.26   2454.57   2345.44   55.26    13.8247%
  numa03.sh      Real:  345.47    401.75    366.51    20.54    -3.26867%
  numa03.sh      Sys:   8.87      11.94     10.48     1.29     -1.33588%
  numa03.sh      User:  14709.09  17409.22  15824.09  1010.20  -0.822607%
  numa04.sh      Real:  392.78    404.64    398.72    4.50     3.71439%
  numa04.sh      Sys:   6.61      8.30      7.30      0.55     -13.2877%
  numa04.sh      User:  14324.48  14638.68  14464.01  117.68   2.41143%
  numa05.sh      Real:  383.94    414.25    396.28    10.61    12.1858%
  numa05.sh      Sys:   20.20     25.96     24.15     2.11     -35.1139%
  numa05.sh      User:  14707.57  15251.14  14993.60  185.47   6.12161%

Info on each of the perf bench script is available at
http://lkml.kernel.org/r/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com

vmstat data for perf bench numa01
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        125087      130979      4.71032%
numa_hint_faults_local  122058      118544      -2.87896%
numa_hit                472395      562428      19.0588%
numa_huge_pte_updates   121037      126394      4.42592%
numa_interleave         0           0           NA
numa_local              472041      562071      19.0725%
numa_miss               0           0           NA
numa_other              354         357         0.847458%
numa_pages_migrated     977502      1845407     88.7881%
numa_pte_updates        61980575    64723635    4.42568%
pgfault                 709665      823092      15.9832%
pgmajfault              443         507         14.447%
pgmigrate_fail          46592       109568      135.165%
pgmigrate_success       977502      1845407     88.7881%


vmstat data for perf bench numa02
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        38495       22190       -42.3562%
numa_hint_faults_local  35757       17037       -52.3534%
numa_hit                303708      284876      -6.20069%
numa_huge_pte_updates   33842       19259       -43.0914%
numa_interleave         0           0           NA
numa_local              303450      284624      -6.20399%
numa_miss               0           0           NA
numa_other              258         252         -2.32558%
numa_pages_migrated     993537      1570214     58.0428%
numa_pte_updates        17452735    9984967     -42.7885%
pgfault                 368888      330200      -10.4877%
pgmajfault              420         308         -26.6667%
pgmigrate_fail          0           0           NA
pgmigrate_success       993537      1570214     58.0428%


vmstat data for perf bench numa03
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        62510       63635       1.79971%
numa_hint_faults_local  38696       39109       1.06729%
numa_hit                382967      395061      3.15797%
numa_huge_pte_updates   58145       59089       1.62353%
numa_interleave         0           0           NA
numa_local              382720      394809      3.15871%
numa_miss               0           0           NA
numa_other              247         252         2.02429%
numa_pages_migrated     2035239     2196610     7.92885%
numa_pte_updates        29777304    30261666    1.62661%
pgfault                 544043      560325      2.99278%
pgmajfault              355         451         27.0423%
pgmigrate_fail          224256      344576      53.653%
pgmigrate_success       2035239     2196610     7.92885%


vmstat data for perf bench numa04
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        124431      132260      6.29184%
numa_hint_faults_local  121355      119283      -1.70739%
numa_hit                409737      399975      -2.3825%
numa_huge_pte_updates   120253      127886      6.34745%
numa_interleave         0           0           NA
numa_local              409468      399724      -2.37967%
numa_miss               0           0           NA
numa_other              269         251         -6.69145%
numa_pages_migrated     1116395     1659057     48.6084%
numa_pte_updates        61579860    65487765    6.34608%
pgfault                 631873      633795      0.304175%
pgmajfault              337         329         -2.37389%
pgmigrate_fail          47616       156160      227.957%
pgmigrate_success       1116395     1659057     48.6084%


vmstat data for perf bench numa05
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        355042      337290      -4.99997%
numa_hint_faults_local  342282      305309      -10.8019%
numa_hit                469069      461415      -1.63174%
numa_huge_pte_updates   348439      330052      -5.27696%
numa_interleave         0           0           NA
numa_local              468821      461168      -1.63239%
numa_miss               0           0           NA
numa_other              248         247         -0.403226%
numa_pages_migrated     3247276     6844700     110.783%
numa_pte_updates        178418683   169004579   -5.27641%
pgfault                 899368      878657      -2.30284%
pgmajfault              345         334         -3.18841%
pgmigrate_fail          781312      1424384     82.3067%
pgmigrate_success       3247276     6844700     110.783%


on 2 Socket/4 Node Power8 (PowerNV)
Testcase         Time:  Min       Max       Avg       StdDev
  numa01.sh      Real:  358.03    476.82    419.73    46.59
  numa01.sh      Sys:   14.53     20.23     16.47     1.96
  numa01.sh      User:  43304.06  53938.77  48978.04  4280.53
  numa02.sh      Real:  52.55     59.28     56.55     2.58
  numa02.sh      Sys:   7.33      11.74     9.37      1.56
  numa02.sh      User:  5112.38   5765.50   5535.94   237.97
  numa03.sh      Real:  486.71    497.22    490.09    3.68
  numa03.sh      Sys:   12.12     15.21     14.18     1.07
  numa03.sh      User:  56814.30  59414.01  58412.02  893.79
  numa04.sh      Real:  322.51    350.93    335.53    9.06
  numa04.sh      Sys:   14.03     16.90     15.79     1.10
  numa04.sh      User:  33446.88  36163.03  34128.47  1023.44
  numa05.sh      Real:  324.11    333.71    330.69    3.37
  numa05.sh      Sys:   21.25     28.33     23.59     2.55
  numa05.sh      User:  33017.37  34332.36  33536.43  437.24
Testcase         Time:  Min       Max       Avg       StdDev   %Change
  numa01.sh      Real:  402.80    475.17    438.14    23.38    -4.20185%
  numa01.sh      Sys:   15.81     17.30     16.46     0.53     0.0607533%
  numa01.sh      User:  46324.59  52566.72  49514.24  2327.98  -1.08292%
  numa02.sh      Real:  49.32     59.99     54.64     3.42     3.49561%
  numa02.sh      Sys:   5.84      10.32     8.44      1.55     11.019%
  numa02.sh      User:  4962.98   5674.79   5456.00   255.40   1.46518%
  numa03.sh      Real:  481.18    492.84    487.49    4.05     -93.4563%
  numa03.sh      Sys:   12.11     13.93     13.07     0.73     -84.6213%
  numa03.sh      User:  56056.97  58557.44  57546.61  870.03   -97.3252%
  numa04.sh      Real:  314.72    399.01    344.72    28.97    42.1705%
  numa04.sh      Sys:   14.72     20.70     17.05     2.15     -16.8328%
  numa04.sh      User:  34075.02  42869.67  36528.81  3261.87  59.9067%
  numa05.sh      Real:  327.70    363.14    343.96    13.71    -2.45087%
  numa05.sh      Sys:   23.34     29.42     27.00     2.01     -41.5185%
  numa05.sh      User:  31716.77  36602.35  33670.61  1653.60  1.35982%


vmstat data for perf bench numa01
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        63348       64799       2.29052%
numa_hint_faults_local  27783       28052       0.968218%
numa_hit                288564      274955      -4.71611%
numa_huge_pte_updates   24248       25297       4.32613%
numa_interleave         0           0           NA
numa_local              288524      274914      -4.71711%
numa_miss               0           0           NA
numa_other              40          41          2.5%
numa_pages_migrated     668765      757419      13.2564%
numa_pte_updates        6247173     6516368     4.30907%
pgfault                 1026373     982450      -4.27944%
pgmajfault              552         455         -17.5725%
pgmigrate_fail          110871      105728      -4.63872%
pgmigrate_success       668765      757419      13.2564%


vmstat data for perf bench numa02
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        247818      340248      37.2975%
numa_hint_faults_local  165959      197634      19.086%
numa_hit                327750      338501      3.28024%
numa_huge_pte_updates   1302        1786        37.1736%
numa_interleave         0           0           NA
numa_local              327719      338477      3.28269%
numa_miss               0           0           NA
numa_other              31          24          -22.5806%
numa_pages_migrated     184908      212449      14.8944%
numa_pte_updates        601753      817802      35.9033%
pgfault                 714529      802873      12.3639%
pgmajfault              384         391         1.82292%
pgmigrate_fail          512         512         0%
pgmigrate_success       184908      212449      14.8944%


vmstat data for perf bench numa03
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        42672       34540       -19.057%
numa_hint_faults_local  15017       11041       -26.4767%
numa_hit                276938      269723      -2.60528%
numa_huge_pte_updates   13998       13968       -0.214316%
numa_interleave         0           0           NA
numa_local              276919      269715      -2.60148%
numa_miss               0           0           NA
numa_other              19          8           -57.8947%
numa_pages_migrated     333225      349934      5.01433%
numa_pte_updates        3610166     3596818     -0.369734%
pgfault                 992860      963524      -2.9547%
pgmajfault              522         957         83.3333%
pgmigrate_fail          108288      127744      17.9669%
pgmigrate_success       333225      349934      5.01433%


vmstat data for perf bench numa04
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        80020       87821       9.74881%
numa_hint_faults_local  59008       56421       -4.38415%
numa_hit                233083      235072      0.853344%
numa_huge_pte_updates   35238       35577       0.96203%
numa_interleave         0           0           NA
numa_local              233064      235067      0.859421%
numa_miss               0           0           NA
numa_other              19          5           -73.6842%
numa_pages_migrated     944562      1028140     8.84833%
numa_pte_updates        9065545     9159954     1.0414%
pgfault                 847441      851781      0.51213%
pgmajfault              970         421         -56.5979%
pgmigrate_fail          63233       53760       -14.9811%
pgmigrate_success       944562      1028140     8.84833%


vmstat data for perf bench numa05
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        174387      201119      15.3291%
numa_hint_faults_local  133581      146596      9.74315%
numa_hit                249145      257903      3.51522%
numa_huge_pte_updates   73582       85868       16.697%
numa_interleave         0           0           NA
numa_local              249137      257890      3.51333%
numa_miss               0           0           NA
numa_other              8           13          62.5%
numa_pages_migrated     1781374     2077576     16.6277%
numa_pte_updates        18938248    22100144    16.6958%
pgfault                 941574      995042      5.67858%
pgmajfault              434         415         -4.37788%
pgmigrate_fail          49180       69889       42.1086%
pgmigrate_success       1781374     2077576     16.6277%


on 2 Socket/2 Node Power9 (PowerNV)
Testcase         Time:  Min       Max        Avg        StdDev
  numa01.sh      Real:  462.22    591.23     504.51     44.82
  numa01.sh      Sys:   37.07     54.86      42.05      6.62
  numa01.sh      User:  72535.19  86297.67   75983.26   5208.86
  numa02.sh      Real:  82.50     87.37      84.18      1.82
  numa02.sh      Sys:   20.18     30.04      27.37      3.66
  numa02.sh      User:  12171.09  12358.11   12242.31   62.27
  numa03.sh      Real:  595.65    695.32     640.37     31.93
  numa03.sh      Sys:   31.45     42.00      35.40      3.78
  numa03.sh      User:  93877.45  109013.40  100676.82  4856.89
  numa04.sh      Real:  514.19    594.43     548.24     33.76
  numa04.sh      Sys:   41.25     54.25      46.86      4.89
  numa04.sh      User:  76298.64  86625.93   80615.33   4748.38
  numa05.sh      Real:  466.67    513.17     494.73     18.29
  numa05.sh      Sys:   61.19     70.28      66.83      3.35
  numa05.sh      User:  72845.76  76191.80   74651.22   1416.76
Testcase         Time:  Min       Max        Avg        StdDev    %Change
  numa01.sh      Real:  461.27    719.44     552.31     88.06     -8.65456%
  numa01.sh      Sys:   39.71     67.60      47.18      10.35     -10.8733%
  numa01.sh      User:  72257.05  112563.52  83735.04   14612.15  -9.25751%
  numa02.sh      Real:  82.65     84.25      83.41      0.53      0.923151%
  numa02.sh      Sys:   18.32     28.89      22.97      4.34      19.1554%
  numa02.sh      User:  12045.55  12215.64   12162.20   62.80     0.65868%
  numa03.sh      Real:  587.05    660.43     617.39     25.31     3.72212%
  numa03.sh      Sys:   28.05     36.74      31.86      3.45      11.1111%
  numa03.sh      User:  92686.08  103166.58  97013.32   3655.37   3.77629%
  numa04.sh      Real:  464.56    652.41     515.41     70.89     6.36969%
  numa04.sh      Sys:   38.40     49.26      42.43      4.00      10.4407%
  numa04.sh      User:  72275.32  88875.96   77174.44   6149.21   4.45859%
  numa05.sh      Real:  483.10    664.43     562.87     75.72     -12.1058%
  numa05.sh      Sys:   56.23     73.67      65.27      5.73      2.39007%
  numa05.sh      User:  73350.15  89813.72   80238.30   6532.10   -6.96311%


vmstat data for perf bench numa01
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        144716      145619      0.623981%
numa_hint_faults_local  99914       91850       -8.07094%
numa_hit                411314      369456      -10.1767%
numa_huge_pte_updates   136260      136154      -0.0777925%
numa_interleave         0           0           NA
numa_local              411279      369421      -10.1775%
numa_miss               0           0           NA
numa_other              35          35          0%
numa_pages_migrated     464612      481645      3.66607%
numa_pte_updates        4368544     4365935     -0.0597224%
pgfault                 1296071     1362892     5.15566%
pgmajfault              1412        1270        -10.0567%
pgmigrate_fail          42656       49952       17.1043%
pgmigrate_success       464612      481645      3.66607%


vmstat data for perf bench numa02
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        30562       28965       -5.22544%
numa_hint_faults_local  23479       21704       -7.55995%
numa_hit                176214      159995      -9.20415%
numa_huge_pte_updates   28447       27168       -4.49608%
numa_interleave         0           0           NA
numa_local              176209      159987      -9.20611%
numa_miss               0           0           NA
numa_other              5           8           60%
numa_pages_migrated     201448      204467      1.49865%
numa_pte_updates        936226      894109      -4.49859%
pgfault                 493189      481612      -2.34738%
pgmajfault              993         521         -47.5327%
pgmigrate_fail          0           0           NA
pgmigrate_success       201448      204467      1.49865%


vmstat data for perf bench numa03
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        78163       72811       -6.84723%
numa_hint_faults_local  39811       37318       -6.26209%
numa_hit                313487      308119      -1.71235%
numa_huge_pte_updates   69817       65243       -6.55141%
numa_interleave         0           0           NA
numa_local              313460      308104      -1.70867%
numa_miss               0           0           NA
numa_other              27          15          -44.4444%
numa_pages_migrated     184605      172934      -6.32215%
numa_pte_updates        2242167     2094992     -6.56396%
pgfault                 1186922     1166080     -1.75597%
pgmajfault              1077        668         -37.9759%
pgmigrate_fail          24544       24416       -0.521512%
pgmigrate_success       184605      172934      -6.32215%


vmstat data for perf bench numa04
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        152710      147880      -3.16286%
numa_hint_faults_local  97716       100272      2.61574%
numa_hit                324966      321659      -1.01764%
numa_huge_pte_updates   144348      139764      -3.17566%
numa_interleave         0           0           NA
numa_local              324939      321640      -1.01527%
numa_miss               0           0           NA
numa_other              27          19          -29.6296%
numa_pages_migrated     512467      485174      -5.32581%
numa_pte_updates        4626888     4479727     -3.18056%
pgfault                 1250077     1234721     -1.2284%
pgmajfault              691         575         -16.7873%
pgmigrate_fail          54848       58560       6.76779%
pgmigrate_success       512467      485174      -5.32581%


vmstat data for perf bench numa05
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        295774      305339      3.23389%
numa_hint_faults_local  218320      218793      0.216654%
numa_hit                352096      357790      1.61717%
numa_huge_pte_updates   286148      297923      4.115%
numa_interleave         0           0           NA
numa_local              352075      357780      1.62039%
numa_miss               0           0           NA
numa_other              21          10          -52.381%
numa_pages_migrated     906755      909564      0.309786%
numa_pte_updates        9165346     9541883     4.10827%
pgfault                 1407223     1433802     1.88876%
pgmajfault              599         683         14.0234%
pgmigrate_fail          70272       69568       -1.00182%
pgmigrate_success       906755      909564      0.309786%


on 4 Socket/4 Node Power7
Testcase         Time:  Min       Max       Avg       StdDev
  numa01.sh      Real:  677.66    913.24    794.88    85.49
  numa01.sh      Sys:   125.90    205.16    169.35    25.59
  numa01.sh      User:  56772.52  71741.79  63335.60  5073.86
  numa02.sh      Real:  65.34     70.28     67.96     1.98
  numa02.sh      Sys:   12.04     19.41     15.89     2.34
  numa02.sh      User:  5499.93   5682.07   5586.30   77.00
  numa03.sh      Real:  774.48    1035.38   893.82    87.76
  numa03.sh      Sys:   107.67    153.14    129.77    15.10
  numa03.sh      User:  62802.39  87222.58  73511.43  8260.39
  numa04.sh      Real:  504.09    733.50    633.03    78.96
  numa04.sh      Sys:   213.34    351.26    284.11    56.12
  numa04.sh      User:  38925.57  55954.50  47690.41  5716.68
  numa05.sh      Real:  402.78    501.75    453.02    37.15
  numa05.sh      Sys:   146.84    407.64    299.57    97.43
  numa05.sh      User:  33365.00  39445.00  36050.94  2053.69
Testcase         Time:  Min       Max       Avg       StdDev   %Change
  numa01.sh      Real:  636.41    913.49    802.07    94.08    -0.89643%
  numa01.sh      Sys:   169.10    209.84    181.46    15.01    -6.67365%
  numa01.sh      User:  51910.75  65727.60  60906.34  5019.96  3.98852%
  numa02.sh      Real:  63.64     70.40     66.18     2.42     2.68963%
  numa02.sh      Sys:   9.85      21.19     15.05     3.72     5.5814%
  numa02.sh      User:  5305.35   5702.47   5477.28   132.74   1.9904%
  numa03.sh      Real:  753.00    932.44    828.11    66.63    7.93494%
  numa03.sh      Sys:   81.82     132.68    104.12    17.89    24.635%
  numa03.sh      User:  61249.69  72311.19  65282.71  3998.53  12.6047%
  numa04.sh      Real:  504.61    655.03    605.21    52.01    4.59675%
  numa04.sh      Sys:   130.42    330.44    260.76    73.87    8.95459%
  numa04.sh      User:  37562.67  48382.57  45063.68  3892.89  5.82893%
  numa05.sh      Real:  462.05    525.61    488.76    21.16    -7.31238%
  numa05.sh      Sys:   296.76    389.72    345.10    40.73    -13.1933%
  numa05.sh      User:  35920.56  39112.35  38022.97  1151.19  -5.18642%


vmstat data for perf bench numa01
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        8094646     6939950     -14.2649%
numa_hint_faults_local  4327343     3249221     -24.9142%
numa_hit                1550444     1490388     -3.87347%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              1550404     1490347     -3.87364%
numa_miss               0           0           NA
numa_other              40          41          2.5%
numa_pages_migrated     777894      731760      -5.93063%
numa_pte_updates        8103835     6945270     -14.2965%
pgfault                 9504158     8321001     -12.4488%
pgmajfault              277         267         -3.61011%
pgmigrate_fail          7           12          71.4286%
pgmigrate_success       777894      731760      -5.93063%


vmstat data for perf bench numa02
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        698918      733902      5.00545%
numa_hint_faults_local  553784      562257      1.53002%
numa_hit                473790      466220      -1.59775%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              473785      466216      -1.59756%
numa_miss               0           0           NA
numa_other              5           4           -20%
numa_pages_migrated     136492      134423      -1.51584%
numa_pte_updates        714710      749458      4.86183%
pgfault                 1186082     1218861     2.76364%
pgmajfault              155         156         0.645161%
pgmigrate_fail          0           0           NA
pgmigrate_success       136492      134423      -1.51584%


vmstat data for perf bench numa03
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        4525956     3520293     -22.2199%
numa_hint_faults_local  1749531     1319966     -24.5532%
numa_hit                914257      778437      -14.8558%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              914232      778416      -14.8557%
numa_miss               0           0           NA
numa_other              25          21          -16%
numa_pages_migrated     428367      315482      -26.3524%
numa_pte_updates        4536083     3524701     -22.2964%
pgfault                 5578522     4509129     -19.1698%
pgmajfault              202         197         -2.47525%
pgmigrate_fail          22          19          -13.6364%
pgmigrate_success       428367      315482      -26.3524%


vmstat data for perf bench numa04
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        13634799    13598386    -0.267059%
numa_hint_faults_local  8473822     8800575     3.85603%
numa_hit                2604435     2456795     -5.66879%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              2604411     2456779     -5.66854%
numa_miss               0           0           NA
numa_other              24          16          -33.3333%
numa_pages_migrated     1414750     1280512     -9.48846%
numa_pte_updates        13678739    13627859    -0.371964%
pgfault                 15363067    15317090    -0.29927%
pgmajfault              197         237         20.3046%
pgmigrate_fail          30          27          -10%
pgmigrate_success       1414750     1280512     -9.48846%


vmstat data for perf bench numa05
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        23324034    25274343    8.3618%
numa_hint_faults_local  18759362    18625813    -0.711906%
numa_hit                3944010     4235082     7.3801%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              3943994     4235068     7.38018%
numa_miss               0           0           NA
numa_other              16          14          -12.5%
numa_pages_migrated     1785980     2072221     16.0271%
numa_pte_updates        23411591    25325473    8.17493%
pgfault                 26024350    28065879    7.84469%
pgmajfault              233         239         2.57511%
pgmigrate_fail          52          82          57.6923%
pgmigrate_success       1785980     2072221     16.0271%


Mel Gorman (1):
  sched/numa: Limit the conditions where scan period is reset

Srikar Dronamraju (5):
  sched/numa: Stop multiple tasks from moving to the cpu at the same
    time
  mm/migrate: Use trylock while resetting rate limit
  sched/numa: Avoid task migration for small numa improvement
  sched/numa: Pass destination cpu as a parameter to migrate_task_rq
  sched/numa: Reset scan rate whenever task moves across nodes

 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  2 +-
 kernel/sched/fair.c     | 87 ++++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  3 +-
 mm/migrate.c            | 16 ++++++---
 5 files changed, 91 insertions(+), 19 deletions(-)

-- 
1.8.3.1

