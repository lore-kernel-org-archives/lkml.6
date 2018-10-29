Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D51CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5A2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C5A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeJ2S2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:28:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44355 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ2S2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:28:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so7062849ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1XiehrWMgEE3MbsV+WpFw5f4mLZWIAN69gitf+vjDs=;
        b=W2D0uUs3gPi0vbpkd2DLU8GcgQ7HNP6ZC5Cyr+E1wCWRvYrJP1J8Ce0bRI3E24TWoN
         lWncCuG7K+2gS1ywPlHo/uC4g+zOTvua3n6Jezw1sMPyqQsQMW89xLdh9iEQ+kspm7ZZ
         Jv1IJ+q0dSkMZRdEt/aqRpcMykUJSooCuo1d6VkwVRe3sR6wC+62a4CoXQWyd1nap1kE
         NxaWOvXK2I7LRwFbtn/gu7NgXGMf+S+kWyVaBwtfsYZXzGUUAdKVNTfEZIqSmgArDJWa
         DX2uSCr92y1e1dDbZyqWC9+C9Hq/ErXDnuIRU2cxO/z9HGMl5d+vqBM9gKkFwURotayx
         SNfQ==
X-Gm-Message-State: AGRZ1gLvxMUBEIaz3gs6v2ZBTkgshvfrViV7oziNmefS/h51czRDu62a
        jLijYHR1NmNFNYSc7wLUtQk=
X-Google-Smtp-Source: AJdET5cHx9XPqixwZ+8mO+7PhK2xVnSH/bPhvzN/m3/2MB+xbmPAycC/STYPkfiqOf/kC3P9Ib4drA==
X-Received: by 2002:a2e:4611:: with SMTP id t17-v6mr8520543lja.92.1540806044003;
        Mon, 29 Oct 2018 02:40:44 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r10-v6sm3083446lfi.15.2018.10.29.02.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 02:40:43 -0700 (PDT)
Date:   Mon, 29 Oct 2018 11:40:41 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7: add missing linux/of.h inclusion
Message-ID: <20181029094041.GB20774@localhost.localdomain>
References: <20180919071400.GA12191@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919071400.GA12191@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

I see we got build warning from 0-Day tests. It seems to me the
bd718x7.c file lacks of <linux/of.h> inclusion.

I am not sure what has happened as this include was added to bd71837.c
file with commit

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=df43519eb706edfe951284a825642ce2e1d38d09

The bd71837.c was later renamed to bd718x7.c with
commit

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/drivers/regulator?h=for-next&id=2ece646c90c5b45dd76c76ea207a3f3459f2c472

So I am not sure where this include got lost. (I did search for all log
entries with my name and was not able to spot this change)
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/log/drivers/regulator?h=for-next&qt=grep&q=Vaittinen

Should I just create another patch to you where this inclusion is done again
or is there some better way to handle this? Can you cherry pick or
re-apply the commit

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=df43519eb706edfe951284a825642ce2e1d38d09

 - even though the file was later renamed?

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
