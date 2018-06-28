Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76A8242C8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6IVVi5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76A8242C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeF1AeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:34:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43081 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeF1AeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:34:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so1644203pgw.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TyzSTLgrnZp6wgXwgOCEDTdxpDrV6BvDlIvu4YqlsLw=;
        b=e6IVVi5oxcKKPIO/tqTDvVvCT5fAjX1AF2s+KC2FGaamRFENOUdJLBi6P8l5/sUmv5
         tcXnBX1eA3SqUjOgdArccmg0d1SASfORm65t5WWOY6GhtJuYHs+CLJSz8UTBzLVhDc1M
         cErVk/K/hF+Q67fI795YXPByqXU7x76Nu5NfBiwlGLNjvPZJyy5ZEvjf74ZDfqk3dvqH
         /OPyAaLCeUNTAXQBvoQJSJ0CEqzMPSxbfsADNU/yXW5zF9Ku5IK6HXdl/BXvofN+k+Os
         gXsOdDrTSXxJ4e94piZo8GoU9tq8RsGhS+spbxvarTyGrD902B7ObDYhyUsoEM/Ym1ih
         A/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TyzSTLgrnZp6wgXwgOCEDTdxpDrV6BvDlIvu4YqlsLw=;
        b=RiUKDzAGbEB4a3Xh5prjIp09VrAHrMENA8m2coao32u8JscYHkcYTWsWGfghh1YP0p
         pNZAXyWb6Cno1C94fO8i+fkAY5aogMoNPNZhY9zetLO4bX6IIAH0hna2JnlGb/Spm3Jo
         grU/czlvTPlf8FavGwrIoaIXYa8JRd0+fOA3Qtc2CM1836EBKd1s4tCdcIFpXq899nea
         qsCy2Gt6r5Ap6KWSRRCPDvXkUUb0S4wUX6LdIs9sKguedAYItskiUSIe3rkou/VDEuc7
         2fGpA1YMR/RcVrIDaMd962J7Xld8BT9DG/s9tpckMu8S0yedaKRvGUwuWHf/VtLm2VyV
         haZQ==
X-Gm-Message-State: APt69E1CPlGWZfHJOfKFN+CDVE6yIpyQvYJteRn08kP/BVVUoewNvyAC
        /Z+0DtklsWeexLqAtHXymTg=
X-Google-Smtp-Source: ADUXVKIuRlo3WQwosTw2eih0fSVhDgwpGm4rG2hBvaaUrsY2Q6xmbGPn+P5x6bVugHmhhr+VFbp6zQ==
X-Received: by 2002:a65:64d3:: with SMTP id t19-v6mr6957588pgv.148.1530146059203;
        Wed, 27 Jun 2018 17:34:19 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v15-v6sm7750652pff.120.2018.06.27.17.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 17:34:18 -0700 (PDT)
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
To:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
        KONRAD Frederic <frederic.konrad@adacore.com>
References: <20180627185248.GA19743@roeck-us.net>
 <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
 <20180627205915.GA22693@roeck-us.net> <20180627224718.ewamlt42kvyirhjw@toto>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
Date:   Wed, 27 Jun 2018 17:34:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627224718.ewamlt42kvyirhjw@toto>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edgar,

On 06/27/2018 03:47 PM, Edgar E. Iglesias wrote:

> 
> Hi Guenter,
> 
> Re: ml605
> The thing to watch out for with kernel configs for microblaze systems is the
> physmem address setting. Unfortunately the kernel does not auto-detect this.
> 
> I'm attaching a kernelconfig for the ml605 that works for me and a qemu commandline.
> 
> qemu-system-microblazeel -M petalogix-ml605 -m 256 -serial mon:stdio -dtb petalogix-ml605.dtb -kernel arch/microblaze/boot/linux.bin -append rdinit=/bin/sh
> 

Can you also send me the dtb file or even better its source ? I don't think
the one in qemu is correct. It lists the serial port at 0x83e00000, but qemu
instantiates it at 0x83e01000.

> Re: pmu
> The PMU board does not run Linux, it runs baremetal power-management related firmware.
> 

Ah, good to know.

Thanks!
Guenter

