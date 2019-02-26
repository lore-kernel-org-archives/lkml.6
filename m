Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822C1C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A41D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfBZHEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:04:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbfBZHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:04:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q74Nss127089
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:04:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qvy3k4pg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:04:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Feb 2019 07:04:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 07:04:29 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1Q74S5L40435868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 07:04:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985C142041;
        Tue, 26 Feb 2019 07:04:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42EF342045;
        Tue, 26 Feb 2019 07:04:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Feb 2019 07:04:27 +0000 (GMT)
Date:   Tue, 26 Feb 2019 09:04:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 24/26] userfaultfd: wp: UFFDIO_REGISTER_MODE_WP
 documentation update
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-25-peterx@redhat.com>
 <20190225211930.GG10454@rapoport-lnx>
 <20190226065342.GJ13653@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226065342.GJ13653@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022607-0020-0000-0000-0000031B4A24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022607-0021-0000-0000-0000216CAE19
Message-Id: <20190226070307.GE5873@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 02:53:42PM +0800, Peter Xu wrote:
> On Mon, Feb 25, 2019 at 11:19:32PM +0200, Mike Rapoport wrote:
> > On Tue, Feb 12, 2019 at 10:56:30AM +0800, Peter Xu wrote:
> > > From: Martin Cracauer <cracauer@cons.org>
> > > 
> > > Adds documentation about the write protection support.
> > > 
> > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > [peterx: rewrite in rst format; fixups here and there]
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Peter, can you please also update the man pages (1, 2)?
> > 
> > [1] http://man7.org/linux/man-pages/man2/userfaultfd.2.html
> > [2] http://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
> 
> Sure.  Should I post the man patches after the kernel part is merged?

Yep, once we know for sure what's the API kernel will expose.
 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.

