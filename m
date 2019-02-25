Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC09C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FA120663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBlcBKvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfBYNY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:24:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40276 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBYNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:24:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so1049892lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jrYEnf6XxMFCzICo/6yWxmzeFv7wcmwC2PqW/8qzTlw=;
        b=eBlcBKvKNgg3uTwALGtyDohhmoyND2FVB/+tIAWEBCrMRaOAj4X/s2zUZiXSPF0GpG
         fzRZ6llqqG+IOCUVNmiiK1gyFHte9YZcZ1Kf9jH8zRttSLuuLj5qriNEXcxebrBnFmhp
         0ci783Cjb5hPwudkpiau4/cVfxIJi+N7bICe74CicM7FFvcYdJ/9sgYCNB97q/pOVeon
         6PIYA8X2negtFBhaK8Upq+DQAtdtee9XM1xZqRCgGft+E/klRKFndafrQwPNooidtP9J
         OtrkPoZChL/9iaR+KRAsm/Y2QLsbwV2y+E2apZsFmwb8NvcWv4QtZ+5nxlp2Py68jJxX
         cN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jrYEnf6XxMFCzICo/6yWxmzeFv7wcmwC2PqW/8qzTlw=;
        b=BSdSHq7jtbEC2DH3zLqRwc5xBBxng/iwiQ8qbKpH31Z4kT7oNJvEAJw5wZ5Ts62HOn
         m2buEPRvr6S10DGfLrVaL5LHM9qwDsYknUQXGozQWmM3zqw36SKQ8X+WCZNGY62Kjomb
         4BW54nZFdStKxp5zDV35YbpsOKxFaedPYhgP5T94OSsFsdvzxdwAj+RikQRa9GIUeK0D
         lKcicppb7YIB2ky1kJqbqBAtxINSUwazUrJG4yd9Q7GMydLTR/RsYGjVz0itM3DZw2A/
         /x2ECZWvTaJIbhH2XPWrdgt4m7I8MDIcMH9cNTpMTyVVv0/QiObrExBuqtJIRzX7LVzg
         Rc+A==
X-Gm-Message-State: AHQUAuZIVO6n4g1A9a3Ic52O/mM0NBeNKYS2vgRxUOROQO3sNCQ0KMmB
        0tSXNHqOJZxAWiUPLtb5QA4=
X-Google-Smtp-Source: AHgI3Ib57+2NkZ/6YFbCU7xHqI39u5IL1IzmmdiwRG/L3uI+hGP4IHi1PQkfUJgPofFplL+GCaKXFw==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr10941493lfk.24.1551101065828;
        Mon, 25 Feb 2019 05:24:25 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id o14sm2425534lfl.41.2019.02.25.05.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 05:24:25 -0800 (PST)
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
To:     Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <dave.martin@arm.com>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
Date:   Mon, 25 Feb 2019 15:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 3:33 PM, Julien Grall wrote:
> Hi,
>
> On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
>> On 2/20/19 10:46 PM, Julien Grall wrote:
>>> Discussing with my team, a solution that came up would be to 
>>> introduce one atomic field per event to record the number of event 
>>> received. I will explore that solution tomorrow.
>> How will this help if events have some payload?
>
> What payload? The event channel does not carry any payload. It only 
> notify you that something happen. Then this is up to the user to 
> decide what to you with it.
Sorry, I was probably not precise enough. I mean that an event might have
associated payload in the ring buffer, for example [1]. So, counting events
may help somehow, but the ring's data may still be lost
>
> Cheers,
>
[1] 
https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/include/public/io/displif.h;h=cc5de9cb1f35dedc99c866d73d086b19e496852a;hb=HEAD#l756
