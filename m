Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027021871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KjqjwENl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfABJq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:46:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34828 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfABJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:46:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x029cgca133215;
        Wed, 2 Jan 2019 09:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZvvPZnoXljS9BiJp9pRGsMPlW61ZiiU4SzM1RsqDyeg=;
 b=KjqjwENlR4RMbNgvkqJVJjbwsECAh4FpC69enrwYUdtxuC7uvEhtPZ7f2BjJE1MAvavP
 fZCQ/gPQ46jT/QgIBnMbAJpALw7TCNgygf1XcDBbh+kpt3LrGLqxP8S3NbSWpBqbuZ6K
 vD2255r4WdHq+rZPAJ7Rsy3DfnmVtJUJJq+hdGpS/2ZS136LenJ39ffV6WaIAZghZuW1
 SRtO+vaDfBY6IrEIu2eHqnHam7VkV4+GB4gKffZgr0kbaQeagalrHQKraC6MpKmpUHLJ
 ct57GDX7ModRYqroAJejzkkw0HhHYDKU16mfp9RCSGvzUOlj544+wZfiByUWRpkpR0QD aw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pp1jr17rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 09:46:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x029kkIe018685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 09:46:46 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x029kkOP027923;
        Wed, 2 Jan 2019 09:46:46 GMT
Received: from kadam (/197.157.0.49) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 02 Jan 2019 01:46:35 -0800
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20190102094620.GE3781@kadam>
Date:   Wed, 2 Jan 2019 01:46:20 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc:     osdevtc@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: prism2fw.c: Fix "Possible unnecessary
 'out of memory' message" checkpatch.pl warning"
References: <1545667888-38999-1-git-send-email-prathameshdeshpande7@gmail.com>
In-Reply-To: <1545667888-38999-1-git-send-email-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is too long.

On Mon, Dec 24, 2018 at 08:11:28AM -0800, Prathamesh Deshpande wrote:
> This patch removes unnecessary out of memory warning
> message from wlan-ng prism2fw.c file.
> 
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2fw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
> index bb572b7..c040066 100644
> --- a/drivers/staging/wlan-ng/prism2fw.c
> +++ b/drivers/staging/wlan-ng/prism2fw.c
> @@ -557,7 +557,6 @@ static int mkimage(struct imgchunk *clist, unsigned int *ccnt)
>  	for (i = 0; i < *ccnt; i++) {
>  		clist[i].data = kzalloc(clist[i].len, GFP_KERNEL);
>  		if (!clist[i].data) {
> -			pr_err("failed to allocate image space, exiting.\n");
>  			return 1;
>  		}

Remove the curly braces.

regards,
dan carpenter

