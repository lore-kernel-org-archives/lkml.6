Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FBC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F86E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeLRDA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:00:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbeLRDA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:00:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI2weQ8118270
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 22:00:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pepcgvqux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 22:00:25 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Dec 2018 03:00:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 03:00:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI30Jpf6619432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 03:00:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 498764C050;
        Tue, 18 Dec 2018 03:00:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F5F4C063;
        Tue, 18 Dec 2018 03:00:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.36])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 03:00:18 +0000 (GMT)
Subject: Re: [PATCH] ima: cleanup the match_token policy code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Dec 2018 22:00:07 -0500
In-Reply-To: <20181218013348.GR2217@ZenIV.linux.org.uk>
References: <1545092089.4206.5.camel@linux.ibm.com>
         <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
         <20181218013348.GR2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121803-0016-0000-0000-00000237F755
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121803-0017-0000-0000-000032904435
Message-Id: <1545102007.4206.15.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 01:33 +0000, Al Viro wrote:
> On Mon, Dec 17, 2018 at 04:36:54PM -0800, Linus Torvalds wrote:
> > On Mon, Dec 17, 2018 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Start the policy_tokens and the associated enumeration from zero,
> > > simplifying the pt macro.
> > 
> > I applied this directly, since I decided to just commit my own "don't
> > use negative Opt_err" patch for the test_and_set_bit() cases, and they
> > kind of go together.
> > 
> > There's still a -1 in security/keys/encrypted-keys/encrypted.c, and
> > there are also three cases of "Opt_error = -1" in the security layer.
> > 
> > All of which look pointless and wrong, but not actively buggy, so I'll
> > leave them alone.
> 
> FWIW, that part of LSM shite is getting taken out and shot - LSM-related
> preps in the beginning of mount API series are, at the moment, at
>  fs/btrfs/ctree.h           |   4 -
>  fs/btrfs/super.c           |  82 ++-------
>  fs/namespace.c             |   9 +-
>  fs/nfs/internal.h          |   2 +-
>  fs/nfs/super.c             |  34 ++--
>  fs/super.c                 |  23 +--
>  include/linux/lsm_hooks.h  |  17 +-
>  include/linux/security.h   |  82 ++-------
>  security/security.c        |  39 +++--
>  security/selinux/hooks.c   | 798 ++++++++++++++++++++++++++++++++------------------------------------------------------
>  security/smack/smack_lsm.c | 359 +++++++++++++++------------------------
>  11 files changed, 523 insertions(+), 926 deletions(-)
> and unlike the original variant there's not much touched in security/*
> further in the series...
> 
> No match_token() uses left in there after this part.

Could you expand on commit 5b2ea6199614 ("selinux: switch away from
match_token()") patch description.  All that it says is "It's not a
good fit, unfortunately, and the next step will make it even less so.
Open-code what we need here."  And there's even less for the
equivalent Smack patch, which just says "same issue as with
selinux...".

Mimi

