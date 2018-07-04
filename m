Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02F02086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02F02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeGDIbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:31:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932363AbeGDIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:31:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w648UAbj115062
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 04:31:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0spjtt40-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:31:32 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 02:31:31 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 02:31:29 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w648VSUk11141546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 01:31:28 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B96C605B;
        Wed,  4 Jul 2018 02:31:28 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2AAEC6057;
        Wed,  4 Jul 2018 02:31:27 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 02:31:27 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 9DD9B2E2F43; Wed,  4 Jul 2018 13:45:05 +0530 (IST)
Date:   Wed, 4 Jul 2018 13:45:05 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
 <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18070408-0012-0000-0000-00001686CD89
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009306; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056336; UDB=6.00541869; IPR=6.00834258;
 MB=3.00021987; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 08:31:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070408-0013-0000-0000-0000538CF115
Message-Id: <20180704081505.GB1007@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=940 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Murilo,

Thanks for the review.

On Tue, Jul 03, 2018 at 02:53:46PM -0300, Murilo Opsfelder Araujo wrote:
[..snip..]

> > -        /* Initialize CPU <=> thread mapping/
> > +	if (has_interleaved_big_core) {
> > +		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
> > +
> > +		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
> > +		static_branch_enable(&cpu_feature_keys[key]);
> > +		pr_info("Detected interleaved big-cores\n");
> > +	}
> 
> Shouldn't we use cpu_has_feature(CPU_FTR_ASYM_SMT) before setting
> > it?


Are you suggesting that we do the following?

    if (has_interleaved_big_core &&
        !cpu_has_feature(CPU_FTR_ASYM_SMT)) {
	...
    }
    
Currently CPU_FTR_ASYM_SMT is set at compile time for only POWER7
where running the tasks on lower numbered threads give us the benefit
of SMT thread folding. Interleaved big core is a feature introduced
only on POWER9. Thus, we know that CPU_FTR_ASYM_SMT is not set in
cpu_features at this point.

> 
> > +
> > +	/* Initialize CPU <=> thread mapping/
> >  	 *
> >  	 * WARNING: We assume that the number of threads is the same for
> >  	 * every CPU in the system. If that is not the case, then some code
> > -- 
> > 1.9.4
> > 
> 
> -- 
> Murilo

--
Thanks and Regards
gautham.

