Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F9FC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57AB20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beEMonpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfBHQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:00:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43722 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfBHQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:00:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so3159027eds.10;
        Fri, 08 Feb 2019 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGjk9Uusr20Af6UI6iePXn6HwsWauY7BPE5RDjaNmrI=;
        b=beEMonpINWdA1LJAYQWU/Gk3hMSIGOl6llYdzFB+oOJPuMGIkHT9PZETUovzJTz91j
         gd2lkKUIKF9XC0bBy/0ZQsd941wBFO66aMiAyZq2pYuLXp4RtoIN5K1optwN/3t4gvQt
         TOCsinmsTEdMOqjuvtYDFPv8oALvlO6LfMjLqVnU41zawXmtSjQQRM75AuR2E834C/fD
         dbRFAHjV6qQwnk7sGtR6kex89el/rHsSIO5U+6n9sV1y0l2jpM8mUYUj1WrlhxjWSVMj
         gszGlVlaJO1XTWGlBJNZcuRkJkk0Faq67jD+Z/MX3gSRmWcLd15TYEpVSqGPVcjCeJRl
         mhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGjk9Uusr20Af6UI6iePXn6HwsWauY7BPE5RDjaNmrI=;
        b=H68aXH9g/Httom0Mg4ZwL9xZDeNp7ZkSWyfZkB82F8huAqaOaWuHleAT6E+PmKpdyV
         jLZYOW93EO5Clb9I9IrDB5I0RfXnYd+kh5TaXLuHj+tuG8rTf7Wr6urIG+iZQ8MYkrLQ
         efLPHZ21U1xnRF7JKKrcmpvQATRMB+9B9qVbm7qgR/0SZiVP6KWnREIgF5vn7FvFixtm
         QZpuCkhwDXjWmCVbxSljMb7N/4Exgt+8gFOrafVkX8MemYU0QiLncVlk1lOqB9/g0L1p
         /BQXqP5+k3Vtj8SOj+5YvEKJC3mXYaEmXU6fG2lvfEduxYq/lSBlU/3NevVZ/npEjzT5
         ndAg==
X-Gm-Message-State: AHQUAuYuPEPtPpbPrLyo7z8kxngX3/nIlMmrDPU+rCxAJrQqQ1eGnvnN
        SmMUHDYVshuUvYntymtiy9c=
X-Google-Smtp-Source: AHgI3IZQmPa0eVsa8RW4j3J5Qo1Q0T4CTlEeHMX3QmXsDU6SXj4qb9N89Gm9ub1ElvbwNiMdyMJfIQ==
X-Received: by 2002:a17:906:1687:: with SMTP id s7mr10753271ejd.137.1549641647060;
        Fri, 08 Feb 2019 08:00:47 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id i19sm556804ejv.46.2019.02.08.08.00.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 08:00:46 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:00:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Brian King <brking@us.ibm.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Bradley Grove <bgrove@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5] scsi/ata: Use unsigned int for cmd's type in ioctls
 in scsi_host_template
Message-ID: <20190208160044.GB26005@archlinux-ryzen>
References: <20190126075256.29608-1-natechancellor@gmail.com>
 <20190207160719.28895-1-natechancellor@gmail.com>
 <20190208080501.GA18530@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208080501.GA18530@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:05:01AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 07, 2019 at 09:07:20AM -0700, Nathan Chancellor wrote:
> > Clang warns several times in the scsi subsystem (trimmed for brevity):
> > 
> > drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to
> > switch condition type (2147762695 to 18446744071562347015) [-Wswitch]
> >         case CCISS_GETBUSTYPES:
> >              ^
> > drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to
> > switch condition type (2147762694 to 18446744071562347014) [-Wswitch]
> >         case CCISS_GETHEARTBEAT:
> >              ^
> > 
> > The root cause is that the _IOC macro can generate really large numbers,
> > which don't fit into type 'int', which is used for the cmd parameter in
> > the ioctls in scsi_host_template. My research into how GCC and Clang are
> > handling this at a low level didn't prove fruitful. However, looking at
> > the rest of the kernel tree, all ioctls use an 'unsigned int' for the
> > cmd parameter, which will fit all of the _IOC values in the scsi/ata
> > subsystems.
> > 
> > Make that change because none of the ioctls expect a negative value for
> > any command, it brings the ioctls inline with the reset of the kernel,
> > and it removes ambiguity, which is never good when dealing with compilers.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/85
> > Link: https://github.com/ClangBuiltLinux/linux/issues/154
> > Link: https://github.com/ClangBuiltLinux/linux/issues/157
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Acked-by: Bradley Grove <bgrove@attotech.com>
> > Acked-by: Don Brace <don.brace@microsemi.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you for the review, it is much appreciated!

Nathan
