Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79322C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1921717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1921717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeHCMDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:03:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbeHCMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:03:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73A4Fb8031032
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 06:08:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmmcu1g6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:08:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Fri, 3 Aug 2018 11:08:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 11:08:00 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73A7xaQ19857528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 10:07:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF2052057;
        Fri,  3 Aug 2018 13:08:09 +0100 (BST)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.152.96.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 09BA45204E;
        Fri,  3 Aug 2018 13:08:09 +0100 (BST)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1flX02-000869-SW; Fri, 03 Aug 2018 12:07:58 +0200
Date:   Fri, 3 Aug 2018 12:07:58 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/3] perf auxtrace: Support for perf report -D for s390
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-2-tmricht@linux.ibm.com>
 <20180802124909.GB7996@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802124909.GB7996@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080310-0008-0000-0000-0000025C4440
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080310-0009-0000-0000-000021C2E7FE
Message-Id: <20180803100758.GA28475@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On Thu, Aug 02, 2018 at 09:49:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 02, 2018 at 09:46:20AM +0200, Thomas Richter escreveu:
> > Add initial support for s390 auxiliary traces using the
> > CPU-Measurement Sampling Facility.
> 
> Could you please provide one or two paragraphs explaining what is this
> "CPU-Measurement Sampling Facility", in which hardware this is available
> (all s/390 hardware has it? Just the 64-bit model(s)?) and provide a
> public URL for people interested in further reading?

The CPU-Measurement Facility (CPU-MF) provides a set of functions to obtain
performance information on the mainframe.  Basically, it was introduced
with System z10 years ago for the z/Architecture, that means, 64-bit.
For Linux, there are two facilities of interest, counter facility and sampling
facility.  The counter facility provides hardware counters for instructions,
cycles, crypto-activities, and many more.

The sampling facility is a hardware sampler that when started will write
samples at a particular interval into a sampling buffer.  At some point,
for example, if a sample block is full, it generates an interrupt to collect
samples (while the sampler continues to run).

Few years ago, I started to provide the a perf PMU to use the counter
and sampling facilities.  Recently, the device driver was updated to also
"export" the sampling buffer into the AUX area.  Thomas now completed the
related perf work to interpret and process these AUX data.

If people are more interested in the sampling facility, they can have a
look into:

- The Load-Program-Parameter and the CPU-Measurement Facilities, SA23-2260-05
  http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a

and to learn how-to use it for Linux on Z, have look at chapter 54,
"Using the CPU-measurement facilities" in the:

- Device Drivers, Features, and Commands, SC33-8411-34
  http://public.dhe.ibm.com/software/dw/linux390/docu/l416dd34.pdf


Thanks and kind regards,
  Hendrik

