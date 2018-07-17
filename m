Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92529ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4353120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9Fl80E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4353120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeGQK6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:58:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeGQK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:58:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HANwBO098047;
        Tue, 17 Jul 2018 10:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xywr/7YVgXemWvCN3THda6Xxh5CLGGvsKVi1dJsBYrA=;
 b=Z9Fl80E4JIXuLI/+kccipc2+4JozHl0ICImbvtlJKZ8EgKUXCylTdSRhdPytLVLiJcWJ
 QFg+xqMALdgoHIGF05Apu4y3UlycoyrkqzG2ITmCOZ3ln9VtAmBwYRKBAHZEHAr36Q2O
 SxJjKosK04VgLFcrL0VS7oQTTGG9CQeN/rCyUCI3PRYesEZHL+rp41EHCK9AJR99CAtQ
 Do9CSiEYq51I3zzdrj9zuQC7Gi38zMJdbDtvcdHeHVskEWEykntCw/2AjU0KVKNX/qJB
 QHbiKEhBiJ8JrGs27lZpt6QtHUQliHdvFNDr8SNa0P0HszXDiZIZzEPGX+D3303eP2gf yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k7a3401w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:26:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HAQjw3031633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:26:45 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HAQiqQ014556;
        Tue, 17 Jul 2018 10:26:44 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 03:26:44 -0700
Date:   Tue, 17 Jul 2018 13:26:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
Message-ID: <20180717102634.rmywmcjzoelok3b7@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-18-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-18-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:11PM -0700, Todd Poynor wrote:
> @@ -629,7 +630,6 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>   */
>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>  {
> -	struct gasket_dev *gasket_dev = filp->private_data;
>  	fmode_t write;
>  
>  	write = filp->f_mode & FMODE_WRITE;

This should have gone in the earlier patch.  When you spot something
like that then create a separate patch for it and use `git rebase -i` to
fold it back into the original.

regards,
dan carpenter

