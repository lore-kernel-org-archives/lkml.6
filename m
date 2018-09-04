Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE067C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAmjP7b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeIDUCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:02:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45777 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeIDUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:02:32 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so1407802ywg.12;
        Tue, 04 Sep 2018 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WwLDEZk8TM4WkPyTuRUsjdqeI4hMDJqh4twfDCFOhS8=;
        b=ZAmjP7b4iJTI69rIehXJAQsQkyjKEjw11ZToIz0v43hzG7ljaaWlxm3tKT3WXEbomN
         5aI/fQQsMoobXzEn3ocQa1+AjfIFhYI1O/giujISXLmmbf5ZDKWim9i+URtPkX+hHbXa
         +yOmbimGuraSVp+ynbStS9Rogs0JOHs7OGfEeYj2anmN5GGXOYycrjsfE0/afiI12L66
         zosGAop5kwtKQss82JYMoIZokfeo2CZpzume5hdFY/NSbkpiZIHor7UanRpAg3Qbx8P9
         ncTcr6vRmdBSd7aVBUasFvytjLuNhVYNrOlhAS0j6+2TxzmZIFs85hNFOyXPfRKav5t3
         +4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WwLDEZk8TM4WkPyTuRUsjdqeI4hMDJqh4twfDCFOhS8=;
        b=KkQJkOouvobDy2DVYZjlTTmySIcgRD77L1WLI/JO932cR8Qm3OtfXf0Qoo/An70rm2
         ke5qTBEO/eDPM+e0JAn9E+fMF4cUPCIgFLhrf3+OlOLkb+PIhGsQsTXx32xbFOGwphXF
         GzPV3UsbQTH0mdVCdcvcNAIDCI/QvO+e5I++zpu2iG8MNol3MzLoq5QnPvtBaqcagsuf
         RUMquJJaUfyzzKzsosdX7a5/79bYjfzn99XQ2mbcLUzkkEeOx6ePzgY7SQrae0D+mtxC
         Rafw7qJ2AYYdI7c4QuH5eJaGTACFJ5sVVEcPQ3p4JvICuiqktyNe3ELBwnHKjJciJGiS
         W5tQ==
X-Gm-Message-State: APzg51D/3UnnLCgq0b6xeO53y5SViRk2ZhQZaLVL2mvESBQ0Q5CnC7W/
        NWwSmvyT6LICZbBabm6mx/+zkXcd
X-Google-Smtp-Source: ANB0VdZ+TKcROZ1CPuCyvQYkPeGTuOUU0ky2mF0pYpkwnJaQyGESyoKfMCfE9dqNzo1wX43h00J5nA==
X-Received: by 2002:a0d:e847:: with SMTP id r68-v6mr18196157ywe.17.1536075412839;
        Tue, 04 Sep 2018 08:36:52 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10fb:a464:42a6:e226:d387? ([2620:10d:c091:200::1:6a2b])
        by smtp.gmail.com with ESMTPSA id t2-v6sm26650225ywd.99.2018.09.04.08.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:36:51 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Add rtl8188ctv support
To:     Kalle Valo <kvalo@codeaurora.org>,
        Aleksei Mamlin <mamlinav@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830140541.31964-1-mamlinav@gmail.com>
 <20180904081619.7353B606AC@smtp.codeaurora.org>
Message-ID: <53022e37-e9dc-1cf8-ec3c-4df668f3c045@gmail.com>
Date:   Tue, 4 Sep 2018 11:36:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904081619.7353B606AC@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 04:16 AM, Kalle Valo wrote:
> Aleksei Mamlin <mamlinav@gmail.com> wrote:
> 
>> The Realtek rtl8188ctv (0x0bda:0x018a) is a highly integrated single-chip
>> WLAN USB2.0 network interface controller.
>>
>> Currently rtl8188ctv is supported by rtlwifi driver.
>> It is similar to the rtl8188cus(0x0bda:0x818a) and uses the same config.
>>
>> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> 
> Patch applied to wireless-drivers-next.git, thanks.
> 
> 514502c3a70b rtl8xxxu: Add rtl8188ctv support

Looks good to me too - assume it's been tested?

Thanks,
Jes
