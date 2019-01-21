Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60594C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548086002;
	bh=6oPLL4HYKE+2AuC4YV6/tAV370al8QEga0s+FzcpTQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k76lo5ZiwoxLTEh+BnzBXIhRArLa/aFlW1N9Ev8xuBwzQhzGIhJ1LqPIAelB+3KnS
	 grChbHGchVs+YLIJbnlpJBjZ1ggqtKBFDtQXQv09aBYD1JnlWlYAuQumnPflf1YwiZ
	 urUzadsOWVJrw2h021na8q85F6Eo/4/7lUSP28ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfAUPxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:53:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36806 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAUPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:53:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so20930627otk.3;
        Mon, 21 Jan 2019 07:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qe4qvfUSct3qbRBy94TjFwoY4JsWWV/7jTLSUh2s9Uc=;
        b=ePeZc19whwIhjpLKExZp8ove6UKKttOQ6aikCsvOATruNC+ch3mVvZ/UkQND7bddsf
         J00TX3nx3Q8nUb4NsXzV6DoHn9bx+MHXIvvgElePo9CHsIR4hJApTFpJk5KoeNEo1hug
         3/IYUkx+mbhiV62xoASTEBzU4TlzX3NHV3l0ELT7EmqPmUcBIu+mTtQ/ZUQa70NKgPQA
         b75QVsYXB6VIPBeVAxF8VAslh0uhwVKztQq2eMNMLin+Bu6hMAQ3OwWJjaLQossExR3A
         w7c81j5s85LsXK0jdIO630nGmo8reyKQGCgIRRvxNcGqCB/ID4GCyFiidtWGYF4zLI+H
         v7TQ==
X-Gm-Message-State: AJcUukfpeIbsnCCyH972FbcYKfXAhnSLr6916cOieMwTJKsY94Bw30wi
        +vyvgW9g6RkQpTDhqj0+hcHK0cw=
X-Google-Smtp-Source: ALg8bN5f8uRSnN1F9ByVmrjy2vqK+nLdhCS7+fHZfCp+KAEWucx2r/nFVsjPH3omA1OF1we0etGxLA==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr20118154otf.30.1548085998676;
        Mon, 21 Jan 2019 07:53:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w17sm5645274otk.12.2019.01.21.07.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:53:18 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-mips@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] kbuild: add real-prereqs shorthand for
 $(filter-out FORCE,$^)
Message-ID: <20190121155317.GA7426@bogus>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
 <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547719364-18849-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 07:02:43PM +0900, Masahiro Yamada wrote:
> In Kbuild, if_changed and friends must have FORCE as a prerequisite.
> 
> Hence, $(filter-out FORCE,$^) or $(filter-out $(PHONY),$^) is a common
> pattern to get the names of all the prerequisites except phony targets.
> 
> Add real-prereqs as a shorthand.
> 
> Note:
> We cannot replace $(filter %.o,$^) in cmd_link_multi-m because $^ may
> include auto-generated dependencies from the .*.cmd file when a single
> object module is changed into a multi object module. Refer to commit
> 69ea912fda74 ("kbuild: remove unneeded link_multi_deps"). I added some
> comment to avoid accidental breakage.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The patch context depends on some other ones.
> Please use 'git am -C1' if you want to test this
> on Linus' tree.
> 
> 
> Changes in v2:
>   - clean up arch/s390/boot/Makefile as well
> 
>  Documentation/devicetree/bindings/Makefile |  2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  arch/mips/boot/Makefile                    |  2 +-
>  arch/powerpc/boot/Makefile                 |  2 +-
>  arch/s390/boot/Makefile                    |  2 +-
>  arch/x86/realmode/rm/Makefile              |  3 +--
>  scripts/Kbuild.include                     |  4 ++++
>  scripts/Makefile.build                     |  9 ++++++---
>  scripts/Makefile.lib                       | 18 +++++++++---------
>  scripts/Makefile.modpost                   |  2 +-
>  9 files changed, 25 insertions(+), 19 deletions(-)
