Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96539217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOJfwss5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96539217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHCWO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:14:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33704 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:14:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so5845692wmh.0;
        Fri, 03 Aug 2018 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+NNd/R5GXcHHWJTZFkhQBwXE8RrYitKtTq/T1TKAIo=;
        b=pOJfwss5pasX7vrd9i0/TNXTkF2+AgIg9GZ0SvmQmZs+HStDBV3w9aaB+tXslcQpd5
         wHWYhm8tqfVB/5EolSq8AHv/xXvyqQpLcxIZpb8VMDk4nY+TudhDZ9c3/TGNJORsiGoE
         Tx/aWLYTkG91URLXekcGJhvrEpa7okmE17YINzTjyK4WqixHuCJpkIhRevIFYzwGPUp5
         H44GKKr5RpENfJyTRpWbZujtNmzmCcIjn4h+b1FniPlAJG18l1GM1xLNWYipHPveHFKH
         AuY3zs/Q+O6FVhDKmYNbg/3b8wK+Zu8ESvB7UEHBfAFZyjHUhsbcf0y62l6kftLGHsVk
         b3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p+NNd/R5GXcHHWJTZFkhQBwXE8RrYitKtTq/T1TKAIo=;
        b=PeeI2xuFxr0yQylVvyFoyG2sa08PP2zCqQcpUweFRqMiT3E6M//ieyV7IagVpOMQSc
         YB5K/U6XxPw8h7D8bOqADh6e+2W3x4CPLDUi+vhjNI4aOm5htWBz0qe/c+aGgU/1EteK
         a3n6eEoq5/n04jkdK/vXfDbJgE8MAtjuq6N+5fiPDbPsGumCfdUl2VXjYE1nXEPZT9x1
         keWq4Hrwz92DXVkYInV8//GSZY336tnUl07vKnhkCIM2pZKN/riRpyYsSddj/zYgOHDk
         WMdtX3AZnnkcW/XqgKw+DsJgnvUsVNvTY5Z44xw1t3CCgdKuhwrA5HgwPimU0dcIU/YF
         kpJA==
X-Gm-Message-State: AOUpUlHj4x1efgisFEVVSAGNqJVU+wki4hFLDzGNT7Ncw5WzfrNvzpED
        siHynzI2Z4260/txOSda7FInueYX
X-Google-Smtp-Source: AAOMgpdKb0Y0WLDneDdaHw5X2sz+9aI+mgYLILOjgaw4UCu83Ujqizrg5YQm2JFeCYb5Mxip0i+qNA==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr6242358wms.46.1533327426036;
        Fri, 03 Aug 2018 13:17:06 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-235-128.clienti.tiscali.it. [78.12.235.128])
        by smtp.googlemail.com with ESMTPSA id e133-v6sm466294wma.33.2018.08.03.13.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 13:17:05 -0700 (PDT)
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
To:     Peter Shier <pshier@google.com>, tglx@linutronix.de
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        kvm@vger.kernel.org
References: <20180730211254.173686-1-pshier@google.com>
 <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de>
 <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com>
 <alpine.DEB.2.21.1808011954410.1835@nanos.tec.linutronix.de>
 <CACwOFJSta=jM7LDiEtT-V_UnCwhggurDa4B+dViqLcdyPvYGxQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <3dab0fd6-be64-2c72-1ee9-ecd040fd43b5@redhat.com>
Date:   Fri, 3 Aug 2018 22:17:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACwOFJSta=jM7LDiEtT-V_UnCwhggurDa4B+dViqLcdyPvYGxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 21:33, Peter Shier wrote:
> 
>> > The Intel Haswell architecture has an EPT feature whereby the access &
>> > dirty bits in EPT entries are updated without taking a guest exit.
>>
>> Why would this be Haswell specific?
>>
>> Aside of that I don't see what this has to do with exits. From the SDM:
>>
>>   " * If bit 21 is read as 1, accessed and dirty flags for EPT are
>>       supported (see Section 28.2.4)"
>>
>> And nothing in 28.2.4 says anything about exits. It's all about whether the
>> feature is supported or not. If it is supported it can be enabled in EPTP.

Right, if it's not supported KVM instead has to use the R/W/X permission
bits to emulate accessed and dirty bits, taking an exit on every update.

But then it seems to me that you're more interested in the KVM behavior
than the processor behavior, and then the information you need is
already in the /sys/modules/kvm_intel/parameters directory.  (Most
processor features have a parameter so that it's possible to test code
paths for old processors).  I don't particularly see a need to add them
in /proc/cpuinfo.

Paolo

> Thank you Thomas. I missed what I think is your fundamental point
> regarding duplication created by this patch between CPU feature bits
> and KVM's consumption of the IA32_VMX_EPT_VPID_CAP MSR.
> 
> Should all the features in this MSR be exposed via CPU feature bits
> and should KVM consume only from there rather than reading the MSR
> directly? There are 16 feature bits in the MSR per SDM Vol 3d section
> A.10.
> 

