Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7189C208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u9w9sJhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7189C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeFRO6P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:58:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39418 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934674AbeFRO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:58:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5IErx12193551;
        Mon, 18 Jun 2018 14:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ULtF6KwqxbqXxT4CS8lZPLfh2RSvx/WI8k6OKUDh1R4=;
 b=u9w9sJhDznntFGyA5A8g2uVlm1Pujy1zYwF3hl+RJ2TeQCq031dUz/bY2+ECYAO9z4m8
 KWS4qnlpiWYcuciiFBuhAHJYBTpbJ2tIcQxVDC0pJhkeJaO9A912EXSdwKnfgxO+rlaD
 0vvQTAe+CyKYKDlAlJENltkP45Fdtxfn9cR+VZI1EqRaSjzPD/JCDnQE8+Au/e98bVFp
 P3QRwATj4CmE0UqSztzxRhrjyhB6Cl+3PqCcVrRs1Qi/xgIFkP8Ze6JqFiU3H3vBkwag
 Yl3fnxSfIgjaFGZjznXPYFOADESOT2Iv818U/eCYtWNxSAgWUpyUNjh1f29JOVVq81vg cw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6xmde4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 14:58:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5IEw3Id018627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 14:58:04 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5IEw3Va007999;
        Mon, 18 Jun 2018 14:58:03 GMT
Received: from mwanda (/197.157.0.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 07:58:02 -0700
Date:   Mon, 18 Jun 2018 17:57:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        y2038@lists.linaro.org, devel@driverdev.osuosl.org,
        Micky Ching <micky_ching@realsil.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtsx: remove rtsx_trace() and related code
Message-ID: <20180618145754.kxos3ecd3q3eeigr@mwanda>
References: <20180618143802.4124691-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618143802.4124691-1-arnd@arndb.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=665
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -117,7 +112,6 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
>  	enum dma_data_direction dir;
>  
>  	if (!buf || !buf_len) {
> -		rtsx_trace(chip);
>  		return STATUS_FAIL;
>  	}
>  

You're introducing a bunch of checkpatch.pl warnings.  Normally we would
ask you to not do that...  I don't care too much because someone will
eventually fix it, but still...

regards,
dan carpenter

