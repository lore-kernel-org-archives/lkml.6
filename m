Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ABC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C76A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsS2lRqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfA2UaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:30:20 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38641 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2UaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:30:20 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so7315821uaa.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPMDSDeZ5ka8wuI8qGiT3VOy9lGgNfSh41qmQU+EB7w=;
        b=BsS2lRqLxe5uhvySYK778nw2TuF5GJs9hYGwplrLYOvn/cA4QjlBhl9K7lfrCqGD1W
         wDYBktyO2B3KQ1bvzSc3t8C50F+LM1MS4IXmgSotEOzpiYw+42bDG8mS7W0qgdEZQYU1
         XkW7BkbJxe/Dc2l85s0HBhdpEcjigshTTraKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPMDSDeZ5ka8wuI8qGiT3VOy9lGgNfSh41qmQU+EB7w=;
        b=rv0wmgrUyWCKE430aUmJ9iYIZ95oCbrQVUTU4zWX2vjcBM+Fwha/rEqu1FKh7MT3xL
         OdFaSuDPCtZ01naKYiM347/gM6W+li1oxmQyRAHtHnUmtYklpAF8KodSg9XdzKF8oHuW
         JVHYFBC3aYzlEdXjBhLyp5KBw5uo26pz+RC4a50bNOhL4z9CGOluXp9BY1anBs/eR2de
         /9tXTbfAIUMQuhek4LG7hQgvgw2nXwDrEeuIV1zY63p3X6TvXKKh2J+3a8CmmatCXwOq
         aR8Al+MMqVYYOv3ygPTyIltsR0m3myKtDyT6TTUZgLLkMwA3d6vRDF+Zx6blJBNYFnQZ
         jnBw==
X-Gm-Message-State: AJcUukfZpsDL3yQIk6RN5D0fVxvTqrr7chmH4z1r2O3B3C9q7ydG+rzx
        Dce7nzpVsakXrf2BcIAH7zGxdExRVA1wBAxW47cnvA==
X-Google-Smtp-Source: ALg8bN5xG0bd+NADUISEXrurkr6GmkSPT8OHWdV8Pz8cJpwkeSEzCRifLCmFauM5XVbHOiUy++/u1d3BdFkga0JXM6Y=
X-Received: by 2002:ab0:5484:: with SMTP id p4mr11772125uaa.102.1548793819297;
 Tue, 29 Jan 2019 12:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20190129140846.4dc4c158@canb.auug.org.au> <9e32a49c-fb78-c5f8-77cf-66b4b4a8b4a2@linaro.org>
In-Reply-To: <9e32a49c-fb78-c5f8-77cf-66b4b4a8b4a2@linaro.org>
From:   Andy Gross <andy.gross@linaro.org>
Date:   Tue, 29 Jan 2019 14:30:08 -0600
Message-ID: <CAPBZ5QeLEHOLJDBW4zGXJ8DayvDU3V=rGJ6Ty-pKruZEYv88DQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the qcom tree
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 05:46, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Stephen,
>
> On 1/29/19 05:08, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >
> >   arch/arm64/boot/dts/qcom/sdm845.dtsi
> >
> > between commits:
> >
> >   05556681948b ("arm64: dts: sdm845: Add videocc node")
> >   5b6f186f0abb ("arm64: dts: sdm845: Add rpmh powercontroller node")
> >
> > from the qcom tree and commit:
> >
> >   ae0037dbfc5e ("arm64: dts: sdm845: Add interconnect provider DT nodes")
> >
> > from the char-misc tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

Greg,
I'd prefer in this instance that this patch get dropped from
char-misc.  I have too much stuff in flight with some additional
patches coming in to mess with this right now.  And we don't have
clients rdy anyway for this so let's wait till next cycle on this one.

Andy
