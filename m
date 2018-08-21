Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09806C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997FA208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cycEK6IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997FA208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeHUO0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:26:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40319 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:26:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so2466622wma.5;
        Tue, 21 Aug 2018 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3oxF2+RCiA3K4BYTcxC00Sy53yQrr6YR/gfTyx8Lk0=;
        b=cycEK6IWXGDnTSwhS4GaIAmcl+LxXnoQW17ZraUGFjSiXnJGGlFdJSJU/CJcsRQ7Yq
         FMRSEltHAK1hJhaupE6a54ZMlaD6CCYUz681t6QGMWgGAphewa3qa/RSVw0YzymHNbsz
         yZUUgMgD9vAArJWPaL+QRapzBcA1LRZIKYHqk1T3n88wl51zOoFaHyhAyKO8DsxCCmKu
         3yigdmUEmvSTDdONatIATLSTe+TJce5ZdzDMeOhd2eLFtbL8Wy17rYID+GzGibkj4Aap
         fJrTpV72CLl2qY9ZBOEQmgQ0NK0enJ/uumrVWllOAEuTIxNqbXi3/QymNf4DCNGs40KX
         05rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J3oxF2+RCiA3K4BYTcxC00Sy53yQrr6YR/gfTyx8Lk0=;
        b=MX+71pon2DI2s7pvXb9knTvNNADeFUuLimgqJ22AGCSCwdAq6+kEG0jlZPtWJDxF9P
         LdzTxZTUoVaw1QAHsMathmvTu0fZ1EO+QfWj+P0knt1hYPBYf2X/lBeawkpg23pppPvq
         M20E3eiN/PfiuagSqnJzgvDTzMWoRLehLf3aR4XkjZeKnHR94gfvAFPGLQj7fZ5lJZ5t
         HVCN2BaGZNsMHB+WFlin0z9FeTL06uZexDvmKk0L5EH7dqhaJSvIqbt7rVVbvYgsLtw3
         IBF8rOnRLrnsUXxcBlCoPfU2D7xlXgd1gsOZX+GWL0r7vNZm0pcohATGc40FEx7VbY7j
         BRCw==
X-Gm-Message-State: AOUpUlFKoUwzf0LGFSnivPr2bdFAseomAWgoHhucvFm3uNNexvbyB9co
        AfqBNcltJQ/innO+oFQk69p3BYOP
X-Google-Smtp-Source: AA+uWPyFgqp4crhqLC/7emdq8Cf7kjjvyeXs+QdOTvVDga9eSeAZbxagjO+LYudfiubBGpOnWezwNg==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr28697317wmj.130.1534849598440;
        Tue, 21 Aug 2018 04:06:38 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-184-244.clienti.tiscali.it. [78.12.184.244])
        by smtp.googlemail.com with ESMTPSA id 72-v6sm13605909wrb.48.2018.08.21.04.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 04:06:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: Documentation: rename the capability of
 KVM_CAP_ARM_SET_SERROR_ESR
To:     Andrew Jones <drjones@redhat.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1534801165-41525-1-git-send-email-gengdongjiu@huawei.com>
 <20180820142925.zw2vgplbutfcvvos@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <a1d72e58-ce94-e681-bebc-125ea84045d1@redhat.com>
Date:   Tue, 21 Aug 2018 13:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820142925.zw2vgplbutfcvvos@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2018 16:29, Andrew Jones wrote:
>> In the documentation description, this capability's name is
>> KVM_CAP_ARM_SET_SERROR_ESR, but in the header file this
>> capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so change
>> the documentation description to make it same.
>> 
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Reported-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Queued, thanks.

Paolo
