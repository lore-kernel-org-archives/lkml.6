Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeEPPWd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:22:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752285AbeEPPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:22:30 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, npiggin@gmail.com,
        ego@linux.vnet.ibm.com
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 10:22:22 -0500
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18051615-0008-0000-0000-000009CB0593
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009035; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033180; UDB=6.00528261; IPR=6.00812311;
 MB=3.00021147; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 15:22:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051615-0009-0000-0000-0000474DBD3D
Message-Id: <87efiby6a9.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
> Init all present cpus for deep states instead of "all possible" cpus.
> Init fails if the possible cpu is gaurded. Resulting in making only
> non-deep states available for cpuidle/hotplug.

Should this also head to stable? It means that for single threaded
workloads, if you guard out a CPU core you'll not get WoF, which means
that performance goes down when you wouldn't expect it to. Right?

-- 
Stewart Smith
OPAL Architect, IBM.
