Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6178BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330D7208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330D7208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJPCc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:32:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37710 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:32:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so19959950oth.4;
        Mon, 15 Oct 2018 11:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZiA1YMFNvIHfLSz3fDElIhcbArF0l9+L56XKUBdDyMI=;
        b=Bqvr8RzL2Kn3xwCxbHesH+G+yEC5+1wpy6DFM3cPQ6CRq/Rcfvx6p3Mg/dV3RhYF9N
         5Wqx/7nRS9OUn9d9BBPBEFr6wO7JxsdFiK+EnQInQHxqb8AAVCJgLSwwgJjbFZopZL63
         8DMnllndiZgDJtqM3vRVMCk6IZi42olcExUzM7dczh0WLFGNVSLhO1q+SQtwv+tQL9oF
         qtWz64zsUU4I9glgDZDijQTOakePnZcOPSVxKWsniF2NX32UqKFFE2FB5g22ocBUK7ZF
         bLyD89/l7Vf67K55E98bj5ZlVqQbYdkE5jQMCpz/woFS+wYcOkwUi2N2DsHwryrKiqY5
         ccDg==
X-Gm-Message-State: ABuFfoiNrj5lL/zqukoKqCVRPsOqA4BPlhciCAKKszWmE2Z28jqsok8z
        eOvQYt62O3Nm7GFP688jKS9GHi8=
X-Google-Smtp-Source: ACcGV60Vv5fgLB8qAbsKoVphfIkT4BXrMea/PJf1NK+SSnmLKG80tso8mgcIrbkVgKxI0zNz12RvwQ==
X-Received: by 2002:a9d:7581:: with SMTP id s1mr12697519otk.39.1539629189365;
        Mon, 15 Oct 2018 11:46:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s5sm3651384otc.40.2018.10.15.11.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:46:28 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:46:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181015184627.GA23207@bogus>
References: <20180927222655.24482-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927222655.24482-1-lukma@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:26:55AM +0200, Lukasz Majewski wrote:
> Add Device Tree binding document for Liebherr's BK4 external SPI bus.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt

Applied.

To add to Mark's comments, the status of binding patches can be checked 
on patchwork[1]. There's no reason for pings to me. If it is in the 
"New" state, I will get to it and you can see where you are in the 
queue. ATM, I'm rather backed up.

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
