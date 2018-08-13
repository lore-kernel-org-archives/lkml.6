Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9839C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFB5217BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgYTDIpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFB5217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeHMPs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:48:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeHMPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:48:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DCxQOo159583;
        Mon, 13 Aug 2018 13:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yBPlPezc2OFCFgbxIk1Ps/CJanz6K9+AT7GQyM/TfEs=;
 b=mgYTDIpLzKjYH4fB0MN+Mk9stNG0SZJg4CtE+JiEwrsPjuBdkzK+Z90pY4rXmy+Z+SR4
 mh4d5Wj/XAUjlr1xptNLXON6ypXGC7OXUwzlZds1shaCPUuABiWUJ6kvoXNQsTLkwJ54
 Gncjt++cF1kdR0u7DF9TjWVt54ZPxpZ9t7d/brZ1DeQfTxablHnpf2RSXwwtDV1nUOsK
 CaYtt/+7PqD2ZRdfpL9JZ+JGUFCR4EZzpyzrlXXaAlFjuHo0Ag/2YXTqEZvDfLAk9e8W
 1y7+pXSwD2X85NsXlqniWOQwNb8gylmCjaiViBzB0xpdnYnIl+aRQqjQpkind8CHQGKK pA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ksqrp43f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 13:05:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7DD5qYt026632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 13:05:52 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7DD5plt024414;
        Mon, 13 Aug 2018 13:05:51 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 13:05:51 +0000
Date:   Mon, 13 Aug 2018 16:05:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] staging: erofs: cleanup z_erofs_vle_work_{lookup,
 register}
Message-ID: <20180813130541.hzjgb6wznkxcnajg@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-5-chao@kernel.org>
 <20180813120057.6grkpue6h7dtmpt2@mwanda>
 <f162748e-cc02-8578-2a0b-af16d982e0b3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f162748e-cc02-8578-2a0b-af16d982e0b3@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=402
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah.  You'd have to remove the const.

Anyway, on looking at it more, I guess this patch is fine for now.  We
will probably end up changing z_erofs_vle_work_lookup() and
z_erofs_vle_work_register() some more in the future.

regards,
dan carpenter

