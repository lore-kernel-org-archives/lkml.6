Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA17C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF7520835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF7520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJLXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:34:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728527AbeJLXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:34:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CFxUWC013051
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:01:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2vcxxe7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:01:24 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 10:01:23 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Oct 2018 10:01:20 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9CG1JJV51249392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Oct 2018 09:01:19 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4487B7805C;
        Fri, 12 Oct 2018 10:01:19 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23DA578064;
        Fri, 12 Oct 2018 10:01:17 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.185.70])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Oct 2018 10:01:16 -0600 (MDT)
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
From:   James Bottomley <jejb@linux.ibm.com>
To:     Denis Kenzior <denkenz@gmail.com>, ndesaulniers@google.com,
        dhowells@redhat.com
Cc:     natechancellor@gmail.com, ebiggers@google.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 09:01:15 -0700
In-Reply-To: <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
         <1539356751.2656.5.camel@linux.ibm.com>
         <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
         <1539357759.2656.7.camel@linux.ibm.com>
         <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
         <1539359181.2656.13.camel@linux.ibm.com>
         <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101216-8235-0000-0000-00000E1438AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009866; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101642; UDB=6.00570075; IPR=6.00881687;
 MB=3.00023729; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-12 16:01:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101216-8236-0000-0000-000042F9F79A
Message-Id: <1539360075.2656.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=939 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 10:53 -0500, Denis Kenzior wrote:
> Hi James,
> 
> > >   From the links provided in the patch it seems that one cannot
> > > pass char/float/short to va_start().  Fair enough.  So if we make
> > > h3 an unsigned int, the issue goes away, no?
> > 
> > For the current version of clang, yes.  However, if we're fixing
> > this for good a char * pointer is the only guaranteed thing because
> > it mirrors current use in printf.
> > 
> 
> All right.  I guess I wasn't aware that non-printf like variadic 
> functions are now considered harmful or of the impending crusade
> against them :)

It's not, it's just a maintainer issue: The original problem is because
we coded for gcc specifically; it doesn't complain and does the right
thing, so everyone was happy.  Now Clang comes along and is unhappy
with this, so the question a good maintainer should ask is "how do I
fix this so it never comes back again?", not "what's the easiest
bandaid to get both Clang and gcc to work?" because the latter is how
we got here in the first place.

James

> But in the context of this patch, can we please use something less 
> invasive than changing all the arguments around?  Promoting h3 to a
> bool (if possible) or int/unsigned int would get my vote.
> 
> Regards,
> -Denis
> 

