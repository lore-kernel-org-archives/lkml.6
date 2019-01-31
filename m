Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FFBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C6A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfAaKEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:04:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37478 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:04:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so2090009edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rbj9ObnD7bSPC8kY3jXSsVZYuUdtw7GwULpldjY+Eo8=;
        b=rwKGwul0JB7c622ANCOlEOsSmS6gPDp6pJMqVt43Et4a1u9uUaBJMlC9yg0igVF/xJ
         k26UrIwXyk3EIPAU4EGajIMBSa48TOjMfh7hCfchqVYSUQ9I5EpD1pul5FWOhTXZFcB1
         y4BWJemW8UXxtkuLSrIejR0ZflAlyUTdQFK3n7LVu8MB0Po3KUHRw5ZQDoZPP2+qhj+A
         R8wPdNLS/81+pT9P2PTjiG/yqDefTDc/txEztgVLb2Q8yjJdIdUR9aQoXV/LQp4anPGz
         x6h0/70M90mOgEfMPnafdzizWbwYCs3q3epvKqyqSfnoTmR6DGYS1eijhlmGsSDhNbvX
         +DYw==
X-Gm-Message-State: AJcUukdkFdx+yFq9w15AWRW990s3ZCKr69Xq3tB7uykoqQQioLY8tf+q
        BpX8nNKX9trcSyi6Wg2JTj+Sspoy90s=
X-Google-Smtp-Source: ALg8bN4Tz23gqVl6QHEZ3IF6b2YVtng/YpmxexifIHF6HhVTmcyZ4cI6InFCUXKHku8j7QwRx0aLkA==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr25607719edy.99.1548929086352;
        Thu, 31 Jan 2019 02:04:46 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x30sm1150212edd.30.2019.01.31.02.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:04:45 -0800 (PST)
Subject: Re: [PATCH 1/8] platform/x86: intel_cht_int33fe: Remove connection
 for the alt mode mux
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
 <CAHp75Vf1w6fOUp968S=5=-3jsG6x6JAcwR=uxzk9eMjXc7H_ZQ@mail.gmail.com>
 <5642f1df-44b5-8293-3ce6-b244f95498ba@redhat.com>
 <20190128152727.GG7262@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c6551374-8954-a940-6805-bceae3ccb543@redhat.com>
Date:   Thu, 31 Jan 2019 11:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128152727.GG7262@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-01-19 16:27, Heikki Krogerus wrote:
> Hi Hans,
> 
> On Mon, Jan 28, 2019 at 11:44:29AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 28-01-19 10:45, Andy Shevchenko wrote:
>>> On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>
>>>> Driver for fusb302 does not support alternate modes, so the
>>>> connection is not really needed for now. Removing that
>>>> connection description allows us to improve the USB Type-C
>>>> mux API.
>>>>
>>>
>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> supposed to go via USB tree.
>>
>> I missed the original posting of this, so let me reply here:
>>
>> Nack to this change, I've a patch-set in the works to
>> make display-port over type-c work with 2 devices with a fusb302
>> mux and that needs this connection.
> 
> I can add the connections back in this series after the API
> modification patches, but should the connections be added back only
> after we actually support the alt mode in the driver?
> 
> Btw. I'm preparing patches where I remove struct tcpc_config
> completely. We can do that by taking advantage of the software fwnodes
> (I'll send the patches RFC to give you an idea what I'm talking about).
> 
> That's related as we don't need struct tcpc_config for anything else
> except for alternate modes (which no driver supports currently) after
> that series, and even with the alt modes, it's only a question of
> supplying DT bindings that define the appropriate device properties.
> 
> Also, as a "heads-up": As I explained in the cover-letter, my plan is
> to take advantage of the software fwnodes also with the connections.
> By adding support for reference handling to the software nodes, we
> don't need to maintain the list of connections as we do today. And
> more importantly, we don't need to match using device names, which is
> always fragile.
> 
> That means we will change the connection registration, actually,
> remove connection registration :-). The connections after that can
> always be described in the fwnode for the device.

I see that you've posted a v2 series now and that you've kept the dev_name
matching for platforms where there are no fwnodes to match on, thanks.

I've just reviewed the v2 series and it looks good to me, I will reply
there.

Regards,

Hans
