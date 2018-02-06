Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeBFXSL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753537AbeBFXSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:18:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3261D2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 18:18:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sztsian@gmail.com
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com,
        Vladislav Valtchev <vladislav.valtchev@gmail.com>
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
Message-ID: <20180206181807.2d35393e@gandalf.local.home>
In-Reply-To: <20180204032014.6962-2-sztsian@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
        <20180204032014.6962-2-sztsian@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Feb 2018 11:20:13 +0800
sztsian@gmail.com wrote:

> From: Zamir SUN <sztsian@gmail.com>
> 
> The current detection for swig will cause output to be
> /usr/bin/swig
> y
> So this will never be equal to y. With this patch, the swig path is
> removed from output, so the detection can work as expected.
> 
> Fixes 3bf187a43b7e6302592552ecbc294e5820249687

Hi Zamir,

Actually, a fix was already sent to me:

 http://lkml.kernel.org/r/20171220180748.17273-18-vladislav.valtchev@gmail.com

I'm working on add that one.

Thanks!

-- Steve

 
> 
> Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index a5d2c38..7c0d1a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,7 +105,7 @@ PYTHON_GUI	:= ctracecmd.so ctracecmdgui.so
>  PYTHON_VERS ?= python
>  
>  # Can build python?
> -ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig && echo y"), y)
> +ifeq ($(shell sh -c "pkg-config --cflags $(PYTHON_VERS) > /dev/null 2>&1 && which swig > /dev/null && echo y"), y)
>  	PYTHON_PLUGINS := plugin_python.so
>  	BUILD_PYTHON := $(PYTHON) $(PYTHON_PLUGINS)
>  	PYTHON_SO_INSTALL := ctracecmd.install
