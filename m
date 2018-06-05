Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeFEDsH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 23:48:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751342AbeFEDsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:48:05 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
In-Reply-To: <87fu22bxlf.fsf@concordia.ellerman.id.au>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com> <87fu22bxlf.fsf@concordia.ellerman.id.au>
Date: Tue, 05 Jun 2018 13:47:55 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18060503-0004-0000-0000-0000143F1418
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009131; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042477; UDB=6.00533813; IPR=6.00821607;
 MB=3.00021468; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-05 03:48:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060503-0005-0000-0000-000087914BE3
Message-Id: <87k1rd28t0.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=638 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
>> snooze to deeper idle state") introduced a timeout for the snooze idle
>> state so that it could be eventually be promoted to a deeper idle
>> state. The snooze timeout value is static and set to the target
>> residency of the next idle state, which would train the cpuidle
>> governor to pick the next idle state eventually.
>>
>> The unfortunate side-effect of this is that if the next idle state(s)
>> is disabled, the CPU will forever remain in snooze, despite the fact
>> that the system is completely idle, and other deeper idle states are
>> available.
>
> That sounds like a bug, I'll add?
>
> Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
> Cc: stable@vger.kernel.org # v4.2+

Yes, it's a bug - we had a customer bug because we lacked this that
meant we had to do firmware changes rather than just tweaking what stop
states were used.

-- 
Stewart Smith
OPAL Architect, IBM.
