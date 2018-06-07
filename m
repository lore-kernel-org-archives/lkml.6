Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y2FsITe/GFsUIAAAmS7hNA
	; Thu, 07 Jun 2018 05:15:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F24716089E; Thu,  7 Jun 2018 05:15:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O35DTM2R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEXNBlGA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2BB9260115;
	Thu,  7 Jun 2018 05:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BB9260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeFGFPI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:15:08 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35694 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeFGFPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:15:06 -0400
Received: by mail-ua0-f196.google.com with SMTP id s13-v6so2191013uad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=MzMzcczTKjT2/kZVVWUx/XHpA6Y/zy5aKbprw7xiKb0=;
        b=O35DTM2Rh7k4Wp5Vuni1all9Bdfbr1fszbDyi5Q85bwkWvF86wJi2cvIn2jLo6d0ZB
         ZhOLth1+5mLpsnyvzuKjR97F4CJRP/CSCHQfGBEqjHUH7elbLMluuXmDvam0oJsQttn5
         lqJ3wmM/IWLsFXddtBA1In7fyBSJbUbaBYIqIc6XGrFb1ak5cwGTeu46XB+7mZC7AiSF
         gywpeJyU4rgIWrS6fFbD72094P5NzKvmx79ewScSWbAR7zj9fQBd6Et9B1TNt9iIIVPu
         c7FgqIbmdewXkoIwO5ITHqhr1KO6YayvR0xaRs+JiGlXZlCXlRRZrYwywipgkTDDdxq8
         Ak1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=MzMzcczTKjT2/kZVVWUx/XHpA6Y/zy5aKbprw7xiKb0=;
        b=bEXNBlGA3o+4InWOt5+ZsqmOtQPUG3xTlF1sw+aJHCfkgclKaTAm+I45yuUVd38Ep4
         VuJu5LjnzRhFicM32TIC+8ahZ4NJssjAXshiv4V+PvtoES4HyvfwB6XpirdiLf1O3L9f
         a26Ugd38MUawsvdvJ9MvS7Ut5pfnUU046Hsw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=MzMzcczTKjT2/kZVVWUx/XHpA6Y/zy5aKbprw7xiKb0=;
        b=Xn6foFQYhOGTfJmDeD3GaEQgo8bRDOWBgbOW5ynb5kgWPlJuGe9qSDDrG4GkTMFt2y
         Awyehs4C/y5BOcUGWISRhjiDQH8glvxIgv9bOrNM2FReYVNTZgUMdeci8r1j71lUD+mD
         T6Pf6I4qeORT0k1e6C/iwjambCA0phC3Z1R9UpaC96lg5+/DuglaumQgmANqoSjHwYyX
         PcZXHlnx4FY2ovqQc0OPHDVa8t4mJ3TE12ip3Y5N+Fr514J20WQjvWyOWAUSwk9Zr6Rp
         k8VoCOxpdTiLT+ZsC7Bc6MBuw9iBZAxvu+F0hPhgSDHiRDkMRFA5HmxZRqSxxbDll381
         7sIg==
X-Gm-Message-State: APt69E1oZI5wdru9Lv8DXaxOwxXphV51e171UUu2FutUqJP4sEwzhGgD
        dJbkFKgiYd9t/o3dIWXEwQBfzaeDQQh7oVDY1zv9dw==
X-Google-Smtp-Source: ADUXVKJCHoDir/wVauaUuaqDqMZyi9H90ubWfxumqI/0Ej8L4Oi8TDUSETW3ogsqKr6HEKtjbYx649eDf0zig97gNpg=
X-Received: by 2002:a9f:2823:: with SMTP id c32-v6mr236786uac.193.1528348505262;
 Wed, 06 Jun 2018 22:15:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 22:15:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Date: Wed, 6 Jun 2018 22:15:04 -0700
X-Google-Sender-Auth: EBeFnWxRLfqYDYKbVE4inOSFZeU
Message-ID: <CAGXu5jJq774LZY1xUCKxG3Z4MkJ_JBJP7veB5gUCy4meb_PtSA@mail.gmail.com>
Subject: Re: nfp: bpf: perf event output helpers support
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     nfp: bpf: perf event output helpers support
>
>     Add support for the perf_event_output family of helpers.
>
>     The implementation on the NFP will not match the host code exactly.
>     The state of the host map and rings is unknown to the device, hence
>     device can't return errors when rings are not installed.  The device
>     simply packs the data into a firmware notification message and sends
>     it over to the host, returning success to the program.
>
>     There is no notion of a host CPU on the device when packets are being
>     processed.  Device will only offload programs which set BPF_F_CURRENT_CPU.
>     Still, if map index doesn't match CPU no error will be returned (see
>     above).
>
>     Dropped/lost firmware notification messages will not cause "lost
>     events" event on the perf ring, they are only visible via device
>     error counters.
>
>     Firmware notification messages may also get reordered in respect
>     to the packets which caused their generation.
>
>     Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>     Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
> index e3ead906cc60..4db0ac1e42a8 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
> @@ -441,6 +441,53 @@ int nfp_ndo_bpf(struct nfp_app *app, struct nfp_net *nn, struct netdev_bpf *bpf)
>         }
>  }
>
> +static unsigned long
> +nfp_bpf_perf_event_copy(void *dst, const void *src,
> +                       unsigned long off, unsigned long len)
> +{
> +       memcpy(dst, src + off, len);
> +       return 0;
> +}
> +
> +int nfp_bpf_event_output(struct nfp_app_bpf *bpf, struct sk_buff *skb)
> +{
> +       struct cmsg_bpf_event *cbe = (void *)skb->data;
> +       u32 pkt_size, data_size;
> +       struct bpf_map *map;
> +
> +       if (skb->len < sizeof(struct cmsg_bpf_event))
> +               goto err_drop;
> +
> +       pkt_size = be32_to_cpu(cbe->pkt_size);
> +       data_size = be32_to_cpu(cbe->data_size);
> +       map = (void *)(unsigned long)be64_to_cpu(cbe->map_ptr);
> +
> +       if (skb->len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
> +               goto err_drop;
> +       if (cbe->hdr.ver != CMSG_MAP_ABI_VERSION)
> +               goto err_drop;
> +
> +       rcu_read_lock();
> +       if (!rhashtable_lookup_fast(&bpf->maps_neutral, &map,
> +                                   nfp_bpf_maps_neutral_params)) {
> +               rcu_read_unlock();
> +               pr_warn("perf event: dest map pointer %px not recognized, dropping event\n",
> +                       map);

Please don't use %px on kernel pointers unless you absolutely have
to[1]. It seems like this value wouldn't be actionable here, so likely
it's best to just remove its use entirely.

-Kees

[1] https://www.spinics.net/lists/kernel/msg2671068.html

-- 
Kees Cook
Pixel Security
