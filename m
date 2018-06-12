Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A572EC07D5C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E31208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1xtnvxx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E31208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFLFUW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:20:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44992 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeFLFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eUGBOe5JtRU5yDsZ51+xZBaz9v6viMnYte8JnvldPwE=; b=1xtnvxx+KGyzW6FGSVur59rmqR
        nSkMQf/y7o1Rv40EA2DYThm1mPWp/1Nzq8/BTdV5IL23WyzoR7LEQv0qBrBqRGJ3NnonptNtdjFUG
        eloxUgsLoyUcRXnP/ORdjgx666ol0HFr/UKQ/7Zd3hl2YzH99tAe+kqsgfclQAJXyv2jfAc9tjdhe
        pvysYLsxnz4ZUWz8+VyMI+vSqWM1e7wNZ9tRKhPUhEFV5Sze46N4Y5qjLuf7AVpc2F/AO9ab2pzMI
        Nt72vZVQFdj3++TLJBvWgX+Z8CX7XBtNDQ1+suAb6YjNOR4+9F0wMlHBUOL2aSiRF9sImMBcLPaxU
        23FIcQHw==;
Received: from static-50-53-109-124.bvtn.or.frontiernet.net ([50.53.109.124] helo=[192.168.1.109])
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSbir-0000L3-23; Tue, 12 Jun 2018 05:20:01 +0000
Date:   Mon, 11 Jun 2018 20:28:01 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180612112310.2d77e1c3@canb.auug.org.au>
References: <20180612112310.2d77e1c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: build failure after merge of the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
From:   dvhart@infradead.org
Message-ID: <775DC8EC-94B1-4A6C-B799-4E0156F5BE41@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 11, 2018 6:23:10 PM PDT, Stephen Rothwell <sfr@canb=2Eauug=2Eorg=
=2Eau> wrote:
>Hi all,
>
>After merging the drivers-x86 tree, today's linux-next build (x86_64
>allmodconfig) failed like this:
>
>drivers/platform/x86/silead_dmi=2Ec:84:21: error: variable
>'chuwi_vi10_data' has initializer but incomplete type
> static const struct ts_dmi_data chuwi_vi10_data =3D {
>                     ^~~~~~~~~~~
=2E=2E=2E
>Caused by commit
>
>2da502a0aea7 ("platform/x86: silead_dmi: Add touchscreen info for the
>Chuwi Vi10 tablet")
>
>I have reverted that commit for today=2E  More care please=2E

Grmbl=2E Thanks Stephen=2E I'll work with Andy tonight to get for-next bac=
k into good shape=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
