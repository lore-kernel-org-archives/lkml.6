Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98920840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eelMkd2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfAPH0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:26:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42387 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbfAPH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:26:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so2615756pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fcmmCKmXnjggUHzgvY3ZaciS/pA/uzOuHAOiCFMpZH0=;
        b=eelMkd2nA6TL6u0kzLIAQI2EnVxw82u2U76amjNmP3FlO4iErlKfjvCUmENNRHtapE
         lZaNMVGlBzIkdop3vhoLLbaGUfjFUeF5Di/8ASXRfdwUkjxZ6bWTkat82alBf8Lv4LWU
         nzVJYnJJE3rzsGBpTb67Aa+T0DwSvwFFJTOCLAE9F5g5ddqZv9IJZd73QbVyPdqUgmGt
         gcr9JHmwUI7xdwbwSlYoRYinoVQ1Gf/GA9Sg5LrH3uonxyCK+7x3tk4ZQKaq5tf7tp6/
         easUrXwVsozuDSH8nSvISIqCyujW+MIfxdQu09A4bCQ1yWQH335J5MEcBj5t24Dic/Wi
         ZqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fcmmCKmXnjggUHzgvY3ZaciS/pA/uzOuHAOiCFMpZH0=;
        b=Ep8zNBWmtBpIN3dhJjdzqw3T+NwzmQkhmHXvLRZXCF/Hfj+izFDP9kJ15Zkli59nCX
         3YvaHA1plQ5/wpQHKBxxosrCa6aGF6hVY+m+zA3GX1pP7sD9DRaymAbVcSZpoBBHrYsR
         IqC86d/z3KNwVFTZRWLpEKqitR+E3VYrDYENh4771sG64iLOd67RXn7oXxMaTjtsfk+9
         OltDch55U77lLf68xZfLWyEmvmukCHuVe6qPzIYzLGePVy5qZ+ayW9jZegTPx/FCZk32
         VvGtLAzD3tdG8grhQxOvVnVp0vOr+7lmrBOXKuPcXjd/pjYG6fpRdj1+Wdd2lSfecXlo
         5R5Q==
X-Gm-Message-State: AJcUukc4CouI+7otOpNEMTKNwNIkmTHcJ4wWjj5x7aysJIJDKl4wPpJo
        tRuQ6Ra0NvuedyDs7B1m++FsGaGO8Bw=
X-Google-Smtp-Source: ALg8bN7TeKRqrgN+JdYFkxcGfOIqnjI1MYMzmpc88B3PCt0iyGk0Ljy+G5lTaVGtMlihVtHyAMFt0g==
X-Received: by 2002:a62:4c:: with SMTP id 73mr8267149pfa.24.1547623614402;
        Tue, 15 Jan 2019 23:26:54 -0800 (PST)
Received: from gmail.com ([203.109.101.34])
        by smtp.gmail.com with ESMTPSA id g26sm7447863pfh.61.2019.01.15.23.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 23:26:53 -0800 (PST)
Date:   Wed, 16 Jan 2019 01:18:26 +0530
From:   Jitendra <jkhasdev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Removed not necessary braces for single
 block
Message-ID: <20190115194826.GA11240@gmail.com>
References: <20190115145108.10249-1-root@localhost.localdomain>
 <20190115152015.GA25735@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190115152015.GA25735@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>"interesting" email name you used here :)
>
>Please fix up, it has to match the signed-off-by line.
>

I fixed and resent the patch again.

---
Jitendra
