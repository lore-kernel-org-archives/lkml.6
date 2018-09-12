Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B605AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FBD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOMEjZdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FBD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeILWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:03:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37335 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeILWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:03:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id f1-v6so1268230plt.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IUyrxS9O298mMFj9ZUGbzvXi17JcRSzgBXOWYGhGGIM=;
        b=HOMEjZdwHDkb8VulHUfiQWoPKGpLV9U32WoXhQrwEpQkAnBJyvdvSJbbkj45MCo37t
         DDRWN2aBWlgH+Fhgww0rShUwr4Rc6qmJa4hhOifTdoCgdF/Jb/UWfETI7MRyoQXfXxAy
         2qT5Uqlo/fmkQ0+sQlftdByEtNCgdbIb+lnn0nvm8ot9ZnD4rHASKsZR395FnDh7MIlo
         e8NuKD65I7BYpdbwiXY9T8BxEg0M28GePxAdlPLetfF23gzvno0tIdAKybSNhY++Z+fi
         M0rO7XmOML333SXUURNrG/fdhFQy8w8jSYLVjmmd6i06VsCmYfbRkiKr+gGNiX1DeZRg
         4Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=IUyrxS9O298mMFj9ZUGbzvXi17JcRSzgBXOWYGhGGIM=;
        b=rWWfcgQO8mIYB5jWYWifrDs9dJqBkwkgugpFkHkNATvNgG703jelwmXVo1yww32Q+8
         5vFyDhFTw4YribLhnX5n+A5Bk6nZzFBeHF2mOk9RLpDn2AI1KQOaI9ehgjf5Ol3DBumO
         85TZmmM6eWXNBpijqGKPewQEi9HeSsoMa8LXPDoxAcwN4/jwB3I9A6ZsvjWvZkk/OBmp
         k74rNm4Dw5NlMYEfIwo7KBBqSrncBMiXq8ub1tdQfQ8hGW9Mduazus4MYl/21TpIVqLx
         6R8qq9BhVrl4/li2bLXmXjAJCp5wKESbvxnhQWcAX/RudVuAzYDcHPq3lSVjQ7aeTDKg
         S5Lw==
X-Gm-Message-State: APzg51ClTXhMxeS5AA4EXIXAEVUH+FDjEYJk/QWkCgclPF31dRJB9iaD
        OGQQBMJw+QnmTbg1YrqGlNU=
X-Google-Smtp-Source: ANB0VdYPkbmeTM/nNRJnNKu6MvdEc+GnSSHXBF4gP0ApR16bna+y3QaNBBVFOULqVZj81uhpCf1Lmg==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2-v6mr3330638plb.185.1536771499951;
        Wed, 12 Sep 2018 09:58:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n9-v6sm3919610pfg.21.2018.09.12.09.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:58:18 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:58:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Message-ID: <20180912165817.GA5118@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 07, 2018 at 03:13:10PM -0700, Vineet Gupta wrote:
> helps gcc with better instruction selections such as 64-bit multiply MPYD
> 
> before
> ------
> 82c34b58 <sched_clock>:
> 82c34b58:	ld	r2,[0x83068d00]
> 82c34b60:	add_s	r2,r2,0x7530
> 82c34b66:	mov_s	r0,0x989680
> 82c34b6c:	mpymu	r5,r2,r0
> 82c34b70:	mpy	r4,r2,r0
> 82c34b74:	mov_s	r0,r4
> 82c34b76:	j_s.d	[blink]
> 82c34b78:	mov_s	r1,r5
> 82c34b7a:	nop_s
> 
> after
> ------
> 82c34b7c <sched_clock>:
> 82c34b7c:	ld	r0,[0x83064d00]
> 82c34b84:	add_s	r0,r0,0x7530
> 82c34b8a:	mpydu	r0,r0,0x989680
> 82c34b92:	j_s	[blink]
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

This patch causes my arc2 test builds to fail

Building arc:axs103_defconfig ... failed
--------------
Error log:

standard input}: Assembler messages:
{standard input}:154: Error: inappropriate arguments for opcode 'st'
{standard input}:157: Error: Insn j_s has a jump/branch instruction j_s in its delay slot.
{standard input}:186: Error: inappropriate arguments for opcode 'st'
make[3]: *** [net/core/dev.o] Error 1
make[2]: *** [net/core] Error 2

Building arc:nsim_hs_smp_defconfig ... failed
--------------
Error log:
{standard input}: Assembler messages:
{standard input}:218: Error: inappropriate arguments for opcode 'st'
{standard input}:9329: Error: inappropriate arguments for opcode 'st'

Building arc:vdk_hs38_smp_defconfig ... failed
--------------
Error log:

{standard input}: Assembler messages:
{standard input}:9629: Error: inappropriate arguments for opcode 'st'
{standard input}:9883: Error: inappropriate arguments for opcode 'st'

I use a toolchain based on gcc 7.3.0 and binutils 2.30. What version
of gcc and binutils do I need for the builds to complete ?

Thanks,
Guenter
