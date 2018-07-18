Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2CB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeGRWsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:48:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbeGRWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:48:54 -0400
Received: from localhost (50-234-71-226-static.hfc.comcastbusiness.net [50.234.71.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 30A8B1479FDD8;
        Wed, 18 Jul 2018 15:08:59 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:08:58 +0900 (KST)
Message-Id: <20180719.070858.620001411860238690.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.mesoraca16@gmail.com,
        f.fainelli@gmail.com, David.Laight@aculab.com
Subject: Re: [PATCH v2] net: dsa: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718203725.GD20228@lunn.ch>
References: <20180717041034.GA37382@beast>
        <20180719.053333.396851874410198344.davem@davemloft.net>
        <20180718203725.GD20228@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 15:08:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 18 Jul 2018 22:37:25 +0200

> On Thu, Jul 19, 2018 at 05:33:33AM +0900, David Miller wrote:
>> From: Kees Cook <keescook@chromium.org>
>> Date: Mon, 16 Jul 2018 21:10:34 -0700
>> 
>> > From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> > 
>> > We avoid 2 VLAs by using a pre-allocated field in dsa_switch. We also
>> > try to avoid dynamic allocation whenever possible (when using fewer than
>> > bits-per-long ports, which is the common case).
>> > 
>> > Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>> > Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
>> > Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> > [kees: tweak commit subject and message slightly]
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> 
>> Florian and Andrew, please review.
> 
> Last time there was some discussion of just always allocating it to
> make the code simpler. But the extra complexity is O.K.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Great, applied, thanks!
