Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC72C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5641B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgJlK1W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5641B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeKHAai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:30:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44771 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeKHAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:30:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so7958240plq.11;
        Wed, 07 Nov 2018 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1eaFVBobgO2+QXHP7kWrYOH7nmTnM/w4Kcb/yWpLYbc=;
        b=TgJlK1W6FAVwENeLcqVaQw7vl2JymWUVqmzFdu5+Fsap4ipE1ullBsS6OXSxY8ABX/
         +E63wUubMi+BL9H8bQxVf1F2BL0TZMJhJqfy3enqzZSPjvJ43LAF4+/rZKG/mnjHvNfp
         RlRpj+bVj9OEp981zfH7kI9x1GDdRLn0zxSz8s91vD95hh6d7vN94rALl0N4r4F0fPD5
         0nN3n332EyCaQ+TKcjEs29pILVyM4puIyX0lzIjZAVpUkTXRh7vLCGl44l+WRAh4A0Tt
         8OtDCgVdtqEw0uc4vQnTNXZHu3sfvY6oJbSgQFo5hPJaSWlQ+zh6PWBQtKfgH3XFwgV6
         yVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1eaFVBobgO2+QXHP7kWrYOH7nmTnM/w4Kcb/yWpLYbc=;
        b=ZX1TZLC458lw5rSgzQsqT3YPSWBEE0m2zdA2sN1XjGIEM7Z1AS81pxJMRyCAFDOYqi
         iebZI9SmyGQGBMTc/z3nX9zLq2TtwFQz+L8QsMpBxmmx+pQEh8sIBBl7NuRekCavT88B
         n9Vf5eOfh0E1xM6wKa6MvPuNbwDE7FG2Gt1DPkqSHHUdfvd9CotpYZG2xTAMDyxPCFjv
         w6Kzni4McqfDKRtPfwri8h6n3Nr9obC57u1RNu5AYBrOE7sGqJXvTx00U788En3uILVR
         4IZf5gxv4YIadIkjpzVRHW2udWcKn1cpl306zq8fHgNM6QFGF9Sevhld7PPXDMwA3oDg
         QXvg==
X-Gm-Message-State: AGRZ1gI1oSe52AC8ntZ2GJmKjXe8kbIhZq4QID12zPeleGybJ0vfhVoh
        X16LL6bbCmrxIzqxKMQSJ8w=
X-Google-Smtp-Source: AJdET5eA3jOBYhkifsWPUpVzLgYt9L5k9z1cYJimxAQF0YhwLr7XKgZCC4HBO7wvc3jSNCADxelcOA==
X-Received: by 2002:a17:902:443:: with SMTP id 61-v6mr549370ple.216.1541602795174;
        Wed, 07 Nov 2018 06:59:55 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b62-v6sm890605pfa.159.2018.11.07.06.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:59:54 -0800 (PST)
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
 <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
 <87sh0dqec5.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8d2d4bcb-1349-7bfb-7007-151cb9f19c1b@gmail.com>
Date:   Wed, 7 Nov 2018 06:59:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87sh0dqec5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 4:09 AM, Michael Ellerman wrote:
> Frank Rowand <frowand.list@gmail.com> writes:
> 
>> Hi Michael, Ben, Paul,
>>
>> Do you know if anyone has tried this series on PowerPC?
> 
> I have. No obvious breakage.
> 
> My test does a loop of adding and removing multiple CPUs multiple times,
> and in the past that has uncovered refcounting bugs. So I don't think
> we're leaking any with this series applied.
> 
> I used the tracepoint patch to keep an eye on the refcounts :)
> 
>   https://patchwork.ozlabs.org/patch/751602/
> 
> 
> I'm happy for this series to go into linux-next where it should get some
> more testing.
> 
> cheers
> 

Thanks for the reviews and testing.

-Frank
