Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6h9uVSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED9020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeK0KpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:45:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37432 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeK0KpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:45:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so7384450pfm.4;
        Mon, 26 Nov 2018 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQtdakAh15RmXJrANEBGx95X61gZCt40DYbkEr/6PfY=;
        b=m6h9uVSqsIozWs4K3kmAo3hj05cYjPk4+Hqb3xcS6hD4Gg5ywaH9sR9rqxFG7C/zjn
         k9W83i315EW9gWNUU5Vh5XC0mQoPcNCZ9jCU0FoEQwOTypm5DinvRK/hhRTfzu1EfFvi
         WTfGypZEpfUpu00PJvNs8lU4X/gXn4hFfPfYtr0InTVAj46usk5cFYQGRk8gqcTDb1o/
         tC86ZQTDfqpz3n3unOOHTykNkApvQFStMW/bZhj/Gtk1EanpRTCNvntkymKuj4o3ihb0
         RdDiBVmwiNaGhmGQwMwNdZt388DZQfq5WTqJVIumimko/iFTnyI1Ckogp9vigSATaW7U
         TlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQtdakAh15RmXJrANEBGx95X61gZCt40DYbkEr/6PfY=;
        b=gF9nQew4374qZ5wYjXG6Ir2ceF9NG3pExpBEHUIWQX/X3yHsf0chHEDCeEvpvGNYvs
         CgEvuP3bfhM5X5RxTA7flcJnhGuSn6M8ku4wfea0GR0lkq4b2eSD73kjonDHS5By7Hoi
         f7G+ZPbUiu7gjf6/3gBi/QSS7Fyfnb8ZiSrz0f8X9Ni8Wv6BXk6gQHIZ+HB6KYYWEeRg
         9fHu2iBHI6ez7JwAzhz7b1akatLcMMpqwkpc6fTtqCfFiixO7C1zzNGlxpLYe1Kw5Z6W
         BabZaGNL+NogzLaFmPEqIbDzA5pUuURY7DTeLYVji+sj8GRYja0HJJm5BJdSvaogpwig
         ZEJw==
X-Gm-Message-State: AGRZ1gLVVC4pKM9+KRxtKfwfUOAwadU1mK53BHNLabRNopVi99oZ6QKe
        5HhmeRjAwW4qBdJD/ZsZTf17tYPB
X-Google-Smtp-Source: AJdET5fVYV/v4S7uyh4ZO3MZKmsx8at5HW7S6DamfDocdsF0dRA3KnT5ZwHCRE4Vg4cltwAiil23zg==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr26965839pgr.333.1543276150334;
        Mon, 26 Nov 2018 15:49:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm1866084pgz.53.2018.11.26.15.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:49:09 -0800 (PST)
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181126105046.722096341@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9ac3f7d4-f7b0-0a48-2648-3e1397032344@roeck-us.net>
Date:   Mon, 26 Nov 2018 15:49:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 2:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.165 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:16 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.164-71-g4209bc7270f7:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 264 pass: 264 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
