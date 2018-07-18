Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F629ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A269A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p74W0xjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A269A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeGRSMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:12:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeGRSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:12:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so5493440wrt.1;
        Wed, 18 Jul 2018 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meYHRy8zPiPrtj05PyilguAX+u6D6hfb0GLpsDJAwAU=;
        b=p74W0xjcnt5j0HRD5H7I+klawZMxxtd4bxx9NFgXoSMB0TD+RhNkMVVe7oPLEEbftL
         Se+df77jCElYo2OoLqWsEgq6pvDkNB34s05Dvq8JLgzekHAuuwLbTwrVHPEQRt9SZAJC
         OAn9ytRczDmVURu2w42PNplCG4wa+q2Ynvb98wiZED+Idain1NyPWn2MP9CZM+NcokFz
         yJ9IRw75mSQuAlFnmuKpUTbMnzhTfB3VLXEO+fZ5x5jp2tqLFpKpZO0geykOH89FTaRP
         WGrkVLKmcQWeSPhlkpKRzBlz5OeLjc/KB0whVtrgc5XJhS78V6UWA8I3ybhOo8Ll/XA7
         +b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=meYHRy8zPiPrtj05PyilguAX+u6D6hfb0GLpsDJAwAU=;
        b=lEgTypvmOuh3XF/kZseuDNlmhDig9pSEYclrP6yjGAzUaI/m6AooscVQmXR9y8mJ66
         RJzF+4bj3FKE0GTifsUpdkyQr0AjIckxI3M17MgZ1R2VX4jMrkDywPod363O9E/xIm2+
         R8TKxSxpErAKbkYl5jynGG547yiS+xw5UzoPUujXwxA+mVGWjQm/BsaATbeM15YV4AES
         0R7torU6yI1NUuLXGPzf45afj/IN9F0QqMhoJ7t8zyuLAMbRwMMZC+4gsx5hgca+eOXW
         FhWvh6uvFU0HXn+/rDFVnbCghDe/zPbNuwJmm/WzFJKS7wumgT996Pe96DnJ50Op+XS+
         GqfA==
X-Gm-Message-State: AOUpUlHRwnXVNQveU9zae98PcAkh2tH/a/VJuAvid7TAjLCn1bBs5YRK
        dO0GNeVTH2q8bFAyFndeM58=
X-Google-Smtp-Source: AAOMgpdUCuDdZduOjg1ieMwRhqVhJ8flnoK54yN7WyrXNoYEyePj0ioj1BKmHn+jtqQwhCSV5wxmvA==
X-Received: by 2002:adf:fe8f:: with SMTP id l15-v6mr5317010wrr.165.1531935183408;
        Wed, 18 Jul 2018 10:33:03 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-156-57.clienti.tiscali.it. [78.12.156.57])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm10214130wrv.23.2018.07.18.10.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:33:02 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
To:     KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
 <1531214840-24686-2-git-send-email-karahmed@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <e0bf0d2e-6aaf-6ce8-f4f7-832011d0cf3f@redhat.com>
Date:   Wed, 18 Jul 2018 19:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531214840-24686-2-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 11:27, KarimAllah Ahmed wrote:
> @@ -11772,7 +11772,6 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>  	if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
>  		goto fail;
>  
> -	nested_get_vmcs12_pages(vcpu, vmcs12);
>  
>  	r = EXIT_REASON_MSR_LOAD_FAIL;
>  	msr_entry_idx = nested_vmx_load_msr(vcpu,

I think this is not enough, the MSR load should not be redone on
KVM_SET_NESTED_STATE.  This issue is preexisting and happens for SMM
exit as well.  SMM exit in fact also needs to defer
nested_get_vmcs12_pages, or the pages could be read from SMRAM.

I'll send a v6 patch and a testcase, and in the meanwhile I have applied
patch 1.

Paolo
