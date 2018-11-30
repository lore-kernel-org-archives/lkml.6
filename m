Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619FFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BE920660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gStp/Q3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BE920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLAJEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:04:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51901 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeLAJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:04:09 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so771886itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YbALuDan4FuFV4eX+ephaYVAxQ59K1quXJ7RMoEMPCs=;
        b=gStp/Q3zfBzq/lyYrmhyYUyTfzQvBSpaY/q+qV+o16X3MgO4QcPUbeUFaN+luJ3xCe
         OeGsX+HZiqUP8UcEdwkk0VGO8tfh2EwCF8L50Kr2BMqRpnUKmzYZIHBDTpunfC7zaBQR
         6+l22+BotVOOql+jPfxn5nIA9gLNotLSfL9p/0/3Asopet7x2Q4ChxYxj9hv0xCOWSvP
         gCT1XAkuHhbq5+fHhxdi5k4c7yDrFqo/2czq5R9h4JcGS53AIxTBrk+sz/HrRC9ZAMY7
         UzqgyPQgvRs7m2JOB2MY5P8grMuR6ES1VxQHRCm+DYXSCYhomk+cuhY21cVTQFJUKlJ9
         dZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbALuDan4FuFV4eX+ephaYVAxQ59K1quXJ7RMoEMPCs=;
        b=Ue0F8yzqcGDiWFyKuD6emONgKah/M6tDnyDrCjud2vI7xohc5QGR8ufiUbcchAvLlz
         7kHRcUTOkbjBD6gSOOX/w0kVnxyXGurlj7rPPXekWvhOXDbh2OtjBqBdiu2CDdIcrYFR
         GDLEVYKI1IyhYVYllz2ivIZ4HoGU4d4K+5NT39Jagpjm+QHQuwFGeOWHSQUjUrK7DVPj
         JrCsMQQ7gC5dvM9Whv6PpE7eRTS8cka/9WvU2KU7pcxpAY7TxaBAyfn+qES5r9ikOWYi
         Z9D0TplDUCVy+Aqtj+yk8VbCtwnJGRzyDUaLHh/1x65wY65c/Pm0N83f4mC353dW2m6W
         QF0g==
X-Gm-Message-State: AA+aEWZxCaMjpr+XYlgFEXkt1cH6Lt1WAOZAt+B6wxEBfgw6fPBaU/2Q
        ezqfJji0RzBxHw1ctmoP7U0g6Q==
X-Google-Smtp-Source: AFSGD/XDQInznbS4iopjRBTDXgerdxC1yiEbky1iNrPAUAfmUb5wHYHEYjzCsl0n9R1fDEYT7A4y5A==
X-Received: by 2002:a24:4d87:: with SMTP id l129mr447326itb.37.1543614807405;
        Fri, 30 Nov 2018 13:53:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b188sm182238itc.9.2018.11.30.13.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:53:26 -0800 (PST)
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
To:     David Miller <davem@davemloft.net>, jarkko.sakkinen@linux.intel.com
Cc:     dave@stgolabs.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        dja@axtens.net, linux@dominikbrodowski.net,
        dri-devel@lists.freedesktop.org, edumazet@google.com,
        federico.vaga@vaga.pv.it, geert+renesas@glider.be, deller@gmx.de,
        corbet@lwn.net, kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, rostedt@goodmis.org, me@tobin.cc,
        makita.toshiaki@lab.ntt.co.jp, willemb@google.com, yhs@fb.com,
        yanjun.zhu@oracle.com
References: <d7c34289-f03a-b641-cc9c-00395306511d@kernel.dk>
 <20181130.123507.1940310466680455876.davem@davemloft.net>
 <20181130214233.GF23772@linux.intel.com>
 <20181130.134703.1703684498402097596.davem@davemloft.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ec7ecc9-ebb5-3c01-3b54-0aab97b856c2@kernel.dk>
Date:   Fri, 30 Nov 2018 14:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130.134703.1703684498402097596.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 2:47 PM, David Miller wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Date: Fri, 30 Nov 2018 13:42:33 -0800
> 
>> Can you tell how the CoC should be interpreted then?
> 
> Regardless of what I think, as others have showen the CoC explicitly
> does not apply to existing code.

And with that, can we please put an end to this thread (and patchset)?

-- 
Jens Axboe

