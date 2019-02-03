Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A69BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F57217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1SKMgMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBCL3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 06:29:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBCL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 06:29:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x13BTG2D136902;
        Sun, 3 Feb 2019 11:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wbbvjChGLJWh1uIRfkBvRjZCsZ9jM8dRUzRhQ3wtqoY=;
 b=p1SKMgMjKo/6cQ391/lKACXoKDTU9nC9VsxFsJIOTg3jQcvUXwjUa6H+y3rp28QEkNQu
 mbKv8bHg9cwge9XM4WGpVsFX2mCeBLAF3w3oh1LBMeYBxCQclCIZKO/5wd5AXUARZ2vh
 vnQOJARx3sJI1N83UyKbSSyLyQILTBgEEpmL7zFxfoxfutzsQz5Rax8asKyu1AMLj8Bx
 MPN+JGiYUrtF5JjtJXz7LDjpvB6WnV7NGEPDIypplmu9c5VqBV6dxA9gUYfZuJaR28xX
 2Bs+IAqJ54kDbqxIqLevhGAql2HMB0KtheuVshLQ978MN9c/jIRjQ0yvx6LOwZyqKWgb 0Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qd98mst63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Feb 2019 11:29:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x13BTFKd028685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Feb 2019 11:29:15 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x13BTDMD025576;
        Sun, 3 Feb 2019 11:29:13 GMT
Received: from kadam (/197.157.34.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 03 Feb 2019 11:29:13 +0000
Date:   Sun, 3 Feb 2019 14:29:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: dt2811: fix integer overflow in multiply
Message-ID: <20190203112904.GA2563@kadam>
References: <20190202215916.25753-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202215916.25753-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9155 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902030098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 09:59:16PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Multiplying two unsigned ints leads to an unsigned int result. The
> intention is that the result is a unsigned long long, so to fix the
> overflow cast the div to an unsigned long long to ensure that the
> multiplication is on unsigned long longs to avoid overflow.
> 
> Detected by CoverityScan, CID#1357597 ("Unintentioal integer overflow")
> 
> Fixes: f2975a9b2ab9 ("staging: comedi: dt2811: add async command support for AI subdevice")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/comedi/drivers/dt2811.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
> index 05207a519755..820e75f850ff 100644
> --- a/drivers/staging/comedi/drivers/dt2811.c
> +++ b/drivers/staging/comedi/drivers/dt2811.c
> @@ -323,7 +323,8 @@ static unsigned int dt2811_ns_to_timer(unsigned int *nanosec,
>  		for (_mult = 0; _mult <= 7; _mult++) {
>  			unsigned int div = dt2811_clk_dividers[_div];
>  			unsigned int mult = dt2811_clk_multipliers[_mult];
> -			unsigned long long divider = div * mult;
> +			unsigned long long divider =
> +				(unsigned long long)div * mult;

The max "div" can be is 12.  The max "mult" can be is 10,000,000.  So
this is a false positive because there is no overflow.  The code is not
complicated.  Unfortunately, Smatch has the exact same problem...

We should fix the checker instead of the code.

regards,
dan carpenter

