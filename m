Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD22DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945F020665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCKJciSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945F020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJYX2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:28:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJYX2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:28:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so4300455pfb.13;
        Thu, 25 Oct 2018 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXJ8cPnoZvJ2sAUX0URYriFwPHKYPmm9JuiPpEhdtMA=;
        b=tCKJciScPlOjHEVNg5nXnopOUhGfxmgEEMdvK4hznCw5ov7LFkf3v6nowufpkFt42n
         bDXe70gVHSH3g9ol5X4CuNvdrpQQFuRUxBq46ZQFV/0t19u0cif9ldkB766IWgVomaEL
         qSQgn2AE6S7hLbwX01MZ4t2yg9s+WrOe3Q0QYbo/lWkrMX9WFNhnEZxTNB8j1b0gt3jq
         Yx3F2YHUnE/9sTdfTCjJxnO/ydCYY2LcnHk0H56DWYGTzqOodDN9wAtTJp6iFknl3T3M
         2wziUzL+rA91nCaqOdMJ29EdyoTsYNQyspyS2aHbwWpFcq4xjCPHm47JaBcbM3K5tiHV
         ni/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXJ8cPnoZvJ2sAUX0URYriFwPHKYPmm9JuiPpEhdtMA=;
        b=hdFUotCA/POCTFjZr6de6t6vAJQNfroAp282YrqOKjHtYZLSfkVqHfrLhg3pFr8A/L
         9xKC8kJ2/kaTJ84kB/gUS//JvgOZ10XPzW0wOc6rc2hBFIFWEE3aoE+i96QOc5/NvBsI
         bL5vJnRUSELEVaKTH0qurK7DAaYiZe03z/TIe4rof8jsbBUZVnOeIIp6tdEqvqr8tznp
         AKRD6tHDtUXRhtZT7PZr+zc6MgCiFrv9OsQyesAyM3W+ZHh73BH4bpoko8aipp5liiYP
         bqojoiBRLh0xVjpdV30wKeLQwHAllieMaUg7A7i6sLF1f6fvWe9RtelCARETi09zZPY1
         FM+g==
X-Gm-Message-State: AGRZ1gKwhBD/QnsEYfvAJ2BlFD/Pl1TP5iIXON2I+MMMYor7OLSz6IA5
        cDLs1S0tcjBnVvS4UvHO9LU=
X-Google-Smtp-Source: AJdET5d1gw9fXhBA8bR8QBPWQAcr6HFLTTWAtDMQC3o1Hfk5OzkmyPomamHUsIqUPBseYnbAFZc5Hw==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr1727451pgd.228.1540479332154;
        Thu, 25 Oct 2018 07:55:32 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id e2-v6sm9839277pgv.25.2018.10.25.07.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:55:30 -0700 (PDT)
Date:   Thu, 25 Oct 2018 20:25:20 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
        stefan.popa@analog.com, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
Message-ID: <20181025145520.GA16950@himanshu-Vostro-3559>
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
 <20181025142635.3apgyaxzhr73kehc@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025142635.3apgyaxzhr73kehc@renatolg>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:26:36AM -0300, Renato Lui Geh wrote:
> Hi,
> 
> Thanks for the quick review. :)
> 
> > But please create one patch per issue and do not put unrelated changes into
> > the same patch.
> 
> Should I resend this patch as a patchset containing the two changes?

Yes! "One patch per change policy"

> > Also your mail client seems to have replaced tabs in the patch with spaces,
> > this means the patch will not apply cleanly. Check the
> > Documentation/email-clients.txt file for some hints how to configure your
> > mail client so it will not break patches.
> 
> From my end my original email patch appears to have tabs instead of
> spaces. I redownloaded my email and vim shows that the indentation has
> the ^I tab characters. But when downloading your reply it was converted
> to spaces. Am I missing something?

Your patch applies fine.

I think the problem is on Lars end due to Thunderbird.

In the meantime, you can verify the patch using:

$ git am <your_patch.patch>

Also, you can try to use `git send-email` to send patches.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
