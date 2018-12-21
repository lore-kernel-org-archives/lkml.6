Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36E1218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiQ+Wb69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeLUJ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:27:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51602 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbeLUJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:27:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4625131wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/2fEDgbTGqRViEPVPG3IPT1chDHbSJALgPOc96/49PM=;
        b=KiQ+Wb69ftAWuJ7U+lnewKSOlVUAh1e/WInH0uFFddYgIMFRGQshiRF5/HWu9O2AFi
         KFfV3V/t0WvY/3ivQMJ7iXpisjnU5a62dsjhY2uvQ/iGlU7yNjZmy9SP1VAoi5XMxZgW
         mPYRlNMQ0ocK+aFf/yVGEHadnx8oBVUVGk3nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/2fEDgbTGqRViEPVPG3IPT1chDHbSJALgPOc96/49PM=;
        b=jZdOn80b1KpGJNzK9xkKxiUuxCiASJqGkktb2sMJOTT88S7a0u5XBehFK9UBSGGZsd
         H8gMa2dVa5tGeyZWRgKTCMtyXhV0UkOTbvOi1rafuMJ43SlmFvjSWOzJhG2QPKUQTzjv
         PWZ9FcXL7TASSzJHM7JxmkAAgmYJ4WffhgLnMLWuUpQMyT30KUIBN2PDoHKvozSeuRnq
         HJkX3uLQUrdNqm5c3jTG1c/fddf+Eszm9v3OEKAU0mWgFIY1ouoMJ9oX7PQ0kdsQKSw/
         XgNAPdh5nbmcFH6ljyl/Xbund+/kCZXEj4BTA6rC49Arjgp9X3gkaDFZ1gNCKfa97AsP
         rVHQ==
X-Gm-Message-State: AA+aEWbXOZQ3jofut/4E3BbNX1qNOonToFwMJrDvPkVzUf2qDzM8cmmQ
        2m4jNK/z6nHFsiwBY27M6x/E7Yd/Gyg=
X-Google-Smtp-Source: AFSGD/VyHtODsCf7/rcfnz6taf1avD0qv63nZR/wzwk1n+wmxrKkoephUciY4UE7KVFJ8fnCv+oZCg==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr2003635wmp.19.1545384444499;
        Fri, 21 Dec 2018 01:27:24 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id s16sm8810504wrt.77.2018.12.21.01.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:27:23 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:27:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: madera: Remove spurious semicolon in while loop
Message-ID: <20181221092722.GC13248@dell>
References: <20181214143914.24393-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214143914.24393-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Richard Fitzgerald wrote:

> Coccinelle warning of a spurious semicolon on the closing brace
> of a while loop.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
