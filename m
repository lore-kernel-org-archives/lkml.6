Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeAaAAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:00:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeAaAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:00:43 -0500
Date: Tue, 30 Jan 2018 16:00:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] tools, vm: new option to specify kpageflags file
Message-Id: <20180130160041.ced8e9bbb4741494147f476f@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.10.1801301458180.153857@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1801301458180.153857@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 15:01:01 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> page-types currently hardcodes /proc/kpageflags as the file to parse.  
> This works when using the tool to examine the state of pageflags on the 
> same system, but does not allow storing a snapshot of pageflags at a given 
> time to debug issues nor on a different system.
> 
> This allows the user to specify a saved version of kpageflags with a new 
> page-types -F option.
> 

This, methinks:

--- a/tools/vm/page-types.c~tools-vm-new-option-to-specify-kpageflags-file-fix
+++ a/tools/vm/page-types.c
@@ -791,7 +791,7 @@ static void usage(void)
 "            -N|--no-summary            Don't show summary info\n"
 "            -X|--hwpoison              hwpoison pages\n"
 "            -x|--unpoison              unpoison pages\n"
-"            -F|--kpageflags            kpageflags file to parse\n"
+"            -F|--kpageflags filename   kpageflags file to parse\n"
 "            -h|--help                  Show this usage message\n"
 "flags:\n"
 "            0x10                       bitfield format, e.g.\n"
_
