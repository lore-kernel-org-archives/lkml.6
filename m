Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA6CC60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFFS0k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeFFS0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:26:37 -0400
Date: Wed, 6 Jun 2018 14:26:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Johan Hovold <johan@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, changbin.du@intel.com,
        linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org,
        akpm@linux-foundation.org, changbin.du@gmail.com,
        tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180606142622.2338abf6@vmware.local.home>
In-Reply-To: <20180606142600.GN13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
        <201806060501.btF3aJMZ%fengguang.wu@intel.com>
        <20180606095714.1d3c2def@vmware.local.home>
        <20180606142600.GN13775@localhost>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 16:26:00 +0200
Johan Hovold <johan@kernel.org> wrote:

> Looks like the greybus code above is working as intended by checking for
> unterminated string after the strncpy, even if this does now triggers
> the truncation warning.

Ah, yes I now see that. Thanks for pointing it out. But perhaps it
should also add the "- 1" to the strncpy() so that gcc doesn't think
it's a mistake.

-- Steve
