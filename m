Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3ACC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834812184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1aRZWN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBAIRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:17:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41242 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfBAIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:17:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so6044053wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hMhn/HTa/qYSZQG2pgokIUdkGkKp08wdGnM7svsUcXE=;
        b=b1aRZWN16i8ymJT6jms0uhE+xBqyzSWZD37o/CnUeqlfRnPgZZ1elzHfXkwdHL6kHC
         u7VEJ+4w323rnwkUfgE4FuUQgYWAcXmEzJd6uTkan+vZo3Brr9JVIxlgRZSpapPzOUkW
         TvL0p2SaIVS8dc3EuWc97ZlfpnEMjt6NhrrUYJ196yd+3/wMSSZGENSluhKFH6Hbsa3H
         KPmGh4UJxdNpS6NJEudlkjgCXFzzZsFy6rHw8tMni8fFVHLHMC/d/d93WF7CDGOH+oYf
         qBZGG9DqTvgOO08q8YvFrhM1lJHe5DuaCpPflSOwPWrjzVLuzRcexNakQprsuMoTYXJG
         E5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hMhn/HTa/qYSZQG2pgokIUdkGkKp08wdGnM7svsUcXE=;
        b=XzPpo4UeWHSRHNu9qB+CDpRoQBXL4b+JaLMk6EdOYIMGBX6yDsLgog1isJCv9ZFqzO
         UtF7fKkwJq9ARmZXqaOvqTi82BR2AKHgpeBEmzbPFrIhzm60KOqJgfVOWDl9phmkbQez
         YXAzHSv5SwAEbe0k2+FQol8ZH1bIFcsFsQsTPbjhDEDTVrhM1yC2TBSxgT8dXm21Q6Ih
         T47TE8TtRNt/WAGNk02dTw42npZQ4oTIBVwKP6zOrxTwfPX2xJlvyBJ5gPzKHPjmKSRm
         hfxMF7gQ1kcbECJxptgFj8IE9+78nUNVvG3Oj/KmSq7BsRcePD08V8HCdVXNxgrdnecO
         tsEg==
X-Gm-Message-State: AJcUukc7Z3F1wANAymDx+08DMYiFrFxM4lzaO1P0Bi4v7QqgvG9y8E/v
        KMwpfdk1+zyeOVIlQMP6a2YUdA==
X-Google-Smtp-Source: ALg8bN5Zd5spjX/pV23rK/hUUGJ7dFezrvWFGyZNbqRuiuoalGir3/lBABKAOBYZczT5UM8Y1QPvXw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr36437112wrx.315.1549009041493;
        Fri, 01 Feb 2019 00:17:21 -0800 (PST)
Received: from localhost ([2a01:cb1d:12c:8800:1e45:34e8:9e5f:f03])
        by smtp.gmail.com with ESMTPSA id v133sm1810559wmf.19.2019.02.01.00.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 00:17:20 -0800 (PST)
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com> <1548693481-1162-2-git-send-email-lollivier@baylibre.com> <20190130154851.GA25794@bogus>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
In-reply-to: <20190130154851.GA25794@bogus>
Date:   Fri, 01 Feb 2019 09:17:18 +0100
Message-ID: <86womj3ott.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 30 Jan 2019 at 15:48, Rob Herring <robh@kernel.org> wrote:

> On Mon, 28 Jan 2019 17:37:58 +0100, Loys Ollivier wrote:
>> Add globaltop vendor definition.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> 
>> v3: No changes
>> 
>> v2: Alphabetical order
>> 
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Oops apologies. I'll remember that for future submissions.

-- 
-L
