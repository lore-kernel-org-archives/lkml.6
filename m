Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C836C21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C836C21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHTVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:30:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33515 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeHTVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:30:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so27512311oip.0;
        Mon, 20 Aug 2018 11:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZmsWosXsvIxR1tmiJQX/h//SH9j70MVeptZTwfibUc=;
        b=lf30sB9Xqvjr9vgtWh9kSN8itPiBxn87utYHte/LqqnOdFBwbuCdknGFTrjDjYEizh
         62uR5V9tfOonXtPS+cRuC+P8ZJMU3pv2tUP4shm7Ce7O/I/6IXKA4JUnUdhm08bJXql6
         NpTNsoEuFyQbEihlEfE4LeMvjD8AskUgbKRoPIQjUNdopC7ssYh6chkB3I8nz7LDugXj
         gdCn+vGiE4jXRU/1nGk3lun2s5AL0aXJYJYyAwtTWHn/v3dZNSOA/6NJfyF6Jlj/PIRB
         VaxwAcSe1LykDoWu0JOZpiB6+x9LEgwyk4oWqzB1DBGSBa3PVpDFS5pjalayyopWzY13
         5/ZA==
X-Gm-Message-State: AOUpUlHWsA1LzGmdrJHraQELw99J/mMU8wKpgO63NnCIqQMwqG8wKG2n
        fCj9NKJLE7HjakdcT4XrO79trJQ=
X-Google-Smtp-Source: AA+uWPxTfTLi1uQbM095Z0Ve08QtKZlc95fFF2hAjVdtvBzawOwAETnYZ/4ACiii7HFUFK1Fp16GKw==
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr16167966oif.104.1534788822132;
        Mon, 20 Aug 2018 11:13:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5-v6sm6302212oia.57.2018.08.20.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:13:41 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:13:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Message-ID: <20180820181341.GA982@bogus>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816084521.16289-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:45:18AM +0200, Alexandre Belloni wrote:
> Document bindings for the Microsemi Ocelot integration of the Designware
> I2C controller.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

No need to re-spin just for the subject.

Reviewed-by: Rob Herring <robh@kernel.org>
