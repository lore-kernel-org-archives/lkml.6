Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061E2C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0832064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="LNS9tp8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0832064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeJOSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:13:11 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:14008 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539599308;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QLgaqgPb93mB25K4JnHqT8eJZorAERpeE1vLnCBjqb8=;
        b=LNS9tp8mz7FpLIjzdLcNrlIz323lDkI+kSs/jNSP/8C9Oidyly8HE725l9kZhuS4tB
        9MopUdgw+PmkEhPArO/4m6HPUlo9KvtnHZ9OqQOPH9Qp2IYXARg+QNepBRKLc64NVNL/
        5T7BPCauW/OER/zhRlOeZ9kfIBOrc3hbzS52ETX9/kdKZxrlIbJET3bcHk/Fv5eMqAyD
        8MriEx1D97piXLN7tr6nfeZTuV6dRj1bJQEg2sfPSNwSVMX+re4zpoAkpprIjOiXy1PA
        tBAsMQ4vq1Lit3221fo6auvrAOAx/OtpQOMOhx7dtbA0gR60/LE41WwEtZukHVLixm2Y
        KMbA==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id K07bccu9FASQ0KO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 15 Oct 2018 12:28:26 +0200 (CEST)
Subject: Re: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
 <VI1PR04MB5327D0F4AA27C5AED5C535388BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <e13ac59e-6698-8ef2-685e-75cd5ed35d98@exceet.de>
 <VI1PR04MB532710F1E99B016C52FCDBAD8BE20@VI1PR04MB5327.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <bd54e348-75e0-dbee-fbdb-b040163f68db@exceet.de>
Date:   Mon, 15 Oct 2018 12:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB532710F1E99B016C52FCDBAD8BE20@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2018 03:19, Peter Chen wrote:
>   
>>> Thanks, I should do it earlier, I could not find a suitable board with HSIC support
>> at mainline kernel.
>>> It is very kind that you could help on it and test function at real
>>> board. My suggestion is follow all flows in Link [2] since we need to cover
>> suspend/resume and remote wakeup.
>>
>> It seems like power management and other things in the linux-imx kernel are not
>> fully implemented in mainline so there are quite a few differences.
>>
>> My knowledge of USB, etc. is very limited, so I guess this is currently beyond my
>> skills. Can you or someone else provide a patch to get started? I could help with
>> testing, reviewing, etc.
>>
>   
> Ok, I will supply the patch, and you could add your dts changes as well as testing.
> Thanks.

Ok, great. Just let me know when you have something that is ready for 
testing and I will give it a try on my setup.

Thanks,
Frieder
