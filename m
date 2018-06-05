Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeFEIpk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:45:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751495AbeFEIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:45:38 -0400
Date: Tue, 5 Jun 2018 14:15:30 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Reply-To: ego@linux.vnet.ibm.com
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <87fu22bxlf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu22bxlf.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18060508-0020-0000-0000-00000E198E2C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009133; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042577; UDB=6.00533873; IPR=6.00821707;
 MB=3.00021472; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-05 08:45:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060508-0021-0000-0000-000061C3491D
Message-Id: <20180605084529.GA5656@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=970 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Mon, Jun 04, 2018 at 09:27:40PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> > snooze to deeper idle state") introduced a timeout for the snooze idle
> > state so that it could be eventually be promoted to a deeper idle
> > state. The snooze timeout value is static and set to the target
> > residency of the next idle state, which would train the cpuidle
> > governor to pick the next idle state eventually.
> >
> > The unfortunate side-effect of this is that if the next idle state(s)
> > is disabled, the CPU will forever remain in snooze, despite the fact
> > that the system is completely idle, and other deeper idle states are
> > available.
> 
> That sounds like a bug, I'll add?
>

Yes, this is a bug-fix for a customer scenario which we encountered
recently.

> Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
> Cc: stable@vger.kernel.org # v4.2+

This patch applies cleanly from v4.13 onwards. Prior to that there are
some (minor) conflicts.

Should I spin a version separately for the prior stable versions ?

> 
> cheers
> 
