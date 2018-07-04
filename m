Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4C8208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4C8208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeGDRgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:36:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752667AbeGDRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:36:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64HSwQb040614
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 13:36:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k10vgkv3e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 13:36:34 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 4 Jul 2018 13:36:33 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 13:36:31 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64HaUWw3735922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 17:36:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61C9CAE062;
        Wed,  4 Jul 2018 13:36:12 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21B44AE05F;
        Wed,  4 Jul 2018 13:36:12 -0400 (EDT)
Received: from localhost (unknown [9.18.235.193])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 13:36:12 -0400 (EDT)
Date:   Wed, 4 Jul 2018 14:36:29 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
 <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
 <20180704081505.GB1007@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704081505.GB1007@in.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18070417-0064-0000-0000-000003251B8C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009309; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056517; UDB=6.00541978; IPR=6.00834440;
 MB=3.00021997; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 17:36:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070417-0065-0000-0000-000039D1D194
Message-Id: <20180704173629.GA21119@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:45:05PM +0530, Gautham R Shenoy wrote:
> Hi Murilo,
> 
> Thanks for the review.
> 
> On Tue, Jul 03, 2018 at 02:53:46PM -0300, Murilo Opsfelder Araujo wrote:
> [..snip..]
> 
> > > -        /* Initialize CPU <=> thread mapping/
> > > +	if (has_interleaved_big_core) {
> > > +		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
> > > +
> > > +		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
> > > +		static_branch_enable(&cpu_feature_keys[key]);
> > > +		pr_info("Detected interleaved big-cores\n");
> > > +	}
> > 
> > Shouldn't we use cpu_has_feature(CPU_FTR_ASYM_SMT) before setting
> > > it?
> 
> 
> Are you suggesting that we do the following?
> 
>     if (has_interleaved_big_core &&
>         !cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> 	...
>     }
>     
> Currently CPU_FTR_ASYM_SMT is set at compile time for only POWER7
> where running the tasks on lower numbered threads give us the benefit
> of SMT thread folding. Interleaved big core is a feature introduced
> only on POWER9. Thus, we know that CPU_FTR_ASYM_SMT is not set in
> cpu_features at this point.

Since we're setting CPU_FTR_ASYM_SMT, it doesn't make sense to use
cpu_has_feature(CPU_FTR_ASYM_SMT).  I thought cpu_has_feature() held all
available features (not necessarily enabled) that we could check before
setting or enabling such feature.  I think I misread it.  Sorry.

> 
> > 
> > > +
> > > +	/* Initialize CPU <=> thread mapping/
> > >  	 *
> > >  	 * WARNING: We assume that the number of threads is the same for
> > >  	 * every CPU in the system. If that is not the case, then some code
> > > -- 
> > > 1.9.4
> > > 
> > 
> > -- 
> > Murilo
> 
> --
> Thanks and Regards
> gautham.
> 

-- 
Murilo

