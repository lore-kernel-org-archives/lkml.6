Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeB0VM5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbeB0VMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:12:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B890021771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 27 Feb 2018 16:12:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <sw-dev@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>, <zong@andestech.com>
Subject: Re: ftrace: Proposal for an Alternative RecordMcount framework
Message-ID: <20180227161252.25162d81@vmware.local.home>
In-Reply-To: <20180227100425.GB20904@andestech.com>
References: <20180227100425.GB20904@andestech.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 18:04:26 +0800
Alan Kao <alankao@andestech.com> wrote:
 
> 1. During the final linking stages, do "objdump vmlinux.o | grep ..." [2]

Note, doing it at that stage takes the longest time. It makes small
changes much longer to compile. That said...

> 2. Form the output as an ELF objecj
> 3. Link the object to __mcount_loc_start symbol
> 4. Done
> 
> With the similar reason as the patch [3], we should mark _mcount to be
> a weak symbol to prevent it from being relaxed later.
> 
> We would like to know your opinion and comments on this.
> Thanks!

What about just having your arch use recordmcount.c instead? It doesn't
do any grepping. It is an elf reader and modifier and modifies the .o
file directly.

Note, I will be rewriting that code in the near future too, to
consolidate it with objtool.

-- Steve
