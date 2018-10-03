Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C212C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23733213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+JE294K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23733213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJDAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43186 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeJDAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id e21-v6so6326569otk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bbGdgcS2yNeFXRywZHLuQ4rZs0lyTkpXt1P8+o/ZZM=;
        b=l+JE294K1vLaM38bDhX06tSdtzZg8fTx69R9dXaQ62WCuUnvlHghNHTxLU+JI6lTog
         jYexGPMUP40eAopU+kve7Yf/a41hHCnFTkGYR44MZD6mQ8jsnWsS74Q8dZ4XlBmukUkc
         QMYniz0qksZlHX6U1vbKYgkqnjy9msGuCyaR37Su5FJF37Yf97QSylK8uzi2J6oo2okd
         9Xstpn623joqZtBli5B69sdZ+xi9iCW/WFG7gTtGUEva5XVZU18Fn+Peoaq6NeXABkcF
         rTgSCOfRIDmN0ZzuGRQzrL2H+UNXBEwrjKyngKa8Kl9C7xgtmjLH8owHXZ/JzmVvT/60
         v0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bbGdgcS2yNeFXRywZHLuQ4rZs0lyTkpXt1P8+o/ZZM=;
        b=iLjpH+nVOnfChkAmQyZbGYyXGKNCEt6ddaHC5iKAueXqJ4Zg29DtneIStLXy1jmA7n
         /122hAsDvj/p02aVd0GqpUSw1jKpVQVBVK7pYR2tBpGUFOsUzqTjmGO5vGr+ZaBMhgS9
         f61qLBijTEfHS4W9OcQ42OUJOE/gCuUe1csOv1xIBWgMjLXIFs+H8OiNR/oobedu1WRs
         2dZFQmEVmTPyxr9ZhSmjdv1qbqhfxbHCxq+qNq71GoNAljk9JZqfDdJo3qTYJ8Nyx1+i
         ibpgXj3Tipb00fwIhk99N6Dt+HlrwuiTxTE2qvJqzvVtVYUEP+qNcZ6OdRwK1kP+/U93
         mlGQ==
X-Gm-Message-State: ABuFfohKlSWgVtqXzuvxfdQSWhVuUGVV77js/Y1I3ZQ0i43J/k09v8/6
        cPyZv9mAnT9o3e2OYu9vkq4oF6QIWPZ8aXwWXyVfCA==
X-Google-Smtp-Source: ACcGV63qZ+LP0VCCML4ng8J6SPf577JBCgxKJgbhkX+z4NwFo509Ygo/gqfmyMxtTKXpp8v97Yy+TyKoHN5428mm4yA=
X-Received: by 2002:a9d:2a38:: with SMTP id t53-v6mr1455545ota.35.1538587107377;
 Wed, 03 Oct 2018 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0Q3BaFsA_FUs1ZCAMRZtXkq5o_VCbU8CgTEVwa2HRZfQ@mail.gmail.com>
 <20181003170520.gc43zeffylshz5k2@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181003170520.gc43zeffylshz5k2@ast-mbp.dhcp.thefacebook.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 3 Oct 2018 19:18:01 +0200
Message-ID: <CAG48ez1-WZH55+Wa2vgwZY_hpZJfnDxMzxGLtuN1hG1z6hKf5Q@mail.gmail.com>
Subject: Re: BPF: RCU use-after-reallocation of hash table elements?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 7:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Oct 03, 2018 at 06:15:08PM +0200, Jann Horn wrote:
> > Hi!
> >
> > Note: I haven't tested any of this; feel free to tell me that I've
> > completely misunderstood how all this works.
> >
> > The BPF manpage, at the moment, states about BPF hash tables:
>
> unfortunately man pages have been obsolete for long time.
> the only doc that is mostly up to date is
> http://docs.cilium.io/en/latest/bpf/

Oh. If you're not updating the manpage, could you at least put a
reference to that other documentation in the manpage?
