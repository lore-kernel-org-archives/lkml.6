Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0288C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF72086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B+HMhjp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCF72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934502AbeFKTAE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:00:04 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37267 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933309AbeFKTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:00:02 -0400
Received: by mail-it0-f47.google.com with SMTP id l6-v6so12299504iti.2;
        Mon, 11 Jun 2018 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CO76SuEA3turxheV49Oh+gj0OELvlZWvS2/rwtylo4=;
        b=B+HMhjp51ZwdHRMmBraUn2clsh+cL1uKCgmhQvHJGdGe51L6xTAdP+lanpL4KixDuS
         IyL8HIrwnEbeqIeZRcv87rJ8a1axVjsjev2oaK1a9WQcfMvatG5SQwz9Plzunwuw3mV3
         jZRYAQ4tK7cUiVS1kiOfMcQnhUkOyrqjXc+48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CO76SuEA3turxheV49Oh+gj0OELvlZWvS2/rwtylo4=;
        b=FvA9zUZ0LlyczwHx1icsgEtgUyuaXPXU7J34C1R6MfALq+2i0ZZ/MrPAwV0aCX+3oP
         uWaJhEltVIiyAYobh5q5M3zHtiQOEBVo7S5ooyfH7H7lKZGJYEFaXG1AnSlWzngHpvOw
         BnokuUfey9qYZ3dgUYXATyyXxkUz6W3QNPVs9AzeHrvmentJ/ftBL82eM1mkEhSHjdav
         v3+6SGvR4L/BaHQDsckq3sNJal+tbpiGNfE2e3DHdd+lPTn63gvTaJHNKhrPU64v+tTE
         u2IU+WAfx0GyG9hOqsJ+LMxCD4h7QyUSTPc3WkPAC7ciDQuqsRcZdmbt2Ujtlb2AO9NN
         Juvw==
X-Gm-Message-State: APt69E0yaPvcl2hdlHO5Z0YAsK0brdtAuKtVUUXptd/eToFP/pYK2c+a
        aTXgo3XaBiwFbGxiVrTJnkdasjFZs7ZfnKhEcH8=
X-Google-Smtp-Source: ADUXVKLTsq9SSZ7q1KsgvjERBUjCKMZus6lDGNWLNII6xcHfMFjUsB2UG1DiS5WqhFjqJnX9/15817bRNbGI4mzOQfo=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr205172itb.1.1528743601724;
 Mon, 11 Jun 2018 12:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180608184842.GD30522@ZenIV.linux.org.uk> <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk> <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk> <20180611162313.GA6942@infradead.org>
 <20180611164859.GA28292@bombadil.infradead.org> <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
 <20180611171811.GB28292@bombadil.infradead.org> <CABPqkBTwqtFxtFsCjTNyHa_T1_vCbCQWHwo42RZAbg0QRi1BFw@mail.gmail.com>
In-Reply-To: <CABPqkBTwqtFxtFsCjTNyHa_T1_vCbCQWHwo42RZAbg0QRi1BFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 11:59:50 -0700
Message-ID: <CA+55aFyg7W8G0fdJgqWEPRu4UeRd16EnkdR2uY1A_e1j8rZUGA@mail.gmail.com>
Subject: Re: perfmon trouble
To:     Stephane Eranian <eranian@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:51 AM Stephane Eranian <eranian@google.com> wrote:
>
> In the meantime, I agree with Matthew, simply disable
> PERFMON support.

Ok, since everybody seems to agree on that, I marked it BROKEN for
now, in the hope that nobody even notices and we can just remove the
code entirely.

And if somebody *does* notice, at least we would also have a
sucker^Wtester for any possible patches to fix it.

               Linus
