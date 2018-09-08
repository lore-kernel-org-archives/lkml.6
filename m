Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1569A20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXlZt8Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1569A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIHJQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 05:16:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 05:16:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so13544942lfb.11;
        Fri, 07 Sep 2018 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AR5RJEH7Bt8sBFBDVo82zkiSv5HmJ+WSppN3IKyPjvA=;
        b=eXlZt8WbO+zz8GEXPt11512ZDGDytVFY5mYyj3Kz1XsxAq1JMdx/KQbGG7EHWcgCUV
         h0MafAsl6yBRzt10dqkiasDYnQfXiEJLYdhuvdbxyL9iXl8QPkZWpj1MgrDn5gQUij2Q
         4fS6czSoHzW4iEU4ys1aOrjPj+xxW8Kyx5iAGtr3tckDOa+kIq1haeeJlyPzQl8QRJYl
         M/838JNINQGS6DvPa8NI9AGa605pri0nArg+a3zin3UqvXvPv0mjPoV6IP/FReLWbfVI
         MvMRp59cQ2pIAEq4cvG7bq4JSPsSxuM05AbiSJAVpsKVppKgqNGC02NLCNV+sBY14FUS
         askg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AR5RJEH7Bt8sBFBDVo82zkiSv5HmJ+WSppN3IKyPjvA=;
        b=fULYRzwPcLkxc0a+2NlazF3dYUT5dsz8J3J0qywWN+VAjRele/5ussjpMi1tb12ZIN
         yO4SbZ+WVc8weh1Xg61gkC7KMKDS6PuhzcdnOcmCDFK35xU50R/XkcSEheKlKpzVQjxF
         BnN+8gJe0ofqlJGsRYw9+ECjngds4EzrTTe/eYTQhLO/Uu+/bnvXD3WMJfVCA+EUFQgJ
         f7UtX8KTeBYKkUIKCeXpSTQmqJ0nyw5hVHCL/u6freZxdR911fcn8pm6AAY8iYBdgE+I
         7WuUl2ERFoj6b7fEIhOOmOnX2rjj27dH1ie5Sj7awQCUYarhgUxEA2+6q/I2Xemn+VSB
         bRwg==
X-Gm-Message-State: APzg51D4JdZiQphN3iFq7KpoPTAWlEToj93sfxp06XbrmChN7vZmskXo
        wRZGqqgigZJqSeOJXdya79WkIJaRc9s=
X-Google-Smtp-Source: ANB0VdYRuS4zcBJKATFTFNTF4MEkGOisyyaA6lyhXisP+7gJDpgM3LC1Kf0OZrYFxLQOjzPtX8RawA==
X-Received: by 2002:a19:500f:: with SMTP id e15-v6mr6583863lfb.71.1536381137300;
        Fri, 07 Sep 2018 21:32:17 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id s193-v6sm1589769lfe.50.2018.09.07.21.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 21:32:16 -0700 (PDT)
Subject: Re: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180907192119.4931-1-igor.stoppa@huawei.com>
 <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <f59169de-fe5b-61b9-df36-321741682da9@gmail.com>
Date:   Sat, 8 Sep 2018 07:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/18 23:41, Arnd Bergmann wrote:

> Could you add a comment about -Wmaybe-uninitialized next to the definition?
> Otherwise that is easily lost.
> 
> Also, I see that the file has two separate definitions of BUG_ON(), and the
> other one does have an unlikely() in it already. Can you change both
> to do the same thing with unlikely() or not unlikely()?

ack

--
igor
