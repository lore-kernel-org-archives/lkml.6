Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9B8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3B820882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3B820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeG2TE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:04:29 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:58905 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbeG2TE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:04:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 485E3181D341A;
        Sun, 29 Jul 2018 17:33:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: voice89_5708ea456c010
X-Filterd-Recvd-Size: 2910
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Jul 2018 17:33:17 +0000 (UTC)
Message-ID: <233f0f7b1165f6427fa86f026c4e7dcb5cafe35f.camel@perches.com>
Subject: Re: [PATCH] Staging: octeon: Fixing coding style for minor notices.
From:   Joe Perches <joe@perches.com>
To:     Georgios Tsotsos <tsotsos@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Smith <catalinnow@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 29 Jul 2018 10:33:16 -0700
In-Reply-To: <20180729144358.3442-1-tsotsos@gmail.com>
References: <20180729144358.3442-1-tsotsos@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-29 at 17:43 +0300, Georgios Tsotsos wrote:
> Fixing coding style for a few lines that were reported to check from
> checkpatch.pl in minor cases for alignment and ending with parenthesis.
> 
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon/ethernet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 9b15c9ed844b..1e258deecacc 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -141,8 +141,8 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
>  	if (priv->poll)
>  		priv->poll(cvm_oct_device[priv->port]);
>  
> -	cvm_oct_device[priv->port]->netdev_ops->ndo_get_stats(
> -						cvm_oct_device[priv->port]);
> +	cvm_oct_device[priv->port]->netdev_ops
> +				->ndo_get_stats(cvm_oct_device[priv->port]);
>  
>  	if (!atomic_read(&cvm_oct_poll_queue_stopping))
>  		schedule_delayed_work(&priv->port_periodic_work, HZ);

Probably more sensible to use a temporary.  Something like:
---
 drivers/staging/octeon/ethernet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9b15c9ed844b..2febf1229587 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -137,12 +137,12 @@ static void cvm_oct_periodic_worker(struct work_struct *work)
 	struct octeon_ethernet *priv = container_of(work,
 						    struct octeon_ethernet,
 						    port_periodic_work.work);
+	struct net_device *ndev = cvm_oct_device[priv->port];
 
 	if (priv->poll)
-		priv->poll(cvm_oct_device[priv->port]);
+		priv->poll(ndev);
 
-	cvm_oct_device[priv->port]->netdev_ops->ndo_get_stats(
-						cvm_oct_device[priv->port]);
+	ndev->netdev_ops->ndo_get_stats(ndev);
 
 	if (!atomic_read(&cvm_oct_poll_queue_stopping))
 		schedule_delayed_work(&priv->port_periodic_work, HZ);


