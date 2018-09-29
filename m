Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC12206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC12206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeI2QC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 12:02:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeI2QCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 12:02:25 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE531D4F;
        Sat, 29 Sep 2018 09:34:40 +0000 (UTC)
Date:   Sat, 29 Sep 2018 02:34:39 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubham Singh <dhoni.singh094@gmail.com>
Cc:     forest@alittletooquite.net, devel@driver.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6656: baseband.c: fixed unnecessary
 paranthesis
Message-ID: <20180929093439.GA30302@kroah.com>
References: <20180929085854.15880-1-dhoni.singh094@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929085854.15880-1-dhoni.singh094@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:28:54PM +0530, Shubham Singh wrote:
> From: shubhsherl <dhoni.singh094@gmail.com>
> 
> Fixed a coding line issue.
> 
> Signed-off-by: shubhsherl <dhoni.singh094@gmail.com>

We need a real name please.

> ---
>  drivers/staging/vt6656/baseband.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index b29ba237fa29..540cc9eafd07 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -382,8 +382,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
>  
>  	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
>  
> -	if ((priv->rf_type == RF_AL2230) ||
> -	    (priv->rf_type == RF_AL2230S)) {
> +	if (priv->rf_type == RF_AL2230 ||
> +	    priv->rf_type == RF_AL2230S) {

Huh?  What coding style issue caused this?  The original code is fine,
don't you agree?  This type of change just makes it harder to work with
over time (hint, you have to go look up the order of operations all the
time...)

thanks

greg k-h
