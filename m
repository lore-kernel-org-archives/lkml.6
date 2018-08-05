Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA53C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5A217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0fMepGmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E5A217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeHEDB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:01:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52812 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeHEDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rfevzn6qtzydYhEuzNQTPMtvQAZcgFpy4upGzsBxshs=; b=0fMepGmzJNGSdM430fNsHyMs6g
        kDO+t9kRRh4m4vYOuF5SxJvbOTLnVhHpYr5BWY6goVwwSXjhlJdMhnqMaJr/wOnT+IYfeMLHVPBSi
        LpKjpLdVTiw/DwJtnkWJ7Gp2bia3o2HKAT8U6BfYkxSwgwI7kNJZhlAH2B14NoK7SyZNWhhCcndsC
        wTramCmeSHzBT5BwfMaBIqtKf8YG4i8eUkGMzopEPakqN7UuSbmGQNWsigk1GPENMtl5KS/ZFVQLx
        eOAVsImZ7pN6GzkhFFkKBXm0FeZ3fT2yrYymGaAUpr+mxZRl5M4zgeL3ythI+vY1TEpBEGjFuwpCe
        FOQ935pQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fm7Nc-0005uX-Hr; Sun, 05 Aug 2018 00:58:44 +0000
Subject: Re: [PATCH 0/3] Kbuild: fix and clean-up arch/um/Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <086167f3-5ed3-1184-bb6f-6c86a5bd6a77@infradead.org>
Date:   Sat, 4 Aug 2018 17:58:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 09:47 PM, Masahiro Yamada wrote:
> 1/3 fixes the build failure reported by Randy.
> (I may have seen a similar report before, but I cannot recall it.)
> 
> 2/3 and 3/3 clean-up the Makefile a bit more.
> 
> I'd like to apply this series to kbuild tree.
> Ack from UML folks are appreciated.
> 
> 
> 
> Masahiro Yamada (3):
>   um: fix parallel building with O= option
>   kbuild: add %asm-generic to no-dot-config-targets
>   um: clean up archheaders recipe
> 
>  Makefile         | 2 +-
>  arch/um/Makefile | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 

for the series:
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
