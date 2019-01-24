Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0867C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AFF21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAXBD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:03:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbfAXBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:03:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O0ngW3064055
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:03:25 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6yejr49y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:03:24 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Thu, 24 Jan 2019 01:03:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 01:03:19 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0O13IAN9044454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 01:03:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502DBA4053;
        Thu, 24 Jan 2019 01:03:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34F1A404D;
        Thu, 24 Jan 2019 01:03:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jan 2019 01:03:17 +0000 (GMT)
Received: from [9.102.54.12] (unknown [9.102.54.12])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 689EBA0110;
        Thu, 24 Jan 2019 12:03:15 +1100 (AEDT)
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Olof Johansson <olof@lixom.net>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com, linux-accelerators@lists.ozlabs.org
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Thu, 24 Jan 2019 12:03:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19012401-0012-0000-0000-000002EC1A00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012401-0013-0000-0000-000021234B7B
Message-Id: <ba543301-9953-4dcd-f744-2aa66746a874@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/1/19 8:52 am, Olof Johansson wrote:
> But, I think the largest question I have (for a broader audience) is:
> 
> I predict that we will see a handful of these kind of devices over the
> upcoming future -- definitely from ML accelerators but maybe also for
> other kinds of processing, where there's a command-based, buffer-based
> setup sending workloads to an offload engine and getting results back.
> While the first waves will all look different due to design trade-offs
> made in isolation, I think it makes sense to group them in one bucket
> instead of merging them through drivers/misc, if nothing else to
> encourage more cross-collaboration over time. First steps in figuring
> out long-term suitable frameworks is to get a survey of a few
> non-shared implementations.
> 
> So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> happy to bootstrap it with a small group (@Dave Airlie: I think your
> input from GPU land be very useful, want to join in?). Individual
> drivers maintained by existing maintainers, of course.
> 
> I think it might make sense to move the CAPI/OpenCAPI drivers over as
> well -- not necessarily to change those drivers, but to group them
> with the rest as more show up.

For cxl/ocxl, I have no objection to moving to this new subtree if 
that's what we all agree to do. (what do people do about UAPI headers in 
this situation? keep them where they are in misc/?)

If we do go ahead and set up this new subtree, perhaps we can use the 
mailing list I set up at linux-accelerators@lists.ozlabs.org but we 
haven't really started using...

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

