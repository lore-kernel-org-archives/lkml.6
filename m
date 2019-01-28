Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oPX8BF7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfA1SbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:31:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42304 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1SbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:31:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SIJbut140662;
        Mon, 28 Jan 2019 18:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7yEd1cqnfnhYlWl35ivCdNYugR3kaUKa6YXJVPI4VGY=;
 b=oPX8BF7Q0D7D463IGl8eCmnfNYQnDlajGcD7EYWnVd8rEWLb6JaRurBvxs1aXdZOBm3w
 qbNcLmpfcyzxXYoeDKGHlWRzTzSmM425jahX36CtT30z+0ElZmrhYgync0yBITMk1Koe
 2IKfs2TJtHV6FRWPlYYx6CqmNLeeHyWtO8UUa2EKGXdEt1D9Gvvhvse7bRA9Yj3muTeg
 gYzHreIsMs3PB6Rh+VYDVdhoJjVM+Zte5ro9wp6reMG1FaQAXOWnBYPpPArxOTOPLybF
 rvgISQz+uR70hicqYJE+bMhxKgdhxEN1p/Vr6/GN3YmpScnMrrRwXo8j/MsKdsnJ4VdN 7Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2e03eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 18:31:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0SIV3Tn025446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 18:31:03 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0SIV3qF023482;
        Mon, 28 Jan 2019 18:31:03 GMT
Received: from kadam (/197.157.0.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 10:31:02 -0800
Date:   Mon, 28 Jan 2019 21:30:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190128183053.GK1795@kadam>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:41:55AM +0800, Chao Yu wrote:
> Hi Dan and Xiang,
> 
> On 2019-1-28 21:48, Gao Xiang wrote:
> > Hi Dan,
> > 
> > On 2019/1/28 21:33, Dan Carpenter wrote:
> >> Hopefully, regular kmalloc() is enough.
> >>
> >> Do really need the erofs_kmalloc() function?  Regular kmalloc() has
> >> fault injection already.  Have you tried to use it?
> 
> Yes, I think we'd better to use erofs_kmalloc(). :)
> 
> Actually, fault injection in erofs_kmalloc only affect erofs module, we can
> expect that the range of fault can be limited in erofs code, rather than whole
> kernel, so the test point can be aimed at more accurately.
> 

Are you serious?  The standard fault injection doesn't do that???

Please fix it instead of creating a duplicate better implementation
which only your filesystem can use.  I would have thought that obviously
any fault injection framework could at least be configured to test
specific code...

regards,
dan carpenter

