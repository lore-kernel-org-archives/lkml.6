Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8896C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABC2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLDPLl4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ABC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeH2KLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:11:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37947 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2KLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:11:01 -0400
Received: by mail-io0-f194.google.com with SMTP id y3-v6so3497532ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=edTbAwATWWCxJJ2KT0WVQXxCdjC3H/pJAmDFnrdRrx0=;
        b=MLDPLl4PkfXb9Ci4PcVaYTjYbc3nk0B30f4PJ/mRK9Co9Og+U/h1cYb4lGOIDdF2C/
         E1PJafPTd0rQ2/4ZzLYaamcKXh4suKioR723Sj4SYAgH707H1QBv8xFX16XzQCk9S9YE
         s/Rt6NF1R/SPYCiHIyYPMrzmRaH9rLGnarj8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=edTbAwATWWCxJJ2KT0WVQXxCdjC3H/pJAmDFnrdRrx0=;
        b=GK57pOd4SG0q6YSQIDG0ag8DHwWH32r+D73hrhlDUdTlCQHlX8Sy6gdcAUVRnsg/K0
         u2Ppl+m8FqGQ3BHpC2hfkTD3c5ef9u64SGtyXO+7ElvQcIsBEhIv58Wp6dki32aMTUvg
         Nu8mGa3OjIH9Kceq7zwgnfGe/a548HvjsAG4jMEf4dn415eqxU7VRMDKTPG7ClfQBj9x
         YwFWJrteVg2MKoXMF5iqUj/tAsHr3hNmiCCWiWHflhVlE9eQ/AOjlKtIdZ306AE1z+lF
         CCR0dcghTKvEtpkNRK/0ZeM4x9j9H6BHW5mY5QER2GNDfYm7ocnJo0w/1eWf1T9uWJKq
         Yolw==
X-Gm-Message-State: APzg51DMjxmq+g+FqoU5+AQTDoRXuIP9sJpSuDOMmLNPkuMBDT5Vpl4C
        Y3wjJfGR1E6/UU+ODBEsE3ZJMXXubZZnlDG6Tir+lA==
X-Google-Smtp-Source: ANB0VdZXuvHuvI0LjT0O5Gv7xyXgf7H8xOXf3HuSCunyjXeFAgLl60ECtCRW1UBtZQDdIFfG8FHlCQcdkqxkP83XOys=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr4135127iof.266.1535523345260;
 Tue, 28 Aug 2018 23:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 23:15:44
 -0700 (PDT)
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk> <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk> <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
 <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk> <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 29 Aug 2018 08:15:44 +0200
Message-ID: <CAPDyKFqLdWL-VG2uZsiQNrJA=VvytGJp0xYYd52jMtmeP1nLcw@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Ian W MORRISON <ianwmorrison@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 21:11, Hunter, Adrian <adrian.hunter@intel.com> wrote:
>> -----Original Message-----
>> From: Jens Axboe [mailto:axboe@kernel.dk]
>> Sent: Tuesday, August 28, 2018 8:12 PM
>> To: Ian W MORRISON <ianwmorrison@gmail.com>
>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
>> kashyap.desai@broadcom.com; loberman@redhat.com; osandov@fb.com;
>> hch@lst.de; bart.vanassche@wdc.com; hare@suse.de;
>> ming.lei@redhat.com; Hunter, Adrian <adrian.hunter@intel.com>
>> Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
>> case of 'none'"
>>
>> On 8/28/18 11:01 AM, Ian W MORRISON wrote:
>> > On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>> >>
>> >> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
>> >>> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>> >>>>
>> >>>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>> >>>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk>
>> wrote:
>> >>>>>>
>> >>>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>> >>>>>>> Kernel oops when booting on Bay and Cherry Trail devices such as
>> >>>>>>> Intel Compute Stick. Bisected as:
>> >>>>>>>
>> >>>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't
>> >>>>>>> busy in case of 'none'")
>> >>>>>>>
>> >>>>>>> This patch reverts the above commit.
>> >>>>>>
>> >>>>>> Did I miss the posting of that oops? Just curious where this is
>> >>>>>> going wrong. Not adverse to reverting, but I'd like to try to
>> >>>>>> understand the issue first.
>> >>>>>>
>> >>>>>> --
>> >>>>>> Jens Axboe
>> >>>>>>
>> >>>>>
>> >>>>> I've not been able to capture it however manually transcribing
>> >>>>> what is on the screen:
>> >>>>>
>> >>>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>> >>>>>
>> >>>>> followed by:
>> >>>>>
>> >>>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP
>> ==============
>> >>>>>
>> >>>>> Do you want any specific register value or should I transcribe
>> >>>>> each (as I am working from an image taken at boot)?
>> >>>>
>> >>>> Just take a picture of the screen, that should be good enough.
>> >>>>
>> >>>> --
>> >>>> Jens Axboe
>> >>>>
>> >>>
>> >>> Attached as requested.
>> >>
>> >> Can you see if this patch helps?
>> >>
>> >> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>> >>
>> >> --
>> >> Jens Axboe
>> >>
>> >
>> > I confirm that the above patch works with commit 6ce3dd6eec11 and
>> > removes the need for reverting it on eMMC based devices.
>> >
>> > Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
>> > (not affected) devices.
>>
>> Great, thanks for testing. Adrian, when is this going upstream?
>
> It is in Ulf's fixes branch, so most likely v4.19-rc2 .  Then to stable in due course.
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681

Yep, correct!

As I told someone before, I am deliberately holding on to fixes a
little longer that before, to extend the test coverage a bit.

If someone wants to test the latest rc with fixes, one could instead
try the pending-fixes branch in Stephen Rothwell's linux-next tree.

Kind regards
Uffe
