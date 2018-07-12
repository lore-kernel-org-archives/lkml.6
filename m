Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22AFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9383221471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c9SsB3DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9383221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeGLGJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:09:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeGLGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eEovRPntPvFsYeGDXWTI9WdWzGli48czGPGCpmvpV9k=; b=c9SsB3DPXzKml3a5sTV7ILH2Z
        DjCd3hRcS7dcMTxBRaLIMjBBjg7huZ+FwANgQkHy0TeYBa2MDdXkW4MdKNikhs83W3AUVVWpZ5+0n
        GapklMWW9UXO7MyZxn9zoV7h1GmZ6otL9IOm+P0cmNwwjAifSymhFJ50TGofRnhiQBmIz6GBl5KFa
        Q1wxOg8GKtOB1pwdL2e+ea1mG1ySJDb+SPqUbyFRZ+XTPeNNysyZQym0qCcxoVGTimRzg4FgeBWhl
        SdgeHG+x7vJRr3z/psXe72jN73wn66OoKvkuoYY6ufWJwoUmsPpO59KzvuLFLTpZHJdoNiSQV9HXe
        IUqwkG89g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdUfu-0006k0-Ga; Thu, 12 Jul 2018 06:01:58 +0000
Subject: Re: mmotm 2018-07-10-16-50 uploaded (gpio: gpio-mt721.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <74774f1a-9ba3-63db-5777-b122d4b17cea@infradead.org>
Date:   Wed, 11 Jul 2018 23:01:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180710235044.vjlRV%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 04:50 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

from linux-next.patch:

on x86_64:
when CONFIG_OF is not enabled:

../drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
../drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
  rg->chip.of_node = node;
          ^
../drivers/gpio/gpio-mt7621.c:243:10: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
  rg->chip.of_gpio_n_cells = 2;
          ^
../drivers/gpio/gpio-mt7621.c:244:10: error: 'struct gpio_chip' has no member named 'of_xlate'
  rg->chip.of_xlate = mediatek_gpio_xlate;
          ^


-- 
~Randy
