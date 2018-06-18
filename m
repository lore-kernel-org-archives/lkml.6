Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19551C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBF20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwq8he5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FBF20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935388AbeFRR2H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:28:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34482 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755035AbeFRR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:28:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so9407216plq.1;
        Mon, 18 Jun 2018 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=usOd83h4X1BW/PHIq2Khx7PTLKe0GW+IESd1VM5Klxk=;
        b=Zwq8he5k83Pq7ysb10IoFXx8w2+mkvrMQaLBQvAX0RtUjCZ1jIdoxd4McC9qJIILh+
         k1ekq/dknqiXY5/rzTrNL/3DHxEnHEqyTFYtIVqTb77QebqV72RSX1aS97WO1nvygjDf
         P8j/zYiW/70OuHCfRMsdUHpYwu0J7FemsUfAcTAIUZWiGVnZ6T4TiBBtbe+Et5WTBvJt
         MdJ7+ctDos3C88dGSMe36OzLFzvxdgcDYLv8NCBd8oZRsOWL4wFmAFqCnbV1CO3Z7tUv
         FzNYp4Ow0WyvKmR6cka7iim77gR5XO1/ZDK49bMxakn9vPMG9iTTjIOHGQ7/fkFXx3eD
         MuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usOd83h4X1BW/PHIq2Khx7PTLKe0GW+IESd1VM5Klxk=;
        b=o4fFZ+Kst5C5KpFFGWxBQZmpb0+p9AUeTk5J5bt2HVz/I0wwdmhyPiC2aWdBOU7rRr
         LIeDNXk3EQLQ5bi5xmZ/IwNjz7m6N2eKwBte0q0T+lHGiSHLbUNPJuluehSEtR5UzMHw
         MVShLiJ1TRUZZSYkgtdqdGQKI2xeHc/YAvyvZRfMZupLZ6sffIZ04BdXUzW25VSrO+zX
         lGx3YRVcs4FoyB3odXeYxacjsgatrQEXdjdY3axzI5pdEsiTvt2bjO/bxkroFlXn8iUl
         Kxb+4Cz8kZQCdOOlXKOuGaV/LB7L7QerbibWny51dqBG1nzDZagZ6miA0OfFCzuP8KcR
         RO6w==
X-Gm-Message-State: APt69E0zZITKpvryUBd0JOEUvDyaJvlkh2UsNKszHqtKmBQqaVKolbPf
        n7h03zDQUE2xIEJt3pJeJdo=
X-Google-Smtp-Source: ADUXVKI9gb8rh9sdf3frtt7YTphYQj9ILLcmxK27eVfBwg80MDNQqfx6b4SqBJ/qZyQpz/Uh+/dPXA==
X-Received: by 2002:a17:902:b110:: with SMTP id q16-v6mr15105376plr.286.1529342885370;
        Mon, 18 Jun 2018 10:28:05 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id m1-v6sm21906828pfh.155.2018.06.18.10.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 10:28:04 -0700 (PDT)
Date:   Mon, 18 Jun 2018 10:28:03 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     efremov@linux.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] crypto: skcipher: remove static declaration of export
 function
Message-ID: <20180618172803.GA8022@gmail.com>
References: <20180617174959.29864-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617174959.29864-1-efremov@linux.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 08:49:59PM +0300, efremov@linux.com wrote:
> The function skcipher_walk_next declared as static and marked as
> EXPORT_SYMBOL. It's a bit confusing since export symbol means that
> we want others to use this function. The area of visibility for such
> function is its .c file and all other modules. Other *.c files of the
> same module can't use it, despite all other modules can. Relying on
> that such behavior was not the original intention, the patch just
> removes the static keyword.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Why not remove the EXPORT_SYMBOL instead?  It has no users outside the file.

- Eric
