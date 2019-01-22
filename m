Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D8217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548180684;
	bh=07BT94PjfSwHjHkOK6jP2+s0ZoNMUfPgwtDOGNvNqhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pS6mR802AEY9An21M2iTr3hQreJ4aubd4iPCo0ZTSXSBIg2wrkz8b3zCuBS35mECJ
	 l+gR1NaGpxp20LKQvXYY/WKci+feDfeiY1nGW6NG7cKznZepK0ovME+/tdT3A6voUQ
	 q/+2j/87tRLcxqawiHxDVxKJE706ikv9YHZeO9hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfAVSLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:11:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:11:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so21467564lja.9;
        Tue, 22 Jan 2019 10:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQVMLyCFOy3go4BoYjSl9tje+NfiN9Ko+F5BtP4Xtdw=;
        b=dEQdvgLvUKiFXWOZ7io5z3w4syjTHtV9gOtzLNycn7SxfJCKLq8H80rqkmZEEE8r81
         FdfQDE6gxyMNBRsRtmy4twsFaMT6t2H6Y76WP3a/i8zLEpMKk/owsUUbloP8gTY/vess
         lmBUzCPVCqLcsbJ0p90E8IUA/sfd+7ku1uwDN6iTTWwIUqhxd1CAlbHXhN2t4EU8XBXY
         ZRvrNalE1KySFrOQTAf4nLdBYcGnOXgeisywn4+GJtxLhuZmTMrnHpnGJboFSpWRXo8r
         4B30jmdL5pdk0koQ5hr5+ob2/fnjDebj6J9s2wJHz1U/eQyUfpRFcaCjNo8dUoNRuCfj
         OKlQ==
X-Gm-Message-State: AJcUukfQS+7mDZJCJlgtU6lZyJtKrfpr6YwmogMQQ8n6W8a3Xk31zp8V
        /MLm2jJEQE9+G3zFTUK0uWM=
X-Google-Smtp-Source: ALg8bN45Vqupndc69F5bWq4ubGoHVWX7QCakgCNc2U6w/YQq6tyDbBXAFhdmz0mbB+bWC5vWLUspMg==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr21047507ljf.96.1548180679969;
        Tue, 22 Jan 2019 10:11:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 1-v6sm108823lju.61.2019.01.22.10.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:11:19 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gm0W3-0004wc-Q8; Tue, 22 Jan 2019 19:11:15 +0100
Date:   Tue, 22 Jan 2019 19:11:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: gnss: add lna-supply property
Message-ID: <20190122181115.GT3691@localhost>
References: <20190116211812.6337-1-andreas@kemnade.info>
 <20190116211812.6337-7-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116211812.6337-7-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:18:12PM +0100, Andreas Kemnade wrote:
> Add lna-supply property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
> - moved to gnss.txt
> 
>  Documentation/devicetree/bindings/gnss/gnss.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/gnss.txt b/Documentation/devicetree/bindings/gnss/gnss.txt
> index f1e4a2ff47c5..e31bc225957d 100644
> --- a/Documentation/devicetree/bindings/gnss/gnss.txt
> +++ b/Documentation/devicetree/bindings/gnss/gnss.txt
> @@ -17,6 +17,7 @@ Required properties:
>  		  represents
>  
>  Optional properties:
> +- lna-supply	: Separate supply for a LNA

s/a/an/

>  - enable-gpios	: GPIO used to enable the device
>  - timepulse-gpios	: Time pulse GPIO

Johan
