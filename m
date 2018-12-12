Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB48C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz49K0Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D457D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeLLMtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:49:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:49:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so8296204pga.9;
        Wed, 12 Dec 2018 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7BfJ6FgUHf7FLrNncdavRRSb/ILokS7715JdPO1ZAI4=;
        b=iz49K0IjFEAAd3wraMtuLifNJhkDg+EXrtebrHtJPRQBk0Nae9ij92iVd2DCVChkgs
         IRCQkHRP/TmlwV3aC5oHEInt/3eSw5xw5y2eV37UhjxPx9rJZHd94ALjhLpMWwW/OF1H
         XIijs6Py2btbHAgghdKRKm3Zf2JD7z0Q0sHp4KLuzvEQRklgNntH37LMtvd1rshubMmU
         tshI4Wqph8KDfB0r82NxmE62HTN4rdBM5Q4XKJETJVvUDTFy2EMxA3M12pQKUG2fzwG1
         JwQYlFMuTiUcF9NTqu0HPGyYkqTQ20OIuOv5QOLdp/cZYm3/JXQMWQZuOo+VY1G3lSaa
         trhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BfJ6FgUHf7FLrNncdavRRSb/ILokS7715JdPO1ZAI4=;
        b=B8rhtgZsLfhDznGa5U87mIlyz1EUiK+WaxcXQwdh1O+c4vhyHhxqjg/FOUAYgYTNnc
         McPKrVgYoj6qEbwnPmtccDswXk+E4Ax537HgX8xAyCW6qtBZyfoMjwQ7lbuePW8A5f89
         KmZuPmcw9lW2IrFBVmXocchJGkqZJQAlbEjhhRv05M7PchcXs0P426PxTntjzNkXEjXs
         2O4YkNvZM6MyyV4CKn39ScNkc4+rBOt0FBCeu/htigU5uzfqMNQttLuV50WoMAD35s16
         z6Q7Y36fyJ/zPjfru0Ly2TAewof9OCrnJATmSqA0YtK+pt43ltdgpQTEpOtXJ22zvjrs
         ednQ==
X-Gm-Message-State: AA+aEWaoNKStsJbmnWQhoHoYEp0MBujV0A7xTFceiLtMxgUNn3hxwTOS
        p/EzL+Vqe6VSSB2lxgYnA18Z2NvS
X-Google-Smtp-Source: AFSGD/XWcQiVZr6mNB8eO9bPawf6Wq99m70xpfrM+R3kBsZUyCHTa6dzNoTLG51w6OMVnBRMyIHkpw==
X-Received: by 2002:a63:8c0d:: with SMTP id m13mr18335815pgd.422.1544618984425;
        Wed, 12 Dec 2018 04:49:44 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id c4sm36218949pfm.151.2018.12.12.04.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 04:49:43 -0800 (PST)
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
To:     Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org> <20181212102415.GM15092@ulmo>
 <20181212104331.GW16835@8bytes.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e0eee0b5-5513-6f38-7b18-ca7a00255ff6@gmail.com>
Date:   Wed, 12 Dec 2018 15:49:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212104331.GW16835@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2018 13:43, Joerg Roedel wrote:
> Hi Thierry, Hi Dmitry,
> 
> On Wed, Dec 12, 2018 at 11:24:15AM +0100, Thierry Reding wrote:
>> So appart from the one issue in the "memory controller integration"
>> patch this looks good and I've acked the remaining patches. Once the one
>> remaining issue is fixed I think this is ready to be merged.
>>
>> Joerg, given the dependencies between the various parts of the series, I
>> think it may be better for you to merge everything through the IOMMU
>> tree if you don't mind.
> 
> Sounds good. Dmitry, can you please address Thierry's comments on patch
> 13, add his Acks on the other patches and re-send? I'll queue it in the
> iommu-tree then.

Sure, thanks to you both!
