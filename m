Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88446C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98A26E34
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yJmK0Rjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B98A26E34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeFZTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:19:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33354 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeFZTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:19:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so17086270oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I5cHckSC04wUivOzz5/DmQrQzhLWuyJnVhxqnKzqq1A=;
        b=yJmK0RjnV0wZcbnwEQMfuZbYlZWVRBS8qmhElDAcwvIl0xlbFrzCXlpIGhYbhiSRxP
         4mS3ZpACH/e9LOrfLQhlfOR0EmYKTWE3d25rDvey4CcIBMdqEPfWzMnPAHbPkV2T4fPN
         qNHUiK6a1XDaDLFGvIqFSwT8J69/Qt9Cxtn9vxzAsUPuayLWV7+3Iz++XEA7zYVDnvQq
         n4eV4ftUA+1Ayy9G6CDZjRk4fe0P9VIni+E30EobDI06WFN5zP2vTHheia1rj/nkUwIV
         Aa7+Xzm9fhLTTn/rtQzDOdr2vLZHqdbtQXUV4TRvWE8ApLyOmLTa7Dr3lDTE4GEIKsoT
         DNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I5cHckSC04wUivOzz5/DmQrQzhLWuyJnVhxqnKzqq1A=;
        b=VursjEGq3wtCy4cEwo1AZqEenmHljYDRJMB6cG4dVKg0eBh5G4ypnEjJAos8JaUQzd
         Sd4EeMPDGBHLhHTKQ7WbmpEXJvMoQfhnxSFDo2oFTDnE0jq5JC3HkR+yeH/vLQkiIyqd
         yB/OBapAIygJtq+dRqB8kyUYPoIm4cNL1FKtNo8atRm74/Cpjqd5xSbUkllhtu+EJPoP
         +zNRVLjuyV6rOJz0pnNF+7Gf8vfsHgQMgB49CAQHB223v+ujz1Td7nRRBt+qD/WqOcLf
         4Ba6zMAjvTZUqNkeorP7Kc9M9HZCaZiDjLUXI/EA5mB+sVFANEv0MEsdMj/q2eZTojXd
         PnqA==
X-Gm-Message-State: APt69E3OXxHcwprxG3vdlma8QLxvql06KemZBeFnfAbsZgT+ftMa8zu0
        KRNmagrZrATcMtV8W2YsL+BMSUdofx5hf7oX1E+AmA==
X-Google-Smtp-Source: AAOMgpfDcaOMacQvgrY7wYV7mdtGkxYwr7KyBz5Puq1O2FdCxXPFoxxuuUs+suXpNjK7L4i1w//gJSvn+gsbONJbszo=
X-Received: by 2002:aca:ab15:: with SMTP id u21-v6mr1659995oie.272.1530040743270;
 Tue, 26 Jun 2018 12:19:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:19:02
 -0700 (PDT)
In-Reply-To: <20180626191346.GA7233@redhat.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com> <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com> <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 12:19:02 -0700
Message-ID: <CAPcyv4iC9AvzC3z_g3DQL_2mzR5Z3C898QjPB0JZn6-HRbsuoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:13 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Tue, Jun 26 2018 at  3:07pm -0400,
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> On Tue, Jun 26, 2018 at 11:58 AM, Mike Snitzer <snitzer@redhat.com> wrote:
>> > On Tue, Jun 26 2018 at  2:52pm -0400,
>> > Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> >> On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
>> >> <ross.zwisler@linux.intel.com> wrote:
>> >> > QUEUE_FLAG_DAX is an indication that a given block device supports
>> >> > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
>> >> > or "sector" modes.  These namespaces lack struct page and are prevented
>> >> > from participating in filesystem DAX.
>> >> >
>> >> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> >> > Suggested-by: Mike Snitzer <snitzer@redhat.com>
>> >> > Cc: stable@vger.kernel.org
>> >>
>> >> Why is this cc: stable? What is the user visible impact of this change
>> >> especially given the requirement to validate QUEUE_FLAG_DAX with
>> >> bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
>> >> afaics.
>> >
>> > This isn't cosmetic when you consider that stacking up a DM device is
>> > looking at this flag to determine whether a table does or does _not_
>> > support DAX.
>> >
>> > So this patch, in conjunction with the other changes in the series, is
>> > certainly something I'd consider appropriate for stable.
>>
>> I think this classifies as something that never worked correctly and
>> is not a regression. It does not identify which commit it is repairing
>> or the user visible failure mode.
>
> So you're taking issue with making stacked dax configs work in older
> kernels?  That's fine.  We can drop the stable cc if you like.
>
> But I mean we intended for this to work.. so the Fixes commit references
> can easily be added, e.g.: 545ed20e6df68a4d2584a29a2a28ee8b2f7e9547
> ("dm: add infrastructure for DAX support")

...but to be clear stacked DAX configs are not broken, right? They
just happen not to work in this corner case of pmem devices without
pages. Given we dropped DAX support for page less devices what
configurations are repaired by this change? Am I missing something? Is
it a data corruption scenario if this DM gets the wrong idea about DAX
support. I could be convinced to recommend this for -stable, but the
changelog as written does not make a strong case.
