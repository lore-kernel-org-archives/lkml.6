Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A86C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E53A2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E53A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754709AbeGCJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:46:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754469AbeGCJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:46:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w639kMcX120167
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 05:46:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k06t5g0f4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 05:46:43 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 05:46:43 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 05:46:39 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w639kc7S7274882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 09:46:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F02B2068;
        Tue,  3 Jul 2018 05:46:22 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461E2B2065;
        Tue,  3 Jul 2018 05:46:22 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 05:46:22 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id B7CBC2E2F42; Tue,  3 Jul 2018 15:16:36 +0530 (IST)
Date:   Tue, 3 Jul 2018 15:16:36 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
        svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v3 1/2] powernv/cpuidle: Parse dt idle properties into
 global structure
Reply-To: ego@linux.vnet.ibm.com
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530609656-13301-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530609656-13301-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18070309-0072-0000-0000-000003791415
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009300; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055881; UDB=6.00541596; IPR=6.00833803;
 MB=3.00021975; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 09:46:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070309-0073-0000-0000-000048933646
Message-Id: <20180703094636.GA24693@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshay,

On Tue, Jul 03, 2018 at 02:50:55PM +0530, Akshay Adiga wrote:
> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Looks good.
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

