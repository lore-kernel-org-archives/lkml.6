Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B472C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4160D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLkkBYiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4160D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLKJLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:11:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45386 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLKJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:11:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so11842846edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7onlj4xwr4CnEsWIxH12oN83HoaCOj6sqV711Y5tgQ=;
        b=cLkkBYiTbvb3ytQJRAXAx8f/WcIia8wW+HVYJqSF4uyEQLKDB17yDjlWt3c4E9j/OC
         I1xoDKutkfkgfK39K1YJbJDNBu8hV5HTvgsxNZaEI3JqHXvOUXcN0K0l8pWQQgZhVD8k
         t1TudpVCdWjeH3mI20gY2h+W1de3hl8b3nZLs7CL/ItllUhmGBwHnhDY0vbPQlVHGFDT
         liW+U4SLb/hW8e+LOMlOFJFBQuWFCr/cbyS8cQx2Nl0OcUWWDWdLOgbqBVNsdB4jK/mw
         +WZb2CbRUcvv3UmQBjlPWRcXSWgWERx3F77IDc/VUs5jWOsGHOvAugaTUdFHO2iUO1JC
         D6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7onlj4xwr4CnEsWIxH12oN83HoaCOj6sqV711Y5tgQ=;
        b=QjopX8SFduAfOANwuUWrowZfsfBU7lSqNhSEnLGeuIwaOmxgpROhNAFqm50dDLEenY
         x9vs6IoDg0vPt567YAA3irxVjyvx4JJ/Zt5LcHidJAvjZi4zi6lwD3DFGONRtQ9xECrJ
         686FBk1CABoMf1qJVemTXiapGZJVq5HzZRqGSeZiVPsdPmdJlb2w0US6M2ILspfGkZj3
         1dQyUNvADIhx6xyBiraWGyx9B+71uuuSOgyyd1c1hq/7aiFqTE1Rk7vtzmXyF43rUjDy
         Sf/zt2QHw4JDZ9YpsHecJZr9N9PKB/LX+ZCvY2qFbcGLWRwShaXVs5EBH+elP9ntCvCe
         ThWg==
X-Gm-Message-State: AA+aEWbMFEQR/kDrCOtfHhwshsMSrPYAHGYEWfgzPypoKjl8TqDTNHMt
        CE5CgI9z3COwiUhf/6g3CdTkxsr9/bGEBzoTl7A=
X-Google-Smtp-Source: AFSGD/X/qCWYrcZlH8HWh61yRdIibZYW9oLlXA7A835s/BO9O9KtCD2u2UF2hYTsdgMw9axfDVfb2VTkjQBcZ3Z//uo=
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr11851731ejm.91.1544519473798;
 Tue, 11 Dec 2018 01:11:13 -0800 (PST)
MIME-Version: 1.0
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
 <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
In-Reply-To: <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
From:   Lei Wen <adrian.wenl@gmail.com>
Date:   Tue, 11 Dec 2018 17:11:02 +0800
Message-ID: <CALZhoSR6QXSUzEY5SuiC96jDAARE-+9=LxNXo4WoZkVcL8gM6Q@mail.gmail.com>
Subject: Re: Coresight etmv4 enable over 32bit kernel
To:     mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        leiwen@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:02 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good day Adrian,
>
> On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
> >
> > Hi Mathieu,
> >
> > I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> > And I am following [1] to do experiment regarding the addr_range feature.
>
> That wiki is very old and after reading it again I seriously consider
> removing it.  It is still accurate but there are better ways to do
> things now, i.e perf.  The main openCSD documentation page [2]
> contains everything you need to know about the integration with perf.
>
> [2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
>
> > The default addr_range is set as _stext~_etext, and it works fine with
> > etb as sink,
> > and etm as source. I could see there are valid kernel addresses using OpenCSD.
>
> I'm really curious about how you use openCSD to validate your traces -
> can you  expand more on that?


I just manually replace the cstrace.bin in the
decoder/tests/snapshots/juno-ret-stck/.
And modify the register data according to my platform.
Then produce the decode result by below command:
./decoder/tests/bin/builddir/trc_pkt_lister -ss_dir
decoder/tests/snapshots/test -decode -logfilename 2.ppl

>
> I think the results are misleading you since the openCSD library can't
> readily be used to decode sysfs trace sessions.  The wiki doesn't
> mention using openCSD to decode traces either.  The only integrated
> way to use openCSD to decode CoreSight traces is via perf.  Again, the
> link above will give you all the information you need to do that.

>
> >
> > But while I try to store one small range of address pair, which contain only one
> > kernel function. It doesn't behavior like what said in [1], the write
> > pointer would
> > grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> > openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> > I_NOT_SYNC.
> >
> > So my question is why ETB continue to grow when there is no trigger at all?
> > Is it normal? I could provide more info if you need it.
>
> I am dubious about the validation process and as such can't comment on
> this.  Please share your results using the perf integration and then
> I'll be able to have a better idea of what is going on.

I see... I would try use perf to get more result and get back here.

>
> Taking a step back I am curious about the ETMv4/ETB combination...  Is
> the ETB the only sink you have to work with?  Moreover, are you sure
> it is not a TMC-ETF?  The ETMv4/ETB match seems a little odd to me
> since they belong to two different era of the CoreSight architecture.
> Usually with an ETMv4 we will see a TMC-ETR, which as a lot more
> capabilities.

ETR is supported. I use ETB as it is mentioned in that old wiki page.

Thanks,
Lei
