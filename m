Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487C627C5D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofpd0OkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C627C5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeF2KnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:43:16 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39764 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeF2KnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:43:15 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so5491966uad.6;
        Fri, 29 Jun 2018 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTkaSgDMhF9IPuCRtMd36ASxsEJH2gz907BE3zyLEJs=;
        b=Ofpd0OkAALjKCHjt/jMQ4hAcXOP8kPd0N1IWBvuRSvwWvLUcdCYxc6eaimmIzrPMa3
         0Ta5eCAGmn+3mrO4tLy3PrhTP7N1YN2UsLAHqBOXOBccbLFjVNk7+M7WayhciVr3lJyK
         gRE31p4wWwFq/sLbmzpO70HEuzf625NgW0aJbdyuPyWjJXaucFwKS1Ut7xI3lfFnVNjN
         2hIes2kSMa7daQM/uQYeXkwlxYHSF3ITBaGhzMrZ4RiryVTWBa6E6E5Ja68nQYl/3TFb
         cTgF/TryR7s/xyWUtW4pqTGII9QIojMtnXhiu+nCbVyrbrb1Fia1RSLq/PW++EX1k52P
         0+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTkaSgDMhF9IPuCRtMd36ASxsEJH2gz907BE3zyLEJs=;
        b=nyVxf/Kc5rQzyfWYcvpXK+amNaPZMdA14o2jY9jhfEzW1GMAffApZy23IGPGj9xvBe
         zv2CvTqj6xOi8y1yYWdcpEaBgifglwzDC1QVtbR2OdnZT5BLrVOGNR7wnKz0GBnkK4kP
         QPURC+J+rYNkWi7ipbnHpvWKqrb5VSgrVq7Xcm/C9eqCOLtT3Ga53RDp2MVsyljB5nXY
         k2uTu/0GEtf5/eozF7vvX9jn9l7qijX+AHPK0wpFYDmxCV8Q82dEWY/e0nReqFbQtCfe
         LMWzsSS/jTg7yHJI6Oc/tQt0aZP9ZC7jmVYjqNGpoon/3iyOpsZrslpS1LZ1CyAP4JZg
         EXNg==
X-Gm-Message-State: APt69E1aKGGW5pccnkAhnKNbmzkjgPFClekF6CVwkFXdEPJoxO15Rdlc
        yU6Kq1Edzz0y30Glp/dJGze7ZtIXzihpFfDCz0Y=
X-Google-Smtp-Source: AAOMgpdHBCoYfmJ/IaIPWUkNcnQIjfhZY6IIHC0TPADhrj4aA/e1ufLZXnsmDrvyq09qSLI9/C9zQTnF97EkWxKxsO8=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr9009412uai.122.1530268994268;
 Fri, 29 Jun 2018 03:43:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 03:43:13
 -0700 (PDT)
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de> <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 13:43:13 +0300
Message-ID: <CAHp75Vcp=uNrQDxGFgPjji4HxEQDR+DGeK5UgtG46ZYiV0Ag5Q@mail.gmail.com>
Subject: Re: small dmesg regression in kernel 4.17.3
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
        "Moore, Robert" <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:13 AM, Schmauss, Erik <erik.schmauss@intel.com> w=
rote:
>> On Tue, Jun 26, 2018 at 8:57 PM, Toralf F=C3=B6rster <toralf.foerster@gm=
x.de>
>> wrote:
>> > The attached dmesg contains non printable chars 0x01 33 around "ACPI
>> > BIOS Error (bug): Could not resolve" which is a new issue compared to
>> > the dmesg of 4.17.2
>> >
>> > System is a stable hardened Gentoo Linux at a ThinkPad T440s.
>>
>> I bet the below commit makes this.
>>
>> commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
>> Author: Erik Schmauss <erik.schmauss@intel.com>
>> Date:   Fri Jun 1 12:06:43 2018 -0700
>>
>>    ACPICA: AML parser: attempt to continue loading table after error
>>
>>
> Hi Andy,
>
>> So, it does add leading '\n' which flushes buffers followed by printing =
the
>> message you see. But, I'm guessing now, kernel adds a default level sinc=
e it's
>> going to dmesg which you can see as unprintable symbols.
>
> What do you mean by a default level?

I can't find fast the better example, though if you look at  printk_get_lev=
el()
https://elixir.bootlin.com/linux/latest/source/include/linux/printk.h#L16

it will shed a light on a format. Thus, 0x01 0x33 means start of the
kernel error message (error is a level).

Kernel messaging protocol is defined in
https://elixir.bootlin.com/linux/latest/source/include/linux/kern_levels.h

This is my understanding on what's going on (I might be mistaken).

--=20
With Best Regards,
Andy Shevchenko
