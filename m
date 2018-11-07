Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F412CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C0D20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeKHF3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:29:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbeKHF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:29:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7JvE2I143556
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 14:57:49 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nm4j9538h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:57:49 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Nov 2018 19:57:48 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 19:57:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7JvhkI34341038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 19:57:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8001EB2067;
        Wed,  7 Nov 2018 19:57:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EBE8B2066;
        Wed,  7 Nov 2018 19:57:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.190.52])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 19:57:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 376C316C41F0; Wed,  7 Nov 2018 11:57:43 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:57:43 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Reply-To: paulmck@linux.ibm.com
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <alpine.DEB.2.21.1811071842340.1906@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811071842340.1906@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110719-0068-0000-0000-0000035C47B5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010003; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01114108; UDB=6.00577585; IPR=6.00894208;
 MB=3.00024064; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-07 19:57:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110719-0069-0000-0000-0000465988B7
Message-Id: <20181107195743.GA4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:44:07PM +0100, Thomas Gleixner wrote:
> On Wed, 7 Nov 2018, Thomas Gleixner wrote:
> 
> > Add a document to the subsystem/maintainer handbook section, which explains
> > what the tip tree is, how it operates and what rules and expectations it
> > has.
> 
> Peter asked me to add a section about locking comments. I added it and
> forgot to refresh the patch before sending. Delta patch below.
> 
> Thanks,
> 
> 	tglx
> ---
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -578,6 +578,29 @@ Sentences in comments start with a upper
>    usage of descriptive function names often replaces these tiny comments.
>    Apply common sense as always.
> 
> + 
> +Documenting locking requirements
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +  Documenting locking requirements is a good thing, but comments are not
> +  necessarily the best choice. Instead of writing::
> +
> +    	/* Caller must hold foo->lock */
> +	void func(struct foo *foo)
> +	{
> +		...
> +	}
> +
> +  Please use::
> +
> +	void func(struct foo *foo)
> +	{
> +		lockdep_assert_held(&foo->lock);
> +		...
> +	}
> +
> +  The latter enables run time debugging when lockdep is enabled which
> +  verifies that all callers hold the lock. Comments can't do that.

     In PROVE_LOCKING kernels, lockdep_assert_held() emits a warning
     if the caller doesn't hold the lock.  Comments can't do that.

							Thanx, Paul

