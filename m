Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F600C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2326A2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2326A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeJLWVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:21:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32903 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeJLWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:21:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so10070701oib.0;
        Fri, 12 Oct 2018 07:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfRO+XuQPfglsf6o7ame1vKCXPdEA9BrcgU7woH/d2o=;
        b=asVjXyuywbbYqzOgxYtz7JKaFJaor3KRrJAkCcpEkW5CFwwxuy51EuvWGTXNR2gaLD
         zwp9TiNwuBHpYxmcpsGav7KlupbAdcwoFPIdcc5ITrCmBWoS0QS2vGZLksNDNhC3vEXb
         JWGMrWik9dTdHckjZcO4X+hXPyZewUIf0w6otaFPjxt/WwgUiGQrAvbNN/gWRLMKiIY/
         qW3j3fKNXM+9tV3CYGOZIhRYfxBy24q9eor3kO2Z9NpEFb66aZgB57KEGur0W/L05FRu
         9HKwG9e3k+ICtipCuRIKVa5v3TVo2cd8Cxo9N0/JhrDN8c/o0W+GqE5+ffiM/9SsbKS4
         FGBw==
X-Gm-Message-State: ABuFfoh1HyOANklkbIoIYmU/nAfnqcWamX5kZMFIvLVg6h9VkfBrmTc6
        VuYdlOFQYoi5Zhah7PhKdA==
X-Google-Smtp-Source: ACcGV62t8CrqA6FgTDhC7jgzsZl9Xi1MY/rLC2L8Bq9Xpt8oKAPuY5w8zMwx65SXoyVA3P3pfbvblQ==
X-Received: by 2002:aca:75d4:: with SMTP id q203-v6mr3554217oic.334.1539355738294;
        Fri, 12 Oct 2018 07:48:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm387168otd.57.2018.10.12.07.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:48:57 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:48:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, jackp@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH v3 3/3] usb: typec: tcpm: charge current handling for
 sink  during hard reset
Message-ID: <20181012144856.GA3720@bogus>
References: <20181001194501.58338-1-badhri@google.com>
 <20181001194501.58338-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001194501.58338-3-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:45:01 -0700, Badhri Jagan Sridharan wrote:
> During the initial connect to a non-pd port, sink would hard reset
> twice before deeming that the port partner is non-pd. TCPM sets the
> the charge path to false during the hard reset. This causes unnecessary
> connects/disconnects of charge path and makes port take longer to
> charge from the non-pd ports. Avoid this by not setting the charge path
> to false unless the partner has already identified to be pd capable.
> 
> When partner is a pd port, set the charge path to false in
> SNK_HARD_RESET_SINK_OFF. Set the current limits to default value based
> of CC pull up and resume the charge path when port enters
> SNK_HARD_RESET_SINK_ON.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> 
> --------
> Changes in V3:
> Rebase on top of usb-next
> 
> Changes in V2:
> Based on feedback of jackp@codeaurora.org
> - vsafe_5v_hard_reset flag from tcpc_config is removed
> - Patch only differentiates between pd port partner and non-pd port
> partner
> 
> V1 version of the patch is here:
> https://lkml.org/lkml/2018/9/14/11
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
