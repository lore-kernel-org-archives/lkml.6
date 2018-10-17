Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6349FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349FD21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349FD21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJQRFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbeJQRFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC5D0AE62;
        Wed, 17 Oct 2018 09:11:06 +0000 (UTC)
Date:   Wed, 17 Oct 2018 11:10:59 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] kbuild: check the presence of lzo and lz4 tools when
 necessary
Message-ID: <20181017091059.GB22571@zn.tnic>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-4-git-send-email-yamada.masahiro@socionext.com>
 <20181016195420.GE27990@zn.tnic>
 <CAK7LNAS7wzJ+L-2kC2fyi9Ta9qq1jiM0-UOAisGL2CZuSEoE7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS7wzJ+L-2kC2fyi9Ta9qq1jiM0-UOAisGL2CZuSEoE7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:59:02PM +0900, Masahiro Yamada wrote:
> >   DESCEND  objtool
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   Building modules, stage 2.
> >   CC      arch/x86/boot/compressed/misc.o
> >   LZ4     arch/x86/boot/compressed/vmlinux.bin.lz4
> > /bin/sh: 1: lz4c: not found
> > make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> > make: *** [arch/x86/Makefile:290: bzImage] Error 2
> > make: *** Waiting for unfinished jobs....
> >   MODPOST 956 modules
> >
> > What am I missing?
> 
> 
> I have no idea.
> 
> With liblz4-tool package installed on my machine,
> I can build x86 kernel with CONFIG_KERNEL_LZ4.

What happens if you remove the lz4c executable? Do you see the ugly
error above or the "lz4 tool not found. Please install it." message with
my config?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
