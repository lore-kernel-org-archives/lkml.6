Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B992C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EEF20883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cGuIIoyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EEF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeGIKem (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:34:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57080 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:34:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69AXelp117079;
        Mon, 9 Jul 2018 10:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Bm1ydDNlBxYE36W3v6TK5fuzay9vLnl35Qpwh6XcDiI=;
 b=cGuIIoyrULJyikGPNGZZwZ3+so62RHi/+gTHukdjCj+d+sq6BQZ6YgV1mQNUukGlnqxW
 kwaXsgqIfK1iyHaqUNiJ2x80qtntS8swBUoGmgDIwKxcpmjabDMnJ3YsHci/LDVcUza2
 jYhLKSu4+L4X5S0u9wnmY8NSyNXMCoKZkV29Sv6Ox73+1WN64KE5YKJ1qF+FMybTEmlV
 dDzM16tlGa0aM29pFLBr7MPBKSczZWD5eZYLTc2J6kyooCxpw56piMcOeN4C4xAnw9Ra
 el9xiWgbv1dP1GwDsv/qavQla7ddHkaRt4z+/M4JN/3prSj9LC07TJxtW3pgv1GWViYM 5g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k2p75uk2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 10:34:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69AYSt2013308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 10:34:29 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69AYQoT006707;
        Mon, 9 Jul 2018 10:34:26 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 03:34:25 -0700
Date:   Mon, 9 Jul 2018 13:34:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaya Durga <rjdurga@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        deanahn@gctsemi.com, jonathankim@gctsemi.com, quytelda@tamalin.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Message-ID: <20180709103418.43vfm3af5fnaroar@mwanda>
References: <20180709100020.7399-1-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709100020.7399-1-rjdurga@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:30:20PM +0530, Jaya Durga wrote:
> From: root <root@boss.chennai.cdac.in>

Please send the patch to yourself first and make sure it's right.  Then
resend to the list.

> 
> CHECK: Macro argument reuse 'gdm' - possible side-effects?
> 
> convert GDM_TTY_READY to gdm_tty_ready static function
> to fix checkpath check
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index bf554f7c56ca..5de1940c1f79 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,7 +27,11 @@
> #define MUX_TX_MAX_SIZE 2048
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +static unsigned int gdm_tty_ready(struct gdm *gdm)
> +{
> +return (gdm && gdm->tty_dev && gdm->port.count);


This needs to be indented.


regards,
dan carpenter

