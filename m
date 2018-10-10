Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDAFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABEF2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXLcAvPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABEF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJJUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:01:44 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38665 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:01:44 -0400
Received: by mail-wm1-f45.google.com with SMTP id 193-v6so5561096wme.3;
        Wed, 10 Oct 2018 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H7V/USDWaBxrT7B/yyXKmDxfLC+6hRQPVCA7Hrv2u+0=;
        b=JXLcAvPt9rPHjoJqLu91zBAHclKqxSF7keVF4u+P38cBRCPVBWkeZxUCfWgRqoJR41
         IMCNwzWQb+0xnvmQfqTslHj2AfxeGASLmZJYE2ax5J+o9rRhMRKzNX5/FdtJzlX1/jkh
         qCuwR8B+Q1+hSuUddX2zxVJ6363EDEEKmHRZtOBNKIIOPLO7o1yYGw1Qg0a2ZPKM+gmo
         OC9McGmw7VvH+GC1CypX8aUOA/dS7Jt3R70nmBM0jO+3LFDdKiwYTQK3hlJ4VpAytnA2
         EtjlKVGEG2IqKU9iqktbKBVOLqOEHnPu39s3UlP0qW+B/Y+Otvx5itpkNPtsgI+N5mhX
         koCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H7V/USDWaBxrT7B/yyXKmDxfLC+6hRQPVCA7Hrv2u+0=;
        b=uDbF2slrEBogq5OHrerWAf8aDQjLJsEQwdKK8lEHq9gypjBaMBzPtTTrMrv757MZRP
         QRMBHl/FtSAUzDfSDWIfLP6Nf3OMZSngwZpYtYpM/Q0qCtHPdqRjw9NQUkJAvZjYN1hn
         WEJaKbV1hoMqPxIwZ9tS3eOQDc6IbTGIuWpv7IX2xAUPBxgYw9/m3WFPho4GH14jGNM6
         MLsM+bISMKBr+fOlJfndT9IlX3QOwZcjlghKPpPj6drXb5yL99r1FnMYRbGOPIbeslZP
         cBWQN3byc8obUyD98+6F+PwD7a5VAKbKx2IZK4jPMP1RWrwbzMHKTho+iunjQ67FFhbS
         XqSA==
X-Gm-Message-State: ABuFfohc9UP5c3zcSqFi+vIV4s/Q+QhG3hV8ZCCjp82QbfIel4NhsuMN
        tm8ah/emscM0LaomChbzSvY=
X-Google-Smtp-Source: ACcGV62sIA96uZYqrzPwRO32JSwliZohTS2ZlhcEJnRwt+eOrjh0UNaKP95y5LGNRpeAGg9LuCd8fA==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr751341wmf.114.1539175182768;
        Wed, 10 Oct 2018 05:39:42 -0700 (PDT)
Received: from [172.16.1.10] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id v76-v6sm26317823wmd.32.2018.10.10.05.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 05:39:41 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <25659.1539174718@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <5db97605-7668-e11d-613a-d3bd99b71532@gmail.com>
Date:   Wed, 10 Oct 2018 13:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <25659.1539174718@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 13:31, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> # mount --move . /mnt
> is this calling move_mount(2) on your system?
>
> David

No. That was an unpatched mount program, from util-linux.

Alan

