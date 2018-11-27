Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B480C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E525F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWovZUvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeK0Tbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:31:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeK0Tbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:31:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR8YPdG080012;
        Tue, 27 Nov 2018 08:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=/qhvZ6P80k4J32NnqQa+zIZzmPV0+W6yehl+ynJABKA=;
 b=CWovZUvSfVKmoH2mqiQ0dNw/L90rCKerdPYU/eqb3TSqpVZyqayka2K4fGbfoWyv2IN9
 xdRcFmSzvaiUxG6IKnsVY4TLLtmDJYtTHcGqgd1esWC+zbOU3+XkXEXNCY/VikiF8MFw
 BRIBTcDmUdBxw7Uj+VqVYsEIbHm8v0AoTiIT2PCSqvS+YTL7TofNvlMdkPZc3qS5QsKJ
 G9C1SoKyryy+d40NrSsYo8CRPjo7omNV5ZUXTvGTo57qCZafwc6NBA0eZMlIDjobnFqd
 bFt4eg4a+Eq5Ulyoap4dHptYsY9izADQ4pqL6HYkKkp5Hy880jaewqzO+jtuB92lsq8V YQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2u2dk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:34:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAR8Yagq030390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:34:36 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAR8YZwM012257;
        Tue, 27 Nov 2018 08:34:35 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 00:34:34 -0800
Date:   Tue, 27 Nov 2018 11:34:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "r.weclawski@gmail.com" <r.weclawski@gmail.com>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "santhameena13@gmail.com" <santhameena13@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "jananis37@gmail.com" <jananis37@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8188eu: Fix off-by-one in core/rtw_mlme_ext.c
Message-ID: <20181127083427.GS2970@unbuntlaptop>
References: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
 <20181127081542.GN3088@unbuntlaptop>
 <HK0PR01MB2163A0287797ECA3CDA68AA2ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR01MB2163A0287797ECA3CDA68AA2ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:29:05AM +0000, Yang Xiao wrote:
> Hi,
> 
> See commit ef9209b642f ("staging: rtl8723bs: Fix indenting errors and an 
> off-by-one mistake in core/rtw_mlme_ext.c") for detail.
> 
> I don't know how can you make sure that line 3254 can be true in the for 
> loop.  If the condition never satisfies, then there is an off-by-one 
> access in line 3267.
> 
> If you can prove it, then the patch is unnecessary.
> 

Ugh...  Patch ef9209b642f isn't right.  :(

Do you want to send a patch to change that back to the way it was.  If
not then I can do it.

regards,
dan carpenter


