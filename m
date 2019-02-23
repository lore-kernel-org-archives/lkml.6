Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE73C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB07206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4rXJS9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBWCdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:33:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33026 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWCdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:33:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id z7so2989748lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 18:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtVpgAsfWx+jnrwvWOS9fgz99omyDP/WLc1UQ0qCLT8=;
        b=g4rXJS9bIds3WBrMUVeDNPOY6xCJ4V/79nLbvGjCxEn52Sq12oZKUMOJJas1wihO46
         XQGA5IOFwp1s+eaUoPyi9B/ye/oX7IGqy9UJxHEkOoc4aebV8J+SKeP7Hvpc+YKh1Bbi
         IDq2bsPhQ1KksaUKA4vV6p2z4iAXcejCILHqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtVpgAsfWx+jnrwvWOS9fgz99omyDP/WLc1UQ0qCLT8=;
        b=CYl/W2/4DCd6RLONe9STJZ33zAb7CGwI2ZRlXFsqcBGEhq3Ymzce4LqYD67orp4953
         wjH3GuY9yB1XFvvsSqtvKNKEGX+XJAZJAGSICYd40uwOhNcLxLmNg74OeZxXq9z6CLAy
         SG+5TTESCo6jl7eirP2dvOsvHUScV9Ic6vJdLeWLsn0k9ij/99KJecJcxlE5ex/GgmlF
         gPp2mreCS0wdzYTR0Qr/UA+LzTmq/AqZNuVaoceFBmXDSpkTRfsXpDBpSocQrACvNpJe
         5HoetYP3EAZ1YC8vffOAAKbuE+Sel8twJ+K0HCm89lF5RLX/77IyL/6sCjpKjdF5N32t
         n93g==
X-Gm-Message-State: AHQUAuadzhcetaBifGnVrbMCsG1/RwV36XyJI296y1zGSDWSVKR5kLxk
        PUrBmS/j3pvXrnMiZ5vxOBypBQhW6nw=
X-Google-Smtp-Source: AHgI3Iat0kxKgH2HvPEFDfRKSRyCMkm0fAeZAXuTeCYzDb7I5TZcI6rOJxIa6v4QzrwrlShA87++wA==
X-Received: by 2002:a2e:20cf:: with SMTP id g76mr3963767lji.36.1550889188936;
        Fri, 22 Feb 2019 18:33:08 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 134sm991500lfg.17.2019.02.22.18.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:33:06 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id d14so3158239ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 18:33:06 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr4002596ljc.22.1550889185850;
 Fri, 22 Feb 2019 18:33:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net> <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
 <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com> <20190223022850.nv4hnweueetprbot@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190223022850.nv4hnweueetprbot@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 18:32:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyFoHuK-EFgOxtepnvKNtzad2qeCTXz0gjRdbntEPoOQ@mail.gmail.com>
Message-ID: <CAHk-=wiyFoHuK-EFgOxtepnvKNtzad2qeCTXz0gjRdbntEPoOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 6:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> imo this kernel release should finish as-is and in the next cycle we can
> change probe_kernel_read() to reject user address [..]

Absolutely. Nothing is going to change right now for 5.0, which is imminent.

It's really a "long-term we really need to fix this", where the only
question is how soon "long-term" is.

                   Linus
