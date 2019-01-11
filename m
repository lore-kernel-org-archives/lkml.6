Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A50C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128FB21872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218341;
	bh=7v/12+M1CCP9jQfK8Tj5TgFaBfKsXnRnggwaxyz+UdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2OR74dXoAGeW8FI6U5nlNTNuLJNWDniDTuxnpr7QH5aE6RNp0QK7DBZY9xvcVc8e
	 frwQ6RAMCXLRTC2TBu+C7KsivAzg/ta2+e7JrxVUXT6ZvHppg2l9D41y/kLRjh9iXR
	 qpwTmmXsvxxOQr8kfSxVXyO4Ua57hsElqCjLLfJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391685AbfAKOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:52:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41612 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391674AbfAKOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:52:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so13296608otk.8;
        Fri, 11 Jan 2019 06:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NaitmcOITIG3mGTfNd5ruDq7+ohukKHtQPEMEo4HVJs=;
        b=iMSh2QWD1ptTdmH0zg7D/44ANaZY8QfZdejDUX0zEhs8/Rw9PWu6OkBTRy91YfrYXg
         rQpnk8coa+al8PJID/QROz46PUSgcq4GdVodI0+D2IbcYt8vGwCbAyKBmD11CyXVnXT0
         hT8YYg8KEFSIRhtglFGz7GQCMFNJFX4/gvZq4gFcHJ/fyaINpI2vgVsPgx2M4wVo9VX3
         /D/P4266uDt4hcxpk9uTUCLS9R6qMBP06eUArSR0rJ3pJT0TigZsWwVzacO8VdS81V1L
         peTdAKxX1yT8qsrfKhQParv2fAkwrbzeOJBVZ4gHeyyVl2LkKkG0K1g0WhQXNQUEFNSW
         x6QQ==
X-Gm-Message-State: AJcUukcYR0kU+gT1pxPfcD0EVdbU7UAzaMv4oJg2Y5WKnOe0g9N31O81
        vO07pJBCqyPebcIivDX3xw7frPI=
X-Google-Smtp-Source: ALg8bN7Y81MPsW9Jh91t5CHZSDGthSsXPZKth7wAFx57s/QabDsseHrQvRL7TnZrfS8NWXoZFfNWYw==
X-Received: by 2002:a05:6830:2115:: with SMTP id i21mr10318713otc.237.1547218335741;
        Fri, 11 Jan 2019 06:52:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm33673912otr.74.2019.01.11.06.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:52:15 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:52:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4] dt-bindings: timer: gpt: update binding doc
Message-ID: <20190111145214.GA15957@bogus>
References: <1546076081-23196-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546076081-23196-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 09:39:34AM +0000, Anson Huang wrote:
> The i.MX GPT timer driver binding doc is out of date,
> update it according to current GPT timer driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog since V3:
> 	be more specific about the backwards compatible of each SoC;
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 39 ++++++++++++++++++----
>  1 file changed, 33 insertions(+), 6 deletions(-)

This now seems in line with my 9+ year old memory of the lineage of this 
block. :)

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
