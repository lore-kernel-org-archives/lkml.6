Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2526921480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2526921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeIXWUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:20:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43418 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeIXWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:20:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so2673528plb.10;
        Mon, 24 Sep 2018 09:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bnolApUHyrHgeeqquSRTkzbvaGDq3iZGb0d6u9BlfYQ=;
        b=XTETpOVzxiGZqJsh6WTokVMYWBWXrxz3LB6ePzPg7eRLx5cK2SMBXo6qfESw81fTEr
         tcbWcx3Aiu9pX3M43KjJnkO0IxTc+fhyyLPxZj1rEt/cytlS3WcDahNWUaldhw1MbILk
         oanfFUn/fhBj5rUKZs8El01/tnCDR02724TbahQSNeSONcAkflSj3z9frY+K+zTPrPr+
         nUfaDgohNWYX8ZpdI2A4p7gOhqpenyXHrX6MHWa6tw/FZGYgyaffagQ+wnpYjulAHYa1
         mADpdqDtHb8Ks0w9VbSe/3MUyd+L6RjqNbeZc40S3QBrM1UVVwLcwPQD7ewGdmARwKgf
         fPLg==
X-Gm-Message-State: ABuFfoj4eSwZjblp9WasF0legrliZ4X6nteYt1e11ypivKStDM5dVDRH
        RmNWCexmo37/Lz2KUXf6UA==
X-Google-Smtp-Source: ACcGV60VMdBHa+8ck2wKvpnod4RavSBKBLbEHf7BB9Jh6PR+9KCpOfn7FuyDQ2RAeOiPewuiHIz3Iw==
X-Received: by 2002:a17:902:7796:: with SMTP id o22-v6mr8564373pll.5.1537805858555;
        Mon, 24 Sep 2018 09:17:38 -0700 (PDT)
Received: from localhost (S01069050caa8e733.vc.shawcable.net. [24.85.230.93])
        by smtp.gmail.com with ESMTPSA id q25-v6sm50008446pfk.96.2018.09.24.09.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:17:37 -0700 (PDT)
Date:   Mon, 24 Sep 2018 09:17:36 -0700
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Message-ID: <20180924161736.GA26094@bogus>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:43:14AM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (r8a774a1) SoC specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v1->v2:
> * dropped "renesas,rzg-gen2-can" and fixed "clocks" property description
>   as per Geert's comments.
> 
> This patch applies on top of next-20180910.
> 
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
