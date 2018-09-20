Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C64ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457DB2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+vu5Dr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457DB2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbeITWiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:38:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40028 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeITWiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:38:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8-v6so6475586wrh.7;
        Thu, 20 Sep 2018 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjR3RWbux8VhpN6TnGbyCACKkFB45t0D6se3yoin9WQ=;
        b=o+vu5Dr42h0EnIUiBTueZleRUcxzsqEhzf6bObOrRy9PUy7iIXRPklrYlUKAnpF4td
         tjRDhdW5w8MmdOa5g7aSdR7anRCdWaSXdqNOAn86S6G5WYqarM897+EsuoCXqGc6Zj9M
         zm9K/YbcXM4g6lWc/LZBx1DnKGYiGmP2yMsmQ69vXPFsL98GVhBGyqJAWYt7SqCqx45e
         iIS2WxAWbF1AwJ+SpbOnE4In0W0caAIEekPax655Sw4FE78gtBtXU23yrLqqrkQBH+6a
         bLEdJ1pe/1gtQL6won+NQOA5tX5zXBWvqMU5TE2ntUucXRHZcjD4TZnV/AIdPaaJw47m
         YbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PjR3RWbux8VhpN6TnGbyCACKkFB45t0D6se3yoin9WQ=;
        b=IbEZJbyaRitv+bAISR19BLNYZpO596aYFaYso5ejlt7AIx+sRtO38Ijdjftg9TQa7e
         SJDAuhG0AaMuD4MjEnOG/zU3E1grYUhtNkjOLdxooDZUn/rIb0+kQFGk84l/dbv0Na0N
         vROZKb5b8vACN0vROpKnkrxHjvSgr3PUf2vheJnE3kTJqUq2sZWsj3ZPgy6USDmQ5zrP
         eVXJvS88p0Y3KDHZNvWkfKiVrH3to2VAqrctBmI4SUDN/rpJyPz1kGEONIQ4zB3TzlbC
         fcqEFYpX+p9KbXfvW7/lwYP6jOvS6O0GfGZV28ThIbe9z6sMepWOnkRQDbt0ebcbWoxx
         3lNw==
X-Gm-Message-State: APzg51ACq9ba1Y4eYNWcH4Jtrt2Je8pv9r1CykTxvanWUnsNW58Sqqyf
        kmy7OD9JxX6igv/sy/7YleOMeiWI
X-Google-Smtp-Source: ANB0Vda5TJToHQyWiMkRerYKMR90OZmxZ8j5aVCHkh3pm6nDL2XuZgOD/wFrYKivJ03QcfgtmbQPsg==
X-Received: by 2002:adf:d110:: with SMTP id a16-v6mr34866389wri.17.1537462437160;
        Thu, 20 Sep 2018 09:53:57 -0700 (PDT)
Received: from [192.168.10.165] (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.googlemail.com with ESMTPSA id 127-v6sm3362421wmb.30.2018.09.20.09.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:53:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: fix failure of injecting exceptions in
 x86_emulate_instruction
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        xu.xi8@zte.com.cn
References: <1536220964-8412-1-git-send-email-wang.yi59@zte.com.cn>
 <9835d255-dd9a-222b-f4a2-93611175b326@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <a9a47c9b-c8b9-74f4-78ef-fb54c7fe806d@redhat.com>
Date:   Thu, 20 Sep 2018 18:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9835d255-dd9a-222b-f4a2-93611175b326@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 18:30, Paolo Bonzini wrote:
> On 06/09/2018 10:02, Yi Wang wrote:
>> In order to fix a page table walk issue, commit 6ea6e84309ca
>> ("KVM: x86: inject exceptions produced by x86_decode_insn") check
>> if variable ctxt->have_exception true and inject the exception.
>> Unfortunately, ctxt->have_exception is set to true only in function
>> x86_emulate_insn(), which won't be called before invoking
>> inject_emulated_exception() in the 6ea6e84309ca.
>> This patch fix this issue.
>>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> Reviewed-by: Xi Xu <xu.xi8@zte.com.cn>
> 
> Queued, thanks.  Do you have a testcase for this?

Unqueued, sorry.  The hypercall test from kvm-unit-tests fails.  A
VMCALL on the "edge" of canonical address space, i.e. at 0x7ffffffffffd,
raises a general protection fault before this patch and a double fault
afterwards.

Paolo
