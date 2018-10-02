Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DAEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46A02082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYpEXvya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A02082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJCDiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:38:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJCDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s/+/7TEkAEF50qRGpH+Ef2QjMYpAS6gTA+UyyGHNe9s=; b=DYpEXvyaW7xZaHRysIvKHSl81
        Sik3VgDYHLd9FlikVIdbJspTk1n83rNtuECxNLNKRZ+hbz/rFadt4JyrXkXVfgPHgrFfEuldzzwc6
        Xy6bljMxoBlzP8V1RE3hj5hy6czraej9vUBBP1DYVJxYpg9VenGF0CESlOqczeGwMN8TkDMc2TdUZ
        Ah81eVKUhNGGNG30ZAL9Cd9ea0EL3w4HNuy3d1Mrc3l0+bK+WSYEjRu3rNGbG54C2ndgs1/XcncX7
        fHG5zAICREAIUoifeiXxk6SybhTbBbpNP/3U+ElOYuNIZPnWAcLeXTfECWXfxVaKsPokhlBkzXkuT
        SHRCpzDQg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7RfA-0007jf-1K; Tue, 02 Oct 2018 20:53:00 +0000
Date:   Tue, 2 Oct 2018 13:52:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yves-Alexis Perez <corsac@corsac.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] yama: clarify ptrace_scope=2 in Yama documentation
Message-ID: <20181002205259.GA16090@bombadil.infradead.org>
References: <20181002204722.GA9610@scapa.corsac.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002204722.GA9610@scapa.corsac.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:47:23PM +0200, Yves-Alexis Perez wrote:
> Current phrasing is ambiguous since it's unclear if attaching to a
> children through PTRACE_TRACEME requires CAP_SYS_PTRACE. Rephrase the
> sentence to make that clear.

I disagree that your sentence makes that clear.  How about:

>  2 - admin-only attach:
> -    only processes with ``CAP_SYS_PTRACE`` may use ptrace
> -    with ``PTRACE_ATTACH``, or through children calling ``PTRACE_TRACEME``.
> +    only processes with ``CAP_SYS_PTRACE`` may use ptrace, either with
> +    ``PTRACE_ATTACH`` or through children calling ``PTRACE_TRACEME``.

+    only processes with ``CAP_SYS_PTRACE`` may use ptrace.  This
+    restricts both ``PTRACE_ATTACH`` and ``PTRACE_TRACEME``.

