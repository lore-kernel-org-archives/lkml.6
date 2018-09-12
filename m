Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22733C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC820854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXKijnVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FC820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeILPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:21:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50968 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:21:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so1772345wmc.0;
        Wed, 12 Sep 2018 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+fvZCpy4CBqAz8fGFL0GVNITnbfG0Uw+lmE/k3Y7kH0=;
        b=dXKijnVyHAyCAytO02CT1IVaNvKWqx5yoHgkclETb5x2lPfoH82dB65YL5f00SESbn
         dRtbj52jEJPdMWwbvZdSY5K88vbhQNvaZAN9TVlRof7xlurfBWPuPz9r9a99ARisjfe4
         wajqikHPqXmC/BVNim7hGQkpOsylr4ttIN8Xyt7sFmtsZIbJbeXYu3opnRY9kIqnb/QI
         PXIzVZ/6cybEKG7EJYK7xA2HORHs04tcYYLvh28OFvV2GQU4GCQt9iSdEIfzASI84iup
         zz5+BcQHyPtPLzt2ZX3i9El1bipsZbHtlB4z9jKC9LYlSDmqe1dAeB2eYBWyiI5mA31k
         xqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+fvZCpy4CBqAz8fGFL0GVNITnbfG0Uw+lmE/k3Y7kH0=;
        b=eV1npuQMWItqi44w7FqdyCKY0NnP6aaigVOQXkjstzc3MvQ+stS/SFUrf0hE1E7uoF
         KRKq9BiZmarDTvMwa7NTQQEJxUgYynILyLtjFkD3RBM8SDl1SbpaMzsh09t/0hZY+K9O
         I5Xj6haNU4Y10n+B0HZSx2eOXiiWlmKyA2CbqxUz15Z4D24AoA1Fq4REAcR5S8RvHWaZ
         9VdmjKIQnL5kysRAR8tJK35fERw8A5vhzALpbE4YuqFfeH6qTeH20ZcP21pV9D2z7bDd
         UPZTEnzobAixhSMz4J6QtXtk8z7+xFIM7VQPP2d+Td66Uznkc1Kl1v4WrlE2U9Frti9b
         ViJg==
X-Gm-Message-State: APzg51AIxmkftHTTGdjSnT1l9GCA9ZRvqWNamqqi456aRkkGJms8l1MS
        xEoaOW44T3JcdqAd3KDoYY9l5QaG
X-Google-Smtp-Source: ANB0VdZarvpcHVULIzn1qxBPz0MGHAvEmeHJehYpJHxo6toLGc6Fp8L7/0+te0Y1u3ovRK9uoHXUkg==
X-Received: by 2002:a1c:1eca:: with SMTP id e193-v6mr1015088wme.99.1536747472244;
        Wed, 12 Sep 2018 03:17:52 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z101-v6sm1043826wrb.55.2018.09.12.03.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:17:51 -0700 (PDT)
Date:   Wed, 12 Sep 2018 12:17:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
Message-ID: <20180912101750.6slpi3puoww72xsj@pali>
References: <20180902131932.11558-1-pali.rohar@gmail.com>
 <87bm9ft5h5.fsf@mail.parknet.co.jp>
 <20180903074005.7e3guj24ksq2l44c@pali>
 <874lf7t3gg.fsf@mail.parknet.co.jp>
 <20180903080422.ta3clnhr5bobv6il@pali>
 <87zhwzro1o.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhwzro1o.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2018 17:19:15 OGAWA Hirofumi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> >> That source seems to check power_of_2(size) and 128 <= size <=
> >> 4096. Rather why do you want to support larger than 4096? Or I'm missing
> >> something?
> >
> > I looked into (Linux) mkfs.fat and it supports formatting disk also with
> > sector size > 4096. Therefore I thought it may be good idea for ability
> > to mount and use it (on Linux).
> >
> > I could check what other operating system would do with FAT sector size
> > larger then 4096.
> 
> If there is real user to use that, I'm ok though (of course, need
> serious tests). However, FAT would be for exchange data with other
> devices, and there is "cluster per sector", and spec recommends sector
> size == device sector size. So I suspect this format is not useful.

I looked into OpenBSD, FreeBSD and NetBSD source code and there is no
explicit upper limit for sector size. Just that sector size must be
power of two.

I have not did tests yet, but you are right that some testing should be
done.

As FAT operates with clusters and cluster size is defined by sector
size, then sectors per cluster and sector size defines cluster size. And
cluster size itself implies maximal size of FAT filesystem.

So increasing sector size could be useful to create larger FAT32
filesystems as current limit hit by sector size = 512 bytes.

What do you think, which operating systems should be tested?

-- 
Pali Rohár
pali.rohar@gmail.com
