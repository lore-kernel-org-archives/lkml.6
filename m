Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D523C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AA9208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldxTFiz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AA9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeFLJIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:08:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47170 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeFLJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:08:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5C96D6X111092;
        Tue, 12 Jun 2018 09:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=mO5TOHCFRt4kWia4ARR8YN+SmS2aNCVYqyMqKP7qhbc=;
 b=ldxTFiz84xzWz7UrClHcNag9/zMPeNYzu4bFm9Gk6qo+Savtp+HdCJeFN4+y7m4T9FXW
 JdQliwtqcbxpICJxa9cmuH19Y1AIeNxygJai1Tzn8+Ta5eSrE22fgwRGwiRpVQU9r5zI
 tjKN/9crLKw0SNEeGjc/75fP1Ujy89HdNKPKe6+VVRPRlPVsWReaeI3LbToplNCkFGtm
 2x7wdmkCRPxFiN4AkSBexIJAoeF1XCNIJjSJnhKL7+vqZZ9lsAkLnD55e3MTuqQzIFPv
 bCeVT8Yt5RbT2yFJxAyqbRK8LywmslE6QPRH82B7nJwXlvtQzj69GOeqCjzuzQBTezhv tA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jg7hx1351-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 09:07:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5C97utY002308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 09:07:57 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5C97sf2005565;
        Tue, 12 Jun 2018 09:07:54 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 02:07:53 -0700
Date:   Tue, 12 Jun 2018 12:07:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [media] cx18: remove redundant zero check on retval
Message-ID: <20180612090745.2k6jmljl73bwj6lm@mwanda>
References: <20180611151045.22535-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611151045.22535-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You accidentally committed several changes...

regards,
dan carpenter

On Mon, Jun 11, 2018 at 04:10:45PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for a zero retval is redundant as all paths that lead to
> this point have set retval to an error return value that is non-zero.
> Remove the redundant check.
> 
> Detected by CoverityScan, CID#102589 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/media/firewire/firedtv-fw.c  | 3 +++
>  drivers/media/pci/cx18/cx18-driver.c | 2 --
>  drivers/regulator/vctrl-regulator.c  | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
> index 92f4112d2e37..eed55be21836 100644
> --- a/drivers/media/firewire/firedtv-fw.c
> +++ b/drivers/media/firewire/firedtv-fw.c
> @@ -271,6 +271,9 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
>  
>  	name_len = fw_csr_string(unit->directory, CSR_MODEL,
>  				 name, sizeof(name));
> +	if (name_len < 0)
> +		return name_len;
> +
>  	for (i = ARRAY_SIZE(model_names); --i; )
>  		if (strlen(model_names[i]) <= name_len &&
>  		    strncmp(name, model_names[i], name_len) == 0)
> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> index 8f314ca320c7..0c389a3fb4e5 100644
> --- a/drivers/media/pci/cx18/cx18-driver.c
> +++ b/drivers/media/pci/cx18/cx18-driver.c
> @@ -1134,8 +1134,6 @@ static int cx18_probe(struct pci_dev *pci_dev,
>  free_workqueues:
>  	destroy_workqueue(cx->in_work_queue);
>  err:
> -	if (retval == 0)
> -		retval = -ENODEV;
>  	CX18_ERR("Error %d on initialization\n", retval);
>  
>  	v4l2_device_unregister(&cx->v4l2_dev);
> diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
> index 78de002037c7..044e5a5ca163 100644
> --- a/drivers/regulator/vctrl-regulator.c
> +++ b/drivers/regulator/vctrl-regulator.c
> @@ -340,7 +340,7 @@ static int vctrl_init_vtable(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (rdesc->n_voltages == 0) {
> +	if (rdesc->n_voltages <= 0) {
>  		dev_err(&pdev->dev, "invalid configuration\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
