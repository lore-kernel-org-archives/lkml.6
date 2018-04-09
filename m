Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeDIQUn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753173AbeDIQUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:20:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEBC21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+ADIoDDKbQftDy3LWqKfcttGL/Bllx0dJntUXEl66n/WpS2+L+9fg1UBM/URcod98WDejoBEv952NKPMoGwl4=
MIME-Version: 1.0
In-Reply-To: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
References: <90aab80c1f906e70742eaa4512e3c9b5e62d59d4.1522794757.git.luto@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 9 Apr 2018 09:20:20 -0700
X-Gmail-Original-Message-ID: <CALCETrX=B37UsduZRW2Qo_S28V=hFqTVeqHHnqKQpM+-sE=CnQ@mail.gmail.com>
Message-ID: <CALCETrX=B37UsduZRW2Qo_S28V=hFqTVeqHHnqKQpM+-sE=CnQ@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: Drop idtentry's manual stack switch for
 user entries
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 3:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> For non-paranoid entries, idtentry knows how to switch from the
> kernel stack to the user stack, as does error_entry.  This results
> in pointless duplication and code bloat.  Make idtentry stop
> thinking about stacks for non-paranoid entries.
>
> This reduces text size by 5377 bytes.
>

Just a quick ping to make sure you all noticed this.
