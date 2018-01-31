Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeAaClM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:41:12 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:52860 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeAaClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:41:11 -0500
X-Google-Smtp-Source: AH8x2257EslcCucU0UYK3PQLiLO30hVqRqpWpWhsxoZUeXXgKFvdf3OKfKHmL2Mlfxa7Rru0ZavDrA==
Date: Tue, 30 Jan 2018 18:41:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch -mm] tools, vm: new option to specify kpageflags file fix
 fix
In-Reply-To: <20180130160041.ced8e9bbb4741494147f476f@linux-foundation.org>
Message-ID: <alpine.DEB.2.10.1801301840050.140969@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1801301458180.153857@chino.kir.corp.google.com> <20180130160041.ced8e9bbb4741494147f476f@linux-foundation.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, Andrew Morton wrote:

> On Tue, 30 Jan 2018 15:01:01 -0800 (PST) David Rientjes <rientjes@google.com> wrote:
> 
> > page-types currently hardcodes /proc/kpageflags as the file to parse.  
> > This works when using the tool to examine the state of pageflags on the 
> > same system, but does not allow storing a snapshot of pageflags at a given 
> > time to debug issues nor on a different system.
> > 
> > This allows the user to specify a saved version of kpageflags with a new 
> > page-types -F option.
> > 
> 
> This, methinks:
> 
> --- a/tools/vm/page-types.c~tools-vm-new-option-to-specify-kpageflags-file-fix
> +++ a/tools/vm/page-types.c
> @@ -791,7 +791,7 @@ static void usage(void)
>  "            -N|--no-summary            Don't show summary info\n"
>  "            -X|--hwpoison              hwpoison pages\n"
>  "            -x|--unpoison              unpoison pages\n"
> -"            -F|--kpageflags            kpageflags file to parse\n"
> +"            -F|--kpageflags filename   kpageflags file to parse\n"
>  "            -h|--help                  Show this usage message\n"
>  "flags:\n"
>  "            0x10                       bitfield format, e.g.\n"

Please find a "fix fix" below per Naoya.  Thanks both!

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -169,10 +169,10 @@ static int		opt_raw;	/* for kernel developers */
 static int		opt_list;	/* list pages (in ranges) */
 static int		opt_no_summary;	/* don't show summary */
 static pid_t		opt_pid;	/* process to walk */
-const char *		opt_file;	/* file or directory path */
+const char		*opt_file;	/* file or directory path */
 static uint64_t		opt_cgroup;	/* cgroup inode */
 static int		opt_list_cgroup;/* list page cgroup */
-static const char *	opt_kpageflags;	/* kpageflags file to parse */
+static const char	*opt_kpageflags;/* kpageflags file to parse */
 
 #define MAX_ADDR_RANGES	1024
 static int		nr_addr_ranges;
