Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D719BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63DD20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549326434;
	bh=VSpTcsVAvpl8NN5z4FdLt/IZH0dF/jBnVrzssnxh7uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VdPul8cHWH5+evGtL75YLX9J71JwVGNJc2beb38nFqsHJGqO9D90gW566obJD3UWw
	 sCP8kTheFOk/eLQHkDO2w1OGJ3ytoEc3wUpUSAnyrCtnZTFkjmR7W46DFaUnVJ+UV8
	 weNDh5Ie9zTtLTW++2LkWJVFaHzP69lH4BOZPxIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBEA1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:27:13 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38354 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfBEA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:27:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so1069599ywb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 16:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqfLmh7nW4jqaji6B3u2Aq1RhA8Dm+NrZjGqEbJLaDk=;
        b=DTLSfBWiJHdStK0GaYm6itytFkUoLb/7C0VTHaYLAbbM9hVpg4gGpQ/53pxxPNzYTO
         fWqAjMhZa0BWyceD5ceWNkbZkS76D+bJf/azEevpmAHScTtlLsAUWQE3C3IfPv5Kd5H5
         DTn9pVn29hJhdxqFsfpwdV51jYbCaNz9jwsUYK0jyDegbIpJo33zImhQPaFIHeRlMoft
         5MGI/H4NvPhBZkAPljCvgmISgeyU3249XYA7KQ77mSCQ8Agac4q2W7sbKq/QuyOb9h98
         LXQbQxSp71xEWeQndzzqamt2A0L/6ZJAEyvTfV1ASbiQ1XZ+pAidsU4DJFUK2zBGVfrv
         Od4A==
X-Gm-Message-State: AHQUAuYAKyPJ4RcnAiBKGe7U0tWQ7DtHrx9dgpIC+WvvXCHXwBMOZs8W
        R81ualoMUK6YPouQoSCH+4Y=
X-Google-Smtp-Source: AHgI3Iaga5Dqk44UR2SkUujr9lmqtSnFs3f5BoonQ+1uB0fUYNi1bn97tNO3+DK9vzwlpUMjIDvHsg==
X-Received: by 2002:a0d:f743:: with SMTP id h64mr1782668ywf.498.1549326431380;
        Mon, 04 Feb 2019 16:27:11 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id z139sm588697ywa.36.2019.02.04.16.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 16:27:10 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 04 Feb 2019 16:27:08 -0800
Date:   Mon, 4 Feb 2019 16:27:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_loader: move CONFIG_FW_LOADER_USER_HELPER
 switch to Makefile
Message-ID: <20190205002708.GU11489@garbanzo.do-not-panic.com>
References: <1545664497-26740-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545664497-26740-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 12:14:57AM +0900, Masahiro Yamada wrote:
> The whole code of fallback_table.c is surrounded by #ifdef of
> CONFIG_FW_LOADER_USER_HELPER.
> 
> Move the CONFIG_FW_LOADER_USER_HELPER switch to Makefile so that
> it is not compiled at all when this CONFIG is turned off.
> 
> I also removed the confusing comment, "Module or buit-in [sic]".
> CONFIG_FW_LOADER_USER_HELPER is a boolean option.
> (If it were a module, CONFIG_FW_LOADER_USER_HELPER_MODULE would
> be defined instead.)
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/base/firmware_loader/Makefile         | 2 +-
>  drivers/base/firmware_loader/fallback_table.c | 5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
> index a97eeb0..5c7f422 100644
> --- a/drivers/base/firmware_loader/Makefile
> +++ b/drivers/base/firmware_loader/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for the Linux firmware loader
>  
> -obj-y			:= fallback_table.o
> +obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o

Phew ... CONFIG_FW_LOADER_USER_HELPER is bool.

So no new modules. You had me scared for a bit.

The reason this was built-in was that we *need* this table for built-in
code which *can* request firmware *pre* module loading. The table thing
was designed to be built-in if the firmware interface was enabled in
any way.

Fortunately I don't see this regressing as CONFIG_FW_LOADER_USER_HELPER
is a bool. It is hard to enforce other than with careful review.

>  obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
>  firmware_class-objs := main.o
>  firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 7428659..776dd69 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -16,9 +16,6 @@
>   * firmware fallback configuration table
>   */
>  
> -/* Module or buit-in */
> -#ifdef CONFIG_FW_LOADER_USER_HELPER
> -
>  static unsigned int zero;
>  static unsigned int one = 1;
>  
> @@ -51,5 +48,3 @@ struct ctl_table firmware_config_table[] = {
>  	{ }
>  };
>  EXPORT_SYMBOL_GPL(firmware_config_table);
> -
> -#endif

Just a random early spring cleaning note for the future:

Although we cannot rename the firmware module to something more
sensible, we could just make the old sysfs firmware loading interface
*its own module firmware_class* and move the non-sysfs code to its own
first citizen file.

  Luis
