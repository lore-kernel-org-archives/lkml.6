Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B164C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4222AE3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZEnW2+gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A4222AE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeGFU6N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:58:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40130 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933982AbeGFU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:58:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so11030650qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=n5CXz62/QlqbaFHCWp+qNkTNqMa/rnzrfdEgxUqNlpc=;
        b=ZEnW2+gmWp1sWSKbVCbeeYR0RCHaNjuisPT9kaj1WkWbYXMyIbuacxMkkPusj+HCC9
         AEvUqmmpJ50x40N6Om8hz9GL8GQaCu0cdaTHiBbhHWLWces9GzcwySiEQqCiz8EKrC+F
         aN1duLQJ/L113naTAbAZgVDufci9cwOdMhEmZbwutkeT7QQWv97QEh6vsTfuGXONFEE7
         76PNCR5MYsrKJL3VNwurI/LFIgiVr+AjjFutcs8WKfw3Xd6EkXj2L6LI/9CgbDW3uGli
         VTtN3CapQnFzdez5e1yTLmU+6qUUv8ZB1+4msCbDXz1hcKG0T1wOiHJaWsn4BoU/tv6q
         Dy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=n5CXz62/QlqbaFHCWp+qNkTNqMa/rnzrfdEgxUqNlpc=;
        b=IlyOMfn5QW3k/XSAE75knStiwBeQX3sV1gedWlfvVAuvL7mRQvIsrxmnX2WCDuG5sM
         bdQBKq+03Svmr1ps5uEREoeI8qrKJS5KcstgQK+qor//3SviQ3rblaK0uHtJMnyUY8+W
         MHFdshyWrzfgbhZH6p57240hjoITFwMqVswR8/Ovo8gHSu4N1NrFg/b7pT4pXbURKYGA
         eScqbu0jEb0KGbw3Pyr0+b+RKS0Rd2Q+sYVz+dCh0uUq+he5bgthXy2DZevNHu6t1oKh
         uCOqHN5dPUcHzcI6z9mtItEhk87dTpcIDkq5bhAZokEaay4QuJ77oGnjgXxQeLXZ0LAK
         p5Zg==
X-Gm-Message-State: APt69E1STVlrZU3SNCV5Rf0x+uDwhZP3dBEbcYG0xfdnlCQ4PCP5qRY0
        xWYRsJtoB+43Rtw1mchDcrGuXZVC
X-Google-Smtp-Source: AAOMgpepQndt7LwY+JE3yNyzPxPmaNvS1UfJyJ30F6kcqtvH+rPdl1mhJ4zQXaTfXntW0zWDparElw==
X-Received: by 2002:a0c:d6c7:: with SMTP id l7-v6mr10215961qvi.36.1530910688977;
        Fri, 06 Jul 2018 13:58:08 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id l185-v6sm6004786qkc.87.2018.07.06.13.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:58:08 -0700 (PDT)
Date:   Fri, 6 Jul 2018 13:58:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add bash completion for cgroup
 tree command
Message-ID: <20180706135805.1d90ff33@cakuba.netronome.com>
In-Reply-To: <20180706183012.6475-3-guro@fb.com>
References: <20180706183012.6475-1-guro@fb.com>
        <20180706183012.6475-3-guro@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 11:30:12 -0700, Roman Gushchin wrote:
> This commit adds a bash completion to the bpftool cgroup tree
> command.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index fffd76f4998b..82681eb9c02a 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -414,6 +414,9 @@ _bpftool()
>                      _filedir
>                      return 0
>                      ;;
> +		tree)
> +		    _filedir
> +		    return 0

Oh you have not tested this at all, have you?

You're missing ;; at the end of the case, this is not correct bash
syntax and completely breaks the script.

When you respin please use spaces instead of tabs (I know, *very*
annoying but that's apparently how things should be for bash
completions :/).

And please add "tree" to the *) case which completes the actions.

>                  attach|detach)
>                      local ATTACH_TYPES='ingress egress sock_create sock_ops \
>                          device bind4 bind6 post_bind4 post_bind6 connect4 \

