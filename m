Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeD3IBL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:01:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58692 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeD3IBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:01:10 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, Martin Kelly <martin@martingkelly.com>,
        Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH 1/1] tools: power/acpi, revert to LD = gcc
Date: Mon, 30 Apr 2018 10:00:54 +0200
Message-ID: <6842093.byeXVzAmGC@aspire.rjw.lan>
In-Reply-To: <20180424074344.23029-1-jslaby@suse.cz>
References: <54661ff7-5c2a-473b-e08c-1cd267353c03@martingkelly.com> <20180424074344.23029-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 24, 2018 9:43:44 AM CEST Jiri Slaby wrote:
> Commit 7ed1c1901fe5 (tools: fix cross-compile var clobbering) removed
> setting of LD to $(CROSS_COMPILE)gcc. This broke build of acpica
> (acpidump) in power/acpi:
>  ld: unrecognized option '-D_LINUX'
> 
> The tools pass CFLAGS to the linker (incl. -D_LINUX), so revert this
> particular change and let LD be $(CC) again. Note that the old behaviour
> was a bit different, it used $(CROSS_COMPILE)gcc which was eliminated by
> the commit 7ed1c1901fe5. We use $(CC) for that reason.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Martin Kelly <martin@martingkelly.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Erik Schmauss <erik.schmauss@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: devel@acpica.org
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 2cccbba64418..f304be71c278 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -56,6 +56,7 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
>  # to compile vs uClibc, that can be done here as well.
>  CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>  CROSS_COMPILE ?= $(CROSS)
> +LD = $(CC)
>  HOSTCC = gcc
>  
>  # check if compiler option is supported
> 

Applied, thanks!
