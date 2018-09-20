Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF91ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00C120877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQhhzWQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeITK4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:56:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36174 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITK4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:56:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so3733348plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=1MUQMMNkiHzoGflvX0yBDMZ+y22LI9sb3kOH2CzYxwk=;
        b=OQhhzWQm9j37zaqqknAmul22F8bQzzY/rsl8yx+dZAm+dh3gP4e0FbItbjmpLfhUZg
         ix8HC+xPelGAhx4kNGLkm0EbccSL7e2E1u6N7ucXxwUQsl3GprEbzhktHhziGNCrkWTz
         lYvyqc0ZPAFiZxAkDNKBov8TOsMzXW/qUvtus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=1MUQMMNkiHzoGflvX0yBDMZ+y22LI9sb3kOH2CzYxwk=;
        b=I0ix1bJl5vACd4WLe6MgWvk1j3ATUDKUh5eMuOWnca7lUb1sHabHXFz5Fyt75FTleW
         uxCmVaoWnhgQm1MTHeFCZiH9u6Smttz3f3CKmz13ZFUJ0I18N0xX4aZxmtU0ekKpFuVW
         yr9HVK0wGtLgHQXOELWzq3IB4eJqL4t7MbkutxwGUqBqEuG4MbCqGqd2/DWvxe09SHAm
         LIhX8f34zeNeq/tEwdFf728bUU69LDmd25PrnlepofQnkwNMw6iBk7jy9wQZ4sz4Uxi7
         /T241wOw4TCa9yOMr3Esl8bnXz1Om2B6b6JWmZND8jhVLqZPnXpbEiK/MQbAXLIEzVP4
         jpYA==
X-Gm-Message-State: APzg51Bxs+gGjTDadcHHK2NFhdkSSSu+j+uT1+hjqqmMFvJzSfvFLKzh
        et2WJdX8wdUxnTor/K9sGR/zBA==
X-Google-Smtp-Source: ANB0VdbmdRBhvKG/Z8XqYCzDNcU5yjkCZgdVlFcLiPLJIol47RO1+ohlpKKzE6AgCqfFzx+vRHZhow==
X-Received: by 2002:a17:902:4e:: with SMTP id 72-v6mr37325723pla.318.1537420490187;
        Wed, 19 Sep 2018 22:14:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id i25-v6sm26159074pgi.31.2018.09.19.22.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 22:14:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Wolfram Sang <wsa@the-dreams.de>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180919204527.GA889@kunai>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <20180918194126.138455-1-swboyd@chromium.org> <20180918221646.GA970@kunai>
 <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
 <20180919204527.GA889@kunai>
Message-ID: <153742048814.119890.14655726482695872149@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date:   Wed, 19 Sep 2018 22:14:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2018-09-19 13:45:28)
> =

> > But now when I try to use it I'm not exicted when the buffer is bounced
> > but we fail to map the buffer with the DMA APIs. For an I2C_M_RD
> =

> Yes, this was reported before and the function to unmap looks different
> now as of v4.19-rc2...
> =

> > the buffer that we setup. Or we can pass an argument to
> > i2c_release_dma_safe_msg_buf() to indicate if we should do the memcpy or
> > not?
> =

> ... exactly like this :)
> =


Ok great. I haven't synced to the latest stuff. I'll resend this
tomorrow when I test again.

