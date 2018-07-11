Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F82C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EAA208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVzpQO+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EAA208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403752AbeGLAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:10:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46208 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbeGLAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:10:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so19409632pfl.13;
        Wed, 11 Jul 2018 17:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sowhJEIHKT/l4lfxWfpzrrtqYE355WpiopVwEDAv5EI=;
        b=tVzpQO+n6lAzisGuORwar45JH2m3drfg9pDqCRsT/33MpYUFPGgxEKIDOBwfTDcrfR
         yQqp8+FFFKK7J6Dp5t7SEAWTfkuq39ZmOlfxeLdjBConhxTsRY37/1ezqSUs5dOGNnWi
         jqGj+OKglFS+2R8X4/qOE9rUgyAix4vLIjaWICJTDnlTF409PspyaA4PrPKO2wXqhqN0
         Emvaa97jhMvPwvo9Fa1YtompnF2KH4/eVN22vyBpABIIQ0OBvNtI0TBj95ApA7xaq+1U
         lKETqAtVahaBjoeEZiA2TOSZbXIKO3YiuxuY2OkIKsr4NKGS1Py/QrGkbO/u7W+BZEfI
         /FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sowhJEIHKT/l4lfxWfpzrrtqYE355WpiopVwEDAv5EI=;
        b=f+bfEpLuOCVD5iyRtjnYtnUz+NXWPuov6dTY3+6+OgtZgWexxT57i3xmBNp1AWobYV
         1y4Q36hFVXYQkzZIpOjsMcNXyaZiEoY0ZVJGQYjTxHB68N9vUGCzm1ofSpbd/jtd9Xhb
         NJDBsLUsG8BR1QH/9SUAl59yJzVwwaX+5tdgzTTQmkLCc9iiPLfiucEtjEf2JpencBmF
         Ly8d4cBqblC5curPZKY6LUeB/dLCZ/WlnQ9YzXimmqCVnueqXIy30U8j9vmvKne/JZkl
         6b0wRMLI7siHKO4+pX8GaPTcn5nOINHL39T+lS/BP/MUTXHnWemz+jm6aCPokQ5Jufr0
         3DHg==
X-Gm-Message-State: AOUpUlHZLeM4GFcWmIDSuSTb6ZF6Zc/+9m44Jj3bkwhdtyJ34rQYONYP
        2xTINEc8nAbWUQj5+U0vl84=
X-Google-Smtp-Source: AAOMgpcbyQNj6kpK89FQF3x2XoFhjTJYimrScY23L7J/rrisZC2PvcADOLesFzSP78JW9POjRjkONQ==
X-Received: by 2002:a63:e742:: with SMTP id j2-v6mr11728pgk.114.1531353807054;
        Wed, 11 Jul 2018 17:03:27 -0700 (PDT)
Received: from localhost ([175.223.26.85])
        by smtp.gmail.com with ESMTPSA id h10-v6sm10959204pfj.78.2018.07.11.17.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 17:03:25 -0700 (PDT)
Date:   Thu, 12 Jul 2018 08:59:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
Message-ID: <20180711235956.GA4829@jagdpanzerIV>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (07/11/18 16:46), Thomas Zimmermann wrote:
> Am 28.06.2018 um 11:03 schrieb Hans de Goede:
> > Replace comments about places where the console lock should be held with
> > calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Debugging fbcon sometimes requires to not take the console lock. This
> patch breaks the debugging workaround provided by
> 'fb.lockless_register_fb'. The dmesg is now filled with warnings about
> the missing lock.

Hmm. I once dealt with WARN_CONSOLE_UNLOCKED(), and back then, IIRC,
I really wanted to turn it into WARN_ONCE_CONSOLE_UNLOCKED(), which
would WARN_ON_ONCE() instead of WARN_ON(). It's just a bit too noisy
and verbose and a single backtrace was already enough.

	-ss
