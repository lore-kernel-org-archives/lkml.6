Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60998C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D3217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C5WbeZA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9D3217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeHECjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:39:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33005 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHECjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:39:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so3470804edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTt0JluoyzBHg6Sslo/56PgSemOt0eCgCkwz+E5A8JQ=;
        b=C5WbeZA7/X4Z50LOoAIRXln3ISW58cD7XaQwqBOQxhBjBnzO9SEjANobyvlq5Ub42X
         kQBhTGh8JbCTtDIXXT+H/4bC0nsgTHhUx5R9tDdAfoppVORqJQUGZqzBJrqQZo+1/Vrl
         7zsI1FvgFwpjggZhQfmiuF/4kuQu+cMkyX4pf36P3OWhT7PI/owDbt0AHCvo/5o4KnNr
         LEUqKWfgQRvWyIfjiBdHtGcATBC2G9dVK3jiR+8p468nUWpNY+2nm4cAfHi8M6aoMZsu
         5DkWA8GukxH2dpeHDcvE6g6mXyD8epwrq9uDp3v2GhBhBoJstIVC8yKBvNpNAb3ml477
         0bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTt0JluoyzBHg6Sslo/56PgSemOt0eCgCkwz+E5A8JQ=;
        b=kLIEQ4Z358qGoeX8oqk4sEc86Zc74Tr4kY5RC4c4vgQXG2vRg78rWl3dMJAfpMLsDU
         uqVZ22mpRnZ7M2rHuchsiKqE6ltqLaKEMoCQONZlShBZ4H/whRwuKyrMg0A+grtNtyXc
         Ymm/vLhFeTv54x15kcHWrgSFOgX9s7jhksbTR/VBIdHNnvip2gQs9wuF3E1A2kDXB5cI
         ywLeTdbwDcWJYllxmSG6HAkRJf4Mnb81EWqcFk8V5KgJ0NXOO0SrLBDl4zllI4K5Brr0
         cIJPJbq61rT4dFNdO0Rl7JgJR8V552u2vAw6L7U1W+7z+H2OyF+UrgrcTsLpP7c22mdB
         Cyeg==
X-Gm-Message-State: AOUpUlEuFNXibwDsnylzPhMujtoPQwSbkEA1n2wwyZyGtAwBLPdYEJFY
        Mj1h5E21eJ3Si5BuzKwWL3YvKg==
X-Google-Smtp-Source: AAOMgpc2QP5PIcFWGwknEHJf6/eEkhRR5nkZSwBOrckMprTKNJ6/t6SiAKzdb3OVNbvQLoaSG+/mMw==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr12299794edg.25.1533429431688;
        Sat, 04 Aug 2018 17:37:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id p10-v6sm3130324edh.9.2018.08.04.17.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 17:37:11 -0700 (PDT)
Message-ID: <1533429429.2679.156.camel@arista.com>
Subject: Re: [PATCH] netlink: Don't shift on 64 for ngroups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org, stable@vger.kernel.org
Date:   Sun, 05 Aug 2018 01:37:09 +0100
In-Reply-To: <20180804.170856.2031275734761112973.davem@davemloft.net>
References: <20180804235544.10347-1-dima@arista.com>
         <20180804.170856.2031275734761112973.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 17:08 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Sun,  5 Aug 2018 00:55:44 +0100
> 
> > @@ -1011,8 +1011,8 @@ static int netlink_bind(struct socket *sock,
> struct sockaddr *addr,
> >  
> >       if (nlk->ngroups == 0)
> >               groups = 0;
> > -     else
> > -             groups &= (1ULL << nlk->ngroups) - 1;
> > +     else if (nlk->ngroups < sizeof(long unsigned int))
> > +             groups &= (1UL << nlk->ngroups) - 1;
> 
> Sizeof is in bytes, you want to compare against bits.

I'm too bad. Drop this version, please.
I've resent v2.
