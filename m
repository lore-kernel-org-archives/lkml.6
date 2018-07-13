Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D69ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810A4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eINKMbMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810A4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeGMHCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:02:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34382 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeGMHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:02:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6D6mmSh150419;
        Fri, 13 Jul 2018 06:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4QBgxmDDs++p7LUq1dnfA+0H1QRSbE8tSUX3/pQgfnw=;
 b=eINKMbMZ7VWjlpt9AVNS00ggd247gtA1k6iNHIDoZdK4fT3h84eX9+n/7OGZj/XIACz5
 F0NtGZE0zP7LOyiBlz+W+Wt9Jqm6dgULRg2ykPl0Z+CkHLmcFt8t9ddsCfu+duSh7iB2
 bnljXAz0vXnRqj5/5ZC1TLRmMNQpyOE90gznZ7ca7Fu2a1CUg7KZ6IZphh0CFFLgjSl2
 5sDKH5bQmqtT37sDGNfSUQs9U857eZ5/Gc6EPXkssfityC0Z5M+yx+n5/WQqIusriyZe
 Z1YLxfkpE4g6jlf8D7UPhKLFIC4nDqnoWlL2MJYnlbIIBDptFPUQSS6dQTc6dn11R+1f BQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k2p7vpdkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 06:49:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6D6n0bd014108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 06:49:01 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6D6moCf018657;
        Fri, 13 Jul 2018 06:48:51 GMT
Received: from mwanda (/41.202.241.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 23:48:49 -0700
Date:   Fri, 13 Jul 2018 09:48:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] staging: bcm2835-audio: Check if workqueue
 allocation failed
Message-ID: <20180713064816.lv6qhkipi6fpeptj@mwanda>
References: <20180712215417.22491-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712215417.22491-1-tuomas@tuxera.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:54:16AM +0300, Tuomas Tynkkynen wrote:
> @@ -424,7 +411,9 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
>  	int status;
>  	int ret;
>  
> -	my_workqueue_init(alsa_stream);
> +	alsa_stream->my_wq = alloc_workqueue("my_queue", WQ_HIGHPRI, 1);
> +	if (!alsa_stream->my_wq)
> +		return -ENOMEM;
>  
>  	ret = bcm2835_audio_open_connection(alsa_stream);
>  	if (ret) {

This patch is good but if bcm2835_audio_open_connection() fails then
we need to release alsa_stream->my_wq.

regards,
dan carpenter


