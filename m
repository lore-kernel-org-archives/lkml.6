Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B8C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAFC2178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JQhgYndx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAFC2178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeHEBw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:52:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42705 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeHEBw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:52:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so3426285edp.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwYXFwkeKoF2cPxGYnlPcPFlT04hGCvYNg9UseeqgwA=;
        b=JQhgYndx/8W1iTffAPU2sSv0cHpqFeH142enCVkGt4YKcBGmjyOLbaJpavDgrP3SNq
         WNmgMdFi/GooD2P4M0mQqr/9mSN3yUbwPdIET6TX1cA4D+IIxBFUSU/asly7I7FsBQt2
         L88mHUhTab1NpSR7CGk5Apd7K3PSMQxh7fybR9dSa0VS3+QulL3sg5NKv1eqGR78M8I6
         8V60r+79n/ETj2p+fwTlRYOzWrX89LQe35PdHq5S63FNfaAG+VuZVsHb3wHM5EbOtipw
         LuV/DKBie6s/kjyKvAqLXVbrpzZRyGJcf7r7sxmNqMut1dKXt6CMG1ueB4mZwLKFCcFz
         5spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwYXFwkeKoF2cPxGYnlPcPFlT04hGCvYNg9UseeqgwA=;
        b=fmQYABF/ZhVB5vp7Xpts7MNoS7CP4mWnKc5QlkQHfvrMUmgNB0jCKCER4wPB/KbR/R
         Lix4q4qKXnsL8OxAsFJQ3SvRCwKJaZYdrVegKdKNgVSPDunqS1DL6/DEDuvvBLFWjq0J
         MIXZK5xtDHs3H4WAvVJHlMCeei4jJf8f3UzgdDv1JQwtAf/HxmnnwfiLRSnFuU44HULi
         7WSS3lwBKJHUp0KHuXnRWZIp5ozR2GWOKMteTv3KlxsyU3tdLQgjxHpDoRpoDUATgwgl
         vdK3L8ioTY6KwskuaPMLWD+V0ahAgrvLzC6bKcJ4y+bq/izPzsmBV1YpJ9ibnwVlL6s+
         rCSA==
X-Gm-Message-State: AOUpUlGw4p7b1IRbGxhUsKYQAUnliDbO9EJbHqjtzgwYH8FIBgDvCaIF
        ad2L6P05d7rQWxstOO4aW0ivJQ==
X-Google-Smtp-Source: AAOMgpfmy+yDSUu5TAjbOXHoHwybls4C9+sQDeJfnhnZq0pr0/cQoALEN3fPN2Ge3+WYY/pN2UeaRw==
X-Received: by 2002:a50:9493:: with SMTP id s19-v6mr12469064eda.285.1533426632798;
        Sat, 04 Aug 2018 16:50:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id p40-v6sm7644040eda.53.2018.08.04.16.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:50:32 -0700 (PDT)
Message-ID: <1533426631.2679.155.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     natechancellor@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org
Date:   Sun, 05 Aug 2018 00:50:31 +0100
In-Reply-To: <1533426268.2679.152.camel@arista.com>
References: <1533424322.2679.144.camel@arista.com>
         <20180804232102.GA3982@flashbox> <1533425198.2679.148.camel@arista.com>
         <20180804.163348.896647113172060665.davem@davemloft.net>
         <1533426268.2679.152.camel@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-05 at 00:44 +0100, Dmitry Safonov wrote:
> On Sat, 2018-08-04 at 16:33 -0700, David Miller wrote:
> > From: Dmitry Safonov <dima@arista.com>
> > Date: Sun, 05 Aug 2018 00:26:38 +0100
> > 
> > > Thanks for the testing, sorry again for the breakage.
> > > Will send the patch shortly (with sizeof(unsigned long long)
> > 
> > instead of
> > > hard-coded 64). Hopefully, not too late.
> > 
> > 'groups' is "long unsigned int" not "unsigned long long"
> > 
> >         long unsigned int groups = nladdr->nl_groups;
> > 
> > And nladdr->nl_groups is specified as "__u32"
> > 
> > So the size of the relevant bits is actually strictly 32-bit.
> > 
> > This makes also the "ULL" in your constant specification incorrect
> > as
> > well.
> > 
> > So much crazy stuff going on here :-/
> 
> Right, I misslooked that..
> How does this work on Android then?
> I doubt they changed uabi.

Ok, I'm too slow - that is 32, but shift does overflow.
Will send the proper patch in a minute.
Sorry about the mess :C
