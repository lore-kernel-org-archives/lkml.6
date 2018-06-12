Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9DEBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564E22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mo4RvXbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbeFLLet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:34:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeFLLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:34:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CBLnjp050224;
        Tue, 12 Jun 2018 11:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=RpPrh9cbJv9CqKMPtNVmT36hYkP9sYHqq7wfEvwMPCg=;
 b=mo4RvXbeLz0JvbuQarvGyENBFHu3NfMm5zZ64b2KHkfAobLpNePX+/IVXBnDOL+EqwNz
 waLzE7tDFObNGcU0uaQFHjBbyS3WxTmOE6kyg4a/+GabV4KKfTTN3EFz42kCGrClL86o
 Q3dhVfwaMv+nMqoVrZCgFmST7btb4p7ZY0k67Z5OxLVyI1gJrlH/Brec6Sxmkyfd4zj5
 DuBbeh0TF1BPG1Ib+C2dwr1fk5deKHv/G9sKp9/dLBlCeTbV+CTrj/5kQsuOHay6HaOS
 HIn2oBok9a+bNFredMjDkY1o2TESCfuhpRrYTnKv6sSmmIUiQX599upacpAFXhzYRUOY 8w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jgecxgtcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:34:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CBYbej030045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:34:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5CBYarY027120;
        Tue, 12 Jun 2018 11:34:36 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 04:34:36 -0700
Date:   Tue, 12 Jun 2018 14:34:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtl8712: add error handling for register_netdev
Message-ID: <20180612113422.tkta6ynquy6lfy7s@mwanda>
References: <1528773525-37564-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528773525-37564-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=562
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:18:43AM +0800, Zhouyang Jia wrote:
> When register_netdev fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling register_netdev.
> 

It doesn't add any error handling.  It just adds an error message.

The error handling does look sort of messed up, but this isn't a useful
patch.

regards,
dan carpenter

