Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91799C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B051215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQcRXKm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B051215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHQS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:26:45 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34138 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeHQS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:26:45 -0400
Received: by mail-qk0-f194.google.com with SMTP id b66-v6so6479583qkj.1;
        Fri, 17 Aug 2018 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gtw8U6M1YN6hJovMedXkOYQAN7cTCpNydzYPiCT5XgM=;
        b=WQcRXKm7gzhm2OU2KL11I2t7QG7zbpndEvH6MY6sisTefgiP98SnIWTjKZv64l+ALN
         w49G/o47pZDOXpoBg9HAv5uuI9wd0WsEDMUsrsNqk13bO+0nxs/2LN0mZeBd+gZ8pFuH
         ANp5vDCm6/JZOZUUMfDSS3tvLA4CekqNCideZTWrLcHXEIT/qrb//xy99ENHFDr3FFe6
         CuJ8xuDRG9MiqSmdfsqxG0+5CAzoYww0tWvgxuh+LMRVm+ejMtcUssSKb+B4XoR1Log+
         x5JA4Saf+GvCrZqvicUVfr4vDBjI1ozvi3OBdmJ48PcBEnTV7UoAnHGckjc79/hxXLv9
         xZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gtw8U6M1YN6hJovMedXkOYQAN7cTCpNydzYPiCT5XgM=;
        b=DBbSx4sXYWYLOs81ImCmFzbP5gXwk4jp+REGjJhXegZAfSNPDqR3CsW/TW8w12fD8T
         DaDl//AuQwOFxwjme0qFiSiVEZ8J9knwvLgbGiJE11KUPOpZwGPJOqbXi/2ZQ0Zxl2Ft
         bo2a5MM9AvprH+9nKldtxP8m+XYspmvXMYPd8/vJc04rzRjlvskFeGLS1oRaKr64c0AR
         5GF7SAXV/WBR7sv1UEUNYmuAlAKFYHF+GcSej4vEFE8EKy2zBZlgNo3vtCkqNdVyxAU5
         PEXTbwE+LmbGkY0C8kxfAkU+tDr9ayH5m01CqoAEGK+6MYvL1VzzI7LD1gRdfJINL/8k
         NYlg==
X-Gm-Message-State: AOUpUlFmm7QS8q4QNSRTJdRXFqxdjnqDxC/vDGQ+c/G/YyVvx1Z5Y0sq
        Akn+U5wh46j8SXq3jidqNVH+xw/mXkG+f+yZ/JRa2JYc
X-Google-Smtp-Source: AA+uWPwXZM8b4YkNbKYhUyeyOoRSjyP0Xp2NioELprlF+5pUq0JUehgL1dLgR7kmNtc/4Qm5J/SvqCazmnl4maNegeg=
X-Received: by 2002:a37:3752:: with SMTP id e79-v6mr33571387qka.131.1534519377366;
 Fri, 17 Aug 2018 08:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:949c:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 08:22:56
 -0700 (PDT)
In-Reply-To: <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <1841468.1pWPcT6Du7@harkonnen>
 <20180816220034.GA4431@archbook> <2759044.uKe7sI2ItL@pcbe13614> <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 17 Aug 2018 08:22:56 -0700
Message-ID: <CAJYdmeNJwkr3dLpdDDL-ER=X+TJgB+7Kf2U0VVQbhUjQE8TBMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
To:     Alan Tull <atull@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Federico,

On Fri, Aug 17, 2018 at 6:19 AM, Alan Tull <atull@kernel.org> wrote:
> On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> wrote:
>>
>> Hi Mortiz,
>>
>> I'm not 100% into the problem to understand all cases. I'm putting on the
>> table the point of view, mainly, of an user. If you say there are problems
>> here or there I believe you. At the beginning, you did not say that this
>> interface may introduce problems (and I'm interested in those problems
>> since I
>> implemented one and we are using it), but that you fear that it becomes
>> the
>> default (usually, being a default is a good thing).
>>
>> Since you and Alan are working on this for a long time, you can read each
>> other mind, but I need a more verbose email to understand ^_^'
>>
>> Of course the interface must be safe, I totally agree. In order to make me
>> understand what are the issues, can you list some of them?

Say you have kernel drivers (a network driver in the FPGA, or an I2C controller)
for example bound to hardware on a MMIO bus in the the FPGA.
You reprogram the FPGA using the debugfs interface, and the drivers don't get
unloaded correctly, the driver will try to access the registers and depending
on your system / bus either give you bad values or lock up.
Now userland locked up your system. Bad.

I'm not saying it isn't possible to do this if you're careful, of
course you could
first unload the drivers using rrmod and it would work just fine.

I just feel an interface like this might make it easier to create the
wrong design.
I've seen plenty of Application notes from vendors where they literally did
"cat foo.bin > /dev/fpga" followed by mmap(/dev/mem...).

>
>
> Before we repeat what the doc l posted says, could you look at it and
> comment on what I'm not saying there?
>
> https://lkml.org/lkml/2018/8/15/525

Alan, maybe I didn't express myself well. I'm fine with the debugfs interface
as a debug interface, just not for general usage ;-) I think your document is
clear on that.

Thanks,

Moritz
