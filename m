Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E69C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWRPrpqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C6A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbeFTJg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:36:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeFTJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:36:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K9YkkL020159;
        Wed, 20 Jun 2018 09:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=TlHv60nTMGk4Sv/o0j15GHvlQkE7JEGelgYO4koww2A=;
 b=UWRPrpqo2+zT50Heyic95RJE1hSWbMBg6EmYcJ02qNsnlkx5aOWkofqb3/p1A58YmLS8
 jIvVOwJLRgIylZEWFoKkWDHqsVufpzCUY+UlCvMdlFRbs+hs9EU4fpdKnImyx2ar2Sr+
 h8viIp/z5osxzyj+RfNcYDOndLNlr8ZosPc1npOcQZKyYW1SEkRJ2hEdoMHNRv0xhRt2
 pF+AwcFfY/bdfy7Rrux1MHNa26IxAiV8Sw6l7jsb6GXTE4jz9YC1Fca4WmWLCxVqqnJA
 VxupuAWNzS8lSfx3fcH3xzPrzSI61RRmyff818k/4oJTQYvjiCXDS/0y1aGKGTEg2rcg ZQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jmr2mktsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:36:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9aEaJ016996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:36:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9aDes017716;
        Wed, 20 Jun 2018 09:36:14 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 02:36:13 -0700
Date:   Wed, 20 Jun 2018 12:36:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thibaut Robert <thibaut.robert@gmail.com>
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wilc1000: Use common structs to parse ip
 packets
Message-ID: <20180620093604.vpud3j4qb5hbpdgq@mwanda>
References: <20180604105549.04031722@ajaysk-VirtualBox>
 <20180619184419.10304-1-thibaut.robert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619184419.10304-1-thibaut.robert@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=479
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice...

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

