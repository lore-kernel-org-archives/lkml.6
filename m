Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735B321908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1voHhon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBGOly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:41:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:41:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x17EYLe2181153;
        Thu, 7 Feb 2019 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oSbzPjNwfzawamtQ8HXIfou5wZ8VdRl8yxBIUDGdRJo=;
 b=W1voHhonqmdLiPJyE1uqlnvXHMKM1wjZ7WEXtvf5woPcDcLpACpYTVm7ApaC0nShsKjH
 Igf32z+vF+FuaI/pxA61MPwQhNNBm4pNRhLT+68FNLOgEwJsB7OdVvv4auaq9kyq/cU6
 54nwe93D5Q/ECZlPMBwMb1s2I2YJoGjaMo0Z30GzX8fvnm5vE07PonvuEqC3swgGtAQr
 87bJDPLi3wNIdCgo0DakApRW6NCbCgBivx/BiJ+kuZjSJEuoFzhLZykerpIgJSegfEyH
 HqER7B8G3RWte2YyQGBmjJBnqu+bK4m133Xpj6TclEOHwt861KkoYMY49ubm6KguN+PB lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qd9arq8xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Feb 2019 14:41:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x17EfnNR028084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 14:41:49 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x17EfmaT024383;
        Thu, 7 Feb 2019 14:41:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Feb 2019 06:41:48 -0800
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
        <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
        <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
        <SN6PR04MB49259233067FBEC4AFA35963FC680@SN6PR04MB4925.namprd04.prod.outlook.com>
Date:   Thu, 07 Feb 2019 09:41:45 -0500
In-Reply-To: <SN6PR04MB49259233067FBEC4AFA35963FC680@SN6PR04MB4925.namprd04.prod.outlook.com>
        (Avri Altman's message of "Thu, 7 Feb 2019 14:15:40 +0000")
Message-ID: <yq1bm3nzmmu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9159 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=649 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902070113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri,

> Is there any reason why this sires is not applied for 5.1?

I haven't had time to review it yet. I'll get there...

-- 
Martin K. Petersen	Oracle Linux Engineering
