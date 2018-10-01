Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C102083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/bPeRV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C102083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeJAMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:09:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeJAMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:09:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id n2-v6so2915450edo.9;
        Sun, 30 Sep 2018 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMwx7TFPM7lpB4alMw91oqjiqxn1pwszOMuRYXcNaFw=;
        b=i/bPeRV8GWQaVfM03GA/xVHUNoaw51Jw2lraEPe103lUb/NFefZDjYmEMvBYwMh9wR
         KWi49s2CWXm2C/iqZ60R1J5NjRRFGpv0cFd4vUolI5gtA7Prk8hcHexgyifH0PZhEeOD
         /gNbTavvnuHumFeVAIhXIS7m48sAL+HwDwx6SIt3C2kf+mZxJA/h8wF0bZ4YLBUrFWEO
         z7knKENhQRNrlx64jkbmAsLzS1lFUKo3uBk7OfXHHuijGOHVnJUj/nI5O+3iy5/0bzc0
         wto2CDSy9bJcVIGl8IAtZkz9QO7Md83A9IN8eupFas413Pq4DrsKvsIxeOv538Uxjay6
         Hxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMwx7TFPM7lpB4alMw91oqjiqxn1pwszOMuRYXcNaFw=;
        b=sHV68mAgVPQfBg3ZNenSTEJi3mtDXwmcqOVLRvAq8gXNOYrhj6o6hkaHuyyBfmxHyx
         DF4rVjPgq8xWPSg6xU0axm2zP+lm4i6VO7gwuE4X1FzXQi02BvpO/yj4mtXQW/fzS6Ew
         N/jr7jn2VqwB1zccqHsLOyGfPZzqDYD9ZXdxObikXSDHyIh2Ll4McYu/EkVE9L7c98JW
         +imF19nov1pY4nWik8NM07wRigdQEzfBI37h3/OkU65eH2K68lEwqS0J1mwrZWZuM1M5
         CJMR/+UPA+TrHUIjfVHtztdb1NN48sYae++He4tZbDN1VGv++wej24gW/L4ds/u85TtT
         QPcA==
X-Gm-Message-State: ABuFfogyPiOLPEifQTXurSgjJkHhMZKQCix2R1tPe0K4dD3SIZ1rEJfE
        vEDw0yuXLAYwBW7dUVOxlNo=
X-Google-Smtp-Source: ACcGV61PTGGGu3OzDwslLFmiREvneyELd5Z1esiJENfWJcemZhQvF9AicVVe/qxpdDZG9tddsLzSrA==
X-Received: by 2002:a50:a347:: with SMTP id 65-v6mr8058626edn.57.1538371987266;
        Sun, 30 Sep 2018 22:33:07 -0700 (PDT)
Received: from scappy (d54c34dc6.access.telenet.be. [84.195.77.198])
        by smtp.gmail.com with ESMTPSA id z33-v6sm863738edb.85.2018.09.30.22.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 22:33:06 -0700 (PDT)
Date:   Mon, 1 Oct 2018 07:33:04 +0200
From:   Daan Wendelen <daanwendelen@gmail.com>
To:     Alex Xu <alex_y_xu@yahoo.ca>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
Message-ID: <20181001053304.sf64cx7lhot347yz@scappy>
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
 <20180930221751.rd7wva3zolephj6q@scappy>
 <153834665886.421.6376790866713055481@pink.alxu.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153834665886.421.6376790866713055481@pink.alxu.ca>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 10:30:58PM +0000, Alex Xu wrote:
> Quoting Daan Wendelen (2018-09-30 22:17:51)
> > Hi Alex,
> > 
> > I randomly opened your patch even though I have absolutely no idea what this patch is about, but I
> > found a mistake in one of the comments:
> > 
> > On Sun, Sep 30, 2018 at 11:06:39AM -0400, Alex Xu (Hello71) wrote:
> > > This affects at least versions 25 and 33, so assume all cards are broken
> >                      ...
> > >        * 1GBit link after resuming from S3. For whatever reason the PHY on
> > > -      * this chip doesn't properly start a renegotiation when soft-reset.
> > > +      * these chips doesn't properly start a renegotiation when soft-reset.
> >                        ~~~~~~~ 
> > I believe it should be "these chips don't"
> > 
> > With kind regards,
> > Daan
> 
> The grammar is correct as is. The subject of the sentence is "the PHY",
> which is singular.

You are right, I misread the patch. I thought that "these chips" was
the subject, but I believe "the PHY on these chips" is the subject.

>  However, I think it should be "the PHYs" instead,
> assuming that they are different.

I can't say.

I say we leave it as it is because the comment will look good enough.
