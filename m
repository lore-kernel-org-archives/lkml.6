Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B385C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1BQssVHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B905A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964952AbeFRTqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:46:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34271 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964904AbeFRTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:46:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id i205-v6so15977776oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w7eFyN5OjYalMfVm729/qKxnewR+swQiKFOonGtqVNk=;
        b=1BQssVHVh8/NAwXZYzBqXTHy0NGa99bqL5ZJANHXTveaDCyaFMx7oCFSY2+QcYlWoF
         PDoKiDewg2e2/nI9q+QVL7Jh14MJi9D81lZMDc+Rb7aNMphMbOxf71yQNEU5FnUjqEcV
         NZl/+VFKN7yPJV3WQa7w/5kjR85yTvAZVhzIpFQOfpbF4JGbe2J3ajD+YuEYbX8fixuD
         6fo5McwDX4E8ONrhbh49IoGwVknSgGOeYgI6lcFkIhfmSjoaH+utAwABB+f3QlgsC5tK
         KUaV+MAi4UfcA8fawtq3idhOGyY0AZ1/yrlD0CGTfYvhnjW0lQav9yRgMdckNteGUrlO
         molw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w7eFyN5OjYalMfVm729/qKxnewR+swQiKFOonGtqVNk=;
        b=MSNbJ+UgzzuntO8Kphm/1txmTlbsdJyUlGOqs9avfY4BZjZi1I/XL5VM+ufgslTLz6
         tnXZ8GImL5A2jZiGetWx46hqfVgI1/sdMgwf7PV2qdwxXnG3RB7s971eoqTe1/+8DV2M
         buCWG0Ec5o4w/+RmaOpvkLJuvWTGny9zkztaSawEtaBftn0YikyTIHMj/2MjAKkMh79q
         E2OZlY5As0r/pPIjBLnJ3BpXYxeK8ADmZ2CEdfgWK1othPb9iZuI3xXD4Z+agSaECRs3
         vGFoGi6MclOTUhX4zqY5LnB4mrLHACpVruHSGlPB2G9Z0Uo2lbOxqzC5aQNpI+qqXXLc
         hRHw==
X-Gm-Message-State: APt69E3Kfyb33pZkUjAST+Joqpj7leKQOdP7hXEU0ERefLxLbziXXkPz
        IqaUss9sxsrzC36ECrOjTgii5VoZyCLyhkijmiqiGQ==
X-Google-Smtp-Source: ADUXVKKMkSYSyMFk/S1vVA6pTgxaDPFCsqmbsgi2Cp4yJRIsHgHcSlmiY4e9ogFry3r8gkJ3RiXRc2vhQk26JpVHoHI=
X-Received: by 2002:aca:3d43:: with SMTP id k64-v6mr7253613oia.166.1529351201846;
 Mon, 18 Jun 2018 12:46:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:46:41
 -0700 (PDT)
In-Reply-To: <1529350667.14039.119.camel@hpe.com>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com> <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 12:46:41 -0700
Message-ID: <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI 6.1
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Li, Juston" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:39 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Mon, 2018-06-18 at 12:01 -0700, Dan Williams wrote:
>> On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani@hpe.com> wrote:
>> >
>> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
>> > as follows.
>> >  - Valid Fields, Manufacturing Location, and Manufacturing Date
>> >    are added from reserved range.  No change in the structure size.
>> >  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
>> >    format).  The spec clarifies that they need to be represented
>> >    as arrays of bytes as well.
>> >
>>
>> Circling back on this a couple years too late... where are you reading
>> this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
>> says that vendor id is stored LSB of the id is stored at the lowest
>> byte in SPD, which is little endian. So it seems Linux has showing the
>> incorrect value for a long time now.
>
> This follows ACPI 6.2a section 5.2.25.10 NVDIMM Representation Format,
> which Robert cited in his comment below:
> https://patchwork.kernel.org/patch/10237609/

Right, the representation format has the fields big-endian for some
reason, but the individual values for sysfs should be show
little-endian as far as I can see. What am I missing?
