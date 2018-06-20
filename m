Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DAC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D91920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkYzBzse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D91920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbeFTQkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:40:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40436 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeFTQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:40:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id g18-v6so190459wro.7;
        Wed, 20 Jun 2018 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lIRLwoDYvUIhb7UdPPBBQwwgZ7alj2yOMNic2Z8nIb8=;
        b=MkYzBzsei5AmZZUxM/Uxs1Xbd+iUNfTmHdzd44GVA0g29IiYyMVB8zhVxJScIl+eVR
         /le+7FXBZ+irf6X+Aai7I8YfXorFlSV/BOPqX0v3y9c5RXCtJmQJMkPJ2IrHVc9OQTfB
         LjXfWVGuVrk9rJqAMYUoXkMw3Qz3zZCGUR4yTjtzIGyf4EZCKpa09ss2yk6pFDChcs3C
         AtHW8XGWZGroZTIzBXkNBmTjNs05qTAHNYojaDZ8sB55I3dZCoUatFdlKcchQHS2kubr
         VXZ3ex3bYyH2Ez9QZHs4J7RLtGeb//qBcqx1I2rYTOl/FOE65xGo6dWY6tTCymFh9usc
         /Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lIRLwoDYvUIhb7UdPPBBQwwgZ7alj2yOMNic2Z8nIb8=;
        b=jWktUuV41KU/gKyXbl+Ii+ycQy3HAJ3l0TseG+tumUNFkAG5muNFaYIbHp1XlUaeiD
         qdCwPRADpbkvpNI383B/pyUHbMmrhyKeMpg64LazPVihmxQZoBPRcQuzwLquCNnpiRGI
         bNvyZ/gLQqfLgIJrYBxrQ6y5TMnExrLYhXz+qlAHQmJUfGbhQTvmMHdTJhMJfIeN/KvF
         pxEitwIO8NPsxe3bSTG0wfV59r2j3EDhP4dz0sN6ii9fxVX1b1q7bz89bGQhWlKJB6j1
         XWyWS+FNRExbD6EIOkXjYZ+MIaujc3FgaeEAV+kLDp1QIdcdzsJjCg8K5s7OcMzTE5Us
         5vPQ==
X-Gm-Message-State: APt69E2GBSf7WHZ3OMeu10RHHQY055JFF4Ah+pLroV19gSPOBhzI0C/h
        Dw0HE4SzjBi4EdTq1nAf5hU=
X-Google-Smtp-Source: ADUXVKKHujra10SxJ6zQTOidPt8FMTTQhg0BavWFggSYnRVtLqVkCVlv3hatE3R7RPJOo0vqasGzXQ==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr18750726wrf.206.1529512841931;
        Wed, 20 Jun 2018 09:40:41 -0700 (PDT)
Received: from [10.0.0.26] (45.179.189.80.dyn.plus.net. [80.189.179.45])
        by smtp.gmail.com with ESMTPSA id w126-v6sm3651426wmw.29.2018.06.20.09.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 09:40:40 -0700 (PDT)
Subject: Re: [PATCH] [Bug 16494] NFS client over TCP hangs due to packet loss
To:     Joe Perches <joe@perches.com>,
        'Trond Myklebust' <Trond.Myklebust@netapp.com>
Cc:     'Andrew Morton' <akpm@linux-foundation.org>,
        'David Miller' <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
        kaber@trash.net, eric.dumazet@gmail.com,
        William.Allen.Simpson@gmail.com, gilad@codefidence.com,
        ilpo.jarvinen@helsinki.fi, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        'Neil Brown' <neilb@suse.de>,
        'Chuck Lever' <chuck.lever@oracle.com>,
        'Benny Halevy' <bhalevy@panasas.com>,
        'Alexandros Batsakis' <batsakis@netapp.com>,
        Andy Chittenden <andyc@bluearc.com>
References: <4c57cfe8.887b0e0a.2f79.4772@mx.google.com>
 <20100803.012144.267950450.davem@davemloft.net>
 <20100803021110.f0b3877b.akpm@linux-foundation.org>
 <4C57EE9A.7040308@gmail.com> <4c5ad0d6.42ecd80a.47d7.0dfc@mx.google.com>
 <1281037822.2948.49.camel@heimdal.trondhjem.org>
 <4c5bd64a.4a2ae30a.0283.0551@mx.google.com>
 <4c5fc9f3.487e0e0a.2960.ffffe4ec@mx.google.com>
 <0dead6e0deabafe0abdd4b30f97bcdf5c12cd824.camel@perches.com>
From:   Andy C <andyc.bluearc@gmail.com>
Message-ID: <bac42441-07c8-bb94-7559-94f9047654fa@gmail.com>
Date:   Wed, 20 Jun 2018 17:40:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0dead6e0deabafe0abdd4b30f97bcdf5c12cd824.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Antivirus: Avast (VPS 180620-2, 20/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-19 22:56, Joe Perches wrote:
> On Mon, 2010-08-09 at 10:27 +0100, Andy Chittenden wrote:
>
> You really need to check your clock.
> Mail sent in the year 2010?
>
I didn't send it just now. I sent it on 2010-08-09 at 10:27. And I did 
receive a copy at that time. If I'm reading the headers correctly, 
something happened here:

Received: from mchehab by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
	id 1fVNCq-0005da-3g; Tue, 19 Jun 2018 20:26:24 +0000
Received: from vger.kernel.org ([209.132.180.67])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OiOdm-0004za-Ks; Mon, 09 Aug 2010 09:27:30 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0HIJ1U (ORCPT <rfc822;tgraf@infradead.org> + 8 others);
	Mon, 9 Aug 2010 05:27:20 -0400

-- 
Andy

