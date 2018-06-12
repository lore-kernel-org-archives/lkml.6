Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7BE1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE62208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPwSt5x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE62208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeFLI4f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:56:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933439AbeFLI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:56:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5C8taxF146464;
        Tue, 12 Jun 2018 08:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=M+RUTheYD/unWoN4X5PIzJQzkibbb/dZxi8qMCDBkYQ=;
 b=LPwSt5x9gCfcSUfQlOPMhMJNb9WmA/aFs2rvzCBsMM6NPD+S0c3am2LprUAvPDpvHGXi
 Mow/nqJlynO3jWCUQaXblpbnfffoT0rqVYxq+P5d5+vBA/qdJzCk6qKZq8/vaeuG/lyM
 tPDorj+hSM5YQACXd/6Bb/DW4gCu7J9RB7OhfQzf21X8T87X1u9+buuCBPXExU0fVIRy
 Dt/1kplMxslQTio6excxS7hs4cruAurr3Q41uAbSjzi9FmJKKAixTtTThma/urW4Vi9u
 L0z1ermVGJGlHM7HZSyPdnMbVKPQDMVpxTpJJ0s92uLWfnmlTKLAKMtrybhpMtqwqr19 hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jgecxgacu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 08:56:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5C8uPt5018796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 08:56:25 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5C8uOSW031399;
        Tue, 12 Jun 2018 08:56:24 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 01:56:23 -0700
Date:   Tue, 12 Jun 2018 11:56:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chris <eklikeroomys@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Simo Koskinen <koskisoft@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180612085616.ukbpgtx7s4nxiekz@mwanda>
References: <1528554204-4388-1-git-send-email-eklikeroomys@gmail.com>
 <20180609140527.GC28854@kroah.com>
 <20180610103001.GA7804@kerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610103001.GA7804@kerdev>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=665
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You haven't been sending the v2 and v3 patches in the right way.

Take a look through the email archive and see how this is normally done.
Also google it:
https://www.google.com/search?q=how+to+send+a+v2+patch

On Sun, Jun 10, 2018 at 12:30:01PM +0200, chris wrote:
> Hi Greg,
> I've added changelog text to the patch below. Appreciate your 
> feedback!
> Regards,
> Chris Opperman
> 
> >8----------------------------------------------------------------------8<
> 
> Improved the readability of comedi_nsamples_left:
> a) Reduced nesting by using more return calls.

nit: return isn't a function so it can't be called.

> b) Separated variable declarations from code.

It was separate in the original code too.

> c) Using kernel integer types.

The original types were fine/better.

The rules are that we don't like uint32_t and the reason for not liking
it is that we looked through the kernel code and standardized on what
was most common...

Generally u32 and friends mean that the hardware or network protocol
specifies the number of bits.  That's especially true for s32.  If you
see code using s32 when it's not tied to a hardware spec then that's a
sign that the code is written by an insane person and it's a tricky
situation to deal with.

Some other reasons to use u32 is because it's shorter to type than
unsigned int and because of line lengths...  I've sometimes done that.
But it's perhaps lazy.

> 
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
> ---
>  drivers/staging/comedi/drivers.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
> index 9d73347..3207ae2 100644
> --- a/drivers/staging/comedi/drivers.c
> +++ b/drivers/staging/comedi/drivers.c
> @@ -468,26 +468,25 @@ EXPORT_SYMBOL_GPL(comedi_nscans_left);
>   * Returns the number of samples remaining to complete the command, or the
>   * specified expected number of samples (@nsamples), whichever is fewer.
>   */
> -unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
> -				  unsigned int nsamples)
> +u32 comedi_nsamples_left(struct comedi_subdevice *s, u32 nsamples)
>  {
>  	struct comedi_async *async = s->async;
>  	struct comedi_cmd *cmd = &async->cmd;
> +	u32 scans_left;

I would make scans_left an unsigned long long so that you can remove
the cast when you do the multiply.

> +	u64 samples_left;

Nothing wrong with unsigned long long.

regards,
dan carpenter

