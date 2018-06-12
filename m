Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E49D4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9555420891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke08M+0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9555420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934616AbeFLWH3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:07:29 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:46176 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFLWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:07:27 -0400
Received: by mail-pl0-f48.google.com with SMTP id 30-v6so259083pld.13;
        Tue, 12 Jun 2018 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iaiu+8U0TPwg9YQcgYOHuCBGJDr6zl5mKAZhyAgyZcI=;
        b=ke08M+0KJh/bp7EsIapDO4lz6eSEoX4noNkFW4QR3ETilCWLmu1ugascdg36EvXd/0
         6xsi2uhtcJF3wDk6CW6PPszvrzyaE8D2MIgawtkd0gqwSM62V0VayGLiJkDalSwIEIau
         FQ+aswmXYcrSflV6N6B3YkhdECeP8UdgVysj3xrp5iGEUPh0hDFOqeFYVvn3TC/YcuOE
         04YLn//jDkn53RHXW/gYrvCoAWxJhOJ3iRLFK2L4+BLuz5na+Cywwmq9sj6Bn7Q4nbvD
         gx0eL38pdffSQupEFCqxBuLYOh31f0q7BFTzPfbXvEe9l+vjFlCI7JhHW97lf/LplDQW
         X59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iaiu+8U0TPwg9YQcgYOHuCBGJDr6zl5mKAZhyAgyZcI=;
        b=oP4bnAECxxtvJCKhA9AxPU1cv/tbYTe9ucOaX3EjEUwYmiMsEQKtldPbABDmV4CWFO
         Q/+/gqWIqTpREAMfFZosd0fIRSpzBFgr6G/rapx2A8GdrXov13HjKqpcBZpyWOCRH/p6
         tQhb5SvHL2vx05Rq0ghNdGA+5wIr9ja6MtDa57b8AQwbx9sI/Z4zHiBIQHWxyiiTh+ix
         /za3PW9hq2NVcIKor+LjVIAxXJx61aYFi83cDJ7+mRiXfvrI1RR645B27YEY2N07UKtS
         lmC6PwfXL4KEtbr9GS5kJIgEGJ1XgmPdrce0AK2msO5K052Cv9rawfIIwqM+DBsPOFoM
         1ucw==
X-Gm-Message-State: APt69E3f+J9VIUWCjYkfn5nw/HHIqAiDxsCtoTZGs9Dg3s4NirgJVzBl
        J9I0cKkpYbG/NcoW4ldY9Eo=
X-Google-Smtp-Source: ADUXVKKGzI6YT21tgC5yL6pKFLFg4gTxVftHboumt0YF3M6JmViNnzjjKLobn2Xjww71QXaW7Hp56A==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr2352777plu.22.1528841246370;
        Tue, 12 Jun 2018 15:07:26 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id c4-v6sm1532047pfe.53.2018.06.12.15.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:07:24 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:07:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time
 configuration
Message-ID: <20180612220722.GA38773@dtor-ws>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-4-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612074856.28451-4-andr2000@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:48:56AM +0300, Oleksandr Andrushchenko wrote:
>  
> +	if (!(with_kbd | with_ptr | with_mtouch)) {

I changed this to logical "OR" and applied, thank you.

> +		ret = -ENXIO;
> +		goto error;
> +	}
> +
>  	ret = xenkbd_connect_backend(dev, info);
>  	if (ret < 0)
>  		goto error;
> -- 
> 2.17.1
> 

-- 
Dmitry
