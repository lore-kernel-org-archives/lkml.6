Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A013C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF72168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZA/phyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeI1AYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:24:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54186 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeI1AYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:24:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so6828434wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x7nsDjK2N9dHZ2Xkgqd7jP2hfoyIt7k0fYpYz1TXKwA=;
        b=DZA/phyuKL8Y/m+HJt7sC84CHIFZxpOX0CbxUgZ58fITfDcIr3r10nNouF9qbyqKy+
         sn7boA3iPvpvmtdrJwLysfg7DqPWw5umKNQz9GdsKZEj2C1fH7cNRzDvxxlXiYpuiyHD
         iGwgkhmmKPXGh+v2VjoEyZF7wgOQ8lOyS9gsUqVoqEpJxP5AE8umu29gbT88qJJX1si4
         sW5yKU3pWjiy3yipzSiIzbgk2FcairGjXnbgHN8jtj+WSitFlHXElin8ApnHl/fyxs9z
         oJzuQSRz7z97nMUHGAxkJz7WvcRj27/lHewX9Y7J8sTA5TEByglWVNZdTFToncCWUnxG
         eHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x7nsDjK2N9dHZ2Xkgqd7jP2hfoyIt7k0fYpYz1TXKwA=;
        b=H28T6bbg+RZ7rq9boNDu/BJfI0CSZNY/zhFDoytwfcItMLhIaEgOK6FmYRppHBdlts
         HyD5PbYd38SgL4ZndDvqCDhIeshCfOcUHbtCzVPdlcSoiuxzNPImaNU5ijk6bk68ZzXs
         bdBasZ7qenwFhcSXuGNd2jx082PbAHLJu5nzEhm0Pe5InkHPjNdGuOeqe1ZG+0b4FQ4a
         ZmSwRZ2GywkPeAhHPWM0wkHkqpChf2aZURk52tnGN6vtTjU4jMFjYSS3SnNv9GcGCd9v
         pZk/OYBvGjvt0g0gaGoXpztdnfBaf3AdqX6kWQYlUY99pmx058hS0BeD+wWwCJBMLbDD
         zNZA==
X-Gm-Message-State: ABuFfoitIeTmWnoTF0MhWHz1joR4dufV+/jaYOWez3mIOietjUoWaFHc
        fFNF9MJMTAnP5+tam6kn3GQIG8Ww
X-Google-Smtp-Source: ACcGV63qhoGM308LX4lLR+mR1jzH4TGJ7772FaikG88ps8og56nvCNUXJpyXKM7Dt/5IV9q+nbdtTw==
X-Received: by 2002:a1c:adca:: with SMTP id w193-v6mr8074696wme.147.1538071485735;
        Thu, 27 Sep 2018 11:04:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id 144-v6sm3887625wma.19.2018.09.27.11.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:04:45 -0700 (PDT)
Date:   Thu, 27 Sep 2018 19:04:43 +0100
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: ks7010: Add null pointer check for skb
Message-ID: <20180927180443.yjqycqa7jir6rb57@localhost.localdomain>
References: <20180927151614.25470-1-qader.aymen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927151614.25470-1-qader.aymen@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retraction: in hindsight I see that with the current usage of this
function, there is already a check for the socket buffer so this check
is unnecessary. However, I'm not sure if it's considered good practice
to keep this check anyway--in any case, ENOMEM isn't the right error
to return.

On Thu, Sep 27, 2018 at 04:16:13PM +0100, Aymen Qader wrote:
> Add a null pointer check for the socket buffer in ks_hostif.c to avoid a
> possible null pointer deference, and remove a later now-redundant null
> pointer check.
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
> v2: Remove redundant pointer check
> v3: Style fix
> 
>  drivers/staging/ks7010/ks_hostif.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 0e554e3359b5..95b6c7557e84 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -1011,6 +1011,11 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
>  	size_t size;
>  	int ret;
>  
> +	if (!skb) {
> +		ret = -ENOMEM;
> +		goto err_kfree;
> +	}
> +
>  	skb_len = skb->len;
>  	if (skb_len > ETH_FRAME_LEN) {
>  		netdev_err(priv->net_dev, "bad length skb_len=%d\n", skb_len);
> @@ -1023,7 +1028,6 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
>  	    priv->wpa.mic_failure.stop) {
>  		if (netif_queue_stopped(priv->net_dev))
>  			netif_wake_queue(priv->net_dev);
> -		if (skb)
>  			dev_kfree_skb(skb);
>  
>  		return 0;
> -- 
> 2.17.1
> 
