Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E03C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4778F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7tSl0ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4778F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKUACQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:02:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeKUACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:02:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1981850wrs.8;
        Tue, 20 Nov 2018 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wxy2QALKIIHJvm2jVs9rjLVOtsCm581jguFnbG5s7nI=;
        b=E7tSl0ZWCAUWlDzOedFzmztw/Zbuf+eoMn/fs5ESBPMQ3UgYCq+SJUIDUBk31QEEcT
         fcmhklmc95A99TlXk9Bj4bYSBC9a0D8OacSgNOv//N2FCP8hJb4rPntfulacMFWjPO4L
         T7md5LujIRGewf6Us7ukWL6Hcuq9+KWCtwGa2OzgPwvlSDEuNySqnkGYVbvn25kJWcTU
         ftDJMzFNe6z8+hdpiYRTKIuXygxeKGDAoXpe60Ulv7l68ipWTWRffnjI3V7D3Ipc2+lh
         E2sw9Uh9ynx4sNQfl29/1JV/BB1xtFERe69vsIw2A8TdkmkY0Xl0rn1ctKyom4661J0o
         5rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wxy2QALKIIHJvm2jVs9rjLVOtsCm581jguFnbG5s7nI=;
        b=e/CuXpC53aVjvB7JqVo6wf1jmW9Io8zPQzOPHmpWoPc8QRuBI4IQzexXxKR2fRwV9e
         dRNIbTXUdlRhpw2sjYY2SZYAq8XLiViUiBaCcSAr/iM2MXBi/aUB+1GPaWpUC+qmSQ85
         2x8OvEBTb4QJf7s0SB833zhv3/HqPMKjuTkJjEPeEyMEGg+e2myZl8s08mdyomSob0x0
         gXzL1+1zE/uZ4uoH0JpfLd98bpIwcyrmi1C8so0UrlzofSqhSMJetlrOTC7jcZ86aNLD
         rlgdxVOPHBaeLJUw92wGPN51AC+NMGG6t0lPLsXmjYseAHz8c7vpk6XdEjtH70fkJ/H5
         NZEg==
X-Gm-Message-State: AA+aEWZgWfJnT+nlZ+HaSNTclJJSptuOvA83XkVtR/AUzl9Ua+vbnLn3
        m7UNXtoGiQcmgU/iS31OUXo=
X-Google-Smtp-Source: AFSGD/XRuBvdE8uoFXt4H/5FPFDBfj965Lfhdn6ioANGOaFjtLN2OwqPvSbx2lYZy+fpDBT0wy2iyA==
X-Received: by 2002:a5d:634f:: with SMTP id b15-v6mr2029943wrw.14.1542720784042;
        Tue, 20 Nov 2018 05:33:04 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id 11-v6sm28562394wms.24.2018.11.20.05.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:33:03 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <20181119152735.GB3535@sirena.org.uk>
 <cbbc3dba-7f85-c6a3-525f-01eb23e50592@gmail.com>
 <20181120132624.GD3894@sirena.org.uk>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1597e984-6b69-1d1e-f033-296d658f8011@gmail.com>
Date:   Tue, 20 Nov 2018 14:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181120132624.GD3894@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 02:26 PM, Mark Brown wrote:
> On Mon, Nov 19, 2018 at 11:10:04PM +0100, Marek Vasut wrote:
>> On 11/19/2018 04:27 PM, Mark Brown wrote:
> 
>>> The SPDX header needs to be C++ style so I push people to make the whole
>>> block C++ otherwise it looks messy.
> 
>> OK, I'm not gonna wrestle you on this, but I think it looks horrible ;-)
> 
> I don't really like the C++ comment in the first place :(

Then we are in agreement :-)

-- 
Best regards,
Marek Vasut
