Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeDXQjR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:39:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34210 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeDXQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:39:12 -0400
X-Google-Smtp-Source: AIpwx4945nYVd+HyG4fyCCo+sQYsmXjAEIC5+wra4IdAN1qHMNagKoYru+qp0gULqW+PRz1OKllxd4xEEH+rhysZvAc=
MIME-Version: 1.0
In-Reply-To: <20180424074344.23029-1-jslaby@suse.cz>
References: <54661ff7-5c2a-473b-e08c-1cd267353c03@martingkelly.com> <20180424074344.23029-1-jslaby@suse.cz>
From: Martin Kelly <martin@martingkelly.com>
Date: Tue, 24 Apr 2018 09:38:31 -0700
Message-ID: <CAN8CM3wHg8ena1ZfUQwioc_fhn0P9gNHVe7OwttUVi0vmkDrcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: power/acpi, revert to LD = gcc
To: Jiri Slaby <jslaby@suse.cz>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:43 AM, Jiri Slaby <jslaby@suse.cz> wrote:
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
> --
> 2.16.3
>

Reviewed-by: Martin Kelly <martin@martingkelly.com>

Thanks for noticing this and sorry I missed it!
