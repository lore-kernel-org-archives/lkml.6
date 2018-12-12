Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DB92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZf80CZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DB92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeLLQrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:47:01 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39129 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:47:01 -0500
Received: by mail-pf1-f172.google.com with SMTP id c72so9135422pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKexHWBSPBTwgHQ3TVsh4NUrQIerF2gMww+s2Yt8PRc=;
        b=DZf80CZY3ZSg8MNKSWUEb2WZm+H9h90sfk1FpqpNsM9jvL9OSwpO2cSmU1ElPDzJGv
         7wompIKWprPG5pktbAXEX4qSlzwdXxAC6PxfEYCXz8Ro70FoJ39Pn9UdvG4wsWExjAHs
         pBhsy9Dz3kTxBquXsYV2+t/O2SLeAANacR0MFMedeyDU7Hf0w32nbkJzrukW3UlGy3tn
         YMK7kvr2OQFsiBeYMgEc5Ap9pqZgL6RNd/FRA3EqycCZLvqU/WOtyrq3zsvlDW8b27qd
         AM6Cu6YvjLNY0WqbhEXXHSpFXCqFeTJ/4iUaJQLQCwyxGMdQeK6P7f63KnYzzirUIR3y
         E1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKexHWBSPBTwgHQ3TVsh4NUrQIerF2gMww+s2Yt8PRc=;
        b=GWw5KjN+vmbUEllXarKuoNygb6SP+j6xk+BlSnhpsvzTBs83ajENDL01fJwaHmDSdb
         Lees/YGvytF7ZJWL3v3B3SFdsXsjssQaKu9rwusOFzX2zv+4ZsDdKv31xxkbqKm/gM4n
         UnuWGHcgzpEf/clobmv3ZHXYfaig9k4Qxo54b1I5xtseXLcqQf/Xp44z8jlZJdKdM5mZ
         Ej/bWv4k7AfrRk6jS4bL2LNLCLYq9b8MBox38cCtnyEXnPfrG1lQQST143kR0+wJwL4I
         jpGFbSQ8GXL0KX4/2kcieqQkBSKnenGGt1pY8c4SQfMkPPwrsO98fiY/hSYDEN5Dqo+/
         uF6Q==
X-Gm-Message-State: AA+aEWaNwh/51LjaaOgptit0BkJmJ5tEQ3a97LIoAy2advciRx/eWvlw
        htBjFEtRbLw3BYBqeZPvtjA=
X-Google-Smtp-Source: AFSGD/XE0M1tivgWU5+fyQCrHj8ldJLjuBLljhTwYGnI3029F91sD+L3/43flbcpk/9Ta3elU22ghg==
X-Received: by 2002:a62:14d1:: with SMTP id 200mr21151444pfu.103.1544633219150;
        Wed, 12 Dec 2018 08:46:59 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id x26sm22242652pfn.50.2018.12.12.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 08:46:58 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:16:52 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>, yamada.masahiro@socionext.com
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 0/2] scripts: coccinelle: Improve boolinit
Message-ID: <20181212164651.GA12081@himanshu-Vostro-3559>
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Masahiro Yamada

On Wed, Dec 12, 2018 at 12:55:55PM +0100, Julia Lawall wrote:
> Reduce the scope of the rule and improve the warning messages.
> 
> julia (2):
>   scripts: coccinelle: only suggest true/false in files that already use
>     them
>   scripts: coccinelle: Correct warning message
> 
>  scripts/coccinelle/misc/boolinit.cocci | 43 +++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> -- 
> 1.9.1
> 
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
