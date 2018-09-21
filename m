Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F7ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5A921522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVtHnqOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5A921522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbeIULBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:01:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIULBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:01:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so11493324wrw.6;
        Thu, 20 Sep 2018 22:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAWB7DI3gDNDKXPaKxcE09WvRehqoEigOepgID/tZmA=;
        b=hVtHnqOjMdMuhJYrREN39veRM63WxZ6Bjnc8744J0C/EATi99fY4WABXIJPknRJsHg
         j62ZhwIxW0DLwIDdSUQZsNv+SowucIqwt5FV3QAZfCPTu2tlH85FNWAip5VLSSw5H86/
         C0I9Rr7p/GoFMgvjdWCWyE5AOmCksaupaE7nXrSLlfEsfvWTD3v50BTe2ggI0h4VqXcf
         tsKgnbXEZhcTjgnRNQGhTPB41EZvJf95A5b5w/eyWZyBQVfQxsUn0QhZ7df0Ick7MfTv
         aM5FH3zNYrssIwyOcyde//7quU9ULgH6i+grF73YFjQ7RFxbfdpRnJumsBUEQwgl6IS7
         yqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HAWB7DI3gDNDKXPaKxcE09WvRehqoEigOepgID/tZmA=;
        b=egQ4pOHnzJaSPcdTSf0TucTi01G1t77QPeYKe/mvqE3Ehqeb7tiGgtwLnXoOnfkAR2
         vl0hPmWUYFCz4E0lIqwb+65Ym2cxos7IsKLjHqTyyIYEMbRCzmxol/OZYfm+MhQEDYp7
         tCNuH2Wa8Rgv/JGOkwAkze11iuT173xcUrrLnfkg9eLr2YHenOQR/hJbOrxTkwmByeNZ
         spFvWYNYnic3jMcDgv7MV2uQiFASpfDl5g8eKckN/CMzXNiToAKPdingWjAyhh63JHBB
         eNDq5x76Yf4WXWYYll6T40vR8nlw1Rgw9oPM4X/azsAOYALsd8EuNFomABPmpDt9RVx+
         doXg==
X-Gm-Message-State: APzg51APx2a4sU/q0VpUaQl9dSvoDwBC4QQUFYlTch+abuivMwVUA++i
        espraggSWehNmLoQkljH5/8=
X-Google-Smtp-Source: ANB0VdayPmVsUs4PL7w/F/1iziUVy/BzPvsvqCgkt+kho1vtEfSTgmOe1Axg5S6pCN7a+ebY2ptyqQ==
X-Received: by 2002:adf:82b4:: with SMTP id 49-v6mr14602707wrc.252.1537506838249;
        Thu, 20 Sep 2018 22:13:58 -0700 (PDT)
Received: from [192.168.10.165] (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm34014601wre.18.2018.09.20.22.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 22:13:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: fix failure of injecting exceptions
 inx86_emulate_instruction
To:     peng.hao2@zte.com.cn, sean.j.christopherson@intel.com
Cc:     wang.yi59@zte.com.cn, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, xu.xi8@zte.com.cn, jiang.biao2@zte.com.cn
References: <201809211008185136372@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <7eb41388-993b-34c3-ae3e-c10607af904a@redhat.com>
Date:   Fri, 21 Sep 2018 07:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201809211008185136372@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 04:08, peng.hao2@zte.com.cn wrote:
>>> Unqueued, sorry.  The hypercall test from kvm-unit-tests fails.  A
>>> VMCALL on the "edge" of canonical address space, i.e. at 0x7ffffffffffd,
>>> raises a general protection fault before this patch and a double fault
>>> afterwards.
>> Peng Hao submitted a very similar patch[1], the difference being that
>> it also modified x86_emulate_instruction() to ignore the result of
>> inject_emulated_exception().  I have no idea if that change is correct
>> but it may be related to the aforementioned unit test failing.
> The return value of inject_emulated_exception for #PF represents whether in nested vcpu, 
> not about the success or failure. Because we are not in nested vcpu, inject_emulated_exception 
> must return false. And for other exceptions,  inject_emulated_exception just return false. 
> After propagating exceptions to guest, we just should return to guest mode and let guest handle.

Yes, your patch should work, and the x86_emulate_instruction code that
is there now is clearly wrong (though I'm not sure how the double-fault
comes up, #GP + #UD shouldn't generate one because #UD is a benign
exception).

Peng Hao, do you have a testcase?  Eduardo's kvm-unit-tests patch from
Nov 2017 doesn't reproduce the bug anymore for me.

Thanks,

Paolo
