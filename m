Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB97A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="N9yhE2Yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB97A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeLABW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:22:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeLABWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:22:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so4942694edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTHGnBf1aZoskEgtMSAcIcRO7UT4fQhUjgl711JiFLM=;
        b=N9yhE2YdKz5xlZ+NFeL68PSJKTDifZu9dPlXw2caB5AkEwtkaw8B4P1cAtzJ5NnLtK
         jxhW+2duCDxeOC2ah/RAdcBAqqyaH/+aur94+EIp1vucbCR40eICemzzkf7KS7zToulx
         H62/feXN1DYR7EwXwSgUzPP1lUrQ/E5sLyICKIWZBvOj0EmiGuhnAk5nAKVLU9hLbytN
         BlhlXuFLf3nJeII0XoffCwDxesm+/dXQKxq5fab6lOLzkcveegL3y95nbu4YeZ0QSULx
         NB7SQDmAmZb8dApIUMRb6YGnLhw7w0KbXzowDcfCj7kYk/Kqt42zoluVB28ael3EwWaJ
         MkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTHGnBf1aZoskEgtMSAcIcRO7UT4fQhUjgl711JiFLM=;
        b=abkGiMlcHTNVL15fmRQr0vYZU7l9vDPjEdD6qArWyPeIGnU2O3YtQbRwgPvY5O7UQQ
         I85zwXj/eN+nLOdxNaLtjNRR1GbRwmECUg4FjV2aJi7PvKcfpIOju6+ZC43x6mXqzHGu
         0ulHk5pRImhnUkkLdI+L58sSgyVWKq+tYjK/G+xwAjPedChVNAXq3IRtzx0GM/yfm+a3
         bW8BIqo+yZpaUsD13aj3qApxaic2DMNHOUSNzlk8Lq2JlfzUkDrWLKOBacMgXj9n9vUK
         vwTcOF64b66nIjCpjUW5GSAbVruN5J0xyhL1XRvRuUXlWMxfj6Rf6KUSsxkAobVcDm4P
         pWPw==
X-Gm-Message-State: AA+aEWbXfToUxAJ3yrqaYmE9VHxDwO5JvURDXWfRCCj4txffDOvw8QIa
        ZiWdDJnCGX+i252BMXmSLeQh4w==
X-Google-Smtp-Source: AFSGD/X4ppVEi9mR9DpIh6n7uyhMt85x1BxYABeZ5M1Mj5D8IQEZy3U7EM/85b/5xXR4N65QDlcm0g==
X-Received: by 2002:a17:906:6c14:: with SMTP id j20-v6mr4866180ejr.41.1543587206239;
        Fri, 30 Nov 2018 06:13:26 -0800 (PST)
Received: from netronome.com (watermunt.horms.nl. [80.127.179.77])
        by smtp.gmail.com with ESMTPSA id b6sm1484192edd.94.2018.11.30.06.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:13:25 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:13:21 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: fix spelling mistake "execeeds" -> "exceeds"
Message-ID: <20181130141320.vudeegxkezadlxlp@netronome.com>
References: <20181127143717.27698-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127143717.27698-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:37:17PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a net_warn_ratelimited message, fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  net/openvswitch/conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index a4660c48ff01..cd94f925495a 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -1166,7 +1166,7 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
>  				&ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple);
>  			if (err) {
>  				net_warn_ratelimited("openvswitch: zone: %u "
> -					"execeeds conntrack limit\n",
> +					"exceeds conntrack limit\n",
>  					info->zone.id);
>  				return err;
>  			}
> -- 
> 2.19.1
> 
