Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4813C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3122084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3122084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbeKFHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:21:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33246 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:21:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id c25-v6so8968835oiy.0;
        Mon, 05 Nov 2018 13:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UBqUI3Ebgz/loKHGdkzx5oLJPu0zKTGczKDzUJXkbY=;
        b=oW9Dx9HYJUO7Z4LKwgyhQPUAONYgLXoD6I6JH1uyRmgSL/yK9DpzOUSmyzH3CfgrNX
         pPFkL5P2O/N1YITXzFGgxqDdMujAYkSmDIXyEFjDItyGJGBMfnu+Q3NrTUR7H7AKVSC/
         MU1Ml4RUja/L+/i7r3booTQtS8xxA9Nlg1XqtgC8Z9pnAW9kCwUT1qaixOkcrD0rLdS6
         j3tGCnQNtE/9sVs1YrxX2QgymuzY0FdRz1tJyKoT7K2JsAhxQijsO86OTBCNPlf0O11T
         sy9adHs3C04iJ0HqwgripEubAVKR1lza52kDP3rb5LH1jH0aOFFBhyUl6WDKdyiDt1Uy
         3ZsA==
X-Gm-Message-State: AGRZ1gI/VnKAZ0RwORxfNxxgWY8shUI5PDdIKP6BJJQ7l6olVrtiXVXo
        v0WfP8/a3VR0NNpOAjl+Zw==
X-Google-Smtp-Source: AJdET5ePCVMJw+htL2lVOFtICDAv1XVrYGmtGsM8nhNKuGdICJ1KrQpBA2ILBdLj87D4LVeVLFY8MA==
X-Received: by 2002:aca:4f93:: with SMTP id d141-v6mr14560447oib.142.1541455158462;
        Mon, 05 Nov 2018 13:59:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t43sm5478381oti.73.2018.11.05.13.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:59:17 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:59:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: Re: [PATCH v2 1/7] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Message-ID: <20181105215916.GA9820@bogus>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-2-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 20:11:43 -0400, Brian Masney wrote:
> Add support for the ti,bq24192 variant and a child node for the
> usb-otg-vbus regulator.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../devicetree/bindings/power/supply/bq24190.txt         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
