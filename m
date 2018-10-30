Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224EC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9A6205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9A6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=auristor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJ3W1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:27:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33966 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeJ3W1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:27:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so10487867eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXRtCTlaRWMFMozxd45mrrhKVmhQ8IH5PubYsVO8Tzo=;
        b=mwIJJVEF/t6qeyiE/P6N42KbRu5+UCYga4Fxv8TC/tekZd+VCXrqWmeKfQcHn88KH9
         L4KG2rwZ55ojcGXibGLao0gnsg2qdiwdfEs2Id3FHJ0xwqBq62ItOC2fdOkDza3g8auE
         jYPE6uRuNNMPmugccDd1WWna7CnJL+dRwcHQ8BAZ6M2cV6jFOeE0Z3BuowJLSUsG9r9/
         yVwwx/fDNUDFX0kb9e0EIIm5Nb+VHG75SuS8ha59+Er+y5ZnlQ9Fg9MTjj/zO5cHbrwZ
         igBrvnk7N1ZlOGvDVgfZFFl3NKOrO/6SQDO/vt3cQrp9HIpcIk/Zvjc8G9IVS3HBLehx
         B3FA==
X-Gm-Message-State: AGRZ1gKNT2jAfi3yUGhbHTz11LErjO3eiLwYFZSj0NRyQLsIlBLNAvUU
        o96faK8k9Scgjy4azDslKCMpc3DUdRk=
X-Google-Smtp-Source: AJdET5ctlvudxZ/iYIibpXoIti3oHqnPmHIfSS5ZzkRV7XesCzl3GfGe42v8XSytyvOPSjKDlBhspg==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18-v6mr12993885ejp.77.1540906431282;
        Tue, 30 Oct 2018 06:33:51 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id e17-v6sm693596ejk.66.2018.10.30.06.33.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:33:51 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id c1-v6so10488266ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:33:50 -0700 (PDT)
X-Received: by 2002:a17:906:2555:: with SMTP id j21-v6mr4878843ejb.103.1540906430644;
 Tue, 30 Oct 2018 06:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-5c83511bdb9832c86be20fb86b783356e2f58062@kernel.org>
 <CAB9dFdtLHkpZqrmNEuMfPdOmZm32q5SXYx1zMexSd94rt3KyDw@mail.gmail.com> <d8d4b1bd-2b80-ae4c-18f3-3d2957409500@suse.com>
In-Reply-To: <d8d4b1bd-2b80-ae4c-18f3-3d2957409500@suse.com>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Tue, 30 Oct 2018 10:33:38 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtw1_YuBXUY3Rb74WisR1iipZK+Sm60pD4cvcrYvbZb6w@mail.gmail.com>
Message-ID: <CAB9dFdtw1_YuBXUY3Rb74WisR1iipZK+Sm60pD4cvcrYvbZb6w@mail.gmail.com>
Subject: Re: x86/paravirt: Use a single ops structure
To:     jgross@suse.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:25 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 29/10/2018 13:58, Marc Dionne wrote:
> > On Tue, Oct 23, 2018 at 2:37 PM Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org> wrote:
> >>
> >> Commit:     5c83511bdb9832c86be20fb86b783356e2f58062
> >> Parent:     27876f3882fdd4acb3d3614a0133ecdc777fc292
> >> Refname:    refs/heads/master
> >> Web:        https://git.kernel.org/torvalds/c/5c83511bdb9832c86be20fb86b783356e2f58062
> >> Author:     Juergen Gross <jgross@suse.com>
> >> AuthorDate: Tue Aug 28 09:40:19 2018 +0200
> >> Committer:  Thomas Gleixner <tglx@linutronix.de>
> >> CommitDate: Mon Sep 3 16:50:35 2018 +0200
> >>
> >>     x86/paravirt: Use a single ops structure
> >>
> >>     Instead of using six globally visible paravirt ops structures combine
> >>     them in a single structure, keeping the original structures as
> >>     sub-structures.
> >>
> >>     This avoids the need to assemble struct paravirt_patch_template at
> >>     runtime on the stack each time apply_paravirt() is being called (i.e.
> >>     when loading a module).
> >
> > The above commit replaces pv_lock_ops, which was EXPORT_SYMBOL, with
> > something that is part of pv_ops, which is EXPORT_SYMBOL_GPL.    When
> > CONFIG_PARAVIRT_SPINLOCKS is set, this has the side effect of making
> > spin_lock() unusable by out of tree modules, which will likely be an
> > issue for many, if not most of them.
>
> Thanks for noticing!
>
> Sending a patch soon...
>
>
> Juergen

Thanks for the quick patch.  Does this also need fixing for arm/arm64?
I can't easily verify but it seems like it would have the same issue.

Marc
