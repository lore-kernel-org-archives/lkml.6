Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zlrcJye4G1snTwAAmS7hNA
	; Sat, 09 Jun 2018 11:22:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AE93B607A4; Sat,  9 Jun 2018 11:22:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuHMqQtb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34267601D3;
	Sat,  9 Jun 2018 11:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34267601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeFILWP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 07:22:15 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40171 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeFILWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 07:22:13 -0400
Received: by mail-wr0-f169.google.com with SMTP id l41-v6so15752129wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2p6JHalsl4KFZhXlgTJqJCOBjeszzGoUJDMQUa2OW18=;
        b=BuHMqQtbBVhIqhbew6D7eOZeIcRJS1c2mNNesRPeHDqtuA/Iy1e+cCO8mnZqG+cgRj
         7XwpFUlBopGp9PkVX4KChz5Up8kv6f3KwOA5VPiUyM6bwjV40RthsLXSreDEVVrRgsCC
         YClZm2S1XtYo87UbcQH1jiPgOpEAzC6CuRyElePAeUvKq6yHkG8uAmeDOEKzoBYPIjXI
         2TI30oMfTarHmoUbGeZCficTuw4l/grieKsgdFXudhdBgsQ31Lde45aCkpPpuEcg8LuN
         wxty66zf3pWGWLpiv8kdUOX3h0ogBYH9aGvxUdZs4MFo7Osoct5D/feqAceiA4HSMeBk
         K2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2p6JHalsl4KFZhXlgTJqJCOBjeszzGoUJDMQUa2OW18=;
        b=EphwFicGB2uY2KJAV86CqDKgnb47uzseDWeLMgUjoHKDFz/RGU/AP296Gv7dhfc1HB
         r2xl8SF6zsoOWY431pLlqa01+3WZa7eXmGWfZL/pIs+b3qT3KJu6jWAYMRrNZQg+PHvL
         ZQs98gxpNcsq13wXJzLDMJ3P/7+f5ZQeZSJwztTsYSMlhqJ+JiAMszyFkvAh3IZ3/u/p
         8ujk7hUkOP65Tnu/dnmzGY/It+YIhu5nA3OiTQZ3qNRR4eGbkAP9MBu75O3n6zQC1JxZ
         B3U5vB9LNiB0QDY0Z3Z/f2E/SxQHp/gFRLYaOR0n5dUbkewNTFb4ZpgqHT4dbzhuiIjF
         psyg==
X-Gm-Message-State: APt69E0WV2Ub8zFD2gfmujh97DDcDd5lvhMw2T/6MxsOUBBzaB0UGoYB
        eeWMjbfzsj6NOZKx5RosB6Q=
X-Google-Smtp-Source: ADUXVKK5kc+zPgfRTIhS+lrXICWqVWDOtgZYZrRw13CCP4WpLuW2NNwpMX953ZN/UYr3x2j8fh2FrA==
X-Received: by 2002:adf:ad2f:: with SMTP id p44-v6mr7944261wrc.164.1528543332700;
        Sat, 09 Jun 2018 04:22:12 -0700 (PDT)
Received: from localhost (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.gmail.com with ESMTPSA id g105-v6sm43417725wrd.37.2018.06.09.04.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 04:22:11 -0700 (PDT)
Date: Sat, 9 Jun 2018 15:20:50 +0200
From: chris <eklikeroomys@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: shortened a long line
Message-ID: <20180609132050.GA26085@kerdev>
References: <1528541720-1853-1-git-send-email-eklikeroomys@gmail.com>
 <86ccd1d2471b4541c2242d71173734cdbb99f247.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ccd1d2471b4541c2242d71173734cdbb99f247.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thank you for the feedback! I understand better now and will resend
the patch.

Regards,
Chris Opperman
