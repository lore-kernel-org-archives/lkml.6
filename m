Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D839AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F04C2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+jBfn/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F04C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbeGIMZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:25:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34639 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGIMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:25:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so10739051wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igUeFTOeUUbkZTHYgAmO/HkyuRPbtRI1fcvjhZ7KAgM=;
        b=G+jBfn/4QdKPiKpXqvXoX7D51QCi4unvBpveCBaKLekE4Bn+OxDyPSZJQR1h7AYx6t
         9G0OBC0jbD0R3h2hC09gLPEL//Chc0oVVlxPHWK91G6BxIEePGqlOmNKYeyrJSX4qifg
         2rNn7cLW/VlEu3de+Ceg0TwwVLGp9zlMNOvO5RTKxOqWJFnfIiouie3vSAQzlJUAij36
         h5LL4as+RSxNkHMetAGsfDNozUQRGGORJa2f8wQ0Ce29BhhRMSZvn7JV6FkLsqA+DBjG
         Fxr+kj0W9ei+mxrqtjR0znuF05anSo2gnLOSPR7c1VRnXaeRkkZTiVy5XVwKteh2RNcr
         CsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=igUeFTOeUUbkZTHYgAmO/HkyuRPbtRI1fcvjhZ7KAgM=;
        b=kVeFNe042Ndbl1mUdlE65ENGvDDYPJI3iTYbLpR7LOaJeR5eJ3kysq+TlzgoiJ7PK2
         y2RzxLm7USMmPeISul5HSBkU3VEj7GTcxhqHlgClwMqtWfqWkPLvmF2UjssLvkmd9Y+0
         Se7Yph5pOB54+yI/YpD4+FoHnB7TWEdhx/n1vV01ZZkqfwdWCqGBXjNAPBajLfsVa9Gx
         cLUB2C6dN1L0cMqCC5R56b0N5XFTEsXrD5oD0FA7F8qpZRO+iS6R2qvU+yUJuQzimi3d
         n3a4U3KhVXKUebXijS3xFNI03ABoQTjvJnDEEQhO2868t6LA7JXs5LRHSgbSQpyEDvMk
         6Kmw==
X-Gm-Message-State: APt69E10/PgLnGad4CU4IwPFBbO+lVgM0gGBYnOLd3QZCuR9TKVpd7EZ
        SuEdTzCqdpIB/BGTRtcXJ64=
X-Google-Smtp-Source: AAOMgpdCNCCetmy6xWcoldPjwrjdM7zsAWYhlKd+SG3kRMkt0M46PwtIWE2r1Or9qKTkGg4cM+pwVQ==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr15213089wrj.109.1531139105069;
        Mon, 09 Jul 2018 05:25:05 -0700 (PDT)
Received: from [10.178.4.240] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id l6-v6sm11584551wmh.41.2018.07.09.05.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 05:25:04 -0700 (PDT)
Subject: Re: [GIT PULL 2/4] bcm2835-drivers-next-2018-07-03
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20180703200511.2725-1-eric@anholt.net>
 <20180703200511.2725-2-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <02301f0e-1700-c4a7-0ce8-2f74fdf45808@gmail.com>
Date:   Mon, 9 Jul 2018 05:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703200511.2725-2-eric@anholt.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 01:05 PM, Eric Anholt wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-07-03
> 
> for you to fetch changes up to 5bfdc1097654eb31bcf2d10421ed769ef3b161c6:
> 
>   firmware: raspberrypi: Remove VLA usage (2018-07-03 12:56:12 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in the new HWMON driver for getting
> under-voltage detection from the Raspberry Pi firmware, and a change
> from Kees to remove another instance of VLA stack usage.
> 
> ----------------------------------------------------------------

Merged, thanks Eric!
-- 
Florian
