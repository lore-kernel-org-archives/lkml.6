Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A3EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EC121476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LMOWVr1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EC121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeINAVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:21:15 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46929 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbeINAVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:21:14 -0400
Received: by mail-ed1-f52.google.com with SMTP id k14-v6so5478032edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hHRQA9boOvNAjvjJozlDs1aG8YX1tcbcPlOhGMn78bY=;
        b=LMOWVr1NZOGmBof6KcewJ49cMFTA78wYI2UEoPayCU88FdS3FfYQrg/0Ggzp4kKM8d
         BzIJabY0O5BjWu2tX2C2Kybww+O1AsCPFF2f22JAP+8ByVw5beAhzADb2xvI50eHWQ2P
         ZPkRnh3/pZAzM9vJgVGaWBqkZ519xInDhkckhvODefZX990mfr+wNdkXr2UVpk30zuuK
         PmxUvXJU/gROQfSdYPwnuZ8A8oOKH8thklXnzur4fG0NmhFetA6wa5aoNtNGYzxr2ZxX
         rSrYIi0F9Wb/5GDSkkrat+n0HmOiRrnkmmRp1G36lefsPzsvFK6/uniarsDPZUOQVu+b
         W+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hHRQA9boOvNAjvjJozlDs1aG8YX1tcbcPlOhGMn78bY=;
        b=FVMKgDNQ1AWIvMuyknTPkBbGrSJVvp2BOcL6Fw/oIi2RHOLjg7pNPD1K+Zviek7Jdu
         0o128NlPlR5VpurPoybkTkTp+CCpIxloT7XoUjni3TZOSrYbcpDYGQFrRPVQzIfyXl+4
         GGeaDxBpO9kX+siVc9cUMpVAKo8aLO6ltPRwybxigRo2eptVryOGpKjcuETUJKXBWwdC
         s3PZwsz5Jjeur9VSeknVoDuPuz6bMmZZPbYPeWw/pNRbN4/Znq97/f86eh470gDQM9v4
         lq/WlbA06Upp+N5BIndXZIxH4Ns6u/JtJWwnzPNIr3RXAqAeVhGintqbOiLtwAt0RPJm
         +BBQ==
X-Gm-Message-State: APzg51AVnNQy/8jluWIP3oKaoJx0wtv5FVSvDRv1J7AhAhrtK6GtKJGe
        T4k5cip4BCCwZxT1iEJAS4tn3+bD0jb68Ng7URBKZA==
X-Google-Smtp-Source: ANB0VdbQFNhGj0aIgJpjiCHsKmBlgi4uHFnVzESHoEpz24mBqbgqVgE+eD8nskX9zrc5+3w43q6kxhcSvSP5AgvVVxw=
X-Received: by 2002:a50:94b3:: with SMTP id s48-v6mr12903479eda.125.1536865824417;
 Thu, 13 Sep 2018 12:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:955c:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 12:10:04
 -0700 (PDT)
In-Reply-To: <20180913.120241.924379440079172532.davem@davemloft.net>
References: <20180913181203.4207-1-vasilykh@arista.com> <16ad730b-ef79-62b0-4b11-9473c0b033e1@cogentembedded.com>
 <20180913.120241.924379440079172532.davem@davemloft.net>
From:   Vasiliy Khoruzhick <vasilykh@arista.com>
Date:   Thu, 13 Sep 2018 12:10:04 -0700
Message-ID: <CAL0zPMNndiwJSXEjy1v8himze06fU6_AgMAN=XRnemjjxfoRQg@mail.gmail.com>
Subject: Re: [PATCH v3] neighbour: confirm neigh entries when ARP packet is received
To:     David Miller <davem@davemloft.net>
Cc:     sergei.shtylyov@cogentembedded.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:02 PM, David Miller <davem@davemloft.net> wrote:
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Date: Thu, 13 Sep 2018 21:26:42 +0300
>
>> Hello!
>>
>> On 09/13/2018 09:12 PM, Vasily Khoruzhick wrote:
>>
>>> Update 'confirmed' timestamp when ARP packet is received. It shouldn't
>>> affect locktime logic and anyway entry can be confirmed by any higher-layer
>>> protocol. Thus it makes sense to confirm it when ARP packet is received.
>>>
>>> Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is effective")
>>
>>    Need at least 12 hex digits... Perhaps could be fixed when applying?
>
> Yeah I took care of that.
>
>>
>>> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
>> [...]
>
> Applied and queued up for -stable.

Thanks!
