Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABDBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BF2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kXVjOgQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327BF2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJFFc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:32:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35439 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:32:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id r191-v6so10406720lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C0Jby9YbZbnuj7BQRoCEdaTdqPoB5cU6OZNrEGdr68Q=;
        b=kXVjOgQnWoIoY8CEdsx4T2uBsMAnCoZgfSQEJhFReNaPNjy86wNrJJ/BRZNKYW/dcE
         WtRvIWffejxAPb/GNz2BbvO2CIexukvOMKB53Yc1Dkqwtyypi3A94rsuI0WGaBLsyt1p
         95mSVYPp1a/Ytv8eBVWhB2C6+oAIO5QTKwiQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C0Jby9YbZbnuj7BQRoCEdaTdqPoB5cU6OZNrEGdr68Q=;
        b=RfL7vBi02t5nDTWmIpmZ/t9vt1XmlP6VmMsysmwO9zrGMt8fh9wzzVVs8+DMugMhlq
         zGNF50kDnoYODYdlAawYUoP9dcmQnVx8ZbOIQ4D1RDTW8Yr8xAzIeRVJA6jt0psUySLo
         9eH1SBuAFvb1j2ZLOlg3YFCo5Q+WfieOh1j5CrsiqHwS9us5FB3j9PipDMZbXmINsqRV
         M9HWaeHgBcW0TS2snnSWFfxoCl6UI0ezlbHB4AaUIAXsRSygue6oe7TWTrenHyrZh4IV
         XKIb4qO+x2ahp/j7KlnCKhbUABiT9nfGB2rGNeewZOhnP76H3Fx1/Fy0/XuW74CEdZpM
         +yXg==
X-Gm-Message-State: ABuFfojnJcur63fVxW1cORJnuuVb/MyoESWfAsVonWrz1iLgM+lMklOe
        MUApNtJMybDtd5z38dd7f2TCKhyuCB6IJ1YZVyDdDQ==
X-Google-Smtp-Source: ACcGV61UhQSaNZS6l4Bxi7KlfYewts0QhKtF9E3h05DH6306l0g20ycGXfCFlVkfrOicEfMuKE+oPgiXXHNtWj5DRTw=
X-Received: by 2002:a19:735d:: with SMTP id o90-v6mr8007351lfc.45.1538778698436;
 Fri, 05 Oct 2018 15:31:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:80d6:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 15:31:37 -0700 (PDT)
In-Reply-To: <20181005222820.GB13613@kroah.com>
References: <20181005192727.167933-1-joel@joelfernandes.org>
 <20181005125339.f6febfd3fcfdc69c6f408c50@linux-foundation.org>
 <20181005211058.GA193964@joelaf.mtv.corp.google.com> <20181005222820.GB13613@kroah.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 5 Oct 2018 15:31:37 -0700
Message-ID: <CAEXW_YSZOCsmtyJnfbvG-P+cQLM8WyohyDGe_FRxi_Xea2aw6Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Add an fs-write seal to memfd
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:28 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Oct 05, 2018 at 02:10:58PM -0700, Joel Fernandes wrote:
>> On Fri, Oct 05, 2018 at 12:53:39PM -0700, Andrew Morton wrote:
>> > On Fri,  5 Oct 2018 12:27:27 -0700 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>> >
>> > > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
>> > > prevents any future mmap and write syscalls from succeeding while
>> > > keeping the existing mmap active. The following program shows the seal
>> > > working in action:
>> >
>> > Please be prepared to create a manpage patch for this one.
>>
>> Sure, I will do that. thanks,
>
> And a test case to the in-kernel memfd tests would be appreciated.


Sure, I will do add to those self-tests.

thanks,

 - Joel
