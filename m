Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13298C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0B720854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AkKjS6Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0B720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeIJXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:48:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52905 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeIJXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:48:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so22454866wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Tx/eu5rm0m4dwC6pvywi/Z9EN1mDEfIw+XcoZodFk6Q=;
        b=AkKjS6LwUmrW5OVh/RMQPmITeMfHdmmGd+kL6fmQt6n7iMKPPd1ylR7aY6Ct7yE7zf
         qnEIlKqPqRqNhsX9dgDyQiMPIPrcg2dIlCvXReHff33DV6zl43clQMV57kb85HHJRnOw
         3MX5PkBEZMi4G3zvbgPSKf/AQkCCUov+1XTxoh+POsFvNP4ayG7oJQPdaWiy01MevLh3
         o3hlpFedUW3sfLt9Hr5EV4V8CgEQvdwFxvUElDz/OsB7tzLJYOm24T1OO0b1ooiDf5vr
         VVb+/cU9yq9zELgVfbMnS4cG7FN5W/EIMDlC/bQ9nkl0hVKg+izzIzQHfvFtrVvDIuET
         84zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Tx/eu5rm0m4dwC6pvywi/Z9EN1mDEfIw+XcoZodFk6Q=;
        b=BdIsSD88Q3RTyw56aIbZdTx0b5+6mmeE6Apd/s0+ztRa4QNQsilTLnS0I2QbkXgZ1N
         x7X/O7twi7hs76Uz+OqAYJpeV06fJ+8jSqV9l6vFuftw4fSWlX8fVy39HsCdwX8I9XgY
         w9OaR4GJnPEpvwNU/rePhx4OhNU8/yVf/sm0VDINjtfDnqvd2ZUs7iptrpHeVjuZAejj
         u+dl/0NVdLc81qdravCW/HXnnbzXmqtIeZuV5tcXwtqnHHR6gb2lVIMdhme6w83I9AEQ
         OS3AviA6gqY3UNmjaNWg+n03YWADGkpoAKSwzz8yrx0uThtYU9pHc43026kEl5MPqZTU
         mnEw==
X-Gm-Message-State: APzg51CBpIHj4WLr00r5nH6eUUDF12MNfvqVVpUo79UK2573m+nkLyI0
        eJg5yYB8uyIwDSkqsQTxz5TBCw==
X-Google-Smtp-Source: ANB0VdaFZXeYkgHP4u6K1fdj0B1lWs8M/a0X3yjC1nhVFjWjn6RPuUI5DcsIzPpdE46CN26Tf+DXig==
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr1600915wmg.27.1536605608719;
        Mon, 10 Sep 2018 11:53:28 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id 94-v6sm20826894wrc.10.2018.09.10.11.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 11:53:28 -0700 (PDT)
Date:   Mon, 10 Sep 2018 20:53:25 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Message-ID: <20180910185325.GC7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
 <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:22:04AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 à 21:41, Corentin Labbe a écrit :
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> So you changed the name of setbits32() ... to setbits32_be() and now you 
> are adding new functions called setbits32() ... which do something 
> different ?
> 
> What will happen if any file has been forgotten during the conversion, 
> or if anybody has outoftree drivers and missed this change ?
> They will silently successfully compile without any error or warning, 
> and the result will be crap buggy.
> 
> And why would it be more legitim to have setbits32() be implicitely LE 
> instead of implicitely BE ?
> 
> I really think those new functions should be called something like 
> setbits_le32() ...
> 

I believed that writel/readl was endian agnostic so it explain my mistake.

I will use xxxbits_le32 as you requests.

Thanks
Regards
