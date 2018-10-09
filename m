Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F218BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07752085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlBcRC6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07752085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJJE6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:58:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:58:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so3420226wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M95LgpS2PsDkEe+YoErJnEBvU3qWCAOqD68FM3ytc0M=;
        b=YlBcRC6GAtH1+AHl2uRy2fbvmlaD4RRn9o2GE482YtH08nQIAqNB9FaQE7FWMWAYWl
         XCT+wry38p5DI8c3O8V0qpNy2sqUzmDi3w30e0Mtw6Ac0C7AILDMpkh3dH3Gb/pyVa1F
         iyYJYckeWC1HDU2soJaR458sFCvJVze/wou7LTW9tNnBCg9Rvbv8toN4o/Pok8aTEepi
         TMZt57zoLZSkJrtmyfuy0+KCFNTRCO/us6DgnXDTwi7UIiGD6RlWdXNq68SdT49jPy/J
         PKIbvoxApLvomeA3ULo7hWJXtC8v6dfBtuzyotfzZ2cW11lO8SJ8s/n9wBxZ0rkfg7ZP
         po1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M95LgpS2PsDkEe+YoErJnEBvU3qWCAOqD68FM3ytc0M=;
        b=GIwpKSp8xBjTG/os8+VMBAFyiZTJntwfyEMHbmaLE3WQ41PQixypGWRUj4qNiWQJnz
         sp0J5Egxn6IJqUDllYVzYZqN6u52WbYVQSi2UnL5VszxhBcXt2peQufJtvKSblg5AWDP
         y/oy/+ey0E/bqOZa2pX5WtTJsZ/uv8yMhqmSe0c2LSmEe/7+9kWmkR5oLzGMDIC1un9I
         8iVV59r3+hmpPP2xypu/meqF5JJvpjg8ZTy2HoHZF9EHxC4HwLIywb6q6eTJGNU2VK9D
         xBUzGYTLjdyjQFLtVZCO7eI/Ne+KxuZrCCjVgm9ONlU9xCzbQ/Oc1QsHQWjzK8Grp54N
         y4sA==
X-Gm-Message-State: ABuFfogeUJWeLqFdaBdDC3Gl+MI+HFAsm2L9vHHOGVwow62dxhpUtCUx
        EkswDd1qlLkFYPcvPvKQ3yd7C8qSPJA=
X-Google-Smtp-Source: ACcGV60eIyRW/Q+IB5fMgNeqdbDxKNAsZ9IIVdzZR5mBI7x4vQ8pZP+Rjn7Y9gGSXVFFaJSg3Jy2MQ==
X-Received: by 2002:adf:9102:: with SMTP id j2-v6mr21924493wrj.3.1539121164736;
        Tue, 09 Oct 2018 14:39:24 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:fd29:c80b:4f28:4b3d? (p200300EA8BD43F00FD29C80B4F284B3D.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:fd29:c80b:4f28:4b3d])
        by smtp.googlemail.com with ESMTPSA id b8-v6sm12542384wme.1.2018.10.09.14.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:39:24 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     Chris Clayton <chris2553@googlemail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Azat Khuzhin <a3at.mail@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
 <98680351-5123-761f-982a-726098da9716@gmail.com>
 <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
 <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
 <bed5c327-6a2a-99da-8b86-16f897b32548@maciej.szmigiero.name>
 <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e11f8eae-2bca-037b-9a7e-43c4276a2be6@gmail.com>
Date:   Tue, 9 Oct 2018 23:39:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.2018 16:40, Chris Clayton wrote:
> Thanks to Maciej and Heiner for their replies.
> 
> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>> On 07.10.2018 21:36, Chris Clayton wrote:
>>> Hi again,
>>>
>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>> 14-15ms to more than 1000ms.
>>
>> You can try comparing chip registers (ethtool -d eth0) in the working
>> state (before a suspend) and in the broken state (after a resume).
>> Maybe there will be some obvious in the difference.
>>
>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>
> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
> 
> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
> 
> I've attached files I redirected the outputs to.
> 
> Please don't hesitate to ask for any other information needed to solve this problem. In the meantime, I've now got
> scripts that stop the network during suspend and restart it during resume. (Those scripts were removed whilst I gathered
> the diagnostics shown in the attachments.)
> 
I'd like to check whether it may be a timing issue. The following experimental patch
adds a PCI commit after writing register ChipCmd. Could you please check whether
it changes anything?

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 7d3f671e1..f3c359492 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4641,6 +4641,7 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
 	RTL_R8(tp, IntrMask);
 	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
+	RTL_R8(tp, ChipCmd);
 	rtl_init_rxcfg(tp);
 	rtl_set_tx_config_registers(tp);
 
-- 
2.19.1

