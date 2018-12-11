Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3324DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE812054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544539442;
	bh=jgH4Pd48VOsaiK9D76yCSq6L7Lgc++xPq8WOzg0yxyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mTp2CJR693W09aLHxi7LcWJwwcpvDYnG5raUgfmt9HhqGvybrlMKQ5PtsPaiImXFl
	 5VBznQ/0wrTH1Xr/94eqN8znpy5rnXRJlqbYWkYqd+wwz3KN19hGCtCMyNHiPlHOgV
	 XlJT0BCN+GZBPWkn9CnC/G3xGB5O/JyvLvFn7DSQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE812054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeLKOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:44:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:44:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2505364wmd.0;
        Tue, 11 Dec 2018 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ccD+kdiWAzAcykpu4sjBPhcau0AaOdROPYqfds/Quc=;
        b=GOFWpiIKXHP+83uXX1vAzmFBrqCAxCJ12ApA3we8z00dS40ZOeb1/XnSwOI4PkAPzz
         XQFkExE0m0TZKbLZaDRVSUzG2L9YTmcyTOktF8CS1rhbBTNTxPE0WhUKAEsYZCJ8l9Fm
         ppAEBKOsg+926MpbWimKQHZIl7dbCxj8DAhOMen0qU6S2HGT3Itdd7bhw1fipdKovgw6
         8+gUJWfi4kNGNhS/H9UBKsANrR/NoUvCwwZkf2SoyicmKthgbOPFITpH0EjOLBrE4/wk
         ZFqmnq06DCVxuqfoA+J0YEp//f2MZ0773zqjzpKY5feVCbF3G7FPzgMQ3q4G1Jp2ZowD
         cQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ccD+kdiWAzAcykpu4sjBPhcau0AaOdROPYqfds/Quc=;
        b=ncrh9zWFzcZK0k/Z4Y9BdUcixw7bdBi9kYkCXqXk/nzr9CeoF5NGwJ8lOp7ihVD2CR
         iCIhmmiJUCTVScFUNSRT+gby4PDBtwCpK8LwwHLH0sbLStWyT9OsYXCvJzmF823wn7tj
         uZuu98gZOnZDy38U6hcOQUQ+uozKM+NmUZMhCg/xQmQu2wHp5+gS/+NXzO74Ke3Uaifh
         wT94Aho7wKdyyyFe1RDQTwDwrv3jrurt1E5H5ZZ2BXHTPkoA1mMdNxxUGo62tq9pZa9l
         wxGdkNjfV4eHhUPffgk4hRZqS2T1arF6CdVAVeh0/FpZBQ0gBr6nUM1a12GygccAxioa
         TOhg==
X-Gm-Message-State: AA+aEWaF4hGiNLbj2mxeiiWudewH2Efhmpu0VH05yLTnjx5nrhEZomJD
        PJwf6LyN60iG6sFcL9vNzS8=
X-Google-Smtp-Source: AFSGD/UXOD3G/2J3Aj2DwB1aVKzTqgDZPWsqPkr3xbbFvWoFmWs64S6/GjtdFggBfxb9zyZbYU3TBA==
X-Received: by 2002:a1c:1550:: with SMTP id 77mr2754688wmv.100.1544539437747;
        Tue, 11 Dec 2018 06:43:57 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l3sm15355508wru.36.2018.12.11.06.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 06:43:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:43:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Message-ID: <20181211144354.GA89489@gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
> 
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
> 
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
> 
> Make it treewide consistent now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks for doing all this Kconfig language work!

Thanks,

	Ingo
