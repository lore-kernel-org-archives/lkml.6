Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C120874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbeLQNey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:34:54 -0500
Received: from verein.lst.de ([213.95.11.211]:34429 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732765AbeLQNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:34:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 0AEAE68DD3; Mon, 17 Dec 2018 14:34:52 +0100 (CET)
Date:   Mon, 17 Dec 2018 14:34:52 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        julien.thierry@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        mingo@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, takahiro.akashi@linaro.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181217133450.GB5774@lst.de>
References: <20181130162015.83FE767357@newverein.lst.de> <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com> <20181214094714.GA30043@lst.de> <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com> <20181215134144.6b0cc45b@blackhole.lan> <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGdYn5rrLZGrXUPA+HcKfA1pECYnwT0B1-j3YBzdt773zjORw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 09:52:04AM +0530, Amit Daniel Kachhap wrote:
> There is no error message or crash but no useful output like below,
> 
> /sys/kernel/tracing # echo wake_up_process > set_graph_function
> /sys/kernel/tracing # echo function_graph > current_tracer
> /sys/kernel/tracing # cat trace
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |

Confirmed. The graph tracer self-test passes, but when used, there is no
output.

	Torsten

