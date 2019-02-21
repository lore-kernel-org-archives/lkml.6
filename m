Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55059C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C1420836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FqQ6OfqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBUW2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:28:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:28:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id j13-v6so195676ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/EKS5FMbbbeu9VTChJy0uSr42jQ2xqiKp/2x/yLQjE=;
        b=FqQ6OfqVqO7Aa3Kf+089O6MvNAC2xTygh4kf2G/a1Ng2xpGcQQ1Qv7P0ZnhfCF53Vy
         xOc05g5DKuOxBngvDWogXE8lsz2wXGznza0xMXt3iJzLH2PF9a/27Ex2UyGY8LY+tn2y
         m8PXT5q/q07Nmmj7b1IRsl+hRSMg0n93p5SRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/EKS5FMbbbeu9VTChJy0uSr42jQ2xqiKp/2x/yLQjE=;
        b=TVgw1doDmAu8GIVeLmSu2GH0XvJX2lIcvOa/2nGwEsi63VtOshC3vAIWbIr1o9Tnjw
         HWJ3ODlNazqVqsGzUv7MtAoiHLES93rQTRS/rikzBYw6Z8KOc8h2rsJc/vnn8ld0JAxN
         ZENp8tJlsdvqG58gBziJyp+/Qnhhweh612MT4eIUu/zqwAPotwEzzOi7qwDxuZPLWJVD
         NoQd6CjJ9Fl+3Vm+96luBL3eeN2XUyVLpZuXgbHPHgNWkrZkWQgeAB2XadZI04sU+vQD
         N+g6GXck7ycb6ohBKBCwuDWs3pn1m+KKwRehGG7lyjc/0PqMwt4aQG67z3ecAqb3Gntj
         fC+g==
X-Gm-Message-State: AHQUAuY2ANqh7HZfaw2MUL8goLuhc1YjuC0uuQspy1aeHlZzwky5y98K
        WKaJNrTCbOM0/grgBNEZA4lPnUrB+3A=
X-Google-Smtp-Source: AHgI3IZtCi6/zpl0+xwj4xNVk6s0rv3hy5TkUvhSylECdMs+Tpthd3zg1MZEMRAfDB4nXqEom6bDHA==
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr448676lji.82.1550788086680;
        Thu, 21 Feb 2019 14:28:06 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y15sm40280lje.23.2019.02.21.14.28.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:28:05 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id f24-v6so203656ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:28:05 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr386436lji.79.1550788085219;
 Thu, 21 Feb 2019 14:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20190221221941.29358-1-daniel@iogearbox.net>
In-Reply-To: <20190221221941.29358-1-daniel@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Feb 2019 14:27:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNfnC-oe7aJGgNWoTbssc0LPYK6FyR=6LO4_U_dsphbg@mail.gmail.com>
Message-ID: <CAHk-=wgNfnC-oe7aJGgNWoTbssc0LPYK6FyR=6LO4_U_dsphbg@mail.gmail.com>
Subject: Re: [PATCH] x86, retpolines: raise limit for generating indirect
 calls from switch-case
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:20 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> In case of gcc, this setting is controlled by case-values-threshold
> which has an architecture global default that selects 4 or 5 (

Ack. For retpoline, that's much too low.

Patch looks sane, although it would be good to verify just which
versions of gcc this works for. All versions with retpoline?

                        Linus
