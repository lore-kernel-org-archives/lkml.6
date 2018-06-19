Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD30C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C03205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwWGs6k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C03205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030508AbeFSThq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:37:46 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39162 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030305AbeFSTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:37:44 -0400
Received: by mail-vk0-f66.google.com with SMTP id r83-v6so533072vkf.6;
        Tue, 19 Jun 2018 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mHGe3Lxx/v8t1FFSvVu1pq8Re61n2BMj7k+bxayZ8mQ=;
        b=WwWGs6k/x/vdSexd6GuTKo/FqmPAol/t4GY76hhoxPDQrMqh9CWv+dQ5priM4uQuWI
         jBcbMSRDa5CA5EuBqUUf6zPkyf2l0PCgRfosZoy0qneBIya9AWDH00+yJnNskdbqZ0EV
         Qs95h3cNvVcreZBDFf2bultR6Xz+XIq2Pyrvi2LZ1Mudnq6tSDc1fupnv4mjTgP2quRD
         20vu9x4fii5ul+/AuZpFlAlsTZhxodHxvw4dO+PVZLpLkwNyEWf0ArcrpFNZBDzBul06
         eAasiFh3tr44HgBoXljhzoHBY7NYAMBU4czXQMMyCPY5Gc8KeBUWezUUemhgETgfucPB
         /kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mHGe3Lxx/v8t1FFSvVu1pq8Re61n2BMj7k+bxayZ8mQ=;
        b=lZGScfcMmLDSK+MZAlpiQehv39S22fGY5ig5cy71R2IoH2trwKjVaw9nCgTO4RIBjq
         /joxam/QsYHGIUsQpLCZva9WGk+UlutbseWZWbwHthyataoGlj04itBTZBQJioCgn3Sn
         PxAzlkTf2k4AM2ekCn3S2LZDlIEhEZ2l+xcvNXlyeis/riTls1PBsceBTzeNf1OM8VMr
         VBCr7FpzzHMq4xRXm8Ka5t+JxycPQvY5VXo+OPMi8iDKpJgncFAbP3MsLj9y4PgwF017
         BrQBz6DmXN1RujmIdBXlS8tJoTH/6pD6k6pNLeDpsRzAWdUWd19da1ZRYwWlMdDxXS5d
         c6gA==
X-Gm-Message-State: APt69E2nK5JGdoX8uzfGg7uJOWLIiD2axMF4omttT7O+4hLmS5iTVZPc
        PDDg+fI/yuNBvLuM7y2AMNU7VVolBnTdgEeuivI=
X-Google-Smtp-Source: ADUXVKKHcGeJbY9qp548AB/IdRcgLV2PJuG1kJalT+kLuOISqGrBoOUQMEkOQyO9MSRddxbN4b6JH9maVAQkfQjPCVU=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr10494871vkd.15.1529437063076;
 Tue, 19 Jun 2018 12:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:37:42
 -0700 (PDT)
In-Reply-To: <5B29590C.3040800@broadcom.com>
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
 <5B0D1C9E.4000800@broadcom.com> <20180530090633.GA15390@panicking>
 <5B294920.5050909@broadcom.com> <87fu1izjcs.fsf@kamboji.qca.qualcomm.com> <5B29590C.3040800@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 22:37:42 +0300
Message-ID: <CAHp75VdhkN5_9wr_3evGvi67FXhrJA+zSSLKViqr-_7_fNti=A@mail.gmail.com>
Subject: Re: [PATCH V2] brcmfmac: stop watchdog before detach and free everything
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list@cypress.com, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:27 PM, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 6/19/2018 9:06 PM, Kalle Valo wrote:
>>
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On 5/30/2018 11:06 AM, Michael Trimarchi wrote:
>>>>
>>>> Using built-in in kernel image without a firmware in filesystem
>>>> or in the kernel image can lead to a kernel NULL pointer deference.
>>>> Watchdog need to be stopped in brcmf_sdio_remove
>>>>
>>>> The system is going down NOW!
>>>> [ 1348.110759] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 000002f8
>>>> Sent SIGTERM to all processes
>>>> [ 1348.121412] Mem abort info:
>>>> [ 1348.126962]   ESR = 0x96000004
>>>> [ 1348.130023]   Exception class = DABT (current EL), IL = 32 bits
>>>> [ 1348.135948]   SET = 0, FnV = 0
>>>> [ 1348.138997]   EA = 0, S1PTW = 0
>>>> [ 1348.142154] Data abort info:
>>>> [ 1348.145045]   ISV = 0, ISS = 0x00000004
>>>> [ 1348.148884]   CM = 0, WnR = 0
>>>> [ 1348.151861] user pgtable: 4k pages, 48-bit VAs, pgdp =
>>>> (____ptrval____)
>>>> [ 1348.158475] [00000000000002f8] pgd=0000000000000000
>>>> [ 1348.163364] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>>> [ 1348.168927] Modules linked in: ipv6
>>>> [ 1348.172421] CPU: 3 PID: 1421 Comm: brcmf_wdog/mmc0 Not tainted
>>>> 4.17.0-rc5-next-20180517 #18
>>>> [ 1348.180757] Hardware name: Amarula A64-Relic (DT)
>>>> [ 1348.185455] pstate: 60000005 (nZCv daif -PAN -UAO)
>>>> [ 1348.190251] pc : brcmf_sdiod_freezer_count+0x0/0x20
>>>> [ 1348.195124] lr : brcmf_sdio_watchdog_thread+0x64/0x290
>>>> [ 1348.200253] sp : ffff00000b85be30
>>>> [ 1348.203561] x29: ffff00000b85be30 x28: 0000000000000000
>>>> [ 1348.208868] x27: ffff00000b6cb918 x26: ffff80003b990638
>>>> [ 1348.214176] x25: ffff0000087b1a20 x24: ffff80003b94f800
>>>> [ 1348.219483] x23: ffff000008e620c8 x22: ffff000008f0b660
>>>> [ 1348.224790] x21: ffff000008c6a858 x20: 00000000fffffe00
>>>> [ 1348.230097] x19: ffff80003b94f800 x18: 0000000000000001
>>>> [ 1348.235404] x17: 0000ffffab2e8a74 x16: ffff0000080d7de8
>>>> [ 1348.240711] x15: 0000000000000000 x14: 0000000000000400
>>>> [ 1348.246018] x13: 0000000000000400 x12: 0000000000000001
>>>> [ 1348.251324] x11: 00000000000002c4 x10: 0000000000000a10
>>>> [ 1348.256631] x9 : ffff00000b85bc40 x8 : ffff80003be11870
>>>> [ 1348.261937] x7 : ffff80003dfc7308 x6 : 000000078ff08b55
>>>> [ 1348.267243] x5 : 00000139e1058400 x4 : 0000000000000000
>>>> [ 1348.272550] x3 : dead000000000100 x2 : 958f2788d6618100
>>>> [ 1348.277856] x1 : 00000000fffffe00 x0 : 0000000000000000
>>>
>>>
>>> Forgot about this one.
>>>
>>> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>
>>
>> Should this go to 4.18?
>
>
> It is a bit of a corner case, but yeah let's do that.
>
> Regards,
> Arend

Guys, sorry, didn't have time to test. Do it ASAP.

-- 
With Best Regards,
Andy Shevchenko
