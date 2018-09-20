Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4CBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6697621529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sV0PWLOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697621529
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeITQYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:24:08 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:44209 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeITQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:24:07 -0400
Received: by mail-ua1-f45.google.com with SMTP id m11-v6so4283200uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaODmu8LJz1bzDD00tbsApu1todrMpQy7HdQ8oFrrLk=;
        b=sV0PWLOX4+bdsAJ84Ps+WhzPPyf2VCz3f+saaOxaNhYcQKu6HABAPUqxF20Yt6AwaG
         gfLrOzFckfFXGE7z5wo8t7LWA+xYdXVpfaDpN/12O/uVdMSHICQ28QrFTPWnNMLIuXF/
         GzGxQXzVEiYsYCYGomB+iLQ42S/8Li3KBoLHFbSe/GnmkeGTzKpzJ37KxBVKBLEOQf0D
         QdMlpO8p+k0/rtpfddm2/S2JtIWfJEhrPG9ME+i/XUxiK9z+KIltSknZdzNCxxl2MGWo
         gBM8Z1Tx1Tn1GSEMif9dD5ND+2Do4UYnZqJiQlmuuy6O/n0GWX7TluKvbIVO830FBv24
         xuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaODmu8LJz1bzDD00tbsApu1todrMpQy7HdQ8oFrrLk=;
        b=fy6VxwAlQGhOO0N3btUjchupzVdlqXDCjghoAeY88W9CK/LAPB5S2z7Ad5QY046ttP
         qfplrBOyZrvtE/siNEXBhz2OxQycp+4YtXA1nl0IHx6SZzDO7E7e6Mz6BsvngdKQ+EKe
         UXq4L04OZh/c5UQhxE04aXEgBalGlGtrdTfKi/f0q3gcA7b0IMm75bOq2JVdaD5VTRh1
         H1F5vjsMRw99geyc7oTZhLEDUdpoGeXmj/Cb1vHF+Wo3a23aIPb8H5Qz55A0J3Hjg7K1
         x3cbnpZTatKVtQtbAX5IWi4mxlBdTr3aKFbW18kMmgOLw7eQBswpN8O1DPLiAHsF5Ngb
         bPnw==
X-Gm-Message-State: APzg51ByYt37yNUkfZdJ8WVVMVhk5vUOqc2bDjrc/LPKKnJFdIUedD4c
        2z+kaCvVKxbcrbw8AKLOiYLysAyBAV1rJhgXLRA=
X-Google-Smtp-Source: ANB0Vdbn8zCJ1n7mU+Zt9h4TyBCwRoldkWP3p9cZMT/Cyq+E5iMjyJOXnV5cLL1l/oXX8GO3ic/zgdZEmLZtaz/qLIA=
X-Received: by 2002:ab0:6352:: with SMTP id f18-v6mr12128525uap.76.1537440075981;
 Thu, 20 Sep 2018 03:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it> <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it> <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org> <0bd7fb92f5b2d5f18e67fdc9b3f6e603@redchan.it>
 <77f81bcb07d6a9193992f87dbd040658@redchan.it> <CAMjeLr-qVubez4wJ0AVrjVv2hEk6HjCpA30U=Of0hJEWmwqKyA@mail.gmail.com>
 <CAGmj6qv9k+24qvA9Kxik797cx07=_qJdkxYU-39SFG0tu50HNg@mail.gmail.com>
In-Reply-To: <CAGmj6qv9k+24qvA9Kxik797cx07=_qJdkxYU-39SFG0tu50HNg@mail.gmail.com>
From:   Martin Schroeder <mkschreder.uk@googlemail.com>
Date:   Thu, 20 Sep 2018 12:41:03 +0200
Message-ID: <CAGmj6qvbBAjthtT8kLaYwjyd9Vqwv9iWj44YbuGk4UQgr_VHdw@mail.gmail.com>
Subject: Re: Re: Fwd: Re: [DNG] GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
To:     dreamingforward@gmail.com
Cc:     observerofaffairs@redchan.it, linux-kernel@vger.kernel.org,
        dng@lists.dyne.org, debian-user@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rescission of GPL for reasons other than violating the terms of the
license would be a ridiculous form copyright trolling which, if still
possible, should definitely be outlawed.
On Thu, Sep 20, 2018 at 12:15 PM Martin Schroeder
<mkschreder.uk@googlemail.com> wrote:
>
> If the license clearly states that permission is granted to any third
> party to use the code provided that the same rights are granted to
> everyone else who uses the subsequently distributed versions, wouldn't
> the original holder who is willing to rescind the license fully also
> be liable to compensate everyone involved for damages caused by such a
> rescission?
>
> It would only sound reasonable to me. You can not first grant
> something and then revoke that grant and expect that it can be done
> without consequences. If that becomes possible then there is no point
> in giving the grant in the first place. It would sound reasonable that
> there should be plenty of room for a counter lawsuit that would focus
> on how much damage a complete revocation would cause to everyone who
> have originally accepted the grant and then went with it. It is
> crucial I think that rescission of a grant (not just any license) be
> made close to impossible to accomplish after the grant has been made
> in the first place and the work has been made public.
> On Wed, Sep 19, 2018 at 7:22 PM \0xDynamite <dreamingforward@gmail.com> wrote:
> >
> > > On 2018-09-19 03:38, Richard Stallman wrote:
> > >> [[[ To any NSA and FBI agents reading my email: please consider    ]]]
> > >> [[[ whether defending the US Constitution against all enemies,     ]]]
> > >> [[[ foreign or domestic, requires you to follow Snowden's example. ]]]
> > >>
> > >>   > One is rescission of the license they granted regarding their code,
> > >> and
> > >>   > then a lawsuit under copyright if/when the rescission is ignored.
> > >>   > The others are breach of contract, libel, false light, etc.
> > >>
> > >> If "rescission" is really a possibility, it would cause greast trouble
> > >> for the free software community.  We would need to take steps to make
> > >> sure it cannot happen.
> > >>
> > >> However, that goes against everything I have been told by others.
> >
> > This is where copyright differs from IP.  With copyright, you have the
> > right to derived works if they don't violate Fair Use -- but that
> > could essentially be violating the GPL.
> >
> > The only way to protect the code and spirit of the GPL at that point,
> > is to accept the legal concept of Intellectual Property.
> >
> > The question then, is, is source code released under the GPL
> > considered "published work"?
> >
> > Mark Janssen, JD
