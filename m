Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E4D2172F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="OTh/wn2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E4D2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeGBRxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:53:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55689 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeGBRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:53:36 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so13261375itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BHY6ZYxXh/5SIU0rqcfR0+xK86kbiJ6vjr2Qlu+kZKA=;
        b=OTh/wn2IC0mPu07QAxDO8vnUZOEcYbhXsepIjGzVoSw7c2iObjlE6hLZAFqrhRNhCO
         Y2TAnapW43ANw9UWAIZd914chvBUrfO/HY5kxwRAA9/V4B5nj+eaFIJhVXwZWJ1JYrKK
         8gO4nAFiYwVC0NBseiZ7fE0B4frJ//C/+Fy5YJSIGEESHVkvx9hvYZIgHhRuz1htxH+t
         P0HmyiX3epHnt+r3jztuCzASpoUcCGgznb4lpLg8astq5dMGVSaKoXUnXIvb54Pq14XB
         sYkIPWglQeg7+P2E5SfGCWVOAvUhJB7r9o66gtYeM40QXf0o0npuvqZhl9hjhIPulR7E
         k8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BHY6ZYxXh/5SIU0rqcfR0+xK86kbiJ6vjr2Qlu+kZKA=;
        b=Gqmvred3JlDShb7M1/Yrj/h+IF7UKq33ZajDOE1kpjUtwphlXMNFAFnyHTuAjtECbK
         PMAL+PoNpLMUOO49lLOLjBa73B775oWPhP3Gfb6u8O0JoY3TOLlymJCEFJu3PSjJEIEP
         /xn2Way7G1RfHcHg2wGVrHkB+l/NXxNFmNfnijc3tYK2YLSWzZ7xQbyTPMXR6X+Lofck
         4r9vRDpKHLJAsdQjwN7lltN928soWqXZTVP0g74zOnvtvpTnRXMsp2pqVRi5rRe71E76
         dPun1sc8LiVMyceyaktMNJUr3Ps4zCLss33sQ8c5CfBn+CT8fIcyKK8pElr5YjTDCf2r
         176A==
X-Gm-Message-State: APt69E2/i/xA6/ycjcsRGXtnRjD/tJa9bjY1GxUxatsDuquDXtPTW0Fx
        xiAFazQwtTE/WOaejKmsi0Eb7A==
X-Google-Smtp-Source: AAOMgpe8iAkN0TEqc56IV+xavZTooEXsJVwJIuzrpRE11wcB65xP6SpmRGBh7J7+FWxT1gSWsg2A9A==
X-Received: by 2002:a24:ce41:: with SMTP id v62-v6mr6452250itg.57.1530554015668;
        Mon, 02 Jul 2018 10:53:35 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id g81-v6sm6889874iof.13.2018.07.02.10.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 10:53:34 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:53:29 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Cl=C3=A9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
Message-ID: <20180702175329.lobhttvi6z6nkdzq@x220t>
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 02, 2018 at 03:28:04PM +0200, Clément Péron wrote:
> Could you review it please ?
>

sorry... I was thinking a lot what I can contribute to this patch, I
want to make it short.

I see your use case and your use case has of course a valid point.


What I can say about the code? This socket layer was contributed a lot
in a time where the subsystem was unmaintained. Stefan has some
experience with this socket layer by doing some examples [0].

In my opinion I am confused that a lot of netlink handling is needed to
do "something" with this socket layer. I already thought that we need
some af802154ng for next generation.

Known bug is also RAW sockets on af802154 are totally messed up... but
we don't need them, this can be done by AF_PACKET (just need to think
about similar handling there).

---

Now to your patch, you use skb->cb there. The tc ingress part can
_maybe_? use this control block information. I think this issue is out
of scope because we have also other parts in the code how we pass data
between driver and packet layer with skb->cb -> we simply do it wrong.

I have no problems to have this patch inside but for future we should
tackle a af802154ng with a better UAPI handling.

If we fix skb->cb we just need to think about how to pass such data up
to socket layer.

- Alex

[0] https://github.com/linux-wpan/wpan-tools/tree/master/examples
