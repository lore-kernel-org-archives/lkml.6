Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B63821773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547123627;
	bh=hxB3X2IZAOY7p8YaBTzDDfTeXaxGftQX9uCotusATCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rtAIgq1JFMUVEcOaKaePdLKtcuz7aV4yEKy1+idmOKGN8Qt3TB9qLyudonEYZz4SF
	 +NBbs0ss6mO+LQNy3Qx9+bhk6D9KZAoNGzk8q9ulTh6YOPRRw72crkQ5k4emrmyWUe
	 qVkunbnSdoENDSu3cZnkbauEaBRAO3Icc6jd2yK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfAJMdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfAJMdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:33:46 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3815214DA;
        Thu, 10 Jan 2019 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547123625;
        bh=hxB3X2IZAOY7p8YaBTzDDfTeXaxGftQX9uCotusATCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiwsatEx+dl0bJbYDe6GrkuHqP5hEG0q/gl+Vs/kGG3aFhMpxOFCSnpgdaJUZT/pW
         Vi8bDcIjPCnI06o7gPweoMyOPWgDYW6qeE/amoB7vl3qHatINV2sFiamMPKTdtf2jR
         Z5OlEV0xa8tj7C0m6Azpt3HIOL6hNg8ncCADji2k=
Date:   Thu, 10 Jan 2019 20:33:39 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110123339.GA15390@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190110081052.GB13262@guoren-Inspiron-7460>
 <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3OS2Y3_B04z5shaT+CHZ3isQYj-GO+G9kxeY4aGkQmUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:22:46PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 10, 2019 at 9:11 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Sorry Linus,
> >
> > This pull-request is wrong on the patch:
> > "csky: fixup module relocation error with 807 & 860".
> > diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> > -       uint16_t location_tmp = (uint16_t *)location;
> > +       uint16_t *location_tmp = (uint16_t *)location;
> >
> > Please drop it if possible and I'll send another [GIT PULL].
> 
> It's already pulled into mainline, so it can't be undone, you have
> to send a separate pull request, based on top of the patches
> that got pulled.

Thx for the reply, I've sent a patch for it.

Best Regards
 Guo Ren
