Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D3C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wQzu4nvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbfBOHhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:37:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59186 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfBOHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:37:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F7T8Nt183772;
        Fri, 15 Feb 2019 07:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ouO38S8+Vs+emb1gu7YBj/S8iIHWboAqd2m7hVIdC90=;
 b=wQzu4nvxIFCHsITWczmue1s9XNcGeB6ZdJTBtp+Nc0LZbMMe2aNm0M1f5ObrzTGUAITw
 x0Mt82xZ97IQTntVn7O79SjO7AsOsOuNgJMchDm5Zf/mCpfNwEWLBwm/5Cbc8ll7Ekrc
 8NTGfYFP86P69xYVIzTgS0UTYd2H8Z3w1tMeIv+bzAgcI5w++65Is+Y68IJ1T18KIwJs
 8IDGK5nhcf4Flc4gqCEF0W+DY3JedAUFOD+WKsVWUwGqwc6HY17SVAGJxldQ92PQAWQB
 POjC6Nj9D3bNLExmMUlpkdb3BRtoLQOrQ7kb4QmapMnAWd2b22jg51KixDqS/FC8vU2b Zw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qhre5v7b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:36:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1F7asZj026483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:36:54 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F7arPE020103;
        Fri, 15 Feb 2019 07:36:54 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 23:36:53 -0800
Date:   Fri, 15 Feb 2019 10:36:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190215073644.GD2326@kadam>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
 <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
 <20190128183053.GK1795@kadam>
 <16373e83-2496-3bf5-7b16-72f3454d294d@huawei.com>
 <f08c49d2-c3c1-4b80-f61c-004f911086d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08c49d2-c3c1-4b80-f61c-004f911086d8@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=825 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:10:34AM +0800, Chao Yu wrote:
> Hi Dan,
> 
> Any suggestion?
> 

I won't NAK whatever you decide.  But my opinion is that you should
just use normal kernel memory allocators even though it means you have
to use two different fault injection frameworks.

Over time it would be good to improve and expand the standard kernel
error injection frameworks to cover more types.

regards,
dan carpenter

