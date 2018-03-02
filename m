Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-901181-1519975607-2-15887907248671125983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.67', Host='mail-pl0-f67.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519975607; b=lEBqoI0Vz182u/R5Ip0tGV5CDbCwtN8MHQ8t9u9/dz97Mq8
    Qp+Mnd8UQ4lz/17kW/LCbSSK867jPEWGLBdqqCA2CDO06nSWlCSDZewIu8QkG2ua
    dpYdG+2PkywumN9ebGs7Pq/TgUX2IXYo+wCrcOd2Mx27WnwGltENgQZB+1ujU6/r
    RYue6YWN7KAfI+tKXkN4VEpPioJdiBE1OaL7dOw3qHdLEXfxsxzAldh35pDh8Dq6
    GOhzvDBuWPXXYZ56s5JO3O7rd4ohdACVf7aLIo47IKRJyp/1CJ9t63ITsuFPjjWp
    VgkI7KfIcglnD/cd3p6H2OeXhZs7Im9E8mjAetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1519975607; bh=Ci4qibDO
    L5gkXAxPx8wfmIBcBmwsqxvFbesk2s3fygg=; b=OxupVNJg/HC+lN3gqg7S1Zw0
    QWiOOwGJc0Cxamdrz5c5RJ3YMtVpHdWJeEs0daVRupE1kvAm5kNwO5iSgka85nQu
    DkhR1mlE6kQ3aSvTXIUzSD5RFyRtn5//4wwyvdspB0q1yO+dOnSj25DLYvbK1bIQ
    Vv12UazjCmcnnD8xEzCj/69LuI1zPBECLngn+IP7aLlUYmyJBxfUuk9BOI6liI2A
    b4gYmixFLKCWyKQ+5h8ubk3yDXBM+laeZyH2zvSnG5ifUBdmpcltfFrSQG0zVtkN
    h5LIkGgkn0fTAcfccDNZiTlozdL0mDPfOL7Cf76uZQbOm0U83p3R+K0FpSrsCg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TkpBUp6k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ht5Rd/pz;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TkpBUp6k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ht5Rd/pz;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvzAs8fe+EAieQoZEsc/mUPqq6COtW9DDFZ7qmS4szpoA9Qyx5pOTYd2NtsNCwRrjKGnG+Dyg==
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: Greg KH <greg@kroah.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164544.GA23321@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <663e9fac-ec2b-857b-26fa-abe595afc7a0@linaro.org>
Date: Fri, 2 Mar 2018 15:26:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301164544.GA23321@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/02/2018 12:45 AM, Greg KH wrote:
> On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
>> Hi All,
>>
>> Resent without non-upstream patches.
> 
> Again, please start numbering these submissions like any other normal
> patchset...
> 

Thanks for reminder!

Regards
Alex
