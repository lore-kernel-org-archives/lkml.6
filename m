Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B320844
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KzINOM2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203B320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeHaTq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:46:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35503 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeHaTqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:46:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so10454098ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+1E+03ac7mb0WNGQ6ODDNvv4PQ929itM3tgun8/s5g=;
        b=KzINOM2fI8oGAtDio6T2Xcl7IBtftuh/H9cD9Jw9+Aj0Avw6qLq7538B7j7guUECoa
         bxMLfgTPAPRZJoJiA/Q5cg/ng7urORaz3sBS+SAC+d6mmrhb66RuOQqZBfMg/cQUhUdH
         DVMWI43w0u+aqT7AF5LbkGU9GhXT928WyKjtW3BOn+1+gy+ZuGZzs5OOaPxJDsfp6cys
         8e7ibHJCLMiYItbluxtAOV8cP0lYS9Z83oNl5gWkMZdjCXeIb5YuJE2AqjE67BPXobaT
         4XDMFzknm9p4kRWj4eT/Q8/cZTbilpdwqVTiftwL/qDXYTr2/ftpHYzydqxZ+ILPiS+Q
         NT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+1E+03ac7mb0WNGQ6ODDNvv4PQ929itM3tgun8/s5g=;
        b=pzsDVUzH3GxmZWQoiMa+VhN4zMCyXH4lm7jqAtXOqpllM1qyXtea9hXSGfVPZkCl8R
         MNUyv8J43o2hOSCvg0Yx0r6FV5LsXB3Fr329DXnbQj3sI3wybFnZkO37oAEzXwE/NHie
         Np4wsINL3+SiWoE+ynUofn++skntGS6ApfkMVMfxac9Q8IzH0X7Rh2VAmW6RYJLIvxil
         hG1bASe1T2ftb1iSUbmbwylV1j0y+pMHUhrX/J5axb5hEJ2Hs1RQwVjp+c/XxMi5wcba
         Re2QI0HT4H1N3eebruZe0pi3jYjdcUETybU0t5ZN7KEpiRUAUmYuW7kQ5CMajShCGOyX
         UqTw==
X-Gm-Message-State: APzg51B1OKc8nykp1/rgs2/lkhupsAdt0NlwWJZAkkRoZ0YTTqTmJeeU
        6joopWsXUzu/n4QWjiMrQfSdD3rdRb3NY028kSM+OdnuRVg=
X-Google-Smtp-Source: ANB0Vda8hDaWEBabXaPz2kZlSz/4WO5L2OVzxEdcXmbhE6PohvIaAzh0dTtJg8NctHo5E1nUZnAJe8S+nC+qy4D4tbA=
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr10378061ljj.13.1535729901122;
 Fri, 31 Aug 2018 08:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:c70a:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 08:38:19
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:466f]
In-Reply-To: <865zzuyijp.wl-marc.zyngier@arm.com>
References: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com> <865zzuyijp.wl-marc.zyngier@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 31 Aug 2018 08:38:19 -0700
Message-ID: <CAOesGMgsnE=fQwWMs3bkQFn_-9m3XLsnon+Q=NHB4i+o8b5hiQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: cap lpi_id_bits to reduce memory footprint
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jia He <hejianet@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jia He <jia.he@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Tue, 28 Aug 2018 05:53:26 +0100,
> Jia He <hejianet@gmail.com> wrote:
>>
>> In commit fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs"),
>> it removes the cap for lpi_id_bits. But it will cause more pointless
>> memory footprint.
>>
>> There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
>> ============begin===============
>
> [trimming not-so-useful trace]
>
>> ============end============
>>
>> In its_alloc_lpi_tables, lpi_id_bits is 24 in QDF2400. Then
>> its_allocate_prop_table will try to allocate 16M(order 12 if
>> pagesize=4k). Thus it causes the WARN_ON.
>>
>> As said by Marc,
>> Capping lpi_id_bits at 16 (which is what we had before) is plenty,
>> will save a some memory, and gives some margin before we need to push
>> it up again.
>>
>> This patch re-caps the lpi_id_bits.
>>
>> Fixes: fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs")
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Thanks for doing this. Small problem with this patch:
>
> The email comes from hejianet@gmail.com, while the sign off is by
> jia.he@hxt-semitech.com. Your email should start with a:
>
>         From: Jia He <jia.he@hxt-semitech.com>
>
> Other than that:
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Olof Johansson <olof@lixom.net>

> Thomas, would you mind picking this up so that it gets into the next
> convenient -rc?

Yeah, it'd be great to see this go into -rc2 if possible. Thanks!


-Olof
