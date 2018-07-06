Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE0C23FF6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM0bvTEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE0C23FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeGFIba (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:31:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38836 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeGFIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:31:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id j33-v6so3314361wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C4ftMIIBVyvn/K0NOb+9/pNDpUN47yEBBh8aaEw2/dA=;
        b=oM0bvTEQ4krmyd3dLzDHexzWOJLkv9PrStYkXcQ81jEH5XBpcuMK+1rqKm5uvf6d30
         JgR5eicfa/H/6+eNUlhQtqfJZAtVR4uUMSckd780RZ9OQpduORq9gAwgPACa+v8ZYtog
         RdcNYZ9bIu/fwXtqAoJc1TnqXGCBmQYvEWCCztQObDqVif9Pcfese3F7eMtoPPDG/ViT
         3Cv+hbADf6YUOXubVBlX73VPWzm8iWSHWjFcebmY9YYL0TWrXUJYMcAFRYzNNzDLSRBB
         PFOhENeXvvS7alro63VJeBsGNMGGk06ppeiBeei65V/mecxJ1/RxsxvfLPJItIcvtVLU
         jsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C4ftMIIBVyvn/K0NOb+9/pNDpUN47yEBBh8aaEw2/dA=;
        b=UbuXa+x/3aMKmoMpZHxVN5oUGSOY5iHGHGbGY6YlGhHVGHC5pUvuDpi5rZDEOtQ3gV
         Vv0Q22WW6iZgFmRgUGs8yu05CJpqF1EJ2Ti3sJyJY+xSz2/qvdOFaTCRr5Yptzw9ASZE
         evhTJQp/cAMfdkEvPqB15PULAYkKt4/RTsHEeGTN/yv9dXYdAWxfNr2Wte3nDrn9qOuK
         /SQHoLOOJPx+VsyD0lGlzF6lT7BK1au9ADACwVwYERCJoelD25vxpg3Hp1IKKoOMgqC2
         ouOMcbwPTKe/VKSvqtqHTWZ4+0sCPpq9SFRrjf2+7j/yarN5BTAeMN+FjK5z16mGLItl
         Okzg==
X-Gm-Message-State: APt69E19PANVhjAay/UVyJEy0IjN8cTTC4yM+RgAVAjIGyTV8P5/ZalS
        1CwgJgOjFWo/b5gNlFLZi1/ZFVLsxjIqWh0F1eY=
X-Google-Smtp-Source: AAOMgpdG5v43uXvhYLv+SSScv23f7mEmY8NfQNkGd2+/ZzJ+8LVZ50eAXJu3xFospIqp1CR1kx+Ry29ISyTX3GuSDA0=
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr7309228wrj.158.1530865885949;
 Fri, 06 Jul 2018 01:31:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f10f:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:31:24 -0700 (PDT)
In-Reply-To: <87601tz1oz.fsf@notabene.neil.brown.name>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
 <87601tz1oz.fsf@notabene.neil.brown.name>
From:   Vegard Nossum <vegard.nossum@gmail.com>
Date:   Fri, 6 Jul 2018 10:31:24 +0200
Message-ID: <CAOMGZ=GsA4_Zz1z6mae2WzmAeL5p9r-7mXC8ksE-uEF7YP_g_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] cachefiles: Fix assertion "6 == 5 is false" at fs/fscache/operation.c:494
To:     NeilBrown <neilb@suse.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        kiran.modukuri@gmail.com, Lei Xue <carmark.dlut@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, aderobertis@metrics.net,
        dja@axtens.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 July 2018 at 01:45, NeilBrown <neilb@suse.com> wrote:
> On Thu, Jul 05 2018, David Howells wrote:
>
>> From: kiran modukuri <kiran.modukuri@gmail.com>
>>
>> There is a potential race in fscache operation enqueuing for reading and
>> copying multiple pages from cachefiles to netfs.
>> Under some heavy load system, it will happen very often.
>>
>> If this race occurs, an oops similar to the following is seen:
>>
>>  kernel BUG at fs/fscache/operation.c:69!
>>  invalid opcode: 0000 [#1] SMP
>>  ...
>>  #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
>>  #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
>>  #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
>>  #3 [ffff883fff083a30] die at ffffffff8101859b
>>  #4 [ffff883fff083a60] do_trap at ffffffff8163d860
>>  #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
>>  #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
>>     [exception RIP: fscache_enqueue_operation+246]
>>     RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
>>     RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
>>     RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
>>     RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
>>     R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
>>     R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>>  #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
>>  #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
>>  #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028
>>
>> Reported-by: Lei Xue <carmark.dlut@gmail.com>
>> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
>> Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
>> Reported-by: NeilBrown <neilb@suse.com>
>> Reported-by: Daniel Axtens <dja@axtens.net>
>> Reported-by: KiranKumar Modukuri <kiran.modukuri@gmail.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> ---

[...]

> Thanks - I like this approach.  Taking the extra reference makes it a
> lot more clear what is happening and why.

The changelog is a bit sparse, no? We have more info here:

https://lkml.org/lkml/2018/5/8/520
https://lkml.org/lkml/2018/7/3/1184

Why not crib some of that and explain the issue properly (or at
minimum link the previous threads)?

Thanks,


Vegard
