Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203220643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCXxp4G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfBOQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:28:40 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40306 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfBOQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:28:39 -0500
Received: by mail-yb1-f195.google.com with SMTP id x13so4000236ybm.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VS1XG3amQlCyzQiX4r+/7XEWSg1/8sH6mHuaCPiklIQ=;
        b=ZCXxp4G2gBGoOW5wmxWuFXDHqStkY/GC7nvJGLSTx0a1PVSaM8kK4eLfjtb40W/umU
         ruuSnvIcMIrBjC6Hhb2Jr0elPwklLXtznHFatAHTm2MOoGbMWP0fSOUdleIVuIBxuGko
         uh2gsRXRTI27DzJfvrpfe4elvvTZDfU99/5wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS1XG3amQlCyzQiX4r+/7XEWSg1/8sH6mHuaCPiklIQ=;
        b=sZLUtZkX7gYC2JZl7JQPV4Y9bd4c0VFgZgSspj/GSu3KEyGgp0BICTCNTMYf3LRdsi
         HCM0nOukR03bUQ/5Blx0/ukrBcFFEATiRo1PPZQyTyG6BiMmAZNs+mKJAJnUB8ILcmox
         oZUPBE6ab860L9DeU/BZQuuKhYA8EVcpAMUITs5QnfNL9nvOO45KTsZPObPIu3+CQPpd
         kQlvr4NP3IgrONipKwLpFdg8XzMn36wUzDPQ1s0CNRz8yIZZcA+Q3UdFaWKLAmmP/WOW
         y9ztTnxu267iuP1jFxskJD/1mjP1ROnpJ0wbYD3f90BoxUjALKIB1iYBIK39vYcRc+KW
         K59A==
X-Gm-Message-State: AHQUAuZPRcBU3S7e1cSkb1GwHfmmwmdNbr7bhmZFkOIG8aBiHTb/8yWa
        XhHTHPbM0MyrzWoNzLm4qTmT/fdFaHc=
X-Google-Smtp-Source: AHgI3IaBmnzMdAd/2fTAXv3v74t414QE47zzEXuVvulepSglb1eeotdlKwIMd0NtHnqbH/lvJZrOCQ==
X-Received: by 2002:a5b:5d2:: with SMTP id w18mr9093226ybp.6.1550248118742;
        Fri, 15 Feb 2019 08:28:38 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 82sm2140674ywq.97.2019.02.15.08.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:28:37 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id o129so2247148yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:28:37 -0800 (PST)
X-Received: by 2002:a25:2d63:: with SMTP id s35mr9079453ybe.354.1550248117273;
 Fri, 15 Feb 2019 08:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com> <20190215161851.GA8804@redhat.com>
In-Reply-To: <20190215161851.GA8804@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Feb 2019 08:28:23 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK2z_Qx3DTGRgnGBNU6uBUvcWCy7-gU+94HkGnzjzQizQ@mail.gmail.com>
Message-ID: <CAGXu5jK2z_Qx3DTGRgnGBNU6uBUvcWCy7-gU+94HkGnzjzQizQ@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 8:18 AM Oleg Nesterov <oleg@redhat.com> wrote:
> WITHOUT '\n' at the end. If I read load_script() correctly it should work,
> so I think the 2nd for() loop should also reset "truncated" if *cp == '\0'.

Correct. My original v3 handles this correctly. I'll work on a version
with small inline helpers.

-- 
Kees Cook
