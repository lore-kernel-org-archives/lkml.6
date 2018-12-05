Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4640C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA242087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btUfF8zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA242087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeLEJuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:50:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41945 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeLEJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:50:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so241830ljc.8;
        Wed, 05 Dec 2018 01:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RYISLgGXnU6gBBNeqHLvv96XBNp05noLEvvRTVgHeUY=;
        b=btUfF8zyRrk16dxB/76Ldk++VbfYrCa6YAmGeD3Rh5zSIBtTYDai5fsMHxzFlptGxO
         DZxDV9J5x5IsxBw4BBhZ07uNHkBu7NVklxzbolfIXdfC1ql9gz9n1YmrSd6+Na3X3Qyv
         tkLREYis2X8B94CORkF5I4d7RNcHQxZ5cF1PcPesr8hQUrWMdd5mbKUdvt2sSncAupHB
         pFrQwUUIRntAW2oFnkz4nI6h1ehmp/YzUSFQreHISVMz3xzJ3AuxKhiOh+Yqg19k3OiA
         S8KKtOSMQKFJ9kNkQH3zlg7p4+B4p+LvZW+fQ64SIYt2dPcjNiHxskT9tm9py8Qpa3AJ
         3/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RYISLgGXnU6gBBNeqHLvv96XBNp05noLEvvRTVgHeUY=;
        b=BGjKvOHwUXFBCmTcv5DNfuuDEsVQ1Xlj6nM4ARbuBAZ1tUJpSS/senjtzOB75ohTnF
         vOeX+Iy7L3WpJyC4JmuaDTK1NUC3eqCZuuZrBmSf4ANpx8uP7wfcMDSsDZPTqP8SCi/L
         KorBW5QDrOqwNDjPqs+DGcrDQv/JIxNJUz6g98kij5Tqk2cW4sKTMoUbIf6K5PqQy2MS
         dUdSqK59jofypzbmWch2vZ0hmAKpDyOTcatTfiPqOAhytj1ObgWqm3DF2GvOgOWhwdKV
         qyybpuOUuhXd9okpf9E4Idfw/0rY6ebmgyh/WORgrDFU8jebZshbhRKrfl/2gQIFECjz
         RI0A==
X-Gm-Message-State: AA+aEWZO8xDQVQeqWeOUiTcBIYdmjvWlPuNa7tmSiuqV319gE60mXP/b
        Hpo0VOX2tW6LGdWfqdDa+yI=
X-Google-Smtp-Source: AFSGD/XaAPnkxNSEiVLIJ+RzEPeeR309iU79iVR5HmQ8jponIY3d7R3qp4riShxxjwfOuBebgEEJmw==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr14694355ljr.91.1544003448380;
        Wed, 05 Dec 2018 01:50:48 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e13-v6sm3657021ljk.53.2018.12.05.01.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 01:50:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUTpR-00047L-Fa; Wed, 05 Dec 2018 10:50:49 +0100
Date:   Wed, 5 Dec 2018 10:50:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181205095049.GA15689@localhost>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
 <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:36:52AM +0200, Jarkko Nikula wrote:
> On 12/4/18 6:31 PM, Johan Hovold wrote:
> > On Tue, Dec 04, 2018 at 05:15:18PM +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Dec 04, 2018 at 05:00:36PM +0100, Johan Hovold wrote:
> >>> The USB-serial console implementation has never reported the actual
> >>> terminal settings used. Despite storing the corresponding cflags in its
> >>> struct console, this was never honoured on later tty open() where the
> >>> tty termios would be left initialised to the driver defaults.
> >>>
> >>> Unlike the serial console implementation, the USB-serial code calls
> >>> subdriver open() already at console setup. While calling set_termios()
> >>> before open() looks like it could work for some USB-serial drivers,
> >>> others definitely do not expect this, so modelling this after serial
> >>> core is going to be intrusive, if at all possible.

> >>> This specifically fixes a regression that was triggered by a recent
> >>> change adding software flow control to the pl2303 driver: a getty trying
> >>> to disable flow control while leaving the baud rate unchanged would now
> >>> also set the baud rate to the driver default (prior to the flow-control
> >>> change this had been a noop).
> >>>
> >>> Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
> >>> Cc: stable <stable@vger.kernel.org>	# 4.18
> >>> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> >>> Cc: Florian Zumbiehl <florz@florz.de>
> >>> Signed-off-by: Johan Hovold <johan@kernel.org>
> >>> ---
> >>>   drivers/tty/tty_io.c         | 11 +++++++++--
> >>>   drivers/usb/serial/console.c |  2 +-
> >>>   include/linux/tty.h          |  1 +
> >>>   3 files changed, 11 insertions(+), 3 deletions(-)
> >>
> >> Ah, messy :)
> >>
> >> Want me to take this through my tty tree?
> > 
> > If you prefer. I was planning on including this in a USB-serial pull
> > request for -rc6 since it fixes a user-reported regression, but perhaps
> > taking this through your tty-linus branch (which already holds a console
> > fix) is easier/faster.
> > 
> > We should wait for Jarkko to confirm that this fixes the problem he
> > reported first, though.
> > 
> Great, this fixed the issue for both pl2303 based adapters I reported.
> 
> Tested on top of 0072a0c14d5b ("Merge tag 'media/v4.20-4' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Great, thanks for testing.

Greg, I noticed I left out the part about subdrivers not expecting
*write()* to be called before open() so I'll amend the commit message
when applying and include this one in a pull-request tomorrow, if that's
ok with you?

Note that the changes to tty are trivial; I'm just renaming and
exporting an existing helper.

Thanks,
Johan
