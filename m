Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B15F20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJLWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:55:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbeJLWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:55:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CFKrf1049488
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:22:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2vcxw01v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:22:47 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Oct 2018 09:22:46 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Oct 2018 09:22:43 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9CFMhfq39256220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Oct 2018 08:22:43 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA1507805E;
        Fri, 12 Oct 2018 09:22:42 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B87177805C;
        Fri, 12 Oct 2018 09:22:40 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.185.70])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Oct 2018 09:22:40 -0600 (MDT)
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
Date:   Fri, 12 Oct 2018 08:22:39 -0700
In-Reply-To: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
         <20181011203126.15338-1-ndesaulniers@google.com>
         <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
         <1539356751.2656.5.camel@linux.ibm.com>
         <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101215-0020-0000-0000-00000E786F25
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009866; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101629; UDB=6.00570067; IPR=6.00881674;
 MB=3.00023729; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-12 15:22:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101215-0021-0000-0000-0000635A33BE
Message-Id: <1539357759.2656.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=739 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 10:13 -0500, Denis Kenzior wrote:
> Hi James,
> 
> > > So can't we simply use 'bool' or uint32 as the type for h3
> > > instead of re-ordering everything
> > 
> > The problem is the standard is ambiguious.  The only thing that's
> > guaranteed to work for all time is a char *.  If you want to keep
> > the order, what I'd suggest is inserting a dummy pointer argument
> > which is always expected to be NULL between the h3 and the varargs.
> 
> So maybe I'm misunderstanding something, but the issue seems to be
> that unsigned char is promoted to 'unsigned char *' by Clang and
> probably unsigned int or int by gcc.
> 
> So instead of having unsigned char h3, can't we simply have bool h3
> or unsigned int h3?

Given the ambiguity in the standards, the safe thing that will work for
all time and all potential compilers is a char *

James

