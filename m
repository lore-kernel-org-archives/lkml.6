Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54A62083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jvdQLijh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937335AbeFSHn3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:43:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937104AbeFSHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:43:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J7ctVf080492;
        Tue, 19 Jun 2018 07:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=0cFCnK7qB3cUIFEY95glyAX4VU2EWD49odjxtIJ3NDs=;
 b=jvdQLijhjEA+OYKnubmW5b04R97zMr90ojA/nM7gG56xCoGKkKQYrrNuC/M3anjSHzxr
 G5e1gP5TU79OIeDdKNDO8FZ7dprJPa+NjG+qgQQrhFW8JRFM/bLGUpRtivs52yoreRXa
 Enwjo4h8NKAADPBPpwudwqsYv1vveofSiByVVSi8Mo8FVK2salV1oiUaN28crSn6TWbG
 DT+Bqxy+MD7BpyvSh/HR3+7PN0cdcbrfy7qgwzsPaSvRsCxEj3fwuG0yvChFPtghSP60
 lFrrd2tXMLUotkLM1MX/949xERoqp1FaEOkhTiIjOivBDrSIqTHijFSf09THvTcnrely Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwpwhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:43:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J7h8eE028352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:43:08 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5J7h6Da029189;
        Tue, 19 Jun 2018 07:43:06 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 00:43:06 -0700
Date:   Tue, 19 Jun 2018 10:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devel@driverdev.osuosl.org, ldv-project@linuxtesting.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: Re: your mail
Message-ID: <20180619074248.ssu5kza6wdwhzdqi@mwanda>
References: <CAHp75VetOuS+H4GU9UW-Ekczs22-Ju++jXWdvkMJGktbumDzwQ@mail.gmail.com>
 <20180613173128.32384-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613173128.32384-1-vasilyev@ispras.ru>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=48 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=426
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this.  This is a lot of work.

On Wed, Jun 13, 2018 at 08:31:28PM +0300, Anton Vasilyev wrote:
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 70e0b8623110..69e6abe14abf 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -857,7 +857,7 @@ static int rtsx_probe(struct pci_dev *pci,
>  	dev->chip = kzalloc(sizeof(*dev->chip), GFP_KERNEL);
>  	if (!dev->chip) {
>  		err = -ENOMEM;
> -		goto errout;
> +		goto chip_alloc_fail;

The most recent successful allocation is scsi_host_alloc().  I was
really hoping this would say something like "goto err_free_host;" or
something.  The naming style here is a "come from" label which doesn't
say if it's going to free the scsi host or not...  It turns out we don't
free the the host, but we should:

err_put_host:
	scsi_host_put(host);

The kzalloc() has it's own error message built in, and all the other
error paths as well so the dev_err() is not super important to me...

Killing the threads seems actually really complicated so maybe we should
just have a separate error paths for that.  I'm not sure...

regards,
dan carpenter

