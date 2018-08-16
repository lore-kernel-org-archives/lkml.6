Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59712C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7121470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE7121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403887AbeHPQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:35:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32968 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbeHPQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:35:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id z78-v6so1455229qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 06:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOu+4bREw0jn3x9PH3U5OMPynu9OlfDCuJH/bYMq9kg=;
        b=Pxp17B2QVHJCURYSraBNibZGSZM3hBkIsFOQKgm2RaVhVltmvb2Q8XFeVLwgYyqYOd
         SnIwLwImKZJ0vRVCD5GDe634Jp1bR80vIcbWahDxCtEzJO7pD0cJmI+AFGUZlRBxc02l
         dkQ8ikiNF4XafjnaKm2x+uRBWh7b9gvYQE0QK8KfW3ai4qP27MW3NkVM3YayaWnga0/O
         Z/GvjyeJR9i6wSbc/a70nEJsxFzKIvT23S3tGAsPm8mCRA/R5OeuCbA5S0L7yujb20Il
         UPrKEYjJuZ17R9AwCY8ZX7o6p5v5utUrwFO9WkrC2o/5ImI9Ap2dqhKo9pByYTuisS2T
         WOiw==
X-Gm-Message-State: AOUpUlHl1qRxT7JSiZNm81/IUGPXJDRY6baTr9NNKoOKYPcpQ2So/AhE
        Dm0Xjtd4hpIxUc3HEq9CLRPsldYKph4=
X-Google-Smtp-Source: AA+uWPxsYoM9K9G411RFxlkXL9n5XtQAQnjv75MOXBV31wqzGROfqB3TWlVPqeiIgTxYnMKPoxssZA==
X-Received: by 2002:ae9:e817:: with SMTP id a23-v6mr27647321qkg.213.1534426589623;
        Thu, 16 Aug 2018 06:36:29 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::8a8f? ([2601:602:9802:a8dc::8a8f])
        by smtp.gmail.com with ESMTPSA id x26-v6sm17745071qth.15.2018.08.16.06.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 06:36:28 -0700 (PDT)
Subject: Re: Kernel lockdown patch & IPAddressAllow/IPAddressDeny systemd
 feature with Secure Boot
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org,
        Laura Abbott <labbott@fedoraproject.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Fedora <kernel@lists.fedoraproject.org>,
        daniel@iogearbox.net
References: <20180807212531.25161.63476@mailman01.phx2.fedoraproject.org>
 <CALeDE9ORLoyiUcf8Bmwr2rPyo7-3d8Fo54WuPGWtv4ByE_JG=Q@mail.gmail.com>
 <CAObL_7GOOQ01NPf4y1MqRJh4S=CYV8NPmEGTbkrTcjrfUKc5LA@mail.gmail.com>
 <20180816021037.6yxi5rqolhqxipza@ast-mbp.dhcp.thefacebook.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <17c09f82-a32d-fc3b-042b-c44c366f873c@redhat.com>
Date:   Thu, 16 Aug 2018 06:36:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180816021037.6yxi5rqolhqxipza@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 07:10 PM, Alexei Starovoitov wrote:
> On Tue, Aug 14, 2018 at 07:14:00AM -0700, Andrew Lutomirski wrote:
>> [Removed Fedora devel list because it's subscriber-only]
>>
>>> On Aug 8, 2018, at 12:29 AM, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>
>>> Probably a good idea to cc: this to the kernel list :-)
>>>
>>> I suspect it's intentional but with the planned changes for iptables
>>> etc to be backed by bpf in the upstream kernel sometime in the future
>>> it's likely going to need to be reviewed.
>>>
>>
>> I thought this got covered in review. I think this part of lockdown
>> needs to get reverted or fixed ASAP.
> 
> I don't see lockdown in Linus's tree. Is this fedora only issue?
> 

The entire lockdown/secure boot series is out of tree at the moment.
We're working to get it included.  If you search LWN, you
can find some articles explaining the long saga of the patch series.

>> (I definitely brought up multiple issues with the bpf lockdown stuff.
>> It's clearly extremely broken right now in the "new kernel breaks
>> *current* Linux distro" sense.)
> 
> +1
> 

Yes, we need to review what exactly is in Fedora. It's the merge
window so this is a good time to do that anyway. We're still
playing catch up after Flock in Dresden last week. Can you file
a bugzilla for tracking so we don't forget?

Thanks,
Laura
