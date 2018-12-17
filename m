Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3670C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD23206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeLQUVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:21:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbeLQUVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:21:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHKJT8w104571
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:21:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pegr7w4x6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:21:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Dec 2018 20:21:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 20:21:10 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHKL9vn58065012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 20:21:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22FDBA4057;
        Mon, 17 Dec 2018 20:21:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCCCA4051;
        Mon, 17 Dec 2018 20:21:08 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 20:21:07 +0000 (GMT)
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 17 Dec 2018 15:21:07 -0500
In-Reply-To: <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
References: <20181128232019.GC131170@gmail.com>
         <20181217181244.220052-1-ebiggers@kernel.org>
         <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
         <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
         <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121720-0016-0000-0000-00000237DB18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121720-0017-0000-0000-00003290274C
Message-Id: <1545078067.10804.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 11:06 -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 10:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So the *simplest* fix would seem to be to literally remove all those
> > "= -1" for the Opt_err initialization.  Making the code smaller,
> > simpler, and fixing the bug in the process.
> 
> Something like this
> 
>     git  grep -l 'Opt_err = -1' | xargs sed -i 's/Opt_err = -1/Opt_err/'
> 
> would do it, but I also notice that
> security/integrity/ima/ima_policy.c then has some truly funky code
> that plays around with the enum numbers , ie
> 
>   #define pt(token)     policy_tokens[token + Opt_err].pattern

Yikes!

> which actually depends on the ordering of policy_tokens[], and depends
> on the exact values, ie it literally (and quite insanely) sets Opt_err
> to -1, and then Opt_measure to 1, and leaves 0 unused. That code
> seriously makes no sense at all, and is fundamentally broken.
> 
> It would be better to use
> 
>     #define pt(token)     policy_tokens[token - Opt_measure].pattern
> 
> instead, but even then you should have a huge comment about how the
> policy_tokens[] array absolutely has to be properly ordered.

Will do.

> 
> Honestly, for being about "security", all of this code seems to be
> doing some really questionable things with all those Opt_xyz enums.

It's being used for parsing and displaying the policy, which do need
to be in sync.

Mimi

