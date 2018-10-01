Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06CC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960C2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvRHQ1H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJAQ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:29:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeJAQ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:29:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w919nAJ4124932;
        Mon, 1 Oct 2018 09:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZltC4BgGNykYL6ehmAXhpCYXTxjo/xz5TWGDHnZrxCw=;
 b=cvRHQ1H4Dy4TCpNR8OLyErWWWeLdPtmQp1QcnAOMU+6WEuPV0O/Kfy3eNBu0EHheNVCe
 NFj2ErjnmvS5PtD06BlQ2nKhKASNbUuxCDQDE4S5CBRSsQXsmoot5ZOpAPPOEV1ox1oE
 tEs8o0RrjccGW2vLt9ZAybE1apmW+6hWYziU51fp+eQ0BwnEKtn2Z7YMQQwdRJMluyXO
 cxLNzMtmRQOzhO9IdvbSnSQXbNEN4Q+ZnWbM0mssrOobem0MN64RSJsFsmbff7FiY4K7
 1c+nLkusBTkyJ2B+iQCIJlXtNQfdJlpf1ojig/qM/iSrXFgqKndLWy4P6K+JvZOwnrDs FQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mt21qnupv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 09:52:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w919qMiH001497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 09:52:22 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w919qLRh012303;
        Mon, 1 Oct 2018 09:52:21 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 02:52:21 -0700
Date:   Mon, 1 Oct 2018 12:52:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: media: replaced deprecated probe method
Message-ID: <20181001095214.pjp7cshbi3nxq6w5@mwanda>
References: <20181001094229.9148-1-st5pub@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001094229.9148-1-st5pub@yandex.ru>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:42:29PM +0300, Andrey Abramov wrote:
> Replaced i2c_driver::probe with i2c_driver::probe_new,
> 	because documentation says that probe method is "soon to be deprecated".
> And fixed problems of the previous attempt.

I'm sorry to complain again...  Please, don't reference the "previous
attempt" in the commit message.  The previous attempt is gone so no one
will remember what you are talking about after tomorrow.  This is how
you resend a patch.

Change the subject to:

Subject: [PATCH v3] Staging: media: replace deprecated probe method

> 
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> ---
>  drivers/staging/media/bcm2048/radio-bcm2048.c | 5 ++---

Then right after the --- line put:

v3:  fix commit message

That part of the commit message will be removed when we apply the patch.

regards,
dan carpenter


