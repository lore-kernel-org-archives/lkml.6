Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92688C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6973F20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfBAIYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:24:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:59664 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:24:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 00:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="143320217"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2019 00:23:57 -0800
Subject: Re: [PATCH v6 15/27] compiler: Option to default to hidden symbols
To:     Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Garnier <thgarnie@google.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jan Beulich <JBeulich@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sparse@vger.kernel.org
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-16-thgarnie@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3a2bdc07-e8c4-c340-dde7-516ab0de66f2@intel.com>
Date:   Fri, 1 Feb 2019 10:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131192533.34130-16-thgarnie@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 9:24 PM, Thomas Garnier wrote:
> Provide an option to default visibility to hidden except for key
> symbols. This option is disabled by default and will be used by x86_64
> PIE support to remove errors between compilation units.
> 
> The default visibility is also enabled for external symbols that are
> compared as they maybe equals (start/end of sections). In this case,
> older versions of GCC will remove the comparison if the symbols are
> hidden. This issue exists at least on gcc 4.9 and before.

What does this mean, if anything, for what/how symbols appear in /proc/kallsyms?
