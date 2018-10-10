Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F93C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AF02087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcRhuY/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AF02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJKBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:43:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34485 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:43:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so14018717wmf.1;
        Wed, 10 Oct 2018 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSBZZPVn14NZ7CjrqM7WrO/ay6lnPnb9WLyMAZg6XLA=;
        b=PcRhuY/cCygYAiepH8DuofMrs65wXahwTZVjoIbtV79g+vIZ2IGaLI0QG+c+MPKPUL
         GFDUToFlgYpjvqf0UYqSj8a8VP4T9iWOhXry4aXZW/UBw9S1XIq+D+c4H3Swc/cSdRds
         EoCh3PIiEcCe1UU6qP1FgGMUos4inmB2dYn2dnbzu9gZjCWgSpp+SVZCNJPKYtwryjh2
         T/JKp1OndNlNhnf/MQ2sK8+EtmWjuhFaXn9RH5EofeDteKbVIlQRbz+SO9y18t1oWxDc
         6Xd5YNzr9aeNjtdPpjQ5gBhlGkP2iByiN2F4E28FP3dPDq/MA4JznX34opIrJAHIZNOu
         g4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VSBZZPVn14NZ7CjrqM7WrO/ay6lnPnb9WLyMAZg6XLA=;
        b=Gl9EkW/SvRYWm48Lyp5CjGm5v6iP5dNDFS3WmawX2jmzQz+w1Wiq0nXl29k4sYK/WU
         gf8i+6/8ruo/RBTECDuTYq8OUZ6XGOFDnW3d7AEfBX+IzYN1/8AdJHqw6ulwZ0sIB4Kk
         3RArTuFVyYywk+t0D/O9O2b7g5dHbWcCCdOdiYTyJCCjIck7TajVeo6r7iQvZRWZtygb
         Vn55XCXQmrN0PEim025d0cPIl2Hk5relputv0NmryjL2wqZmAbgJ3v+7GfWWmpWQYnxN
         XthBQkcntBr6taFF5PGUuZHIcFemUVjW2KzLXPNnXd/zSCMzdxN/k9m1O1sXOWqZ0ciz
         b0rw==
X-Gm-Message-State: ABuFfoh9lMFQJHiNjdPWy2ytMJSYjGWtDFlHUwznZjKDvLymt7xqDTdO
        iiVCbFrT2uzBiokC4ZErMyI=
X-Google-Smtp-Source: ACcGV638YhXnf5qd1/31JrGn+2keUdnopp1nMXDQUP1ddwFWlKTu3Iha3gYgNNXniWyfUa+I5SOjgw==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr1765939wma.69.1539195599535;
        Wed, 10 Oct 2018 11:19:59 -0700 (PDT)
Received: from [192.168.2.28] (218.83.broadband9.iol.cz. [90.176.83.218])
        by smtp.gmail.com with ESMTPSA id z8-v6sm18184649wrr.67.2018.10.10.11.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 11:19:59 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] tty: erase buffers when the kernel is done with
 it.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu,
        Daniel Zatovic <daniel.zatovic@gmail.com>
References: <20181004180614.25619-1-gregkh@linuxfoundation.org>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
Date:   Wed, 10 Oct 2018 20:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 20:06, Greg Kroah-Hartman wrote:
> azlig and Milan Broz reported that when the tty layer is done with a
> buffer, the data can hang around in it for a very long time.  That
> sometimes can "leak" to userspace under some conditions.
> 
> Because of this, just zero out the data after the tty layer is finished
> with it, for buffers that we "think" should be zeroed out.
> 
> v2 - addressed some review comments on the 2/2 patch.

Hello Greg,

together with our intern we re-tested both patches and it fixes the reported problem,
so, if it helps anything, you can add

Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>

Do you plan to add this to linux-next?

Thanks!
Milan

> 
> Greg Kroah-Hartman (1):
>   tty: wipe buffer if not echoing data
> 
> Linus Torvalds (1):
>   tty: wipe buffer.
> 
>  drivers/tty/n_tty.c      | 20 +++++++++++++++++---
>  drivers/tty/tty_buffer.c |  6 +++++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
