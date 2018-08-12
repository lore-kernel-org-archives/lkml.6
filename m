Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C2DC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D8218C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mt8fgUGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6D8218C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHMAaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 20:30:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeHMAaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 20:30:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7CLhinc114926;
        Sun, 12 Aug 2018 21:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nMHlv8fbA2bjz0FBRbH4MjSSUFWW+2HlB9QS1fvc+R0=;
 b=Mt8fgUGxlizx5t3wZyQ8WMQadDEILzfG1y0T2akMI3EpSqiFbNN3zdfdfTVj+vx8yUaq
 lX3PJdpCF7s5NjRdMVrXKH+Pn7k38mu5Hhbl1cR2trtTtAkYZ+bt0A1SxZRlFMZUiq6R
 a1aDjSc8yOnBgmyDDeeKC6rzM5LTu94LMjV8XcyhyEnhk30AsS3MNTos9zAE1wTgIla7
 HzPwzLA0U4KhxQyaR3mBfPMiakhOr18BTHhAAZuO7ZYgc4QSMY3n+X21X3nOPf4ZecgA
 IcelzkaNQm/vrHXPukncxugnmdmgxAq+hWFeNybBhCHfgiQaBhaDizmE+G59rtX6epzA nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ksq7t2447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 21:50:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7CLoqjT013803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 21:50:53 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7CLoqZb031175;
        Sun, 12 Aug 2018 21:50:52 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Aug 2018 21:50:51 +0000
Date:   Mon, 13 Aug 2018 00:50:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tom Todd <thomas.m.a.todd@gmail.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        arvind.yadav.cs@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: devio: fixed a trailing statement code style
 issue
Message-ID: <20180812215044.pw3rvb2vw5matp5l@mwanda>
References: <20180812180656.26079-1-thomas.m.a.todd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812180656.26079-1-thomas.m.a.todd@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=564
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808120243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 07:06:56PM +0100, Tom Todd wrote:
> Fixed a code styling issue
> 

Just ignore checkpatch on this one.  The code is slightly unusual so
checkpatch got confused.

regards,
dan carpenter

