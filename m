Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861A1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54177214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFeiHduz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfA1Uq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:46:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36148 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfA1UqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:46:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so14264926oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZijaVUG5xxd/yGw2txPDnmNMWdCgsYETQ39uaT3Gdk=;
        b=WFeiHduzIoByhkJ11zfVgyxt3DVBSYMU7ue+AUBvCy/yD+z4VJlnWwkzKFFqlPme+j
         fn3f6DHfjnZ6DeX8hgf1e84B9YulW7pr4rgAmprh335d2092E/IEr7u+WGIOScMgwRaQ
         9uQKzSWxQB2Ew9SJgVLZXTHz8W5gHS0VSifyxkWt9P6H8pa9JDcTmnP+xObnVwY11UNC
         pGE30iea3reBw0m2saIs9GsPenaKAvv8BJdeOOsaA/6rzBDZn5afidpOxidPRuQK625B
         SN29aVVtZstur31MFe0sgo+N3f9gEZRid13Ja3jAx8WVbnbtt7+10drx1xgeRp50EGSj
         sDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZijaVUG5xxd/yGw2txPDnmNMWdCgsYETQ39uaT3Gdk=;
        b=eYFVlNj1D87dpxTgnm5lmQn818LYDI+1IeP08q5H67OREC8ELxE7LFxp1Esj2b9GDy
         hLXjT0hRGCtUbsPZEjoCgnBKUwPiEDUGqKTWwJBPgr+3VvMpryptN+FGOLxwmHakJX5B
         c77br9l/3UesVp/+OZODGJkNRMzOIIfyLLwBLtFiJ6VTDSHr+wU8iG3SuXKslX1Ft85Z
         9AejknqbTlvUBD7gi/MfEeAV32wAZx7nMVWV9P2fWeScfl5W2Z1ShGsdIZ0eAqNP3FAI
         W+OnCwyaK8N0vxy9U1fAw5ZAtREN/vYdMehIJ3Lv8alvJz8RX5zmFsbEa7cQN+LujkVm
         RocA==
X-Gm-Message-State: AHQUAuacaMEb29Z2ucPMcEpSdfmdL/YFl4mf8vyVTVVNde9aJXlvrfCh
        lUiLlUiZbe5PChXFI8S2xXh2g4t7OoUvbdkM6TRlnUSw
X-Google-Smtp-Source: ALg8bN4aQ4dT3F264GlL4mkF1l79TgWzaiWMfxdKpGN3sNyzldvFLRLFE1uCMzPCyXrK0qcZUCvw3howoY550GCy0k0=
X-Received: by 2002:aca:3345:: with SMTP id z66mr7302111oiz.91.1548708383255;
 Mon, 28 Jan 2019 12:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20190122150344.8072-1-qiaochong@loongson.cn>
In-Reply-To: <20190122150344.8072-1-qiaochong@loongson.cn>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 28 Jan 2019 20:45:46 +0000
Message-ID: <CADVatmPj=11jTZGVUijuxSYzt57cMh5mqzD+Q1400iWK-W8dNQ@mail.gmail.com>
Subject: Re: [PATCH] parport_pc: fix find_superio io compare code, should use
 equal test.
To:     qiaochong <qiaochong@loongson.cn>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi QiaoChong,

On Tue, Jan 22, 2019 at 3:04 PM qiaochong <qiaochong@loongson.cn> wrote:
>
> From: QiaoChong <qiaochong@loongson.cn>
>
> git blame drivers/parport/parport_pc.c
>
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1376) static struct superio_struct *find_superio(struct parport *p)
> ^1da177e4c3f4 (Linus Torvalds            2005-04-16 15:20:36 -0700 1377) {
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1378)        int i;
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1379)        for (i = 0; i < NR_SUPERIOS; i++)
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1380)                if (superios[i].io != p->base)
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1381)                        return &superios[i];
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1382)        return NULL;
> 181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1383) }
> 73e0d48b8c28f (Michael Buesch            2009-06-11 13:06:31 +0100 1384)
>
> git log -1 -p 181bf1e815a2a
>
> -static int get_superio_dma(struct parport *p)
> +static struct superio_struct *find_superio(struct parport *p)
>  {
> -       int i = 0;
> +       int i;
> +       for (i = 0; i < NR_SUPERIOS; i++)
> +               if (superios[i].io != p->base)
> +                       return &superios[i];
> +       return NULL;
> +}
>
> -       while ((i < NR_SUPERIOS) && (superios[i].io != p->base))
> -               i++;
> -       if (i != NR_SUPERIOS)
> -               return superios[i].dma;
>
> the code before 181bf1e815a2a  also mean superio[i].io == p->base, fixup it.

So, this means the Super-IO chips irq and dma has not worked since 2009. :(
Can you please resend this with a proper commit message..


-- 
Regards
Sudip
