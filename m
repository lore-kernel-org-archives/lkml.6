Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeBARKZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbeBARKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:10:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0ED21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 1 Feb 2018 12:10:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle
 issues
Message-ID: <20180201121015.72fd242c@gandalf.local.home>
In-Reply-To: <4b373579-7a86-6883-2624-12a5408bb49b@gmail.com>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
        <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
        <20180125060330.781667e9@vmware.local.home>
        <a30d4cd3-0068-8cca-cc2f-ca207d0d278b@gmail.com>
        <20180125231443.44yy65ztr6exaam7@ninjato>
        <4b373579-7a86-6883-2624-12a5408bb49b@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2018 16:46:06 -0800
Frank Rowand <frowand.list@gmail.com> wrote:

> The point is that using ftrace means there are use cases for the
> debug information where the information will not be available.

Note, this email came out when I was traveling. I'm now looking at the
code and trace events are enabled right after rcu_init() in init/main.c.

The early_initcall() enables syscall events(), as they are not
available earlier.

-- Steve
