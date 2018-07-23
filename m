Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F270ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B413420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyfuUUKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B413420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeGWTkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:40:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38070 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWTkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:40:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id y19-v6so1652729qto.5;
        Mon, 23 Jul 2018 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MbfWKhbX3O44X9s3sfMfPY0/G8ANIrSbpr/SpFtq2ps=;
        b=NyfuUUKE54BY4KpuXncAnrh/0M/RRGdqvJKIvNWWvpsyIRb6TCpagMDoDQnh6wH4tZ
         d+avkBzyPVkkCIF8v1jDv6MellJ/bRsoKeOsbl/6syJSqusmHOeMmZoJ2hPnhWPrvRZE
         3KHQC+bHbInAKMTRBAo+qEzkkhz5W1WaA7Y2hfJHAbOYN3mq8rYjMQxyhFCim32oWbsy
         FGY0FaaMHtjbkPs9tO5vj691fHYGm4rCzHpo8JY5F2OY+41DlRxcUTHr5pnLhQPIAxQy
         CKBGzZKW7UrZYyg8VbEiWnvI2vNBPQYzfFfFdkNDSzYwi2Mqra84gl68kRzNXVz7ztn5
         18EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MbfWKhbX3O44X9s3sfMfPY0/G8ANIrSbpr/SpFtq2ps=;
        b=SoJb90jGiYv4jxjw0H6kgfwSnJa3pV3HYfRBAwHDAeViQOvKLpkcM5yUfXDlID74dw
         gT/CdRKeAJIbHu+kf/3M5XzcXrZbQgV9lmZ+zID+MSiRveNyKieVicC2IIwF5BZMh+F4
         7OZ6omZIl+uYLuR6YVKqRtiioTGCKHkCk5lfq2qKpv4+VSyUqWJ6BPLn5pDCnemErMOL
         wrIGDia3rBNt7cvpFRYqpf0ugcBmDmSj8x92ujONUGhQ1bm9SRcmOP3QlF4To53ePQMy
         MaOkXTNDWH6Kky3O67bvXN0c0jBP85KNFJrPZZP9dWT9Tg9upuI6ZvHFMhHEqce/lgQ8
         HAyg==
X-Gm-Message-State: AOUpUlF54q/VjSmKYuA/FeixseRYG8QhhGgMUIO2FlexAcq8SCry6TbL
        iz+pmSE2Y0GSdqcWCkJ6cMwFi3sF4KI=
X-Google-Smtp-Source: AAOMgpfLscwm6oJiPBTjIM4u70qxbee/MNrMJHHBgGsgRKzapla75QTlZhfUfwftBk6nfxRYyeN7Sg==
X-Received: by 2002:ac8:1a90:: with SMTP id x16-v6mr12542064qtj.160.1532371073101;
        Mon, 23 Jul 2018 11:37:53 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id z23-v6sm6570410qka.25.2018.07.23.11.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:37:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com>
 <20180723181318.GG13981@sirena.org.uk>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <95929e34-eeb4-f3a4-daa1-0b89dd60f570@gmail.com>
Date:   Mon, 23 Jul 2018 14:37:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723181318.GG13981@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:13 PM, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 01:58:26PM -0400, Peter Geis wrote:
>> SW2 and SW4 use a shared table to provide voltage to the cpu core and
>> devices on Tegra hardware.
>> Added this table to the cpcap regulator driver as the first step to
>> supporting this device on Tegra.
> 
> This also doesn't apply against current code (though it does now parse
> OK), please check and resend - make sure you don't have other out of
> tree changes and are using an up to date kernel (ideally my regulator
> for-next branch) as a base.
> 
Good Afternoon,

I thought it was my error in the patches being stripped, unfortunately 
it seems to be a known Gmail behavior.
Any ideas on how to get around it?

Thanks,
Peter
