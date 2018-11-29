Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC36C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB92081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gWGwv0yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeK3CCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:02:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbeK3CCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:02:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEmsKA091507;
        Thu, 29 Nov 2018 14:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1q7darRtWVeRNLf6yabi/rv9PJBKgjPkTapaqzJ8fHQ=;
 b=gWGwv0yy1KqFNZjrBCxj3yPDEELB/H2HRjFmBXGBCfoQeeGX8WC5qct9i47V/WzeAQxB
 /D/yHktSCb5JcNo2M1OPZrCmEEQra11fpI6dHN5uR0u1zR1iG5e1oacH6+rwRFKBTJDg
 rsocwh41lKUg3jJGFyjqy1ixx7K1cuo6Q+HAi3rsc0ufP0DSwz4553CAj6YhUKdFB5sW
 3ieI6QJ/8oXJ22Q/fmmgsnpYRB4VRgQhhCyo9mr6f4XdNPEKcQcewg7+NawGe5iDypy1
 mscxgP4mezVpi98teJz0eP8tS0496IlDByJO0ekWg3KOO0drk7xmsZxLZ7+I9wTu/8Nb cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2ugpbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:56:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATEuTET006487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:56:29 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATEuTjd008819;
        Thu, 29 Nov 2018 14:56:29 GMT
Received: from unbuntlaptop (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:56:28 -0800
Date:   Thu, 29 Nov 2018 17:56:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     kbuild@01.org, kbuild-all@01.org, lee.jones@linaro.org,
        gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 5/7] mfd / platform: cros_ec: move device sysfs
 attributes to its own driver.
Message-ID: <20181129145619.GW3073@unbuntlaptop>
References: <20181129112141.GR3073@unbuntlaptop>
 <43f05051-b1ad-88a9-abea-2111fbc2be94@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f05051-b1ad-88a9-abea-2111fbc2be94@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:43:14PM +0100, Enric Balletbo i Serra wrote:
> I had this question on my mind for some time but I didn't look for an answer, in
> fact, I'm not sure if I already asked you this before, sorry about that if I
> did, the question is. There is a easy way to run your smatch scripts locally to
> check the patch before I send to the ML?

Yeah.  Happy to help.  Run ~/smatch/smatch_scripts/kchecker path/to/module.c

It's slightly more limited because it doesn't have the cross function
DB.  Building the DB is easy, but takes four or five hours these days...
~/smatch/smatch_scripts/build_kernel_data.sh

regards,
dan carpenter

