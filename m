Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0720C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73037208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Fko++q+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73037208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeFTP2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:28:35 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:39031 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFTP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:28:32 -0400
Received: by mail-pf0-f177.google.com with SMTP id r11-v6so1778177pfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n5Evgzf8t1wwiO5Hgy4rsEVNFCUVL4Ttd3lUd8BA1+8=;
        b=Fko++q+ICkJXY2nFU8WR/+xwTiVrC0K7EbIHwEOIg5KGJvmynuLf2cSizfxGDlrG7w
         6RpPhSAmUzBGxzOImUmEV+PN/AdJn6cbpp9NpzH/SGNZUntKyYGPKCDfQr5a43kUuvLK
         9U7mYiiQ6FBaj2pwQzFi1G68rmbbVgiuW0tsFv4jkWTNCVtzMZCJ18lgF4aIzcJ8xKFY
         DfR5hlhWzEArzophT4a29sIWopD4UkQ0XeJNgMQlEIcAhCJQlSCmHbah/bkAkWvIYSnh
         Xjmb2lUn2xpAFJLrQD+Iubuv0P5OF5GfKjoERg1rXhuzp0zDdIg22q+Zj/uv8dIQhy4K
         O0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n5Evgzf8t1wwiO5Hgy4rsEVNFCUVL4Ttd3lUd8BA1+8=;
        b=V2wfbcSrSarkVdIA+j3G40NfDeOpWS4yF2Kqk+hN7WnxFABXoT9DtpIIi4ZMWDhqTw
         QzX3VGSAd2CMMd0mpzE6v9+qN0OisTIYUSbRKcJzCcfoxEsUYAOlc0ppfKdmEIRGb6wZ
         Ud+kFs0w+KRZFVUAmS3aXvwgllr5e5e3QuWcVsXFpyrd2SoajRAnk+FSj/N2wDa3Kuam
         +A0qsiGW18X6D8BrryKv5GOl1xps3nt/dJdTGezBBhGvEkZV0U0Q90gloBt/8jVs0SOQ
         btsAUO1fLM3GqLfom06UyJhDodbe98AgXuvJw9Grn/Q9lhKNyVWems3kV9dlrBERuva9
         vl0g==
X-Gm-Message-State: APt69E1gcnJqkkzk6AFKTC9Kp12Chzqbk+mMYWUxcFaJE0H7uawpErto
        ZRGOqEHPZI44p9AJ8mkJKM/zXA==
X-Google-Smtp-Source: ADUXVKLvBZPsOUWPAFRZyUfyK5AvoEjs+OD3h5yfhRJjbpJay2L/vNtIjqvMEnKp50lik9EeZUFmeg==
X-Received: by 2002:a62:a104:: with SMTP id b4-v6mr23534086pff.159.1529508511359;
        Wed, 20 Jun 2018 08:28:31 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id z12-v6sm3406439pgu.57.2018.06.20.08.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:28:30 -0700 (PDT)
Subject: Re: overlayfs: caller_credentials option bypass creator_cred
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
References: <20180618154222.19279-1-salyzyn@android.com>
 <20180618185448.GA8749@redhat.com>
 <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
 <20180618194345.GA15973@redhat.com>
 <aecdeaca-74cf-54b1-3ea9-4751972074f5@android.com>
 <20180619143617.GC22657@redhat.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <d8e6c8ce-6305-67d8-6213-5460e5d0d88c@android.com>
Date:   Wed, 20 Jun 2018 08:28:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180619143617.GC22657@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 07:36 AM, Vivek Goyal wrote:
> On Mon, Jun 18, 2018 at 02:59:50PM -0700, Mark Salyzyn wrote:
> So in this system all callers are priviliged and have the capability to
> mknod and set trusted xattrs.
This is true of the callers that make adjustments (in Android's Case 
this is an su context provided to the adb tool for sync and push). More 
importantly the large variety of callers have the passive/read MAC 
credentials for their domain set of files; where the mounter/creator 
does not.
>   (Amir mentioned the reason why we switch
> creds). If not, then file unlink (Should do mknod), lower non-empty directory
> rename (should set trusted REDIRECT) and bunch of other operations should fail.

Hmmm, neither was part of my test plan b/c these operations are more 
esoteric for development ... need to add them and address them.

Thanks all (You, Eric, Amir and private) for your comments, will 
regroup, test and address concerns!

-- Mark
