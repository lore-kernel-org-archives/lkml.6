Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932531AbeCITFe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932069AbeCITFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:05:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF18621723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELtycHJZKl0YiXeRI4dBqc2IgAdDPB1NiqvwS55QACd9xmrpa962QVILOPxP1syhiZ5BFjv5D2RaZetT/+CfFfA=
MIME-Version: 1.0
In-Reply-To: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Mar 2018 13:05:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
Message-ID: <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
Subject: Re: Bug: Microblaze stopped booting after 0fa1c579349fdd90173381712ad78aa99c09d38b
To: "Alvaro G. M." <alvaro.gamez@hazent.com>,
        Michal Simek <monstr@monstr.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.com> wrote:
> Hi,
>
> I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d38b
> makes microblaze unbootable.
>
> I'm sorry I can't provide any console output, as nothing appears at all,
> even when setting earlyprintk (or at least I wasn't able to get anything
> back!).

Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
!CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem and
it can be removed, but I'm still investigating. Can you try out this
branch[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
microblaze-fixes
