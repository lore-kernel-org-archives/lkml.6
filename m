Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC121888
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K7vfaQa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CC121888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeF3TdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 15:33:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeF3TdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 15:33:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5UJU66a014095;
        Sat, 30 Jun 2018 19:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=nfLYEXe7JXyeQbPcS+B8Fb3OLb9n0f+MLF4TCgxxS4s=;
 b=K7vfaQa02KrJEedxS1pqTT9cCNubyKa4hBZkqLu58dCHQcVOXo37B8IVhC2QbDN6Q8/o
 qv4wTt0K2Hs1VlDXUaRWrgp9UGGXgbp/0pG8eMDB9UgX4dw0vVCgXpHiH1tfFBz92gjN
 W1b7UxryG9d1fzNd1b8XpP5pVQ9dzjhaJOKEwWBQ8mTwY6dZe3JiK/5yy9EqSPPEfYTP
 aHvY7ECbN1JMwXlAoCneMXnRr+pezIu0z5IJ3KSsARNBUMcLVwtar1nPEpsS7+Z14Hha
 luOXVBDyF1v2bq+IJGdB2OXsZby7dUmCzvjY2etinvzgJdqDDwfpgqXa0/j8aK3NEPkg rw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jx2gprxqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 19:32:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5UJWxuJ020953
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 19:32:59 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5UJWwYr013539;
        Sat, 30 Jun 2018 19:32:58 GMT
Received: from mwanda (/197.157.0.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 Jun 2018 12:32:57 -0700
Date:   Sat, 30 Jun 2018 22:32:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Vernia <peter.vernia@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Replaces "unsigned" with
 "unsigned int", fixes mixed indentation, and puts spaces after commas.
Message-ID: <20180630193245.qtowzg7cecjk27ek@mwanda>
References: <1530379055-6713-1-git-send-email-peter.vernia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530379055-6713-1-git-send-email-peter.vernia@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8940 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=626
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806300230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 01:17:29PM -0400, Peter Vernia wrote:
> Signed-off-by: Peter Vernia <peter.vernia@gmail.com>

The subject is over 72 characters or whatever the limit is and there
isn't a commit message.

regards,
dan carpenter

