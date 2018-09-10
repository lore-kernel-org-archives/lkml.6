Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0B52086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YFBIc/Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0B52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIJXqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:46:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50855 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbeIJXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:46:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so22622509wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3RuYV2WCbFak6rHBlJSrmbqGUlfLvEIJ9pu9hGvI5zc=;
        b=YFBIc/Zx8SbriVvg30C0+sPSNbjS8//GaBc5/FCbBDOvsoHAWcHKzj3HSxMcIArRCl
         nfAvSBsh3xyPTqWReDEbKQ0xmLhPhOnpbeH5PsQc7LswNxMg6NOPC976nA3bx2xdnFAp
         EglLpzZcLr3VQsH7GV+cQ7SqwL5rUzuznizg6CI1kcuoydm+BQK+CrnGczoP/HWjuKaT
         huhvW7fD0pODa9Pcamj0Fk0g1s4n5F2w62/SXMrROCRu9wX3Q/br2As8dsIMm89CSx4R
         r7pgiH/u/YTluoPapV+2ueRuGKkqjYvX1F2FHOJK992eD9MEy0v/L54fbQQIyJbtRryC
         pQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3RuYV2WCbFak6rHBlJSrmbqGUlfLvEIJ9pu9hGvI5zc=;
        b=U0vOHATC2XFIwc51yd2mw5eDSurCgwx567HusOBzf2WEaYOiGmguEYPVWcJw9DfeM5
         3XTejS4cOQOc+6joEuqwWzbIaxrcVsP37Vwvwl1qYE5n9LGUIYJ9WOhrlHVPbyJ69v1P
         FL3Piemd3BCUwKLwmu9v/ukHd81kE4wu7Wr/v3B5bQTt8ngATNYymff/TV0JZ65BwThr
         Bp6Hiw0gt5lGY9Gn5AUcbxHMDbvV6+9sx0efmL963wkzYZUHpuvmAqZIvV2FNwHnzH/x
         +xxpgrv5ZYpf/9PqUEfeDn0XRrMvcHrGF4gFk4eA5s9FKomT0pTNchxrfdLWP2+wfK+K
         QcEA==
X-Gm-Message-State: APzg51Dr2BazG2GuQatmUhIMbaSUFN0bX+8a7rbyC/lPw0UhVEgsb2RN
        yBb1jy2kCXWwwq5uaodh0vFj0w==
X-Google-Smtp-Source: ANB0VdYmTVB4fbwNTRiHm07abZJOFb9fcYrKub7FAlBzRkacrtf/yd7vs/ni6b6Gbg+wChrIhB3chA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26-v6mr1636535wmb.112.1536605443702;
        Mon, 10 Sep 2018 11:50:43 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l130-v6sm20553501wmd.16.2018.09.10.11.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 11:50:43 -0700 (PDT)
Date:   Mon, 10 Sep 2018 20:50:39 +0200
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
Subject: Re: [PATCH 1/5] powerpc: rename setbits32/clrbits32 to
 setbits32_be/clrbits32_be
Message-ID: <20180910185039.GB7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-2-git-send-email-clabbe@baylibre.com>
 <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:16:56AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 à 21:41, Corentin Labbe a écrit :
> > Since setbits32/clrbits32 work on be32, it's better to remove ambiguity on
> > the used data type.
> 
> Wouldn't it be better to call them setbits_be32() / clrbits_be32() to 
> have something looking similar to in_be32() / ou_be32() ?
> 

I agree, I will update the patch.

Thanks

