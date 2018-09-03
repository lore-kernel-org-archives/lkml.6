Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C19C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A52077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4A52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeICNvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:51:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeICNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:51:43 -0400
Received: from mail-wm0-f69.google.com ([74.125.82.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fwlDc-0004xK-4f
        for linux-kernel@vger.kernel.org; Mon, 03 Sep 2018 09:32:24 +0000
Received: by mail-wm0-f69.google.com with SMTP id t79-v6so236206wmt.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gA4CMHFpx3SYhrx7jxOLbG6PPLI8KyDREbDB3/8PSCs=;
        b=H2QHEYzrA8V4t4Wlfnnb7+NDaIB/8qen2q4+OxTWviCXFvz2Qe6DUrja3w9TrzbsVP
         tkrcCAYZTnHsrxhJfrzUKgn5Y+EeEP6orah6Sqo7myRdCB5swWwNDzarXOBlc0Uy8zI/
         NujAtQGLCK8D+IAH9TysJMgUovuc5wAxjEe/YoNFbXHIi6en9wuDPkQjrF0ohQEx2Xur
         aqBZKZFlGJyzT+IigrapZp9Pfz2NzvDM1iVkt4oLoCtawNPtA0aV/gaEGryW5yQQPXkT
         /d/kyJ5HgVFxAOBqBiltpUGxFTVAEgYnnKwzMke6r94fWW8Kg07MqXFmInJ9nio7/65i
         uZ+A==
X-Gm-Message-State: APzg51A1VG8Q8taylM6x1fgfifGyPWQjhxCL3su4vht1hljKwYQvHCbD
        uys6rQF4Z4WdXEzJT+3HdLE+Rjc8HZl7q4XpagVJTZHGUAuMFBWbZcbOw1KUORtvKueRGGNRgwU
        9v9cMd4pvQwML7po4+wd7tGlyX778qCWzW5HvKKUeZw==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr18536959wrp.85.1535967143825;
        Mon, 03 Sep 2018 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdYkby4v4fE+v8oLgw0K7TTep75/ELuG4k5sYyeu6L1J2f0VidTBcgSKjgrLkz/41ZbvDYsEKQ==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr18536948wrp.85.1535967143598;
        Mon, 03 Sep 2018 02:32:23 -0700 (PDT)
Received: from gmail.com ([88.128.83.136])
        by smtp.gmail.com with ESMTPSA id c15-v6sm8037570wmb.2.2018.09.03.02.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 02:32:23 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Mon, 3 Sep 2018 11:32:22 +0200
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     Jiri Benc <jbenc@redhat.com>, David Miller <davem@davemloft.net>,
        ktkhai@virtuozzo.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        dsahern@gmail.com, fw@strlen.de, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180903093221.bxdqw2iwvxli4dhf@gmail.com>
References: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
 <20180831.175847.339882322459287210.davem@davemloft.net>
 <20180901184704.lzynbw5zkyiqc6wb@gmail.com>
 <20180902115851.2b224c23@redhat.com>
 <d9efff32-4138-5645-c610-7f2051085d7b@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9efff32-4138-5645-c610-7f2051085d7b@6wind.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:50:00AM +0200, Nicolas Dichtel wrote:
> Le 02/09/2018 à 11:58, Jiri Benc a écrit :
> > On Sat, 1 Sep 2018 20:47:05 +0200, Christian Brauner wrote:
> >> Sorry for the late reply. Yup, sounds good to me.
> >> But maybe IFA_TARGET_NETNSID to indicate that we're talking network
> >> namespaces here? Seems to me that NSID might give the wrong impression.
> >> I'll send v1 soon. I expect tomorrow or sometime next week.
> > 
> > On the other hand, we currently have IFLA_IF_NETNSID for the link
> > operations. IFA_IF_NETNSID is more consistent with the existing
> > attribute. It may be confusing to authors of user space programs to
> > have attribute names doing the same thing constructed differently for
> > different calls (IFLA_IF_NETNSID and IFA_TARGET_NETNSID).
> Yep, I also thought to this. It had sense because it was the link family.
> What about adding an alias (#define IFLA_TARGET_NETNSID IFLA_IF_NETNSID) in the
> uapi to better document this?

Sounds good to me.
