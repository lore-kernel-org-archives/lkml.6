Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1967CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2F320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0v3vL9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfANE57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:57:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39554 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfANE56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:57:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so21291234wra.6;
        Sun, 13 Jan 2019 20:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vbyy6BhIkMnlI786LqA6OILBoYgAW+jACwvZwPI69Gg=;
        b=C0v3vL9ISWoa1uCG8l1TPyQ+DZCnqzPAcL+k/ReUDuS9Zlj+CChSx74S7tC6knb2nF
         RTV5m/Pkm2hYt3Cg+ULLDZ6/N+e2YwKrv0RzESkD4eA6GWKEQ5WfPFKeLcIzQ03BIttE
         mXITk47Ft0y8nLN7P4rb57dvX2faeCBUI7M9hIGi4htGaIkM0XXf6vwonQmtrBija237
         RnOqleUwfV5LTJ/a87IWaQD0V72xEmIwYGdfo4Yt6N67GEU59aRd95J8WfzzbEx9YpML
         BME0CNo3zN6Ub+KAJK5cUuV/m2/oThIZcpQk/URD+HLWoTrQ6WGsJ2jLJtk/bgHlSNzt
         fBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vbyy6BhIkMnlI786LqA6OILBoYgAW+jACwvZwPI69Gg=;
        b=nE5hQ7kERFdIcHXDoivIv8ZAhm+5MIzczuZYJ3AI2oVLDiYIoK11S7lh8b0jd6Jdk+
         19xdasDiaNzetpW4mji74uluyslXAfnr2thH6p+uNyvPkxM48+AQ3Cef885BqpnYK1jn
         CpJG0sj2O6Ryd9XIqu7hSR1lKhEDWl4v5jismuvm/hARy098eKNK/exSpWYGMFwoM3yy
         SrVeiT5wJW6y1gFbBrvxsO7xlYGC0mFTfcX75zvQkZhb6Dvwxw1D5Y2C4ySeXf6uODS8
         b183yN9BtLrxJDyFu2LfDAAkyPdSi0qJ7tu6DfbNDKNRy/ldKm20R0pr36IxjIzEOI5d
         uhsQ==
X-Gm-Message-State: AJcUukcfw1EEGlh4mQGy5ePVBJzOqpzFWx0q4RPFIORt6PE/5vpNr197
        Rv5MczXzYjclrZ7ILDG5/gs=
X-Google-Smtp-Source: ALg8bN6Gd5vaakzTHVzIPhFmAoiZXspSdU1d4H977jEqcY+RD1nOvyeh/pU1okg3WYaRIg2XMAZp+Q==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr21838152wra.282.1547441876516;
        Sun, 13 Jan 2019 20:57:56 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e16sm103491133wrn.72.2019.01.13.20.57.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 13 Jan 2019 20:57:55 -0800 (PST)
Date:   Sun, 13 Jan 2019 21:57:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Brian King <brking@us.ibm.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3] scsi/ata: Use unsigned int for cmd's type in ioctls
 in scsi_host_template
Message-ID: <20190114045754.GA8440@flashbox>
References: <20181020050143.589-1-natechancellor@gmail.com>
 <20190114044206.6351-1-natechancellor@gmail.com>
 <c1f7f039-04b2-a660-2408-8d4ac0ea63c4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f7f039-04b2-a660-2408-8d4ac0ea63c4@acm.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 08:54:35PM -0800, Bart Van Assche wrote:
> On 1/13/19 8:42 PM, Nathan Chancellor wrote:
> > @@ -1292,7 +1292,7 @@ int esas2r_ioctl_handler(void *hostdata, int cmd, void __user *arg)
> >   	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
> >   	if (IS_ERR(ioctl)) {
> >   		esas2r_log(ESAS2R_LOG_WARN,
> > -			   "ioctl_handler access_ok failed for cmd %d, "
> > +			   "ioctl_handler access_ok failed for cmd %u, "
> >   			   "address %p", cmd,
> >   			   arg);
> >   		return PTR_ERR(ioctl);
> 
> If you have to repost this patch, please use that opportunity to join the
> above split strings. Additionally, since this patch touches much more SCSI

Sorry, I should have caught that. If I have to post again, I will fix
that.

> code than ATA code I think it should have been sent to Martin instead of to
> Jens. Anyway:
> 

I had Jens, Martin, and James on the 'to' line, with all of the other
maintainers of the individual files on cc. If I should have done it
differently, please let me know.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 

Thank you, I will carry this forward if I need to.

Nathan
