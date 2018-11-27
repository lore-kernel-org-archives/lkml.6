Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2DC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/5wjr/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2DC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeK1Eaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:30:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44323 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK1Eaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:30:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so8167173pgr.11;
        Tue, 27 Nov 2018 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4KbMhYn/V8t0IeagEe6fAI5kRBQVT4RVnVQITtUUNhU=;
        b=p/5wjr/3vXnbYpxX6DKLv6Tc7i1s068AmQPMbqErZwdp2EznAmhxHLDV0zvv7UteyH
         mjQDSH98haR3lSGNlUwAPYMLPedevjFe1zkAlf+aTcHDpqLIzpnrYUngY+aY+m5nHaG2
         VOQ/3vuQcqYfwk6gB3AzEj6ErKLIhio7ZQh1WOyZZemtMPAVVOrMqBQmDSZGix0UD5Vn
         eoTdJkJCpvUHgpP0IhU0EiKXFhHzorKK6Q45+SN1ebx022GBftGVUVRMYbFfu8MLJwJu
         YhrbU+Z+ozVl49HJmDyU12n3+Uc+puTj6WrdawFb871RjQP1x/i8zsOKoslnisLRbXAC
         efWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4KbMhYn/V8t0IeagEe6fAI5kRBQVT4RVnVQITtUUNhU=;
        b=I/uHR5n4gMQPNcne48SlSfKpw2Ji1F6PXYFILvhK8M4pyHdxQTpqx4z5YYgR4a18Tl
         VhbJa7RrK5m9PrtWh5WFvNq8h+ldQh0UHvLv/gi0sk0kZctJ2OTL7fTDunH3eAi9cUoY
         x9nlLFnErSlIqGW7akUU6kM41mtXQRAJWYyJUNboxXmW7o1EPmCzsg2PMTJh4d1BB4go
         kX6AjN9PMxVG9uYBf9zaTZRw46CCCZIQB5YyZ9RcZnXrb0J7Cg9d7A8/fW5G2kiOcSwX
         jf1TBdDYTnXobj0ss93Pgeo5hfbvHQ2F0Jdx6yl3HbULzjsp7/weVQuk1cSKa80dT3hQ
         RqDQ==
X-Gm-Message-State: AA+aEWa8XfsBfrs8RYkvnFILcfqAfGXaSgpJSflWKkROoLRjZ5YxfUbC
        cQcU3BAbj1+reFu/rGb8bn8D0i1f
X-Google-Smtp-Source: AJdET5fuJB2Dx7hkd2I4xwdiZg9zO2ajeh4mmj5G/kWRhhUkDykRorMBybEfx6GRCl0PyAzBfvlAfQ==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr29013983pgg.347.1543339918231;
        Tue, 27 Nov 2018 09:31:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b27sm5516447pfh.113.2018.11.27.09.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:31:56 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:31:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marek Habersack <grendel@twistedcode.net>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Message-ID: <20181127173155.GA12015@roeck-us.net>
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <5d94f857-b31d-a02c-5a20-2796076f447e@twistedcode.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d94f857-b31d-a02c-5a20-2796076f447e@twistedcode.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:48:19PM +0100, Marek Habersack wrote:
> On 27/11/2018 15:32, Guenter Roeck wrote:
> Hi,
> 
> You might try to see if you have CONFIG_SCSI_MQ_DEFAULT=yes in your kernel config. Starting with 4.19.1 it somehow

Yes, it is enabled in my configuration.

> interferes with ext4 and causes problems similar to the ones you list below. Ever since I disabled MQ (either recompile
> your kernel or add `scsi_mod.use_blk_mq=0` to the kernel command line) none of those errors came back.
> 
I'll try that. Thanks a lot for the hint!

Guenter

> hope it helps,
> 
> marek
> > [trying again, this time with correct kernel.org address]
> > 
> > Hi,
> > 
> > I have seen the following and similar problems several times,
> > with both v4.19.3 and v4.19.4:
> > 
> > Nov 23 04:32:25 mars kernel: [112668.673671] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602889: comm git: bad
> > extra_isize 33661 (inode size 256)
> > Nov 23 04:32:25 mars kernel: [112668.675217] Aborting journal on device sdb1-8.
> > Nov 23 04:32:25 mars kernel: [112668.676681] EXT4-fs (sdb1): Remounting filesystem read-only
> > Nov 23 04:32:25 mars kernel: [112668.808886] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602881: comm rm: bad
> > extra_isize 33685 (inode size 256)
> > ...
> > 
> > Nov 25 00:12:43 saturn kernel: [59377.725984] EXT4-fs error (device sda1): ext4_lookup:1578: inode #238034131: comm
> > updatedb.mlocat: deleted inode referenced: 238160407
> > Nov 25 00:12:43 saturn kernel: [59377.766638] Aborting journal on device sda1-8.
> > Nov 25 00:12:43 saturn kernel: [59377.779372] EXT4-fs (sda1): Remounting filesystem read-only
> > ...
> > 
> > Nov 24 01:52:31 saturn kernel: [189085.240016] EXT4-fs error (device sda1): ext4_lookup:1578: inode #52038457: comm
> > nfsd: deleted inode referenced: 52043796
> > Nov 24 01:52:31 saturn kernel: [189085.263427] Aborting journal on device sda1-8.
> > Nov 24 01:52:31 saturn kernel: [189085.275313] EXT4-fs (sda1): Remounting filesystem read-only
> > 
> > 
> > The same systems running v4.18.6 never experienced a problem.
> > 
> > Has anyone else seen similar problems ? Is there anything I can do
> > to help tracking down the problem ?
> > 
> > Thanks,
> > Guenter
> > 
> 
