Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB02C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003282082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544989615;
	bh=UdYVx5GGtu9r8tifhjI5FSvucXiHocbZJsPJay6zmRo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=WUp5vHj45MORyTlSbSlgvl0WAozLaN6SlaxCjGaZOvU3fvqiGXjcwBmpEOaFNz18S
	 9+EXCUDXqaKWF8BztOty8rVh0UabLsYovewzLkHvDhvs2DBedh7aYUqo1NHDNp53je
	 7mj9Q94Jnrz6vKKS9byeS1hFkpfDl/0e6K6poNAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeLPTqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:46:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38411 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:46:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so11904007qtl.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UdYVx5GGtu9r8tifhjI5FSvucXiHocbZJsPJay6zmRo=;
        b=QPrOJ2CMw4KLEZUKOz+KHEE0XJ8WIfoi+s80wQlgaCQsi68ZVxeH9lBOzblQEIcS+b
         uWQuqemyR+qYhk/97rjr1IeobQmVyO7imeVsqz9cR4kKelFSnEAJQZ7Oh3WZwctdlJmL
         P8Q0wmDVFVBMTc6qNejQVwwzDmGpb5GgIqtBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UdYVx5GGtu9r8tifhjI5FSvucXiHocbZJsPJay6zmRo=;
        b=lnTe/AQQGhZb4Hpcv83jyLUldcuq0sg0aFM55kQ5MVhGtU0gQNOfKSlT1n+vD2r2YP
         rBR0dJ5Es2tmSa7vyFYTxgYVjOMohVylV0J3QPQwbGZBSCaGNkCCIYK84F5WqsRRDfhs
         9Xf74VGjddm+uv6GXj+gDtlL7sBqY0+9gbGEDdCOpp/2Hq0Mkh7HLZgQafZhuy7amkSj
         XHOPyPx5CgqXafgu7PrGjV2eHwxfgdKsweuPb82kFMFksmBnkvXnIYJM8H3s5qZMz9r0
         wGrM1fUcCwLHtCBDbM4ah1t1k2upALdL7oxicKrR+mmPIdYLUfBMOiJ4gFCZ/2db3W9+
         zQ/w==
X-Gm-Message-State: AA+aEWbruSz7IbC7jWKwuiVfLvw906AIeMlKrAxa0C/twAK+rSIQ6NtQ
        9KfTiFFeQYqMaA70l+bXGUX8Tw==
X-Google-Smtp-Source: AFSGD/W7PoX6zk8G11BJN61HtUd4XAloiIQ5pkJbv44mWeyVyy0tMPVr9cM59qKDlLe3rtT5yLqOuA==
X-Received: by 2002:aed:3a22:: with SMTP id n31mr10901212qte.29.1544989612318;
        Sun, 16 Dec 2018 11:46:52 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id h31sm2014690qtk.5.2018.12.16.11.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 11:46:51 -0800 (PST)
Date:   Sun, 16 Dec 2018 14:46:49 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216194649.GA7732@pure.paranoia.local>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181216190639.6safwjqwdphkce67@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:06:39AM -1000, Joey Pabalinas wrote:
> I spent a lot of time trying to find an LKML archive in Maildir format
> that I could use for local searches with nutmuch or something, but all
> the links I was able to find were all dead.
>=20
> I ended up just compiling one myself and I currently host it at:
>=20
> https://alyptik.org/lkml.tar.xz

You seem to have duplicated a lot of effort that has already been done
to compile the archive on lore.kernel.org.

> It's possible I'm the only weirdo who finds this kind of thing useful, but
> I figured I should share it just in case I'm not.

The maildir format is kind of terrible for LKML, because having millions
of messages in a single directory is very hard on the underlying FS. If
you break it up into multiple folders, then it becomes difficult to
search. This is the main reason why we have chosen to go with the
public-inbox format, which solves both of these problems and allows for
a very efficient archive updating and replication using git.

> It's about 1.1 million files, I was wondering if anyone had an idea of a
> better way to host this? I've tried Github and GitLab, but they don't
> appreciate repos with that many files, hah.

Like I said, you seem to be going down the road we've already tried and
rejected. :)

-K
