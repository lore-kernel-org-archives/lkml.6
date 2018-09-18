Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6280AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA9206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/thaUp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AA9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbeIRWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:34:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36004 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:34:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so2465839oie.3;
        Tue, 18 Sep 2018 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGwR8SpWwKNRb2YQNsIVZ6+eBYi0zp5U77Z2A+qhmRQ=;
        b=N/thaUp50H44GSvmVD9UwoTm6EjHyyDx1GorxaP36U+jT7frLyuFUc6GjJcnM6EOvA
         BMCXJ1zeJ7R0NpCwBML/oH0yYztt/c5UrmTywrhOcQ+p7XaujZl3T8ipqWPYLK9QS0zq
         MQzCt/9BEZQjobggj3xV3HBKUporcVmsnl3+Ktm+olxL7GBcVKtBEAfvgEyJx/L+KtyG
         6/6aJlVcwC22rpD9tp1WTYenkNO+aOAMLXBPe9sC7VCdC44XiAzAt/zvudNQ4ahZjjXL
         HLvypyR3mkF/4H3HyqPDHkAbfYL5ZmQ0b1b8JDkEQep6vURRNUdUk/jIlfEfoloa47nU
         d66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGwR8SpWwKNRb2YQNsIVZ6+eBYi0zp5U77Z2A+qhmRQ=;
        b=PGxk6rLD39oFQK1gPg4S2HSxs9o6LAw0jLA5gZyg49yFJbWTapac9Y9FGEK6mpLIhM
         xKZDDe67Bjl8yccFMuffUcz907Xmiohr0x83E8lEkXBtDW8qeTgHDROGNKaVGIeQ/fEO
         Zph/EnDQs/VBrmkM737VZouk4BOsAgKTB9rOJLMfIwOu9J9JxYUvepHrDUli+pIw9mFf
         K+L0SnoZTmxQ6KbZOdopxQXffHNEIHQ/y7p5AGujIo9YarGlA2kEYgC1mxUp+L8YmMaB
         9YO7zkTJ8kjxZ/3jNGTrh+pZ1ItbiTZj78HvhTQqkTfyjRWFVGRgKAyGZ7iLRz4khUNK
         6V8A==
X-Gm-Message-State: APzg51CbY0gg6XBwTaWc9hBJGwSUWxvs0lrJvldwGDYuEOXW8kkD1D0j
        yjfV5zxAWUVvx//PX9Q1C40VNQNL
X-Google-Smtp-Source: ANB0VdbMnO3foQc3yRZ+R97541zBBnxcvFFz2UByKVfHbX2OoTDmiaIy9tSM71FjcLD36jSGf8WQ/g==
X-Received: by 2002:aca:18d:: with SMTP id 135-v6mr2210970oib.2.1537290051042;
        Tue, 18 Sep 2018 10:00:51 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h16-v6sm5332214oti.4.2018.09.18.10.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:00:50 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
 <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
 <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
 <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
 <19247.1537288419@warthog.procyon.org.uk>
 <23698.1537289705@warthog.procyon.org.uk>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
Date:   Tue, 18 Sep 2018 12:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <23698.1537289705@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 09/18/2018 11:55 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> In theory the PEM file already contains the type of the certificate, at least
>> at a high level.  E.g. private, public, tpm.  So if we accept PEM files
>> directly that could be potentially a faster way of determining the parser to
>> use and would still work with keyctl update/instantiate, right?
> 
> Yes.  It shouldn't be much code, either.  You still have to check for X.509
> DER since the kernel currently supports that.

For reasons of backward compatibility, correct?  The kernel also has 
mscode.asn1 which we would need to support as well.  Since we can't 
break compatibility then perhaps this doesn't buy us a whole lot in the end.

Regards,
-Denis
