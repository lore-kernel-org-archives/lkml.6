Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55997C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBFE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fsvLlxUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBFE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966603AbeFSP2o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:28:44 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37261 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966208AbeFSP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:28:40 -0400
Received: by mail-ot0-f193.google.com with SMTP id 101-v6so114657oth.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9QAS1Pneyq//YppdOPuvDHRb2eEE9apSIF+nUedfPjU=;
        b=fsvLlxUS+16Ef3qe0u5Bx6I4XNLBM7S1u85N/61itWpsoZw1f9nwnD8dCck3ULORpt
         nrHNdHjTbGcl2MpY5w9yFhTSzAyltJ3mxiwca8j5Z/0St8Ha+4Z89X20nOhTBJxaSHr3
         JRX/xh3QR9wWHVcBHKDg5hJoxEBBuPCoD5YiOnIDn/z934IkxSYC4it2UgNLh745L7KG
         HF2hnXxTASUe+vAE0LO0qaNBpLbKFEMmCS1O4wt7feQ2Zvs3fGfnEr36Cu8pLNj3a3Ez
         i/bg0T/DrrMd1vmz7ca0OQ3yByx64/K5QnV4+xsJJIy8d4KMziem5QEOzjwvqZek20sO
         lb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9QAS1Pneyq//YppdOPuvDHRb2eEE9apSIF+nUedfPjU=;
        b=oYi1Uku66rkpA9uZO11uk+vxnm0gisnSl9aosRXYNgdsZHGDcY5vABnWRC9XtVF1RE
         DIx3PLIEidNex9ss2BoywcvYNtO4nLVm13g25uWXRJx2Vq6R6wJsGGt7Ilu2Nphkhc/q
         HFjQoG4kb72vtlF2z3yREoFaz3IQlnZkM+eh/vAfdaiUSA5CJofKdcM1JtXrHcPYIp62
         DhI7XFFxLLemxdGiktLP2a8TGT+rhhHSAUn2HzwxK0+wE5i7b3S7sW3eIEwN67jRjaKC
         2Bo1QsIJ2Z5hsQ/qYCM9KZQzGpQmBgc6e9XCkBU2S1euqKYn05lOOXsTbGlbhpaXA0Xd
         1NRg==
X-Gm-Message-State: APt69E0ZtLwxeRSxhsTd1iHNwF5bxg1lm7jI+z5KaxZ2vGRWZzPtnNRE
        DMm7QOINaJPTlyefUTxZaaGh5+n6ySZxVmOq44jGpQ==
X-Google-Smtp-Source: ADUXVKKOnR0Q1aYynQGL5s/P1SZHrLkXoRzzpUA0Hf9kQTLxS6YNJ5qm6uYpoTN250YUDoAzosk6b40w4Qjzu+CnlgQ=
X-Received: by 2002:a9d:2371:: with SMTP id k46-v6mr11386084otd.210.1529422119634;
 Tue, 19 Jun 2018 08:28:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 08:28:39
 -0700 (PDT)
In-Reply-To: <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com> <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com> <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com> <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jun 2018 08:28:39 -0700
Message-ID: <CAPcyv4joz7OemcKvJMJVhqKEVgSMpfLbm2DRP9B=S3vRPUAGkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI 6.1
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Li, Juston" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:31 AM, Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>
>> -----Original Message-----
>> From: Dan Williams [mailto:dan.j.williams@intel.com]
>> Sent: Monday, June 18, 2018 4:47 PM
>> To: Elliott, Robert (Persistent Memory) <elliott@hpe.com>
>> Cc: Kani, Toshi <toshi.kani@hpe.com>; linux-kernel@vger.kernel.org; linux-
>> nvdimm@lists.01.org; Moore, Robert <robert.moore@intel.com>; Li, Juston
>> <juston.li@intel.com>; rjw@rjwysocki.net; linux-acpi@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with
>> ACPI 6.1
>
>
>> Let's take something simple like Vendor ID. What is the Vendor ID for
>> these DIMMs and what does Linux print in sysfs?
>
> Here are some examples (kernel 4.17):
>
> $ cd /sys/bus/nd/devices/nmem0/nfit
> $ grep -s . *
> device:0x314e
> dsm_mask:0x3c76
> family:1
> flags:smart_notify
> format:0x0101
> formats:1
> handle:0x1
> id:802c-0f-1612-122f8255[SPD bytes 320-328, in that order left-to-right]
> phys_id:0x16
> rev_id:0x3100
> serial:0x122f8255
> subsystem_device:0x3141
> subsystem_rev_id:0x0100
> subsystem_vendor:0x8034[Cypress Semiconductor]
> vendor:0x802c[Micron]

Ok, so the lowest significant byte of the Micron id is supposed to be
0x2c and this text representation matches that. So the bytes are being
endian swapped when written to the SPD?
