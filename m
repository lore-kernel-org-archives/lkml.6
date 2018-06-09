Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sZ2UKUBTHFtuSAAAmS7hNA
	; Sat, 09 Jun 2018 22:23:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 984D06074D; Sat,  9 Jun 2018 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528582980;
	bh=PvP1EVL2pl5QrExOD+bUp54xz3TxVXc90a10fKzWKXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M6Ub51w1nNDyR6eNGFgz4H2VgkaLjk9jPBBtXLA7gRR6ESg4mPZ2+MYDejAh/KDVd
	 3q4txeRe77agpec5UR6v7TGvJlT93uVl0Y5PDjYOQeNuMIE+Z7Rfjl0D4+IrU68vvC
	 1naGfK1rci+AhBqUMLPHjfJgODEUYI8Bj+W7TcwQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 15D83600D0;
	Sat,  9 Jun 2018 22:23:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c0Ei0b8m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c0Ei0b8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15D83600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeFIWW6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:22:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeFIWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:22:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9835B6074D; Sat,  9 Jun 2018 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528582976;
        bh=PvP1EVL2pl5QrExOD+bUp54xz3TxVXc90a10fKzWKXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c0Ei0b8mbso2Q26ifpRqEoTFLh1iTU3rTjQpoV9Y+RmKTBCGeBZh4N+8/tC1pUjm9
         SWQbBbgw30jkYvRtGY6nWVWy7Fj0V0ifK7SABq7ziOZRi/pprao73yUZvNu9Twomrf
         M+BaaPT0WrPyU/3SkB+Tkj1HFWpoa3sU6CNLzZf8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 14B72600D0;
        Sat,  9 Jun 2018 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528582976;
        bh=PvP1EVL2pl5QrExOD+bUp54xz3TxVXc90a10fKzWKXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c0Ei0b8mbso2Q26ifpRqEoTFLh1iTU3rTjQpoV9Y+RmKTBCGeBZh4N+8/tC1pUjm9
         SWQbBbgw30jkYvRtGY6nWVWy7Fj0V0ifK7SABq7ziOZRi/pprao73yUZvNu9Twomrf
         M+BaaPT0WrPyU/3SkB+Tkj1HFWpoa3sU6CNLzZf8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Jun 2018 18:22:56 -0400
From: okaya@codeaurora.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] staging: rts5208: add check on NULL before dereference
In-Reply-To: <CAHp75VdkDCCJCqBTGsPCzaCKfT_bqYNGDQekvr56U3fhR+uthA@mail.gmail.com>
References: <20180609163829.30619-1-vasilyev@ispras.ru>
 <ddb00f65153abf3dfe81d9da86c9b98c@codeaurora.org>
 <CAHp75VdkDCCJCqBTGsPCzaCKfT_bqYNGDQekvr56U3fhR+uthA@mail.gmail.com>
Message-ID: <6358f10997e30da2fe91e75525d14131@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-09 15:34, Andy Shevchenko wrote:
> On Sat, Jun 9, 2018 at 7:58 PM,  <okaya@codeaurora.org> wrote:
>> On 2018-06-09 12:38, Anton Vasilyev wrote:
>>> 
>>> If rtsx_probe fails to allocate dev->chip, then NULL pointer
>>> dereference occurs at rtsx_release_resources().
>>> 
>>> Patch adds checks chip on NULL before its dereference at
>>> rtsx_release_resources and passing with dereference inside
>>> rtsx_release_chip.
>>> 
>>> Found by Linux Driver Verification project (linuxtesting.org).
> 
>> I think you should bail out if dev->chip is null rather than adding
>> conditiinals.
> 
> I'm wondering if it's false positive. At which circumstances that may 
> happen?

Only if dev->chip allocation fails. Code tries to cleanup prior 
resources by calling clean_everything() function which ends up in 
rtsx_release_resources()
