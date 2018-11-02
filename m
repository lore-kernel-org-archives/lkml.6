Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79362082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AT8JKaTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79362082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeKCIIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:08:37 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39310 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKCIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:08:36 -0400
Received: by mail-wr1-f48.google.com with SMTP id r10-v6so3481666wrv.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipVsSVUPKk0ZJIthX8rRBsaprJ/wYe/OnefqASLPQ4c=;
        b=AT8JKaTimxFEcwapEj/m4gp+YOseCh5qWXXdi4uAdxjhqoOG5sge3wxFDL0/Saw051
         otouCp6YG8qJmrwvMb8lW8s5lIbbOH+0dKZuOkWm8sqqXb2PLSFjIwEnpjyhAGMdTtWr
         QhIdsFIwjUzSb1Fc+OWlmV0QSXEk6j6f21EHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipVsSVUPKk0ZJIthX8rRBsaprJ/wYe/OnefqASLPQ4c=;
        b=cFRhQjdrV9Npu9X0Gxf+vTVTbRT6QAbYMnwqtOCB1YyeOxAWI3wxxuESEi0XWbgECE
         Ux4UxQMR41sdsdywx+2/35vHrs7+BcuhJBOMm/YowB57jr5drKxjpKh7q9IdzRrejude
         B75QR4geeoeXJhDml+Xga1zJCLj0MPJlH0xJwlWrBH/2dqOy6xrUD//fnriSREIW7rlT
         S1sDFMhjoFEPAjP4yiouegBZ79errrMHGHwNOS+3O4Cs8valc4sYPT3upOXQGbM06na8
         WlkZf06979B6KYp3QITuPkGWBK33QerWCJV/Ue6HldSF0JEFJstbdZWw3sGRl40gN4Gc
         sfhQ==
X-Gm-Message-State: AGRZ1gIlm2lL2GbcjuC1opF3c6j4n+0KT5lD8ycRwQPwlMmH8pOG0O+J
        us1cb840tciwN/oGRtrp0WQpCYLHXuE=
X-Google-Smtp-Source: AJdET5fU16K/lQnTOO5Srf3rFCgpui86YXf4oZpPpgu/NTKoW8G+2eMpUPhMVJcxJdXUQh7liOmvDA==
X-Received: by 2002:adf:9563:: with SMTP id 90-v6mr12083087wrs.60.1541199569977;
        Fri, 02 Nov 2018 15:59:29 -0700 (PDT)
Received: from [192.168.0.40] ([80.125.186.228])
        by smtp.googlemail.com with ESMTPSA id p188-v6sm2864460wmp.31.2018.11.02.15.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:59:29 -0700 (PDT)
Subject: Re: [GIT PULL] timer for tip/urgent
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
 <alpine.DEB.2.21.1811022159420.3160@nanos.tec.linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ab0e549a-9067-4323-3298-f481dce2c3b0@linaro.org>
Date:   Fri, 2 Nov 2018 23:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811022159420.3160@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 22:01, Thomas Gleixner wrote:
> Daniel,
> 
> On Fri, 2 Nov 2018, Daniel Lezcano wrote:
> 
>> this is a late pull request for the c-sky clocksource and clockevent.
>> These are new drivers, they passed the review process several times for
>> the c-sky architecture.
>>
>>  - Add the per cpu timer for the c-sky architecture (Guo Ren)
>>
>>  - Add the global timer for the c-sky architecture (Guo Ren)
> 
> Pulled. Can you please tag your pull requests in future and add the above
> short summary into the tag. That automatically creates a merge commit and I
> get the summary right into it.

Ok, will do next time.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

