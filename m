Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0EEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE42151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD/RK9Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBE42151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeHURW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:22:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42815 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeHURW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:22:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id g23-v6so5891151plq.9;
        Tue, 21 Aug 2018 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5u8rg4L67IpggPIklDkmkhFg5gSXXm9J9u/yfXXtzU=;
        b=BD/RK9CqbAtbVUZ0zUB98TQV+1dtNlm5P69f7obzX2Q5KsrlysrqCjmWHnzcMvzPvr
         rJlliwoD67v40M7/uXzQePpbAfkT1tGxbpRceyf5/J0KNbbfuxjwGM1/MHJP0JLBkqKJ
         RWeoX+AoY3l5aEDqwtC8yYbyktnxW7MBl2cX1oj7iYOuI0+JoVanmCuHi4HXo8NX42qS
         mmBo5Hrfxt0ERGMdCU5yfAsyMcW7WO6Bwz1UpmCCDxw/mBBCU2FYLD/x8UUD/LMeDnXf
         g4p/TsTor0W+DI/x+uO2ibJVlPoKlPEYEfTkFZmM4UdCRGPBifQEXYAKYpHDGJJut821
         8iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5u8rg4L67IpggPIklDkmkhFg5gSXXm9J9u/yfXXtzU=;
        b=iyJBFR13W4KYKrxZ7IzstvBpQ6SlQ8XH26C4XtE7CzwYxxl4ZBBgFQnJ87ay5Resym
         oNIGmExJrSo/REaxPAbYYGHLnQq3udRDf89/2pK5WDsHD+6oxj0O69Oi4MK09juW8Rwq
         K9nrIqNXMIV+/+fYcpKhD0i9t8g+/BYWBMBN6mu3o1o9fqdLZp6yVNwykwTmlt6NDGEg
         X5WLeSSRPvmPCnjbtI+50X7GF+55fjW5hCjUYkTksOFslIxVCw/pvWwoYYUR5DBrlNRl
         nKfYwo/wQ2vz9jJ2ZsJZSNswAPmWHcz19kkTsd1Dcd/CslrLsHLgFFCfkj4Ten/2FPsm
         aRjQ==
X-Gm-Message-State: AOUpUlF43EGCjop/XDvu2jSzPBEUsTg4W+THXczFEu0UYWqQOSi0G8rG
        taD1AhKGIU0blIvTqxKDnZ7NcCnT
X-Google-Smtp-Source: AA+uWPw/KkHy+JZUhDXasW7f6PtLS5QkWOAFVZQAyByMeJI5L0HU8FL8p5h514WO1B7HP+bg9J11Tw==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr50072378plc.270.1534860160768;
        Tue, 21 Aug 2018 07:02:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a77-v6sm28698485pfj.38.2018.08.21.07.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:02:40 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:02:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com
Subject: Re: [PATCH] watchdog: hpwdt: Update Driver Documentation.
Message-ID: <20180821140239.GD17160@roeck-us.net>
References: <20180820193123.23976-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820193123.23976-1-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 01:31:23PM -0600, Jerry Hoemann wrote:
> Remove references to deprecated features like NMI sourcing
> and obsoleted module parameters.
> 
> Add details concerning new module parameter pretimeout and tips
> to programming it.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
