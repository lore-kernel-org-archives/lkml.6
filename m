Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 72159C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B1208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AiBXSVV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3B1208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965674AbeFNOOv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:14:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966319AbeFNOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:14:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EEEJ8r157960;
        Thu, 14 Jun 2018 14:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=lye1J4jozos0QQZoaJ7weTA5eEnuRiGN4GsIoagCjJY=;
 b=AiBXSVV69gySpH87i7zl8/NZ1ltxL1G/Yn7MTmM9SRZzXR8ncnJdRaVMaK70enxl2IEg
 zP5Id5EPUYX1zG6+EyY25Ph5Aiaj4ObmX5EKKX580Mmg6A7p3oqk7xnX42f8cmWjwDFa
 hgKbX6SPlf3tTWHXlVKgLf6fIZ0+FOAkW6tWGzeaUiAlCV7cc/XXBWMYhTGcok5KISw/
 t/+CfZL1YVE9GrN2uAp57kgCgOZxg/EedhZkGev283yZDaTFvNaUwSxkH4xLFWYu+rP/
 exkMPql+XHvhg8W2G4sG04YY5zLFMPUIP1bOlDvucWkiPgQI/6MDAkUw8ApjdZe3Puy6 Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jk0xrn9hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 14:14:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5EEEihq005693
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 14:14:44 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EEEiMF002877;
        Thu, 14 Jun 2018 14:14:44 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 07:14:43 -0700
Date:   Thu, 14 Jun 2018 17:14:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: add error handling for nlmsg_put
Message-ID: <20180614141432.he6h3aphtxfsw2ef@mwanda>
References: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
 <20180612115525.yg2mnhlcz6ok3dyo@mwanda>
 <CABb2Tx+7E9dxV0=D0t80CPnxfLJpEo0+eNG-c_2XH2tZD-C8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb2Tx+7E9dxV0=D0t80CPnxfLJpEo0+eNG-c_2XH2tZD-C8BA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=726
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:27:26AM +0800, Zhouyang Jia wrote:
> Hi,
> 
> I reported this bug since more than 95% callsites of nlmsg_put are
> well handled in kernel, and many of them also allocated skb before.
> 

That's probably true, but the NULL check is not required *here*.

Just mark it as a false positive in your tool and move on...  It's not
like we are close to running out of real bugs to deal with.

regards,
dan carpenter

