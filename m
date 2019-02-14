Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F556C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAA6222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRLmD30R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406827AbfBNK4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:56:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:56:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EAn0os187554;
        Thu, 14 Feb 2019 10:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=MnGiBnQN2atIOsmm2xtueuCS5wsVO8PurpyWe54oMEY=;
 b=FRLmD30RcQReYecFBxI9oMI/5aXV+duA4KBSBunkGGhGpFqeMB40KJIMWKgRqzg5rOmW
 8XyR3cjW2FGQARhFEshHXsJVbTrwVCbiXGHWwRexsHc1y/2/s6B32pG/xw8yN588TRDK
 MsRJZlIEiWfy46c8yn2OgjZuGcvVyHCrvGtmmGNy25ZefRRcFu8fxTx7G5S5tMCMNU1X
 8KZVO87X2USuIoF0No67oFRbWBDxeOf5mfGPXk1rpaEbzUzol683V82Tdmye7aXkuN8h
 abIWJBlOqEnTB8BtNC2eSNLhGaIOCHsWIs8t1Yr/RKIV3KThFIWp9+OF1qTYeakEwfwe hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhree7b1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 10:56:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1EAtrm0000306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 10:55:53 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1EAtq7D014060;
        Thu, 14 Feb 2019 10:55:52 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 02:55:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [LSF/MM TOPIC] (again) THP for file systems
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190213235959.GX12668@bombadil.infradead.org>
Date:   Thu, 14 Feb 2019 03:55:50 -0700
Cc:     Song Liu <songliubraving@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Transfer-Encoding: 7bit
Message-Id: <98E2D333-409A-47AF-886F-3E661BD1C4EE@oracle.com>
References: <77A00946-D70D-469D-963D-4C4EA20AE4FA@fb.com>
 <20190213235959.GX12668@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 13, 2019, at 4:59 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> I believe the direction is clear.  It needs people to do the work.
> We're critically short of reviewers.  I got precious little review of
> the original XArray work, which made Andrew nervous and delayed its
> integration.  Now I'm getting little review of the followup patches
> to lay the groundwork for filesystems to support larger page sizes.
> I have very little patience for this situation.

I'll be happy to dive in and look at the changes from an mm point of view,
but I don't feel qualified to comment on all the file system
considerations.

Perhaps if someone from the fs side would volunteer; I know well how
frustrating it can be to be trapped in code review suspended animation.

