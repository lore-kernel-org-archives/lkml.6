Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E6245A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E6245A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeGCOGc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:06:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932105AbeGCOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:06:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63E4LTv124705
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 10:06:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k08s9wqe3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:06:28 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 15:06:27 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 15:06:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63E6Muq27721870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 14:06:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73B894C044;
        Tue,  3 Jul 2018 17:06:48 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94D2D4C058;
        Tue,  3 Jul 2018 17:06:45 +0100 (BST)
Received: from drishya.in.ibm.com (unknown [9.85.91.104])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jul 2018 17:06:45 +0100 (BST)
Date:   Tue, 3 Jul 2018 19:36:16 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     akshay.adiga@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Add the CPUIDLE_FLAG_POLLING for snooze
Reply-To: svaidy@linux.vnet.ibm.com
References: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18070314-0028-0000-0000-000002D7C1E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070314-0029-0000-0000-0000238F4365
Message-Id: <20180703140616.GA13660@drishya.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2018-07-03 10:54:16]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In the situations where snooze is the only cpuidle state due to
> firmware not exposing any platform idle states, the idle CPUs will
> remain in snooze for a long time with interrupts disabled causing the
> Hard-lockup detector to complain.

snooze_loop() will spin in SMT low priority with interrupt enabled. We
have local_irq_enable() before we get into the snooze loop.
Since this is a polling state, we should wakeup without an interrupt
and hence we set TIF_POLLING_NRFLAG as well.

 
> watchdog: CPU 51 detected hard LOCKUP on other CPUs 59
> watchdog: CPU 51 TB:535296107736, last SMP heartbeat TB:527472229239 (15281ms ago)
> watchdog: CPU 59 Hard LOCKUP
> watchdog: CPU 59 TB:535296252849, last heartbeat TB:526554725466 (17073ms ago)

hmm.. not sure why watchdog will complain, maybe something more is
going on.
 
> Fix this by adding CPUIDLE_FLAG_POLLING flag to the state, so that the
> cpuidle governor will do the right thing, such as not stopping the
> tick if it is going to put the idle cpu to snooze.
> 
> Reported-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index d29e4f0..b73041b 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -156,6 +156,7 @@ static int stop_loop(struct cpuidle_device *dev,
>  	{ /* Snooze */
>  		.name = "snooze",
>  		.desc = "snooze",
> +		.flags = CPUIDLE_FLAG_POLLING,
>  		.exit_latency = 0,
>  		.target_residency = 0,
>  		.enter = snooze_loop },

Adding the CPUIDLE_FLAG_POLLING is good and enables more optimization.
But the reason that we spin with interrupt disabled does not seem
right.

--Vaidy

