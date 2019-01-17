Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59D5205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547740716;
	bh=HLqV2dc1WKO48heQog/k4J+kWTYHX8HMQOJk+y7yPHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rAne0RCMwDsXzRRqFbrDk3f+seBxBDlmuyDwdU2tq5KZdo/0zcFIXm/NMtn8gBnIG
	 SwAoUk6pRETmZT/ZBkwQcMtKEweb4dCXkPOygXhvurFt7EMrs2Pih4HORfIpWGJU68
	 Mx/oJ06RMc0jNv/SC/GroibvxFdzLWiPDPIkyz5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAQP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:58:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46989 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:58:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so11496203otm.13;
        Thu, 17 Jan 2019 07:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urf/u3VuNYi21P4UZujWfzJUpi71TmGGtyLx1c+V4i4=;
        b=iUoMUd3AqQyqsj11AihXBXuhjEIzuCzcVeegL1qpivipU6ZNRMa7gXVUPlxE00U2qV
         YiVVxiue0VFPzIzmhBG3u0ik/uSo40M4E2O4ZlbGauUO6lytj0WQgVlErcvRAmZdQ9Jw
         fNhXDxXLlgIvxW7p+BdRWUuRgM1KBcP8uL+5cu9DPL8NGmMRRNo35oKfX6beXdiMfKJA
         uh8uNbcANMRWD9lQDllgRZo+kAN0hUy18ERfgep+QxKobk/SboIX/NYzFd4GRPKojDFa
         biw5Xo45dRhA3r4+GVeXS5COiF4SbUqLCygOb8x0LWyIGjFJZ/3f22/nSO1vKVQPIlXO
         b04Q==
X-Gm-Message-State: AJcUukcfMIN+pQBU2i40YUh4xtfNYrVqKpRrhVI/5OArfeFKmNS0WE/W
        HPz4OWAqTxhmogniDkpmwoFoElo=
X-Google-Smtp-Source: ALg8bN7CTnPG8WdsWbs+mdw2xlwV0MgOw2MM+Y03pQeFeRCMv0PHCWcnpLql714Phph4kTEVmXb0pw==
X-Received: by 2002:a9d:6143:: with SMTP id c3mr9502622otk.227.1547740713836;
        Thu, 17 Jan 2019 07:58:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b23sm690702otq.5.2019.01.17.07.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:58:33 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:58:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 6/6] dt-bindings: gnss: add lna-supply property
Message-ID: <20190117155832.GA23290@bogus>
References: <20190116211812.6337-1-andreas@kemnade.info>
 <20190116211812.6337-7-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116211812.6337-7-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 22:18:12 +0100, Andreas Kemnade wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
