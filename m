Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26617C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DCA2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikn4k5HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DCA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIEDUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:20:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32853 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:20:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id b30-v6so23039pla.0;
        Tue, 04 Sep 2018 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPO5pqLl0KZa7SMv0SVLsxPcLafuvW8mEsW4LkkQbvc=;
        b=Ikn4k5HWDGmOFtQwFFR324tiYihm/2wRpfzry9U/gLwqDwU/OuVz5gHNrcYr9imBP+
         SeqyoJ8NzT0AtUWqsxUZKh2354UB4u6VcQf4YfRfQ2u7GaTx6TSAc28XRRYm5kglF2KQ
         kfXtM5eUgoT/OndG0+EdKTFPXul3oR3ItU0pRl8+5sKo+KQyhkZmlGxYA4kgc318IZ4q
         22jE66tmWDJX6fHTeTI8k1pEbL8siCeuCsHh7q57FxcY9UX9dOEGTszhyyRR7PsVRgBB
         80c+6jAW9d3IyB3klpTTiyEuIwAdtrUkZ/pD6K183UJWCF9CXsqKRSoNqIWFfVjmQNlT
         AqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPO5pqLl0KZa7SMv0SVLsxPcLafuvW8mEsW4LkkQbvc=;
        b=lIwlaE7bel5v9hQiGGNdtKIdIv/XFcc4UmUBt+mK2S0kwGvWnr/hd3JyrlUL726Oaf
         J6WOjEf1bHdlUs8GqYL3pQlis2lmoetyE9KrlTOG2XJgpMEtONlHEwSy9s1jUOTbYx2a
         5o/qCiMGAqeZGsjiBPm9bIYidBCHS5lAaekJmS3J7O/udDD9kCual4DSAmW33Ly+5omJ
         sgAWNpqjr5PAD5tQtAmUuLW6TkzdF2lnnfgtw6kxBZUUO3/2JqjUTRDRg5Zpp19Ipzk9
         9yrxwdgIIQR+5CpFSd5CEG5sIGMnS7Mxn4dFSgejC3qV5Zec+BvIN7kCmDsYgutDLNa+
         EQuQ==
X-Gm-Message-State: APzg51CSUelx3JvCPdyBMviAayaORNaSTYGLGsErVBm21wQwLoaL+7Jk
        rgUVkvhyamBXDCXiQhigh95MvKt/
X-Google-Smtp-Source: ANB0VdbIB7bw2L7kHM+mRv/41ZCjnPnMmInfwuG1Ap+CbU01Z1GL4aMwfgHptqahlMlRL1dZlgVSlw==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr36073439plk.133.1536101613968;
        Tue, 04 Sep 2018 15:53:33 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j191-v6sm69437pfc.136.2018.09.04.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:53:33 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903165719.499675257@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3a7259c8-33cf-d38b-42ae-d8097c7d00e9@roeck-us.net>
Date:   Tue, 4 Sep 2018 15:53:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 09:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.6 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
> Anything received after that time might be too late.
> 


Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
		total: 314 pass: 314 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
