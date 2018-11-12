Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2326C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605220862
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A605220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeKLMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:15:40 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:46776 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKLMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:15:40 -0500
Received: by mail-qk1-f171.google.com with SMTP id q1so10963883qkf.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 18:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vAAG+j4tOWw+NtYA9joKtj9X/01COWc+LXRYPIryUbk=;
        b=rbUszM99TbIDbpUj7oRKODdXcwstXXGFW2G++4MPiF1eNi/luc2CQY4MZDDs2uAuzW
         WssA5NAw+8cuDdbgvWnRtKZgrBhKqMTVqeoTeGAwUs3vC4sYip6fh5Rk5gUbWGE7JkQR
         4RXFqeMF1K/syfucjNYpB9tw2CqAiprIUGz+EzUnrWrE9FbJQAfBVdK6FW+RW6OjpuRh
         4Ef5zma2LwlkxqnvxKK1wPBq+ImNdt0HTEpRc5op4PztiIpXdXvYgfNQ9w4DJDRe62Ed
         G+8R5GiRE4P5U5YKGU7mfq3tCQMok5AErg7XA/A2IkRzi0zOXMSrWW9LiIMqBI8shrBB
         u/3g==
X-Gm-Message-State: AGRZ1gJlIFuiuL2cyAgU5oj+TwGdTEyw6edgYeRE/jBIKvAfOMctKT3J
        M/a6NUGV98YnPKVdcszDgvAjWg==
X-Google-Smtp-Source: AJdET5cnYy6oGex0BtKgcj+AKDk2ql+hw+hOP3tCMa25vfSnqgtaMgKwLflTHGPVy2slHj5CW52cZw==
X-Received: by 2002:a37:b842:: with SMTP id i63mr3051195qkf.69.1541989483020;
        Sun, 11 Nov 2018 18:24:43 -0800 (PST)
Received: from [10.150.73.190] (97.sub-174-227-17.myvzw.com. [174.227.17.97])
        by smtp.gmail.com with ESMTPSA id m5sm4355044qtn.33.2018.11.11.18.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 18:24:42 -0800 (PST)
Subject: Re: Official Linux system wrapper library?
To:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
From:   Carlos O'Donell <carlos@redhat.com>
Openpgp: preference=signencrypt
Organization: Red Hat
Message-ID: <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
Date:   Sun, 11 Nov 2018 21:24:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110192027.GA29892@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 2:20 PM, Greg KH wrote:
> Also, what about the basic work of making sure our uapi header files can
> actually be used untouched by a libc?  That isn't the case these days as
> the bionic maintainers like to keep reminding me.  That might be a good
> thing to do _before_ trying to add new things like syscall wrappers.
I agree completely. There are many steps in the checklist to writing
a new syscall, heck we should probably have a checklist!

Socially the issue is difficult because the various communities only
marginally share the same network of developers, care about different
features, or the same features with different priorities.

That doesn't mean we shouldn't try to integrate better. As was pointed
out, various people from the userspace and toolchain communities are
going to LPC to do just this.

-- 
Cheers,
Carlos.
