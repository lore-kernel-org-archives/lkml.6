Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E81520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544484189;
	bh=RmVGFrO9AXB+t4/LJlKB0Sufjn1g1S1fmqFWjwaKszk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKRJn/SSCfrZLuLwDwR/859b4ib/zVIypJ9HYwno1/zIoOx7QY7wapJXdKEdz7Mcg
	 Zqvex2Zkofp0KrUiZDgX+rFUySM6tzdrKylvJyXcYWnN0SXVnauF/yUQxYsGU8kMWF
	 kEtJlfoYQVxkqxjKkPzRyY6Uz3OsVOReQObsjB70=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E81520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeLJXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:23:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43991 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeLJXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:23:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so12210272otr.10;
        Mon, 10 Dec 2018 15:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SC8v6ARwXPjod5AbgOR4Son6mz4bX2VIZGUYxTWqMZU=;
        b=p1QUUXpsR1sAKVuBkLEeC54w+K7e1gp7R5rjF56BxaFlM9UVWnn+t6j1/CD4m4IltT
         G3FeP28lh4qO6t1ZfoJNiwcBd1VGx8hT08ZfSj0nxQB7lT2HH6jga+Lt7sBsVw1RyRQD
         GLb3rlb80O562zxQvVPr2WPP7B4thpeWMgtkXlQ13AqD6FLCPrGC0ag7Yt0F9TSNmw3s
         MW9ri/1KZhPxjIglHFwU71xM7feajyiW0dNWWrwkawWdg9uRKUeqHi1GzjTFRo3NWLGn
         3EQh7ueZVAUmYByHooH391mvtSCFZWqMs8OKj2oTAmJB5Li/h4NRZf5yATDbIZT13N/m
         y2Mg==
X-Gm-Message-State: AA+aEWYBOxEguN468QiGHZmY9/y7IGvZw0Q5mZQwMw+ql28fbSvkLBu5
        xJ96HTjJ1O9MYmAc0smNVQ==
X-Google-Smtp-Source: AFSGD/VLIX1D1mZg8UQOPsJch/oiVvllnLKbSNtCOMx9+kBXFvuZyLjDhhYaIfJNlzzuVZQdRQwgNQ==
X-Received: by 2002:a9d:23e5:: with SMTP id t92mr10218283otb.159.1544484186886;
        Mon, 10 Dec 2018 15:23:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b18sm5724966otl.33.2018.12.10.15.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:23:06 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:23:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        chris.packham@alliedtelesis.co.nz, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: 8250: Add rate limit for
 serial port input overruns
Message-ID: <20181210232305.GA11474@bogus>
References: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 11:27:39 +1300, Darwin Dingel wrote:
> When a serial port continuously experiences input overrun from
> (1) continuous receive characters from remote and or (2) hardware
> issues, its interrupt handler can preempt other tasks especially
> when the system is busy (ie. boot up period). This can cause other
> tasks to get starved of processing time from the CPU.
> 
> When this dts binding is enabled and input overrun on the serial port
> is detected, serial port receive will be throttled to give some breathing
> room for processing other tasks. Value provided will be in milliseconds.
> 
> &serial0{
> 	overrun-throttle-ms = <500>;
> };
> 
> Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changelog
>     v1->v2:
>     - Separated dts binding to another patch
>     
>     v2->v3:
>     - Fixed commit message and reviewed-by fields
> 
>  Documentation/devicetree/bindings/serial/8250.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
