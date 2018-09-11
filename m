Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC362086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvx5KLsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC362086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeIKNaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:30:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36963 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeIKNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:30:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so10997747plt.4;
        Tue, 11 Sep 2018 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+5SKP0DJOPWYDuZu3ojUagm1zf4fSkwgebPgCS3KImA=;
        b=Vvx5KLsbPTmAOun5bC4pSYhrAKY7PsXWRbtU1H/fsAQu8Mv0AzQFEALvqtJcDjHWtV
         t2XANEz1nKJ5HGYBTD8ZuHHiIqYmJouPZNwOrLWKS6w8t1qHFFNsW+ULZJx6WHG0yuZ3
         P5OGOnDHTMVsvqVoW0QYz4moMK+gHg9j6o/pHYf8JTJzGrb7ygxstt8SL3Oe/xEw9fW8
         bcSiF/3dreRCqUSK778DK2xXeH1UuDjOeIAq/BMLWhyb85LpWfzZu+B9GwnXviifb5K3
         AFbIGNcXi/wZkCxWCXXt5sDj/Z+tWqoXDyXP2BBfim9LqUBnA4Qifs7jBBlpetjr7lqV
         OS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+5SKP0DJOPWYDuZu3ojUagm1zf4fSkwgebPgCS3KImA=;
        b=D2pfsDF8qHsgCe+pBcqP5ici3a2RmYbudjdPyx5DbbBKSa5cqN45oS94AKccD/hqMH
         yL8/2UIpubZIMSzUvKt33Rbr6Eig+sWaqRmR9IcOirF2zDguhLOBnM+PyprM5tzpvjiO
         1Otif2gjKEhZXTcGZEPSVwSEo6WCLmW5xmfolgWQRDteJej3jSIeD5npDMiO15GAtMdn
         OiszHY4K/NO3pjNo6W8lG+ikixPNxQRwdi2eYc7wv9XUkRLr/BomFJ0fI7Z0K3TKhJ3/
         72GdmlxcetKKkMW2F83XJpTDfHXYC0nbtPUCNP1wCVxg7o3JmMTgCf9G3H3JKb43k2Te
         jGMw==
X-Gm-Message-State: APzg51C0ZxCc/3Rrk2OjSUP8bLQL4Vj9pOQKNsKXQKPfInN22xW9iMjw
        Mepj0cI+TV+/DabL3HhshwM=
X-Google-Smtp-Source: ANB0Vda7MbFmOvj7uzdoQVHJusC0sJ+Ty6W2Hyt0n+PZSsVI92dURsuYurONBceuBT26e65zfKWYLg==
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr25918113pll.217.1536654712819;
        Tue, 11 Sep 2018 01:31:52 -0700 (PDT)
Received: from f2 (113x35x119x249.ap113.ftth.ucom.ne.jp. [113.35.119.249])
        by smtp.gmail.com with ESMTPSA id n9-v6sm37186077pfg.21.2018.09.11.01.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:31:51 -0700 (PDT)
Date:   Tue, 11 Sep 2018 17:31:47 +0900
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Camille Bordignon <camille.bordignon@easymile.com>
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
Message-ID: <20180911083147.GA31642@f2>
References: <20180806115913.GA21556@super_plancton>
 <CAKgT0UcUV8bQRAhyevfnvwE+yWnWjwAkH0WumUoUK4Fa9SCzhg@mail.gmail.com>
 <20180807064222.GA30741@super_plancton>
 <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
 <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
 <20180907062851.GA7336@super_plancton>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907062851.GA7336@super_plancton>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/07 08:28, Camille Bordignon wrote:
> Le mercredi 08 août 2018 à 18:00:28 (+0300), Neftin, Sasha a écrit :
> > On 8/8/2018 17:24, Neftin, Sasha wrote:
> > > On 8/7/2018 09:42, Camille Bordignon wrote:
> > > > Le lundi 06 août 2018 à 15:45:29 (-0700), Alexander Duyck a écrit :
> > > > > On Mon, Aug 6, 2018 at 4:59 AM, Camille Bordignon
> > > > > <camille.bordignon@easymile.com> wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > Recently we experienced some issues with intel NIC (I219-LM
> > > > > > and I219-V).
> > > > > > It seems that after a wire reconnection, auto-negotation "fails" and
> > > > > > link speed drips to 10 Mbps.
> > > > > > 
[...]
> 
> I recently figured out that neither the previous patch nor commit
> 0b76aae741abb9d16d2c0e67f8b1e766576f897d fix this issue.
> 
> In these cases, after reproducing the issue, when ethernet wire is connected
> kernel logs mention full speed (1000 Mbps) but actually it seems it is not.
> The problem persists.
> 

Hmm, so the newer (post 4110e02eb45e) kernels are actually "better", in
that they accurately report that link speed is 10Mb/s.

In the end, do you know of a kernel version that doesn't exhibit the
problem of slower actual link speed?

I had a look at the code and I tried to reproduce the problem on the
hardware that I have (I217) but could not.

Also, out of curiosity, have you tried playing with the speed, autoneg
and advertise settings via ethtool -s to force the link to 1000Mb/s?
