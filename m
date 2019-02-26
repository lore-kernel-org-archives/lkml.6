Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1C62133F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OCel5rl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfBZXyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:54:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37624 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:54:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so12348300edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Xyq4+T9z6jyNkr5RCm77BuoC3UekzsHSOvOCXF8pv0=;
        b=OCel5rl/87JlE88wE9QTv/swTl8yoJFSMGKWePLOu66VtUHASZSui5W/y+r2tkIjJ/
         iwJHN9Qb6S35+u3PNrpNVS3FbzziQ4k0W3b0YzTdhLgS0YxsaDkqxDlNbleuoEfO21dw
         YLfgXpM9AwsGWW8YNRGHChTSCUzRYGiwq6wBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Xyq4+T9z6jyNkr5RCm77BuoC3UekzsHSOvOCXF8pv0=;
        b=CX8njIwcvfSEJdafiu+IEGcoApIpem7nYX008HQT11hF/yKcO3vGXuxVZzAOWTbU6c
         MorFRFDwGVPCUMp3TkguazeBUpUbMsxim06a6DmIoodakpPDeDodE8vYf+fttAfNRE4b
         kORH23SChaDQkLqPqLhWFyoyaQRQWsluu9dupGEjCGV0r1SVU7hItSnbGev1AdSsjMrh
         nFev9THDA4eBuAzdp5TmM+wUEQJgx1/25tHQF/DEjk+RuuuLf6ZORr9DVLY2YuG9aYrY
         SDh9PAuH3Kridm6R754ZrEuhPMf5EYeU9mSLC1ZU/Omj3Hioxdxa/OkDDHLCrMl9cBhq
         7vuA==
X-Gm-Message-State: AHQUAubDqvhwvWIVNf+PfAnvMoa0gIWTRi1wL+jc+IZ2ZuS3as8YhUEC
        MRxNoE6JWI2ja+r2f61CA2yBD/ZRKGE=
X-Google-Smtp-Source: AHgI3IYpEMnu69mzs7JLLE5ozPanHjq+srZsVlw3hz0iI0Wvh4V8+zE1am5W7NGJTdQZpQUqU2eanQ==
X-Received: by 2002:a50:b819:: with SMTP id j25mr20757317ede.77.1551225243828;
        Tue, 26 Feb 2019 15:54:03 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id c42sm3183843eda.63.2019.02.26.15.54.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:54:03 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id a16so12385515edn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:54:02 -0800 (PST)
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr15323812eje.247.1551225242043;
 Tue, 26 Feb 2019 15:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20190223022440.146915-1-briannorris@chromium.org> <20190226223151.GA21838@bogus>
In-Reply-To: <20190226223151.GA21838@bogus>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Feb 2019 15:53:50 -0800
X-Gmail-Original-Message-ID: <CA+ASDXP+fEM38ieCFdZjbjAAMqXw7F-K21rTcTLLhEAj7zNXjQ@mail.gmail.com>
Message-ID: <CA+ASDXP+fEM38ieCFdZjbjAAMqXw7F-K21rTcTLLhEAj7zNXjQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: handle PCI/USB VID,PID in DT compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:31 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 22, 2019 at 06:24:40PM -0800, Brian Norris wrote:
> > Documentation/devicetree/bindings/usb/usb-device.txt describes the
> > 'usbVID,...' compatible format, where VID is lower-case hexadecimal,
> > with leading zeroes suppressed. Allow it here without complaining about
> > lack of documentation (we don't need a new entry for every ID).
> >
> > PCI has a similar format
> > Documentation/devicetree/bindings/pci/pci.txt
> > http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> >
> > For both, I try to detect something that's close to a VID,PID, but I
> > intentionally don't parse beyond 4 characters of PID, since USB supports
> > extending with an interface index, and PCI supports additional subystem
> > IDs.
>
> Now that we have DT schema, that would be a better place to check the
> formatting. So I'm fine with this, but going back to the simpler version
> would be fine too.
>
> We will also be able to really check that compatibles are documented
> rather than just grepping the bindings for a compatible string.

I'm mostly interested in removing checkpatch's false warnings, however
that's best accomplished. I'll leave it up to Joe whether I should
(re)simplify the patch. I could remove the new
"WARN("UNDOCUMENTED_DT_STRING"," stuff, but once I'm doing the VID/PID
parsing, that's really trivial, so *shrug*.

Brian
