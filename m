Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFA7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8135F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8135F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbeGRRjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:39:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbeGRRjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:39:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IGsWwe046212
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:00:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka84qukhy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:00:53 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 18:00:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 18:00:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IH0kjx31195240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 17:00:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9903E42054;
        Wed, 18 Jul 2018 20:01:04 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF71842047;
        Wed, 18 Jul 2018 20:01:03 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.179])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Jul 2018 20:01:03 +0100 (BST)
Date:   Wed, 18 Jul 2018 20:00:43 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] docs/mm: add boot time memory management docs
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180702113255.1f7504e2@lwn.net>
 <20180718114730.GD4302@rapoport-lnx>
 <20180718060249.6b45605d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718060249.6b45605d@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18071817-4275-0000-0000-0000029A9775
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071817-4276-0000-0000-000037A2B637
Message-Id: <20180718170043.GA23770@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Andrew)

On Wed, Jul 18, 2018 at 06:02:49AM -0600, Jonathan Corbet wrote:
> On Wed, 18 Jul 2018 14:47:30 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > > So this seems like good stuff overall.  It digs pretty deeply into the mm
> > > code, though, so I'm a little reluctant to apply it without an ack from an
> > > mm developer.  Alternatively, I'm happy to step back if Andrew wants to
> > > pick the set up.  
> > 
> > Jon, does Michal's reply [1] address your concerns?
> > Or should I respin and ask Andrew to pick it up? 
> > 
> > [1] https://lore.kernel.org/lkml/20180712080006.GA328@dhcp22.suse.cz/
> 
> Michal acked #11 (the docs patch) in particular but not the series as a
> whole.  But it's the rest of the series that I was most worried about :)
> I'm happy for the patches to take either path, but I'd really like an
> explicit ack before I apply that many changes directly to the MM code...

Andrew,

Can you please take a look at this series? The thread starts at [1] and if
it'd be more convenient to you I can respin the whole set.
 
[1] https://lore.kernel.org/lkml/1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com/

> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.

