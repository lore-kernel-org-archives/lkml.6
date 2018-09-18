Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C90BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE13720833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfPvrvSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE13720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeIRUy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:54:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36694 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeIRUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:54:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so2144918oie.3;
        Tue, 18 Sep 2018 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=keRDOha3jfZc+smDOIg0A4FTSQus8ljZUcNPpsqvxuw=;
        b=DfPvrvSDNsam0uaJ2bGjiHLC7tn+XMWxFN+eT7H1ECKKDFkvQoQSG5E0obaz/7QJ4f
         YYL77AxtJptdpsuuoP4DPsa2R1MXH5AEOZ6S7l9Ga6oRlw1RAeCFcR7+ycjHMviQDAJl
         gmGSzsfXe8JVlww8y8j/RYQbw6R+HYMcgrLc6kquaaj2e0eScAmSyvytwicixTebKEYL
         fthQC1lGKwDp+oJSG4KhEXqKIjzTIs96voSNG9fmYaiQ9xAe6T+UcI+7ItWsHrWDvBWp
         qDT+YQJ7WWdd6p5b7py6UARu18VNF164FKN/ukoYtQlxwm/UrgkWSdJ3oXaUhKOFkhIS
         QSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=keRDOha3jfZc+smDOIg0A4FTSQus8ljZUcNPpsqvxuw=;
        b=kovrqkknptLi2ZsK0f4gbUIXT7/Cyv55zaY63SmRrSykYykixbQc6xRTHFX3r/n1He
         G5K7GNdmcd/wVbj91jeKHDpjmM+ew+6LAkV9u1hMZSghDAJOeCwua2uXNq8PIcjyV17x
         mKaoqqzKnPALQR35wyGZq4BSf0vXkM3F8vZv3pbxrfPDUtdwJHVTJ71zglw2cAC/UEti
         JaXCBtsV4IncZLckYLfu7l91fI25HwjIxYTXBeP7K3NRybr90JiSRyDKeLsPue9V4T7s
         OUvhDvKNDGi+VyytEsJa/Teo2a0dyp6UTLltH0fftg08/evvcC5pc2rlcRboSbCwTY73
         tBQQ==
X-Gm-Message-State: APzg51DfzPQhK480ZRxumerd4VRqCgBoqFlA9dMC5u1S8u5q6WJzdKRj
        BHMuMHiGgapbUXMy8rYo3IJT6ra8
X-Google-Smtp-Source: ANB0VdbC6EzvT+hcX/TjM76EMzcLNcaz8qLN1kTRCWMyQSUwbCIkXwlC+4JRkwZBxu41f5UrbyP53g==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr1719309oia.5.1537284084862;
        Tue, 18 Sep 2018 08:21:24 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d5-v6sm6188445oia.57.2018.09.18.08.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 08:21:24 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, jmorris@namei.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
Date:   Mon, 17 Sep 2018 23:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1537253993.20009.62.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 09/18/2018 01:59 AM, David Woodhouse wrote:
> On Wed, 2018-09-05 at 22:54 +0100, David Howells wrote:
>>
>> Example usage for a PKCS#8 blob:
>>
>>          j=`openssl pkcs8 -in private_key.pem -topk8 -nocrypt -outform DER | \
>>              keyctl padd asymmetric foo @s`

The kernel expects a raw DER formatted PKCS8 certificate.  And as you 
point out, keyctl doesn't grok PEM files.  So, that is why this is being 
done via openssl.  The example above simply shows one how to import a 
private key in PEM format into the kernel keys framework.

>>
>> Example usage for a TPM wrapped blob:
>>
>>          openssl genrsa -out /tmp/privkey.foo.pem 2048
>>          create_tpm_key -s 2048 -w /tmp/privkey.foo.pem /tmp/privkey.foo.tpm
>>          j=`openssl asn1parse -inform pem -in /tmp/privkey.foo.tpm -noout |
>>              keyctl padd asymmetric foo @s`
> 
> Those examples aren't equivalent. For the PKCS#8 blob you are first
> using openssl to convert from an encrypted PKCS#8 PEM to unencrypted
> DER, presumably because you haven't added decryption support (or base64
> decode) to keyctl yet.

To be pedantic, it converts an optionally encrypted PEM to unencrypted 
DER.  But yes, correct.

> 
> For the TPM example though, you are also showing the *generation* of
> the key, and importing it into the TPM. And then I'm confused by the
> 'openssl asn1parse' line there... what is that actually doing? If I run
> it on a '-----BEGIN TSS KEY BLOB-----' file I have lying around, I get
> no output at all.
> 

Same thing applies as above.  The kernel has no PEM parser, so the raw 
DER must be passed in.  openssl asn1parse line simply does that.  It 
strips the PEM layer leaving the raw DER.

However, now that you mention it, the actual command incantation is 
wrong.  It seems openssl asn1parse acts slightly different from openssl 
pkcs8 and so it needs to be modified to add an extra -out parameter.  So 
the example incantation should be:

   openssl genrsa -out /tmp/privkey.2048.pem 2048
   create_tpm_key -s 2048 -w /tmp/privkey.2048.pem /tmp/privkey.2048.tpm
   openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
			-out /tmp/privkey.2048.der
   j=`cat /tmp/privkey.2048.der | keyctl padd asymmetric tpm @u`
   echo "TPM key serial is: $j"

Sorry, I should have caught this earlier.

Regards,
-Denis
