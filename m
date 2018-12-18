Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9855C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D322133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLRFFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:05:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbeLRFFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:05:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI54Mbb050360
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:04:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2perng3ru7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:04:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Dec 2018 05:04:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 05:04:54 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI54ric3342804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 05:04:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ABC1A4059;
        Tue, 18 Dec 2018 05:04:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C4DA4057;
        Tue, 18 Dec 2018 05:04:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.36])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 05:04:52 +0000 (GMT)
Subject: Re: [PATCH] ima: cleanup the match_token policy code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Dec 2018 00:04:41 -0500
In-Reply-To: <20181218040629.GT2217@ZenIV.linux.org.uk>
References: <1545092089.4206.5.camel@linux.ibm.com>
         <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
         <20181218013348.GR2217@ZenIV.linux.org.uk>
         <1545102007.4206.15.camel@linux.ibm.com>
         <20181218040629.GT2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121805-0020-0000-0000-000002F9192A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121805-0021-0000-0000-000021491A0B
Message-Id: <1545109481.4206.36.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 04:06 +0000, Al Viro wrote:
> On Mon, Dec 17, 2018 at 10:00:07PM -0500, Mimi Zohar wrote:
> 
> > Could you expand on commit 5b2ea6199614 ("selinux: switch away from
> > match_token()") patch description.  All that it says is "It's not a
> > good fit, unfortunately, and the next step will make it even less so.
> > Open-code what we need here."  And there's even less for the
> > equivalent Smack patch, which just says "same issue as with
> > selinux...".
> 
> match_token() would require messing around with strsep() or something
> equivalent.  It's not a regex; foo=%s has no idea that comma is in any
> way special, etc.
> 
> As for the next commit...  Killing the Cthulhu-awful mess in
> selinux_sb_eat_lsm_opts() (allocating two temproraries, concatenating
> (comma-separated) non-LSM options into one, concatenating (pipe-separated)
> dequoted LSM options into another, then splitting that another by '|'
> instances and figuring out which option each piece is, etc.)
> is a Good Thing(tm).  And having to dance around the needs of
> match_token() adds extra headache, for no good reason.

Ok, so it is this particular combination of things, not the general
usage of strsep or match_token that you're objecting to.  So fixing
the other match_token non-LSM instances is fine.

To prevent the enumeration and the match_table from going out of sync,
I was thinking about defining a macro to create the match_table_t:

#define __policy_tokens_match(ENUM, str) {Opt_ ## ENUM, #str},

static const match_table_t policy_tokens = {
        __policy_tokens_id(__policy_tokens_match)
};

and the enumeration:

enum policy_tokens_id {
        __policy_tokens_id(__policy_tokens_enumify)
};

Mimi

