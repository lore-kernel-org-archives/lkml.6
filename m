Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813722146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXIXqccm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813722146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeGBQOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:14:04 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45732 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbeGBQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:14:02 -0400
Received: by mail-ua0-f195.google.com with SMTP id z4-v6so9562214uao.12;
        Mon, 02 Jul 2018 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=znl0p4wiU8mYIqcHEL+H0pntEVA5MFSEniaA0RPaFWY=;
        b=TXIXqccmkYqFS/rPjT+dxlA4MVMoSQzOYCvjQLlQemVDmX6WCZUtYzIUfImqSnSgkx
         iZPB5bTbgs+03sM6qXrr5x7BNTAXFOyqV/W1ku4TMy8E4UtAM7MqURbxv+n7hX2FmAf3
         CP/Q4El76APadkS+cp+/kPHp0O8e7s7W2yuR3NsIMTpt9U5H9PzhjH6OEJyi1ZK3acJP
         pCaXmh3MJn2DxYeSNRDIVRQpCvwJFSeBY8gVxzTGhfoWUofiqZI4y2XIGbqd7rjYI4oA
         L65RQBZu8ANGLkUk6gTZWrksClaPVNJdQeurh6CMLKSK03UrT1yWG8P7+rCHGoZqj+G4
         Pv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=znl0p4wiU8mYIqcHEL+H0pntEVA5MFSEniaA0RPaFWY=;
        b=bhnNGW6iZzxT1tWD9C6jLqDYrFTz1BoUKIB2PsFLOxoSMBmr3E5agp7MPNtb+y4MRV
         DWnAS9YZSlTZG1mW7zSq98sMKuJKoMB8caNN/dpAzqLk49c+OgMEbPi9G+8zYsA4Q+yY
         SA65rvvNSJmnLSTu5C/kFEdLWQ+QV5CVbon83X9XDorAwF8s85iEiLfrPs080pULVWn6
         LC1C+VLc3CjURWEy+IuGKiLh5m8vWfRolZDWCZL4RFzxrDkg4VQ1eeHP+YpixmWEgpiD
         rp4boqeAXQDQcKCYlfN0c1WjiJ6t3i7KMprkH0l3xRxPCTfhBmdyJBk/SeCU+SDMYjgz
         AGrw==
X-Gm-Message-State: APt69E1G3z05tLIKbCpMENhxLWRSpLsFviwaZuJ3ar3lp1bWMO06tHtP
        I3UvLimsRFTCUnxM2Baw/VD5zTBrJY6hECfKPwQ=
X-Google-Smtp-Source: AAOMgpdIhS21DrojgwkGoENPXiX+UI6hAvd+zoRXuhO6tbQEXEAAiA6+fuf9BQovFPmxEPFIfixJr809LTVEsAr+08Y=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr3586816uaf.199.1530548041751;
 Mon, 02 Jul 2018 09:14:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:14:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com> <alpine.DEB.2.20.1807020810580.31530@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 19:14:01 +0300
Message-ID: <CAHp75Vdr=e-8g2bF0oF+xSY_UL8wD8k2Azkhvg2_a7-bpOFn-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:41 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Fri, 29 Jun 2018, Andy Shevchenko wrote:
>
>> I'm not sure I understand how ->probe_new() is supposed to work
>> against i2c_id_table, but I don't care for legacy platform data
>> anyway.
>>
>> What I would like to point to is device_get_match_data() API which
>> should simplify / unify the case how you get driver data.
>
>
> This driver doesn't need any driver data/ platform_data beyond the
> i2c_id_table name (which has already been matched when probe()/ probe_new()
> is called), so strictly neither of_match_table nor apci_match_table would be
> necessary, because i2c DT/ ACPI enumeration also matches against i2c_table
> names.

Looking at the code I see still calls to acpi_match_data() and of_match_data().
Instead nowadays better to use device_get_match_data().

i2c_id_table should be removed from the module device table at least
(though you may continue to use it internally in the driver).

That's my understanding how it should be done.

-- 
With Best Regards,
Andy Shevchenko
