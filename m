Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282DC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAA920828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sWu7Q2RH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeJ0WKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 18:10:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbeJ0WKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 18:10:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9RDSXuS042060;
        Sat, 27 Oct 2018 13:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=sEN40fKKJ5XpN7P89xeu2zvfZ/ncGGGBI99WbFkO2Dg=;
 b=sWu7Q2RHvm/dGGoKbZEyjhn9TWKLG4I6a/Ps+TwzCpY7KOwo6OdfjSoz6MB6Zw+qhSwy
 5C2qlmXxmzCVSGpAD6p+QE7KttJ563NlIgtvek+4hskNDCpgqLmlilTzQUb+/J8PHIx7
 WPS/f70dX3uNq/8qpBkAwLW+jtUz7mT2jVmn6vU1w5qIxmh8OP34c7LNGYQkJt20OTp/
 r76zrLPHjaIPQTUCrxF+t73GNRVbAZRPw72GSJbr5jLRUuPoWcrPgxYhs3TluSnXMTOC
 FMIh3ifB+TSIrL0XLQnzFWqw1rZKrytF4VqXv9CKi/pUmpGppQYra6JEp0oIdNEO2sKD JA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ncfet8u1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 13:28:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9RDSQ9l016011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 13:28:26 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9RDSO9t022467;
        Sat, 27 Oct 2018 13:28:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Oct 2018 06:28:23 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180930205448.26205-1-natechancellor@gmail.com>
        <10b12992-3570-4646-374b-82cbd7276839@acm.org>
        <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
        <1538503063.193396.6.camel@acm.org>
        <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
        <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
        <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
        <20181025225548.GA10326@flashbox>
        <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
        <1540576908.66186.103.camel@acm.org>
        <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
        <1540589437.66186.124.camel@acm.org>
        <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
        <1540591147.66186.127.camel@acm.org>
        <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
        <1540592684.66186.136.camel@acm.org>
Date:   Sat, 27 Oct 2018 09:28:21 -0400
In-Reply-To: <1540592684.66186.136.camel@acm.org> (Bart Van Assche's message
        of "Fri, 26 Oct 2018 15:24:44 -0700")
Message-ID: <yq1o9bfcydm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=741
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810270126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

> Removing kernel drivers that are not used helps to reduce the workload
> of a maintainer and hence is a rational action. Additionally, if
> anyone would ever complain about removal of a kernel driver, it can be
> brought back by reverting the commit through which it has been
> removed.  Martin, please reply if you see this differently.

We remove crusty old SCSI drivers all the time. The heuristic is based
on lack of user bug reports and absence of commits that are not due to
kernel interface changes or trivial cleanups. So removing stuff is
perfectly normal.

The OSD protocol failed to get traction in the industry, adoption was
very limited. If the code just plugged straight into existing kernel
interfaces it would be easier to justify keeping it around. However, the
OSD support requires bidirectional command support so we carry a bunch
of additional plumbing in both block and SCSI to accommodate it. There
are no other users of these interfaces, so dropping OSD would mean we
could simplify some (hot) code paths. That would be a win in my book.
Consequently, if a patch were to materialize that disentangled and
removed OSD, I'd be inclined to merge it.

But I do think that this is an orthogonal discussion to the innocuous
__weak attribute cleanup.

-- 
Martin K. Petersen	Oracle Linux Engineering
