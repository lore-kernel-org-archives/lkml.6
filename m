Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BDEECDFB4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BB12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJUGmJ15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BB12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeGSEeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:34:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38512 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSEeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:34:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so3197619pff.5;
        Wed, 18 Jul 2018 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5wkn7KzIHXcu8iYSx3rRYrbRkzTH++HYBe2a53i2gc=;
        b=uJUGmJ15IErQB6xveEi6CnutWG7UWhwO7Rtj/wsZYfxEA17+utYHA7uNxzSUWm7fBF
         pPjhIei4Y08SXj31XAgr3CHwxyjtYw0/QVn5jySjuIrMXoyjERdAlTZ0iZ7yxO/BUpth
         lmIy/7MqpFEMldV/aM/TjRsQsv17pRQCuFVFaDEuxVRZK4h88Se0A6Q9Ix1X1hJOx+n2
         7IU3elkQOoN0r4S3k62Mg5UZN6KnlQLRxj6BCPGnmh8xs+3TqXUwUi6JD2+i/V7VYTuM
         hboBdrgCETnSKNBVej62zW79OGxAfGMyaaHNGAC0n0Hq9AqfmTL9j/3OBCeRQAR4iaQk
         AWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5wkn7KzIHXcu8iYSx3rRYrbRkzTH++HYBe2a53i2gc=;
        b=Doa2+3DO11Ww846GXwyk2iITnNuZ2e6Rok4Zadw4lp1YgbhBip4Rq+D4hOoDgI5xIY
         iu8/yHQzh4MHrsZA+1zP3OYY9jdkWWj0bhHDKfj0JHRHjxoamnXm+03nbHaZy9QtYXpw
         fBp2OhZlQpixckew8haCT3Fdk7CkRe723fOcVGMi5L+Flz/y6wKLmbZKSYnlrNEEK6lA
         Mn43MVi4ExSMhN7HfrN4VDzp/EkSaZAvT9+VkYq36WuFDdqgJwPeIhao/7H/tWsW1wuO
         nuud1xz2462MXSBWPW2og6mjjjk6jyjjomLHL6pDHqddhmCdN4XWiiz7DHu3ja1vLSff
         IUbQ==
X-Gm-Message-State: AOUpUlEfCgxbRLjFPgg1LxQLvGPPTfHc3Qx4ktSpZvQNP0+59paoKSMv
        R8L1BnTpqDKBYsyLikkpuOI=
X-Google-Smtp-Source: AAOMgpf7TS2IIRlS8xCXYBSAsgkJq2ytmH+q0kPovG5TNOkevyfWw5MKkNEmS4XGApNg4ahsa9/Lvg==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr8349272pga.124.1531972379377;
        Wed, 18 Jul 2018 20:52:59 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o27-v6sm15324568pfj.35.2018.07.18.20.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 20:52:58 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
Date:   Wed, 18 Jul 2018 20:52:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719120447.6e7ba23d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> *
> * Restart config...
> *
> ....
> 
> This is output by my "make allmodconfig" and only started after merging
> the net-next tree today.  It has continued for further merges/builds.
> 
> I suspect commit
> 
>    1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> 
> which added an "imply" clause.
> 
I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
not. Is that a caveat when using "imply", and does it mean that "imply"
should better not be used ?

Guenter
