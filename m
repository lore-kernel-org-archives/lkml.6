Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5648CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9B622450
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUuyK2VD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B622450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeHJUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:55:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:55:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so4766107pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSWK9ry0RecThbAGMd8vHGNOjIeQM+4zKeKdc2Ryk7o=;
        b=uUuyK2VD/UOqk4flRu1OtIwkD+t5MBMMJfEUeoBYuALSqFOSZdSdG6fnEHaZHF5TsD
         f3wnYpoE73xObaDNKTTsAUaqF8+MiT8PH+whRe7EDkIb5+5XoLMe5rH0Eg3rNnMTf4rT
         DPTtD6M6ne/f4aRmrZnpZ1UZ17rWG6nsUKGX+zfcrJItFhqJNZtHs/HmIAxqa9Kpwv9W
         3FuNWuxCQqQ+XRX0M9Y8iLP6wnStV/mYTHD4vt/UwKTG/yNS+BWBdTlPSfQIU5zKcPXW
         MfgCTheMdOWCe7Ty003bLNzup0KTUO0YMEUZQU+X6FVfZr00w0GWirLrLnaS5LZgkRXD
         /Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSWK9ry0RecThbAGMd8vHGNOjIeQM+4zKeKdc2Ryk7o=;
        b=qIa9NlnBPwYiLZdGjfs5RspeBHiJVd9fsJAad+JKtY1H5oNN5u7kfKlzo2zsCM/Iq/
         EJC+9kPbrAku9yk6W99tE6sJv1le+M9+PimJsOI45whhMKX/0yhGSQrcHnaYkadQ8FoI
         syv//4k3SxdXvWzU2v3QeYi/UmhYwjL9bQlcSl5xVPtv5mDHGKhEdGBFhE1PZbGkkpkN
         KbDMRvNcR+X5SuPUqjMSWCqz4ZawNKjU635Qe/VRyDTm7tCe40x28pl1ixG8+myBXN6U
         dZBSe8Kegu35iajlNOQPkaq7z6T/rE0f2yQfKoPkMNd6+dcW0gE7VjLzy5wo+L91W+Hx
         ZylA==
X-Gm-Message-State: AOUpUlFlOe89ScR433Ls3OIkcF//fhY9um9yrYE+OoAEx1LCqP0l5bAw
        AQ2RHLkAnKZ8xsMXOveJaG85PPDR
X-Google-Smtp-Source: AA+uWPzcOc3fsMPFrybFToCjSzvhMIHplzcsjhrxhYvBNelsQvUzVZMQjlnK3Aj7vHoIKFZmASnAHw==
X-Received: by 2002:a63:7d7:: with SMTP id 206-v6mr7472207pgh.137.1533925446710;
        Fri, 10 Aug 2018 11:24:06 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id h69-v6sm24045215pfh.13.2018.08.10.11.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 11:24:06 -0700 (PDT)
Date:   Fri, 10 Aug 2018 23:53:58 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] coccicheck: return proper error code on check fail
Message-ID: <20180810182358.GA5302@himanshu-Vostro-3559>
References: <20180810133636.8340-1-efremov@linux.com>
 <alpine.DEB.2.20.1808101541270.3390@hadrien>
 <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com>
 <alpine.DEB.2.20.1808101627230.3390@hadrien>
 <CADKZ3F+UzwTbcKBHDYQnoFFgWiVoDbxZzBb=PQjMn2x-T26jHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADKZ3F+UzwTbcKBHDYQnoFFgWiVoDbxZzBb=PQjMn2x-T26jHg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:45:46PM +0300, Denis Efremov wrote:
> My mistake. Initially, I thought that this line signals about errors
> in the code, but now I see that this is about the tool's internal
> error. However, this doesn't change the fact that coccicheck returns
> the improper error code.
> 
> I will reformulate the commit message and send the v2 patch with the
> same diff. Thank you for clarifying things.

I would also request to use the latest source from 
https://github.com/coccinelle/coccinelle

Because some distribution supplied coccinelle packages are
obsolete and likely more prone to be disfunctional.

For instance: https://systeme.lip6.fr/pipermail/cocci/2017-December/004799.html

Thanks.
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
