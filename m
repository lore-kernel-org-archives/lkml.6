Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CC320867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id2mx2Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CC320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeIDUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:53:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34743 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:53:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so1884318plo.1;
        Tue, 04 Sep 2018 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QLnSyS5PYHOxMceUou69NqqmbLj7+jEB3nvbBFDETrY=;
        b=Id2mx2Dagjyrkes1MNR7bg5K71M2sj92DEdh4zVeDhu8msHbQ+9p9S7Eonh5t2o9lw
         51j2j6ZITjGEk5E9D8jsQC3lUYdFrrtKyNNe+kWTTtynZLYgpiQwEtAX23wNOc65M7GQ
         vEZPK03VHYjr7hHU1F9e8j6VF/N1v6YwYIEG11ls5/3rO2pWRuxV6AvCBSNl7JPv1+oq
         hilKiduVOKIH7HQkmCHhRB72g7PQc5QuH9r9DtWSZvymxvevgz05+vSkJKToo6njg1SU
         /QkW2c6GWo6iYl0sFdPI7FHQ9Ap781e9XXBvc4ItXIgP0XKTSK1/wamCUjiEkpOWxXbT
         3D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLnSyS5PYHOxMceUou69NqqmbLj7+jEB3nvbBFDETrY=;
        b=pH3hy6ZyW8xRA0sUQjm2ThWQIcBzCCmv5lWkKi/xny42dfz7WH3YPJjl7rmSODKNHZ
         BGPgxQC788YtNQzha4VODiQnATihsRZfNwRIEvHTZI+r11rSEay2JkvI4/eCgW6mzH2V
         sSte6aeTSjw5mI3KVAOfXH1/bNfi+l0H74Xb2unGg+oVbiVrel97DtkQiXZEM5n+26xB
         avGSFnhqU+c1pe68DXsJGR9QUnrkVfcVYYNp7A+6Rh9zvJCsBMbELsqbif+DrtsOpwOW
         rTznMPrImcV2a/dzavNpoCNXqqAw5za5P6Vu9dUJVfXHs8DQeepgm90xWXXzc0tptM0e
         Ze6g==
X-Gm-Message-State: APzg51AGF7QUOYxmeCIcH5lpuauOSL5eMYzk4qg5e9KvjaHQGORlYee8
        8fgh8Ln9YE2hZZjIXbRFNfc=
X-Google-Smtp-Source: ANB0VdYHOxuHMfO5X9VzmxP30KhaklFHMy0Oh5GM3nkm8rUrC9EQ+lddEB6NJ9aDFShd/f7abaxH9g==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr33742522plp.14.1536078474280;
        Tue, 04 Sep 2018 09:27:54 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:1145:f235:fa5f:50ca])
        by smtp.googlemail.com with ESMTPSA id b21-v6sm58132729pfm.97.2018.09.04.09.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:27:53 -0700 (PDT)
Subject: Re: [PATCH net-next v1 3/5] ipv4: enable IFA_IF_NETNSID for
 RTM_GETADDR
To:     Jiri Benc <jbenc@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, fw@strlen.de, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        nicolas.dichtel@6wind.com
References: <20180903043717.20136-1-christian@brauner.io>
 <20180903043717.20136-4-christian@brauner.io>
 <a4282d46-4c17-b395-dec0-7c8ac10cbf97@gmail.com>
 <20180904085006.58c665c0@redhat.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <8f0aa154-1ba9-5659-cbe3-19da4196fae0@gmail.com>
Date:   Tue, 4 Sep 2018 10:27:51 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904085006.58c665c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 12:50 AM, Jiri Benc wrote:
> 
> This is a general problem with netlink: unknown attributes are ignored.
> We need a way to detect that certain attribute was understood by the
> kernel or was not. And it needs to work retroactively, i.e. the
> application has to be able to determine the currently running kernel
> does not support the feature (because it's too old).

sure, and that has been discussed before.

> 
> That's why we return back the attribute in responses to a request with
> IFLA_IF_NETNSID present and why we should do the same for
> IFA_IF_NETNSID.
> 
>> See 21fdd092acc7e. I would like to see other filters added for addresses
>> in the same release this gets used. The only one that comes to mind for
>> addresses is to only return addresses for devices with master device
>> index N (same intent as 21fdd092acc7e for neighbors).
> 
> I also question the statement that IFA_F_NETNSID is a filter: my
> understanding of "filter" is something that limits the output to a
> certain subset. I.e., unfiltered results always contain everything that
> is in a filtered result. While with IFA_F_NETNSID, we get a completely
> different set of data. Does that really constitute a filter? Note that
> we can still filter in the target netns.
> 

I'll buy that argument over the 'too coarse' one. Looking at the link
version of this flag, the NLM_F_DUMP_FILTERED flag is not used there so
for consistency the address one should follow suit.
