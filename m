Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E86C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17DA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WCONs+Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17DA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeFSXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:46:32 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45229 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFSXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:46:28 -0400
Received: by mail-ot0-f196.google.com with SMTP id a5-v6so1666158otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=guCzthlM3/wATgiTR4AuOzKn7ML7POF7PwQv3lDNXWA=;
        b=WCONs+RiVg5T276Ux5OlwC3uvkEWJcWMxKV73rE8cKVPLgmGee552kj2xy90FJlKx9
         IeKqkRyCEJmeDyrUlwwuSg0w9pvIeMxJ7uAj9qIffDF0pWwvOGDDXbvK4/O7/adKzijL
         /6V/kbNnYfb+K8Urb2APDXOoabBP/pnhu1d3EuRej2EKgnK3Fa/53sOx8FPNWRMFySbr
         VQDUU5QqPH/0j5RRK8DC8/u/OvJ+LBwjb1ZQiMjU4cclKbwYVxfa6d/UW1+c3EA6F86P
         NBYNc1GVnLT4+tMUgfmoGssbwuSZLqUj0u4kckn9ldzCJSTtw9O+19yLomUBtqYYdyqo
         giOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=guCzthlM3/wATgiTR4AuOzKn7ML7POF7PwQv3lDNXWA=;
        b=fXleNV6XVBauCU5VjswuPFatAX3IgtvreNMqNR4RJUV6DH+eHyE73eHbw9SFoO29aN
         TlQtMXYBDOyT/jKGbDyYog1vA016fcDPcZeyquLl2YxoAtiwO2YgpvQ4Tucws+lm+8ld
         adcH/GYJJHsg2ctSK8xqxCi8M8im7gkjAYiIVR/vbhIw8vxpdxDujE/iKuhfaeLEVjMA
         kY3TNKGKOV53aH+la+4tL/Ofg0QDJ4DWMJot8Ul2JkSHXuksHYnbTqOg5wu4D9XfoZKx
         b+tkss11AYw/JRlPVo5pQwVpfvS+TJXaNYAU9/tCbk5gcthcQLq6UrTOoP1zorDEo0Jo
         YBXA==
X-Gm-Message-State: APt69E0LzHflV/lreVOXfyG1cJ+oJxbtkhI/hnEWZKo1yTIqu3TQtD1T
        BCOKWtjpaqtVp50l4GrlMCqlFaKLPbCmbL/6EHnAlg==
X-Google-Smtp-Source: ADUXVKKvhpN4C1QpkQ2IvXLrS6XYxcHAHiQq/1XGAeXKmRi1yROfgrQzvMjrYUm92VkhlqgYotdCV+mtKFKznAnEvD8=
X-Received: by 2002:a9d:32ca:: with SMTP id u68-v6mr12317783otb.117.1529451987591;
 Tue, 19 Jun 2018 16:46:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 16:46:27
 -0700 (PDT)
In-Reply-To: <AT5PR8401MB1169CBD96EE6C152A24D9FD3AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com> <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com> <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
 <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4joz7OemcKvJMJVhqKEVgSMpfLbm2DRP9B=S3vRPUAGkQ@mail.gmail.com> <AT5PR8401MB1169CBD96EE6C152A24D9FD3AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jun 2018 16:46:27 -0700
Message-ID: <CAPcyv4iqb52RiCnCntaSFr1vVOa9A7PZ7=Ob2StYMq-OSmo7DQ@mail.gmail.com>
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

On Tue, Jun 19, 2018 at 12:53 PM, Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Dan Williams
>> Sent: Tuesday, June 19, 2018 10:29 AM
>> Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with
>> ACPI 6.1
> ...
>> >
>> > Here are some examples (kernel 4.17):
>
> Note that these values were as reported on a little-endian system.
>
>> Ok, so the lowest significant byte of the Micron id is supposed to be
>> 0x2c and this text representation matches that. So the bytes are being
>> endian swapped when written to the SPD?
>
> SPD byte 320 is 0x80. That's the bank number byte (with odd parity).
> SPD byte 321 is 0x2c. That's the manufacturer code byte (with odd parity).
>
> If treated as a single 2-byte value, that is:
> * 0x802c (32812 in decimal) if interpreted as big-endian
> * 0x2c80 (11392 in decimal) if interpreted as little-endian

Ok, JEDEC defines byte 320 as the LSB, so the fact that Linux is
showing 0x2c as the LSB is wrong. Linux needs to be fixed.
