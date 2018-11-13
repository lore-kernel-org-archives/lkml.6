Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B891C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C922507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTUdkwgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25C922507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbeKMMJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:09:54 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38296 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeKMMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:09:54 -0500
Received: by mail-yw1-f65.google.com with SMTP id h123-v6so336342ywc.5;
        Mon, 12 Nov 2018 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woqON29sDppaFa7PHsMdLKhOo9G+cuc/+i8sqgC63/4=;
        b=aTUdkwgSmSjE9qcgRTjRfpDzQBhQ8uesbOQjNfzpjY+xLxH+2lo/lzdU0U4MAbFmkI
         5/aI2z3Ehf4Yz4L42xS2cyxI71kC1qxPFut3vrcWTKkALuxlEvqOY+GAW0s8j6YohK7V
         BJqU0MH6fqYt3IgL1N6yNbKC6MPIT2Phw/WqZsBoIVvP9yvkKBqft1dKs2bGx1RGKhru
         i4+gcOX4nR5s4itFYfjfbD5mF+iIthWHl3UTUbOLP9X1xC/9t4U06kGvGHVl5sxVGZ8p
         x2TQE5xggqf3UBeqyAiNvzP5zIYKrBsi/5DdY8GHmHL3S2Af7JuCJBkeW8vyRpEMJjXh
         7GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woqON29sDppaFa7PHsMdLKhOo9G+cuc/+i8sqgC63/4=;
        b=KfRy2MFBnwulWoazc3aK14TRL2rfbWNHDaIst6efecNyTfknucIvwu2K08VfWnPCWf
         /Q+edeifBX+dIv3FXYnnVNT+jxh1avxeUqvCX+aYeGpgfKTQohuf5x5tEvTUrfPSU1ai
         sGoP1gyGhrQt9og05VcDIOIZcMeuRfZfpJ7IAVUVE10etjxgt5p6/APMDu4vaO5LL1lE
         TduIeZe5UF62qgHUVxb1jCdbt6q+0luZdx1FolX4uVStslX65c4pDaup/ToxXSM4yGP0
         urbY3VXv6eN8a3+Gls2ColBC0Vzzg/ILjzWRLFw/IjexZHJ+W1HstiP4FTvNVG0dVA+U
         4Bag==
X-Gm-Message-State: AGRZ1gK3ENzjN7Ya0bql1ynZQ8EtvMhcS1olduhH/V/fwSlaUapRyoqD
        X+q9MBYPhjnl8eOQfojlkzrFYEsdu5ZCS52IlnI=
X-Google-Smtp-Source: AJdET5fbNyLcvl1IZ8mMyx6KwQQOM8BjI7VXaqEkiQAppQy/dk+vzes/LPNrI/CXuYj+w8nDHyVOeJQh08HRniHOExY=
X-Received: by 2002:a0d:f103:: with SMTP id a3-v6mr3352562ywf.468.1542075239590;
 Mon, 12 Nov 2018 18:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20181113020113.29640-1-palmer@sifive.com> <20181113020113.29640-5-palmer@sifive.com>
In-Reply-To: <20181113020113.29640-5-palmer@sifive.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 12 Nov 2018 18:13:48 -0800
Message-ID: <CAMo8BfJWaO6vyikaTRurX3wsMneBr0wWuq+eCgutOAG-Uv8EDw@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: Indicate that xtensa supports sg-chain
To:     palmer@sifive.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, aou@eecs.berkeley.edu,
        ren_guo <ren_guo@c-sky.com>, andrea.parri@amarulasolutions.com,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, rmk+kernel@armlinux.org.uk,
        Will Deacon <will.deacon@arm.com>, jglisse@redhat.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 6:03 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> This was suggested by features-refresh.sh
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  Documentation/features/io/sg-chain/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
