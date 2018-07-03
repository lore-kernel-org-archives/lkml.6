Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C722089D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTM86glu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C722089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeGCQNd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:13:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32988 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:13:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so1257066pfi.0;
        Tue, 03 Jul 2018 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gRYaLjR3CCKM2wGuWU71S1PnHrJmSn/nWuCHLi8CiM=;
        b=hTM86gluYtmbQtOLmXx5fRW5meDPiY1JgQVQoK0NJBThDns8huJG9gC0YvA6mbk8Pn
         8nV6CdBNkslbKoa319X1JoYMNt7vcnlPpcnXA4/947WN31cZ8ZLSK4i6qv3+alp6Wstv
         RmjVftGtbqxAzg/wvWwZjG+jDOSshzkK3cDPIdKvQX3EaZ36dZRUUxq6TsiVuWjLb1yx
         W8aWS0J/F/B+p+H1hmIGiAXWI0dJgxX19BPr8cDcdvvg23PKdy1PZ6HEMGkhliNakrkR
         scht61eIEmsFSEu74WNzFVGgejzNy2dUT0ig90r3gsiwoS1LOoE3lkoaDC7EWxCfofYC
         EhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gRYaLjR3CCKM2wGuWU71S1PnHrJmSn/nWuCHLi8CiM=;
        b=Vqa1NdHI+FbpIOYzwjj9vgXOzoOMPEXXGgZzTZjSF2soEFsCuPDNcL2OF+Xuh9GXmH
         RfAioFuqs++ir9sLlCmo1FbfbTZNLT2eS8xI5iC8s8FIbIj/hb7FtHqQoxFWyVwE9d4M
         5oA417oXRDevSbMiaFOT6CJkxim4iKdOEyjRLQ5EBVMX3JZXGKjx4Wuusi6eeIDLY8qh
         191AUqlu5ogAcZ+nXWR0yHpGnOwhS/a6Qj9um/65uDru8nHOFwDrvEZmt39rqbnX8+Xn
         7DFsZxV0mal4B5gQ4nSsfniy/6Qtq2yJ4cf7oWiFmzaC139Pb/gGUOtYPeICXhgd75u4
         Z+MQ==
X-Gm-Message-State: APt69E15yA+hafV+WKgEGqbm+QSu+tqHhz6X6OxMnehd+A4QVkesKgVW
        Pyhq9Sh7Tj+erPPYPq9I14M=
X-Google-Smtp-Source: AAOMgpeaewWRTCvwDjQj1aj3dHY4fQUWHh0ultjEYNDuvKgLLVdDHxYFCL/3OayBgL2taEfe4t8oAg==
X-Received: by 2002:a63:2e81:: with SMTP id u123-v6mr22670447pgu.225.1530634411626;
        Tue, 03 Jul 2018 09:13:31 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id q10-v6sm4526021pfj.7.2018.07.03.09.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:13:30 -0700 (PDT)
Date:   Wed, 4 Jul 2018 01:13:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] console/fbcon: Add support for deferred console
 takeover
Message-ID: <20180703161327.GA391@tigerII.localdomain>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628090351.15581-4-hdegoede@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/28/18 11:03), Hans de Goede wrote:
[..]
>  
> +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> +	bool "Framebuffer Console Deferred Takeover"
> +	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y

+	default n

> +	help
> +	  If enabled this defers the framebuffer console taking over the
> +	  console from the dummy console until the first text is displayed on
> +	  the console. This is useful in combination with the "quiet" kernel
> +	  commandline option to keep the framebuffer contents initially put up
> +	  by the firmware in place, rather then replacing the contents with a
> +	  black screen as soon as fbcon loads.

Can we please default this to 'n'?

	-ss
