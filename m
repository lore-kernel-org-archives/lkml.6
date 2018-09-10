Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzxe0Yq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B5F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIJQ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:28:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35723 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:28:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so21118564wmc.0;
        Mon, 10 Sep 2018 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTylQ4ofpLVoXS5Zc6IRLrkWY3vps1FjxB8a0pzObeI=;
        b=Bzxe0Yq1PrGZCGh6jfv7LNG9XiWpUZ3I2xhn8/AEwu1g7E8i8LggZBr+ckTPntk3hD
         5bEM4d7021ZcySHyOZ7SxovTlysV/GqgJjIWTBrCzQNsjo+vJogtvYw/H7UJr092sznY
         qHpaiCWLfkbXN+geIdPr/UxU5Mj+cLGG0ku4RtjObbZPliir1IRg9FULyw3zCzlMRnYI
         0jMpj6GW6SgVPFMtX61rEPgFgHHv5RFKKFppaBb1v+fIa/wl0QSiKvW/kwqxMMXut/du
         tIfLsNWNNlAUF3dfZylBd8qqpRvuJYtG3j0RfpXz2xZYIQfgO0H63TGPgZFcIcHjLGvV
         p6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTylQ4ofpLVoXS5Zc6IRLrkWY3vps1FjxB8a0pzObeI=;
        b=HItnumZnXSFvJaZSgWyMCV6vpQ+HIlXlF/izeB/1KPtXGe3tV7Y53cYpLQFXhWAvHH
         uHbgQY31hSjiUd8Tl+Pa/EXGvgbBmccsU4zOjfzi+ZID2qPCrGHIQSEZvEiM1bgOSz2M
         +BVB63ekjRrnKZUHyIERfe8GBGUaEDmjuUVsS5KyENDCbu4BytDHAxpwFsNYsEdF8ylT
         T8dMjYGIQkMMImQzPUyG2Smu+gVDRdlg38m5zkaqsCeSBSGDs4dlhGtr3a2lfPa5Gm/+
         DX88k0okydzjL51DJkfQJuJr6sV2wX2uqACs0m7F+dISrxmdS2Xwu+ezH1bNWq0HYUY6
         yRaw==
X-Gm-Message-State: APzg51A0R1Tyjz7Z2Sa+vGRiovtMyAWS4lI+53utBTYKxR/6NTXQreET
        YhD7H/27KugvCbbK5/BkkAQ=
X-Google-Smtp-Source: ANB0VdabDdEgpxmb7fwqL7hcAcL/WetI9FVjJLjbj9c4fsluZFt8eODTiVlqZWrjupefNx/Mm39mLQ==
X-Received: by 2002:a1c:1609:: with SMTP id 9-v6mr466859wmw.12.1536579291772;
        Mon, 10 Sep 2018 04:34:51 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:81e:af75:e036:d35f])
        by smtp.gmail.com with ESMTPSA id y205-v6sm7121059wmc.3.2018.09.10.04.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 04:34:51 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:34:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910113448.dxnfvznyimtj3tkv@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:56:33AM +0000, Christophe Leroy wrote:
> 
> # export REAL_CC=ppc-linux-gcc
> # make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5
> -D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
> scripts/kconfig/conf  --syncconfig Kconfig
> #
> # configuration written to .config
> #
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   CC      kernel/bounds.s
>   CC      arch/powerpc/kernel/asm-offsets.s
>   CALL    scripts/checksyscalls.sh
>   CHECK   scripts/mod/empty.c
> Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2

OK. Clearly nobody has ever used it so :(
There is an infinite loop because cgcc use the env var CHECK
to call sparse while kbuild use CHECK to call cgcc here.

The following seems to work here.
$ export REAL_CC=ppc-linux-gcc
$ make CHECK="CHECK=sparse cgcc -target=ppc ...

It's a bit kludgy, I admit.

-- Luc
