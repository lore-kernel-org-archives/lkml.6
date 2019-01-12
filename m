Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7051C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC32177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547283356;
	bh=qTUcrCZuvpYqS6dglGoQRev0BNgonPKqo9iHGaeYkpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M8pmZPQ7IEhsaVa+J58Z6/nuyVBZa9pk7M0j1Q02+7lb9qfBtiNVVIHyBvZ5UrNZA
	 Kl77out1Uj2aHrYCrkaoBSm7qNDyQNsIMyNPl6vhkTJErimEjcWnzmiKRqlY367vN/
	 P2b3kyeFE3X1QHM9qBdv4JnVyQM+vZF1iB3SupFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfALIzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:55:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43721 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:55:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so17580330wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1z77Nomw9EUq8iaP5uMzLhy4SfLTzHlpIx9XVlwQoi4=;
        b=ZkURuKcnqKaHb9rV0DCYFyLF8b+fgOT4+LmNFimmeIXFT95LoSFXUQilL7/YjtbrsE
         F0G71aGWLoDV0TaeFa4vuJAbLnHDq8YcaZ+yzRFvR6a50sqo5tNk2jYcLMoXJZN9LjHP
         Ui5AmCYFUgG5vfARdaffL7UQ8bE491licBWplDlY74+eB8Tkn+q6IXvbJ1rQta+Wt+fu
         LasvDrCTD7lR4EcockSqYNJeeTHMy1tfzLtDH+ss5SM7qJlTQd8GvEkuuf8cdFKFJABw
         obiypvec9E3++LE5PWVUOYxB6wCr93ygszsI8KSjdMaAVnFDl/Njpr8knK/GFh/BhwvL
         AZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1z77Nomw9EUq8iaP5uMzLhy4SfLTzHlpIx9XVlwQoi4=;
        b=jSCtBcPUbbKnsu4DFIKTSp2f00Wver4RamkTmZgbK+eaL1Z9Q9vDdflerViQXFCZu/
         x1OL9UGytl2GkI+3RJCL2GmQfaTJw/4DU5JAGa79vwKpYRLm4ugxJSErzQE5CaAtVrEP
         UJ8oigOoUFLl9TlbRAVUE9mZxe7t/FXlLYuPfdiPDg+OTYTTb/x9AGzGmh2KX8VncUik
         mwG6NYmiEdH78UcSunkHa9Vyol4p1MfxTJvYpvURpmKh5JWezTdxBq7oEW96D4xhD/Df
         GP+LCffQM6vMYIbfzbpzun8Xnp+88lgM1nkiwa7UcQvXqsi7+s2ekra1sEYl9k3yDiyY
         Ppfg==
X-Gm-Message-State: AJcUukdO55h7z4nn6rgEKwIwIWUVfnqsBsWFJjJ+GctD9t5D4fF9bIX3
        ZSIQW4N/83QqX91Aa3tmFtU=
X-Google-Smtp-Source: ALg8bN5v5rD1W7v5WP+w1Fc2TlSwjR96N8k/zrb9xv1tQstEHsemdRXT689XOGVP7c/M06EUoRA6wA==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr16104331wrv.202.1547283353548;
        Sat, 12 Jan 2019 00:55:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x20sm29697839wme.6.2019.01.12.00.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 00:55:52 -0800 (PST)
Date:   Sat, 12 Jan 2019 09:55:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Love <robert.w.love@intel.com>,
        Robert Love <rlove@rlove.org>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop PREEMPTIBLE KERNEL section entry
Message-ID: <20190112085550.GC119110@gmail.com>
References: <20190112060613.7115-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112060613.7115-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> The PREEMPTIBLE KERNEL section entry seems quite outdated:
> 
> Robert Love is not actively maintaining the file anymore, nor a recorded
> contributor to the files in the PREEMPTIBLE KERNEL section for the last
> few years.
> 
> The mailing list kpreempt-tech@lists.sourceforge.net does not exist
> anymore; the website just points to some very old patches for v2.4/v2.5.
> 
> So, let's delete the PREEMPTIBLE KERNEL section entry and clean this up:
> 
> - Documentation/preempt-locking.txt is not modified much anyway, and the
>   changes in that file are generally maintained by Jonathan Corbet. So,
>   we do not need to explicitly mention Documentation/preempt-locking.txt
>   in MAINTAINERS.
> 
> - include/linux/preempt.h is maintained by Peter and Ingo, so we simply
>   add that file to the SCHEDULER section entry.
> 
> I got directed to this issue, as I could not subscribe to the outdated
> mailing list address and decided to investigate and then cleaned this up.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)


Indeed - this all was many years out of date - thanks for the update, I 
merged the patch into tip:sched/urgent.

Thanks,

	Ingo
