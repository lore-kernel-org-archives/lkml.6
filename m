Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D146020671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D146020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeG0WvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389583AbeG0WvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:51:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLJa41036598
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:27:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg78ch3t7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 17:27:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 27 Jul 2018 22:27:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 22:27:24 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RLRNu537093492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 21:27:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A40CA4055;
        Sat, 28 Jul 2018 00:27:36 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4B3DA404D;
        Sat, 28 Jul 2018 00:27:35 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.206.116])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 28 Jul 2018 00:27:35 +0100 (BST)
Date:   Sat, 28 Jul 2018 00:27:21 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] docs/mm: make GFP flags descriptions usable as
 kernel-doc
References: <1532626360-16650-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532626360-16650-7-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726160825.0667af9f@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726160825.0667af9f@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072721-0028-0000-0000-000002E149C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072721-0029-0000-0000-000023994418
Message-Id: <20180727212720.GD17745@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:08:25PM -0600, Jonathan Corbet wrote:
> On Thu, 26 Jul 2018 20:32:39 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > This patch adds DOC: headings for GFP flag descriptions and adjusts the
> > formatting to fit sphinx expectations of paragraphs.
> 
> So I think this is a great thing to do.  Adding cross references from
> places where GFP flags are expected would be even better.  I do have one
> little concern, though...
> 
> > - * __GFP_MOVABLE (also a zone modifier) indicates that the page can be
> > - *   moved by page migration during memory compaction or can be reclaimed.
> > + * %__GFP_MOVABLE (also a zone modifier) indicates that the page can be
> > + * moved by page migration during memory compaction or can be reclaimed.
> 
> There are Certain Developers who get rather bent out of shape when they
> feel that excessive markup is degrading the readability of the plain-text
> documentation.  I have a suspicion that all of these % signs might turn
> out to be one of those places.  People have been trained to expect them in
> function documentation, but that's not quite what we have here.
> 
> I won't insist on this, but I would suggest that, in this particular case,
> it might be better for that markup to come out.

No problem with removing % signs, but the whitespace changes are necessary,
otherwise the generated html gets weird.
 
> Then we have the same old question of who applies these.  I'd love to have
> an ack from somebody who can speak for mm - or a statement that these will
> go through another tree.  Preferably quickly so that this stuff can get
> in through the upcoming merge window.

> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.

