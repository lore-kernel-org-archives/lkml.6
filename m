Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB94D21718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB94D21718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeHHIUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:20:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbeHHIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:20:14 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w785sMYf074404
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 02:02:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqnvnsevc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 02:02:08 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 00:02:07 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 00:02:05 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78624Tv28967068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 23:02:04 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35BDFC6059;
        Wed,  8 Aug 2018 00:02:04 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC6EAC605A;
        Wed,  8 Aug 2018 00:02:03 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.79.219.101])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 00:02:03 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5C3BC2E2F75; Wed,  8 Aug 2018 11:32:00 +0530 (IST)
Date:   Wed, 8 Aug 2018 11:32:00 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 0/3] New device-tree format  and Opal based idle
 save-restore
Reply-To: ego@linux.vnet.ibm.com
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <87zhxybceu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhxybceu.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18080806-0016-0000-0000-000009163CC5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009505; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070868; UDB=6.00551265; IPR=6.00850339;
 MB=3.00022577; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 06:02:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080806-0017-0000-0000-00003FEC677C
Message-Id: <20180808060200.GA17634@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Tue, Aug 07, 2018 at 10:15:37PM +1000, Michael Ellerman wrote:
> > Skiboot patch-set for device-tree is posted here :
> > https://patchwork.ozlabs.org/project/skiboot/list/?series=58934
> 
> I don't see a device tree binding documented anywhere?
> 
> There is an existing binding defined for ARM chips, presumably it
> doesn't do everything we need. But are there good reasons why we are not
> using it as a base?
> 
> See: Documentation/devicetree/bindings/arm/idle-states.txt
>

In case of ARM, the idle-states node is a child of cpus node. Each
child of the idle-states node is a node describing that particular
idle state.

	idle-states {
		entry-method = "psci";

		CPU_RETENTION_0_0: cpu-retention-0-0 {
			compatible = "arm,idle-state";
			arm,psci-suspend-param = <0x0010000>;
			entry-latency-us = <20>;
			exit-latency-us = <40>;
			min-residency-us = <80>;
			status = "disabled"
		};


		CPU_SLEEP_0_0: cpu-sleep-0-0 {
			compatible = "arm,idle-state";
			local-timer-stop;
			arm,psci-suspend-param = <0x0010000>;
			entry-latency-us = <250>;
			exit-latency-us = <500>;
			min-residency-us = <950>;
			status = "okay"
		};

		.
		.
		.
	}


Furthermore, each CPU can have a different set of cpu-idle states
due to the asymmetric nature of the processors units on the board.
Thus, there is an additional property for each cpu called
cpu-idle-states which points to the containers of the idle states
themselves.


cpus {
	#size-cells = <0>;
	#address-cells = <2>;

	CPU0: cpu@0 {
		device_type = "cpu";
		compatible = "arm,cortex-a57";
		reg = <0x0 0x0>;
		enable-method = "psci";
		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
	};

	. . .
	. . .
	. . .
	. . .

	CPU8: cpu@100000000 {
		device_type = "cpu";
		compatible = "arm,cortex-a53";
		reg = <0x1 0x0>;
		enable-method = "psci";
		cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
				   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
	};


In our case, we already have an "ibm,opal/power-mgt/" node in the
device tree where we have defined the idle state so far. This was the
reason to stick the new device tree format under this existing node
that has been specially earmarked for power management related bits,
instead of defining the new format under the cpus node.

Also, in our case, since all the CPU nodes are symmetric they will
have the same set of idle states. Hence, we wouldn't need the
"cpu-idle-states" property for each CPU.

As for the properties of idle states themselves, the only common
things between the ARM idle-states and our case are the compatible,
exit-latency-us, min-residency-us. In addition to this we need the
flags which indicate the nature of the resource loss (Hypervisors
state loss, Timebase loss, etc..) , the psscr_val and the psscr_mask
corresponding to the stop states which the ARM device-tree doesn't
provide.

For this reason we have opted for a new bindings since the overlap
between these two platforms is minimal.

> 
> The way you're using compatible is not really consistent with its
> traditional meaning.
> 
> eg, you have multiple states with:
> 
>                 compatible = "ibm,state-v1",
>                             "cpuoffline",
>                             "opal-supported";
> 
> 
> This would typically mean that all those state are all "compatible" with
> some semantics defined by the name "ibm,state-v1". What you're trying to
> say (I think) is that each state is "version 1" of *that state*. And
> only kernels that understand version 1 should use the state.

Ok, I see what you mean here. Perhaps, we should have had something
like "ibm,stop0-v1" , "ibm,stop1-v2", "ibm,stop2-v2" etc, where
version1, version2 etc, pertains to the versions of those specific
states.

Thus a kernel that knows about "version 1" of stop0 and stop2 and
"version 2" of stop1 will end up using only stop0 and stop1 since it
doesn't know "version 2" of stop2. 

In such a case, kernel should fallback to OPAL for stop2. Does this
make sense ?

> 
> And "cpuoffline" and "opal-supported" definitely don't belong in
> compatible AFAICS, they should simply be boolean properties of the
> node.

I agree. These should be flags.

> 
> cheers
> 

