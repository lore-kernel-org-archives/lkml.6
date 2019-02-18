Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B162173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQq95IU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfBRPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:06:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41554 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfBRPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:06:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IF3fUb087312;
        Mon, 18 Feb 2019 15:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XsXQOCW8lBXAh5zlZl5qaFCXBwLXMwVHKkQyhUegGck=;
 b=ZQq95IU+X6lTXqYlyv6uNN//ssFblj1JvCFk5tpx3ksINckuh6lb7jwZxwvaszwvUScM
 WjVjuJRKTUxrPLbCnfngDeb87MFhUaovk0RRlAJEhI90XkgzC7m2mOnx9YmpDneslVAe
 XhPF/Bu3Gtu80MFAIzltamef8fYWEx53Hs6cXMhU3EM+d4MEeqGikzxeIpbVeafN9MhQ
 W1vcQO9IpoebWR9DV+iA7D3XZuc8nIyd45VCIQjvHIl3Wb9CZ3YHxEoq6u/epIjs342H
 i6nFy+2LcEfzMfhlQt8RFduE4RCEqIsi380mlOHbNGnb0DXO7VDhRmjoE16owO8+/8/N ZQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xtpr8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 15:06:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1IF61mA026989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 15:06:01 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1IF60Du027486;
        Mon, 18 Feb 2019 15:06:01 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 07:06:00 -0800
Date:   Mon, 18 Feb 2019 18:05:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] staging: rtl8192e: Remove set but not used
 variables 'broad_addr, stype'
Message-ID: <20190218150550.GG17104@kadam>
References: <20190218123359.83746-1-yuehaibing@huawei.com>
 <20190218151543.145958-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218151543.145958-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=804 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fantastic!  Thanks.

regards,
dan carpenter

