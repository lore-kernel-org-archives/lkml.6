Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2202530-1521047208-2-17485204808098704550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521047208; b=PDdWY/sWnVAQQfB68Qy1CDefWsUAa7/LFYB7ipS8Qn+NU3J
    u6r2ddQFBvtBJRRj/eGWtlQsOu4setmMHTVXrr/BOWvsYzCHem5WeL02KMdVPAN7
    FXeDLpCquJh52fHtorZPgMpbUYWXy16vw304MGNcCkT4fimLvGS7HQqczufVH98E
    zY4qmUCeFI/uLE6iEnlwEeAwQ0TvW+Y7S7pkJbyrdIi55vUm6lW86UX9Lt8bCR2d
    T6Tuan7R+COUx82SIBO9ydY11EvD57PqfvLIoDvh4GtMgP93vRiC4sqplp32UBWh
    4emXut/rfERdx501IJKfqyDroiO5vWod5NVKZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521047208; bh=Gqoh2+8paSNn5MxAmbxxrmznAHqOyQVuqmQH4pzJ3nM=; b=Y
    osXqp03pgmWSu9X2kCZsMKEQRv4Lik5/uqXRJuOH5n1Oli8RWTjYpV/i3SFN6rnc
    hWsLnMtIkhY23RkB7K5pr1dk0B02kXxeOPmJgkfgVOUcUCdh1VaTbDh8LeMve2bm
    4ydjm8RsL6XXOzvoEnsrinNFfdHb81vl9xEbqY36OdU68/nEXHH/v+8bIb8z9k8/
    2MtTxheeCcGzujPMgJUwrnP2j0F5dwzjM+/NrBky3gBU/3Gik1JQgokIct5tZQEI
    6ntLVhEcug/HbMVBkI7NVPA273A4OtOsP5P4Q6948tpiBFKO+truVJrKo8VycRWX
    uAO4TqYY82WY+AbaJ5U8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b=nch/hzVi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=6wind.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oqw+G22j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=6wind.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b=nch/hzVi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=6wind.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oqw+G22j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=6wind.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCNRGi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 13:06:38 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46915 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCNRGV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 13:06:21 -0400
X-Google-Smtp-Source: AG47ELslJf452aX/Mjj3uazW8vvJtYxvua7xE86P6cUYRaK5g466/0jyM0CXzJKeiWKFm+6NZ2kTNg==
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 4.4 24/36] netlink: ensure to loop over all netns in
 genlmsg_multicast_allns()
References: <20180310001807.213987241@linuxfoundation.org>
 <20180310001808.681346858@linuxfoundation.org>
 <1520899459.23626.87.camel@codethink.co.uk>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d37d5d6a-2b5d-184b-470b-25a97910988b@6wind.com>
Date: Wed, 14 Mar 2018 18:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520899459.23626.87.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Le 13/03/2018 à 01:04, Ben Hutchings a écrit :
> On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>
>>
>> [ Upstream commit cb9f7a9a5c96a773bbc9c70660dc600cfff82f82 ]
> [...] 
>> -	return nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
>> +	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
>> +	if (!err)
>> +		delivered = true;
>> +	else if (err != -ESRCH)
>> +		goto error;
> 
> This call to nlmsg_multicast() consumes skb rather than a clone, so we
> must not free it again here.
Right, good catch.

I will send an update.

Regards,
Nicolas
