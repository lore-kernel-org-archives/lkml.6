Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-782846-1520609916-2-8279987459336645692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520609916; b=s6xLSeLDTuHwJ/8Nz1+HzpJEV9xRlmieYQWyEX2qEjMokts
    jZNdjkTWuRf2iboyhk+kPVIJ+g9CG4jOcbWicDIsxSDcbcmybkhX/PoWJwnbQzb5
    HBSOVmea8Pe7oq9bbHDt7trrfhxX7IAHLWBhQXzZhifARJ6dIir4kfR+zkO47kJc
    G8i2eh1wnleiMackAneNEci6YctqclzzaWVYmERt2b1NIiyb4tomgfdYT5HGP1Qo
    XC67KAB9lbPQxEQkfEzmEHiU8rUWSsh27eBSnuFa9L2YaBHOI+8nMBt7G6Azb8hv
    MW/KD1e2y4w6uWmFWxRGFnOH9OyquH2JZBeWjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520609916; bh=ZJhVJtZt32y2K+CH09n675gUG6Vzt/Su2NqJBBkzKB8=; b=g
    sY66O/+ETRQzXILosoDXIOVZKbct46BdknYV4/KxXtRn5HfxpQ/CafKwvWb7mAyG
    MkOeS1dYpgrF+LUvuL+JKNF/Z6pUfFxnSi1OZSGpdWhAcscd9KUqXh2fFYBxEcsE
    IqsiNgJibFMtlTuaJMaWSqA/raQthRTSl1RiGQL54AysHQryT+05x8mpuxUJmh3R
    3dJI7QwtSsaHoycGzFeqsBZyuvFMr7dQ5qXo+5mqBpMIBGYmz6Gd4MdWFYzawusY
    cJkT6Pco8LrcvhD2o5mMSwdldUlg81qt8OM1xCufiWHZVEewgTXouLW2i2kLwYUZ
    Wd97MW5QPXDDR2DWPFtFw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=RMOB1gLj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ePYkwYff;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=RMOB1gLj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ePYkwYff;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIPiW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:38:22 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:44309 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeCIPiW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 10:38:22 -0500
X-Google-Smtp-Source: AG47ELv+mUHOKhd4634Gb4yx6oWEnf/LF//VS8bhAyWNTbXPhJA04PIncsC/2mYVV7S0UxebGV0JaQ==
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180309002048.GA22835@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <81204608-a436-c16b-6846-947573e6ee3c@kernel.dk>
Date: Fri, 9 Mar 2018 08:38:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180309002048.GA22835@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/8/18 5:20 PM, Ross Zwisler wrote:
> This has gotten Reviewed-by tags from Christoph and Ming Lei.
> 
> Al, are you the right person to merge this?  Or is the correct person Jens,
> whom I accidentally didn't include when I sent this out?
> 
> Just wanted to make sure this got merged, and to see whether it was targeting
> v4.16 or v4.17.

I'm the right guy, but I don't see patches if I'm not cc'ed on them...
I have queued this up for 4.16, thanks.

-- 
Jens Axboe
