Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E80C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBEE213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4pDTdoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBEE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeJLWaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:30:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeJLWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:30:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so13779238wrt.2;
        Fri, 12 Oct 2018 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+25m8OAQfq3OldFgjHiL61Y6Iin+a2XCVTiVJ3fXoFM=;
        b=F4pDTdoGnwQPWh6feiWRyNZ704KM9cJJgUbYddUATo1Wv9ktzIFRYCtldck44MXZOi
         r+XZ3UogdBdw4F69r1YxKOu52bTnUJqEhm8wERyc5OW7r2VkKSiHKtRwDzxXdVhC2zah
         OmwqG2StqpRHQg5EFAVIMyf3CWEZ9fBd+vZKDj8SqF2EIBM6WLjYtvMmB4vQJzPdKX5e
         a5nI4iwbvJ4ppWMWWqOf+Eu+3oS5L1di15sGsu+Ynud6Oz7L4nWWO1e16qLJi+BbKqQZ
         BjE+JfLOLo9fCVK7YFPHCG002k5+CGXEuGwhRfyxK6HJ0tfm9iI+zPJuBMkkxrGL0ZTo
         Dd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+25m8OAQfq3OldFgjHiL61Y6Iin+a2XCVTiVJ3fXoFM=;
        b=KWvAvZy57aoMQ65EvR7iIOlXaVJ2hZovCBfa3HHaCFyGN7ZU+HK68OkVPJrWUsd5Gh
         XpHldbj/jfBpVqHzFefBmJue+9Wwjp820Eoh4098lVRSmNKlLQbZckVSMjgN68eC0dcN
         UrujS6zbINkvXfR+nCzbT+hVnGcbnVaaVWHzantNfUVg7+3dzJu3MulG+aQ2qEgJMv/5
         fuXmzFMJk59avOrdVZZ8qG18Y/rJDpiSSxfKaOTLqa5jhyc2tZgOKraBEcnAzFlYWwcl
         FbNngOzKrxYguVQf3un2V6MXTtEVHdd1CxI80DEWRMwJogxkkxAfszygUBzooNtxh4z8
         xzbg==
X-Gm-Message-State: ABuFfoj1rrw6F1liZuFCPJfggrfW1+fPTzwWBZ7LG2QeYmmF/0WgnjaW
        4jv8tLSEwcDTix3exZBf22g=
X-Google-Smtp-Source: ACcGV63hPV0QQ4JF9yFijRve8283me2bLf75M2i29awGszgOcmD/EUPj33wJGYeKqkAsgIJo+vnFwA==
X-Received: by 2002:adf:ff08:: with SMTP id k8-v6mr5394740wrr.15.1539356241091;
        Fri, 12 Oct 2018 07:57:21 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1233469wmf.15.2018.10.12.07.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:57:20 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <02ae06f0-b6af-7f3e-8ccf-b3d80d7e27b0@gmail.com>
 <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <25990.1539174969@warthog.procyon.org.uk>
 <3205.1539356049@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <0ce47aa9-11df-1aed-a9f2-339311e50aba@gmail.com>
Date:   Fri, 12 Oct 2018 15:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3205.1539356049@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 15:54, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> +	open_tree_clone \
>> +	move_mount \
> I'll rename them to test-XXX if you're okay with that.
>
> David


Yes, that's fine.

Feel free to make adaptations you like.  I don't have anything planned 
for them myself, outside of testing the patch series.

Alan

