Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC620C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfrdjAJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BC620C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391179AbeGLCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:09:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45629 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388243AbeGLCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:09:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id a17-v6so4120016plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlAinpI788/u37fyrU+gwhUQK+jSkUXrc5Q1GW2zoxU=;
        b=kfrdjAJ3XrSEvGj4/9b+Q3F1htFpD/X6boNwGnEGIp7yXTPdA5cEddZqvLq7eT5USL
         L8/VTWGvfYNKLR4qXSjEdqMlCuar7LI/KlMncsKOqVpM6siB+041UdsNwD/wlRTV+Owx
         761tN4p8QxLv2aLnrI3+kuJb/vHHnS07EastQaFWLdNtt2g1tfpX54eHTCp/b37fc7I3
         2ML7pB8plghIIYvj6hSIJSuR8JmyKH33ys7MZRsjH1yM/tKh+DdB+J6xYRAVYntSTA9C
         OdShIz7sk6XpenN++MTGYRWhE3JSEU+EURtiNSptZK2cvdCiopBZ+ukllE5+zXWPWMSH
         POmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlAinpI788/u37fyrU+gwhUQK+jSkUXrc5Q1GW2zoxU=;
        b=GlDykeSWn5gkOW3JkZPqNrKgmWovz/j+Y9ZG37RVc0xFJqmdWuZbxz8oeJ7rZaTF5f
         FF4/8CKFNUUbcR+c2JgxQq75HaquDk6lIDVrO4DHWWHWSbKFSHhv3u4odNW1xy8zb5/z
         i2vb46HqOYstZLhRvxSoALx0+uaADFBSHeV3RGEXD9AgqNcSKA2UzQ5kKLMr9JWBu2dk
         zmD7TgtK37nastyeWPvotlJKmE0fA8cxNmNoKPWJoNCP3qXI2MdslbbNMKHSqkxUsWfe
         AeJF3aCntKmA+FIbGfT6WwnJ+Gl3sdhlu0c9pIEOxsjZl17PI9kxvEF3miSHj+eB8/E4
         WlJQ==
X-Gm-Message-State: AOUpUlEYRwdQpeQq5J9qwRy3Dez4jmzAVOtaWj738Ie4x11c0uZpl03s
        /U3ukKElYKQ06yw5qbihArqq7x4a
X-Google-Smtp-Source: AAOMgpfRIPYHL5qpKpK17jt1JRQZAIDyI1Sba4THhKQYBpN8LB+zMsq2Yl2odOjS3SGkfphfnOubSw==
X-Received: by 2002:a17:902:7798:: with SMTP id o24-v6mr299752pll.165.1531360939167;
        Wed, 11 Jul 2018 19:02:19 -0700 (PDT)
Received: from localhost ([175.223.26.85])
        by smtp.gmail.com with ESMTPSA id p3-v6sm6435026pfo.130.2018.07.11.19.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:02:16 -0700 (PDT)
Date:   Thu, 12 Jul 2018 10:58:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180712015848.GA663@jagdpanzerIV>
References: <20180711151755.613eba3c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711151755.613eba3c@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/11/18 15:17), Steven Rostedt wrote:
> +bool ignore_console_lock_warning __read_mostly;
> +EXPORT_SYMBOL(ignore_console_lock_warning);

OK. So, to recap,
We made is_console_locked() EXPORT_SYMBOL recently [it's still in linux-next],
so people could use WARN_CONSOLE_UNLOCKED in more places; this made other
people unhappy, so now we add another EXPORT_SYMBOL to the picture, which will
disable those newly added WARN_CONSOLE_UNLOCKED and make other people happy
again.

This makes me wonder - do we want to add more WARN_CONSOLE_UNLOCKED in the
first place? :)

Other than that, the patch looks OK to me I guess. I'm not super happy with
more printk EXPORT_SYMBOL-s, frankly speaking, I'm not entirely in love with
the "add a bool flag to suppress warn print outs which we added in the
previous patch" direction, but if you guys want/need it...
Probably I'm just dramatizing it, as usual ;)
The removal of "#if 1" is definitely nice.

Let's hear from Petr.

	-ss
