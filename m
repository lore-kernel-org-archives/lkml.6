Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F330620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnjoDt9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F330620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeKGAkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:40:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKGAkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:40:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so3574115wrr.0;
        Tue, 06 Nov 2018 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewLEZeZQgZnIFEwPhYBe1WSKLEr+IPRChyroeXE6Kn8=;
        b=ZnjoDt9qY9u0pRmnrlAZlMzYTYD4+OKGMeEUUVBfAoyUrqn6vmPsLt/sIhz2EqcvKC
         7gqr3lL5iHyTxrz75UqZYi9m1NF35KVeMOM1dFiYRmcsxyKUfYo1/djpLPWxr2MWL61V
         ViCF/AAGYl6VMnB56fITgmQ4YiA11/P4EKcpjEPacMsNPbtEbbLdiF4HRT5GBcZvLrb8
         uAVXuwuxpdXcTsnO2o54544vj28ALyxCkEd4tm3aJMvXe6aYsClNNBPGokI0rKcQEbqR
         5gd34O68QSZxwjq2sK1E/OF6ZrKsT/NF/v8phlv1DmZ4fhL9iI6/Al9RuiRwL2dvgSQd
         EwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewLEZeZQgZnIFEwPhYBe1WSKLEr+IPRChyroeXE6Kn8=;
        b=WiBSo0Fo0oRzDDZNEDWjHkr6cO8bcpArM7sw7QohQozxA7zqMpfOxJC9VWyUkNk6AM
         ppXue5niG9VqPeXu/DqrLn2A10rPV3ZWXesayznJ3f+nliTVgn1qtqifWEWypSN3Jm1J
         IyqG5YY/diGaIzXP/aq3i1kcOjv6+N4h82qO7H2wtS4/sbcWzMfljONdzjyexM2yR/01
         8Agxw2okBcpWoaFd9mBnulzqqs0TN7rAvkabNZ+3D6XYAqV+oetCwNTqV0DdtV/1HmM0
         mj37ctj53dO6EQS1q7TyKstZpppqS4Wz6+w6NF1/dimkmaEhNJYCeLGXRy5mxyJ15Mg6
         dJJQ==
X-Gm-Message-State: AGRZ1gLCAVAVPRyGCkcgRmqKKRLR2Ma98Ax3Tx1Yi82maNPPcNwbMro7
        Ft/ewC83bqfNZlxS5y/DPLPorLM=
X-Google-Smtp-Source: AJdET5dU+HPXYO28k3SsLVNEa+c3fL63wYlitisxDs7mX5fUP+7TQ3vHoxbB5EwXRr8rtVC+nrbwDA==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr23135169wrx.140.1541517290389;
        Tue, 06 Nov 2018 07:14:50 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id w11-v6sm19694941wrr.96.2018.11.06.07.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 07:14:47 -0800 (PST)
Date:   Tue, 6 Nov 2018 18:14:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arch@vger.kernel.org
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106151444.GA11221@avx2>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105233301.KlgdF%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:

> -static inline int fls(int x)
> +static inline int fls(unsigned int x)
>  {
> -	return fls64((unsigned int) x);
> +	return fls64(x);
>  }

Should it return "unsigned"? Logically it should.
I remember doing this and there was some code size increase :-(
