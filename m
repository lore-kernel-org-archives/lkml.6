Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QASs7rI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405627AbfBNFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:55:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731876AbfBNFzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:55:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E5sahw138012;
        Thu, 14 Feb 2019 05:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cSGEIOlxJng5JlamEhdqacudmilQXsYAsuejWXRFWw8=;
 b=QASs7rI/P6pjE9bZjpk2pxrdl85VOJ0deW7A1TLF8Jf2y7Jz/0GRh+c2auT/cE89axJe
 dDk/pWAhkJkd5FgxZw1VYFNBczoX+4QKDiQGKc3bwmK+8fP5+03b2jb1KZDQluLYMwrM
 9CpGx2igbWSZvtcnhhZMcliWdT32ABDmwKf+NzSEu3v73XkyI4I6LGmAnbu1Z0DgCfIa
 Ht1jbEJ8+c3agelo1Z4R8ROFwq6PIqXjXwQtP7EAgsShO1eXu/P8OBHQTmJkSnBBuMk+
 tMvdA60h9UdbqI430AC4pr6v4Ft0D0i8PuHiadXpZ6a5YP9AboE1BPtzwQXvRSMmQ0lf 4A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhreknyeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 05:55:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E5t7vd008363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 05:55:07 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E5t6jM013849;
        Thu, 14 Feb 2019 05:55:07 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 21:55:06 -0800
Date:   Thu, 14 Feb 2019 08:54:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove redundant null check on pointer
 sess
Message-ID: <20190214055457.GA2326@kadam>
References: <20190213135335.4790-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213135335.4790-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=829 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:53:35PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The null check on pointer sess and the subsequent call is redundant
> as sess is null on all the the paths that lead to the out_term2 label.
> Hence the null check and the call can be removed.
> 
> Detected by CoverityScan, CID#1420663 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/qla2xxx/qla_target.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> index 6b8c655d9eb4..9af329a5ed90 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -6396,8 +6396,6 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
>  	return;
>  
>  out_term2:
> -	if (sess)
> -		ha->tgt.tgt_ops->put_sess(sess);

Several places do:

		sess = NULL;
		goto out_term2;

We could remove the "sess = NULL;" because it's not required now.

>  	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
>  out_term:
>  	qlt_send_term_exchange(ha->base_qpair, NULL, &prm->tm_iocb2, 1, 0);

regards,
dan carpenter
