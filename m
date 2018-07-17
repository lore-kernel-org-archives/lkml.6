Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A481D20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBbjbm8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A481D20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeGQLJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:09:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbeGQLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:09:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HATAxV063952;
        Tue, 17 Jul 2018 10:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4Nq4C2O90Kyp0AweraSZAd+/ISt5heZNlul11V9xvO4=;
 b=gBbjbm8bOf4oKku179ASV5A0qsaxFQHxxyFt0A3QhwtDAWuVs9aJe2+Lymp2swPL6Beb
 0pEhfd7ouOheYcR+obP7GqDq7rK/jr6c6kMWMeoFrG0zm4fHSxh0mWDUs5F1l3iTcIse
 Qx0Ezl6z/fFvk2+x6vp1YcMOR9pbgVVXWpvuwydwT7EUBAmCVG2VUy/lqD8zNpOmwrHs
 NMnj8QGbRNwPEwrLqY91doiVVEBXvhvCiVjkFMDuwEFi4XJz042GLOYhg9vlQ2MNOuj7
 pPjjSkBmPslZJn8gyVxisNWeXLrPEM+oMBUgIf+zwDqOn28gboIoGMyGDFOWPAkDttUA eQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k7a3jr3fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:37:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HAbPYa028913
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:37:25 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6HAbPKC025399;
        Tue, 17 Jul 2018 10:37:25 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 10:37:25 +0000
Date:   Tue, 17 Jul 2018 13:37:15 +0300
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
Subject: Re: [PATCH 27/32] staging: gasket: remove else clause after return
 in if clause
Message-ID: <20180717103715.k3cu7jiv4333aq4k@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-28-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-28-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:21PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Else after return is unnecessary and may cause static code checkers to
> complain.
> 
> Reported-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Simon Que <sque@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> index 2a27db658a4e4..080bf78c22c3b 100644
> --- a/drivers/staging/gasket/gasket_page_table.c
> +++ b/drivers/staging/gasket/gasket_page_table.c
> @@ -598,9 +598,8 @@ bool gasket_page_table_is_dev_addr_bad(
>  	if (gasket_addr_is_simple(pg_tbl, dev_addr))
>  		return gasket_is_simple_dev_addr_bad(
>  			pg_tbl, dev_addr, num_pages);
> -	else
> -		return gasket_is_extended_dev_addr_bad(
> -			pg_tbl, dev_addr, num_pages);
> +	return gasket_is_extended_dev_addr_bad(
> +		pg_tbl, dev_addr, num_pages);

This isn't the normal way to break up a line.  It might even cause
problems if you run with checkpatch.pl --strict.  And anyway this fits
on one line:

	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);

But normally we would do:

	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages,
					       wha'ever, blah, blah, blah);

There are times when that looks a bit ugly if the variable names are
long so we could do:

	return gasket_is_extended_dev_addr_bad(
				long_variable_name_asdfasdfaasdf,
				pg_tbl, dev_addr);

But generally try to get a couple tabs in from the start of the function
name.

regards,
dan carpenter

