Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F8C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C82C206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVBu7oTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAGVR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:17:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40938 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:17:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so1571012oie.7;
        Mon, 07 Jan 2019 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i44JmbD6rHkIj+9YO90goURwALDU3LQBJjgKFO0pFJ4=;
        b=aVBu7oTj/6H+j7NAqXMrOygDDBL+Fzv4KVuUkZkO/RmMP4TaR3DtcETkdQJxwj1EYo
         Fepuz/FJ0K3PZ7zIT7Pp8hFsvRahw2cUeeNypPjKqqmuAfA5AtK3hSjBdvOhGWrL1DWu
         MYtmrgHBLnvLoQ7RYPxUbfCqYptHVSJFEIotiQZY+5PurrGfPgLlR5woyBDuJVCrKUUW
         dJv05sI85sJzKD2VOd2IIqIsDB+w0T31TS/bM/L6ppxm/s4o2baToIMp1hgBlqsO/fxC
         F1nY1rDEvyV5hk9SV3UUWkSBycE0dHMLuX6Tg14F97IdRYCN21Az31Bwmpzo/nVyLXKS
         +72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i44JmbD6rHkIj+9YO90goURwALDU3LQBJjgKFO0pFJ4=;
        b=lJSR9A6wS5Ic0NGV4SE9HH0m5j/109RTf8UZVvcANaNqvmk3IwH0Ajng0rLsZlbAIp
         Y8UrtMl7O0Bt3v7vJgvuj8K73kt508aBl1UbRmAAW7e2EF0FUOy8PGT8Ta9CKL/dvCap
         4ULeRKerZVD/mPOBQPVOdyNEJ5MXmo8ocLnONEpOq+ZEuvKjMLPhswy8h5yrJ1uqvbFQ
         kyzvDdzbrflNMOxZ4vM613qmx6fjtQY7WQsoqVB6aITJ5dDLYCxAyx7o3TSMwQjd0Qzb
         MCe7kOFm3n2Oy3rG9RG4RAJtw6OgfhBC7XZC77tfLyqI4VMu3sncBuEofYZ/beZRjteL
         pHrg==
X-Gm-Message-State: AJcUukcd9eiM7SsKkeFrqTn3xiOPHwpJ8CD1lv08xJScqFJn8pND7fAb
        z3zU2hTsNot7OqIPHZfXQyC5lQ5AGrKQR72O1MU=
X-Google-Smtp-Source: ALg8bN7NkHWFBqTNHgZ1vTDBoWhOAJoNOGCJXkoZbaenZj/vxl6fjR3L1rWjY50QciviKI1Eu+XKZ8OrORiOy/sXbDk=
X-Received: by 2002:aca:4b4f:: with SMTP id y76mr9409099oia.88.1546895878432;
 Mon, 07 Jan 2019 13:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107105337.790421457@linuxfoundation.org>
In-Reply-To: <20190107105337.790421457@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 7 Jan 2019 21:17:22 +0000
Message-ID: <CADVatmNw3X2WuUXSY9hP_n7ar2Hi8xUCh+BovQz2=c8RGRnwkQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 090/101] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 7, 2019 at 1:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Huacai Chen <chenhc@lemote.com>
>
> commit bb53fdf395eed103f85061bfff3b116cee123895 upstream.

This has been fixed by 66a4059ba72c ("MIPS: Only include mmzone.h when
CONFIG_NEED_MULTIPLE_NODES=y")


-- 
Regards
Sudip
