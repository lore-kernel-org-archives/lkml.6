Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC50C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0192B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmaBqo2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0192B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJIIYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:24:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJIIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:24:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so22650257wrw.12;
        Mon, 08 Oct 2018 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GBkfHCs+aClJOuXs/BjfTzNCZO9npPLs6pVAVNybe8E=;
        b=FmaBqo2EkiCxNKdBUHYrVIxpeLpzdA8lMO90LqjlUIGyrv93AxQ4zC6WhKRc694rmJ
         Rak2e6Drd6XqGn1HcFPc6yyKy2CQx+eAc3l4OZr7g0HEcXQirAnn1g10q2R2w0UCOjUL
         W7kMA52p+RFoBpm68XYoM26uGZKA5wzJJ33TWShbob2dz8wrkTMhcNRGk3qbzStOUHwc
         ZTVCSq27vv545YULFn0bzbjW4D7o4n/LIfduwyf+QU5PPa+JDTAbtKO6cOoI51Q4YeNX
         oSer7aYz/zFpUvYyiqHi7qHAH4DGDcp366rFgusd8YArORdj3KESq9Bd7oIFPCUxvnfn
         MOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GBkfHCs+aClJOuXs/BjfTzNCZO9npPLs6pVAVNybe8E=;
        b=Nem91guufyyaubP/viTGF/Vf/AM9qGAE0Gy5rQW8eoqgkE0ddC7wukKBmD8/+HdQzi
         7HJclgeeUTJhA/2W/VanouAS6i9S/8JehN+GkSkeGqVXmFd2Nn2HHk99jUEXo4uzS0Ia
         Gupdg3IiTvyWuv6lpHZSi+k7tygJ7CTJZjyFxUv76OR/U0mGpZyH1zzAwN7uMVQWXzYS
         mX/N7MIdy59UNClBy2fiH4bklwXBVg+ZT0+oxz6iNvlmCCFvl3I/030+ok9rkqsEy1qL
         00JwBCCQnmlA9bV7oTAGPikIfEmBpJe7ydRoZs0zps/HITz3UY4TLNBgxLGt5TN62I8B
         ZX9A==
X-Gm-Message-State: ABuFfoh0ITFXo4y03uLaVj9Q+dtWtLXoS4FlcGhqWbCYkyb8Rn/qZZ3V
        5Zn66y8qoSKxetPrLKYNidD7e+Zp
X-Google-Smtp-Source: ACcGV62zdcLHPlrrAMgqf9aLAoEkRK4hanIKIJtgeU0NEuNjaRxvAj/ZYPS65SHCJpnlOcet6AzSvg==
X-Received: by 2002:adf:f5c6:: with SMTP id k6-v6mr18228342wrp.59.1539047390674;
        Mon, 08 Oct 2018 18:09:50 -0700 (PDT)
Received: from [172.30.1.166] (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id n68-v6sm8653376wmn.5.2018.10.08.18.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 18:09:49 -0700 (PDT)
Subject: Re: [PATCH v4 11/11] media: imx.rst: Update doc to reflect fixes to
 interlaced capture
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
 <20181004185401.15751-12-slongerbeam@gmail.com>
 <1538736767.3545.20.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <539cd27c-5c7c-7ea9-af1b-143ac97f9a15@gmail.com>
Date:   Mon, 8 Oct 2018 18:09:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538736767.3545.20.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 03:52 AM, Philipp Zabel wrote:
> Hi Steve,
>
> On Thu, 2018-10-04 at 11:54 -0700, Steve Longerbeam wrote:
> <snip>
>> +or bottom-top or alternate, and the capture interface field type is set
>> +to interlaced (t-b, b-t, or unqualified interlaced). The capture interface
>> +will enforce the same field order if the source pad field type is seq-bt
>> +or seq-tb. However if the source pad's field type is alternate, any
>> +interlaced type at the capture interface will be accepted.
> This part is fine, though, as are the following changes. I'd just like
> to avoid giving the wrong impression that the CSI does line interweaving
> or pixel reordering into the output pixel format.

Agreed, I made the wording more clear.

Steve

