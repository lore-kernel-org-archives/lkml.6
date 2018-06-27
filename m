Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768C6264C6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768C6264C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbeF0IGa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:06:30 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:39078 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933046AbeF0IGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:06:25 -0400
Received: by mail-wm0-f44.google.com with SMTP id p11-v6so4369797wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 01:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liAyNLmSHZHJq+z2HHBCf0yf4rjWhKNPqK5SDddcrUk=;
        b=gQ0IMnISobtP8tq/v+4aNFfbDFK6aovU65hgI3JACTrBianMDnrqDF79QkciL0j/FS
         T83uLdHe1WIHKqusaEeSX1JW6//wkV8eCFGZUMs/CwXZTc2sAw6JJGoPeeZ2XworQIyF
         a0Bavw+i+3hH3EyQMysvzwK2vSR9895EcjlIbPGNkyTPGm7WDzZeforxzSiQcJnk5dlm
         FYLw4Nu5MeLQ2WHUtb3XOnQWe0UpuGe+NEcg6hfgbynmX/2JWH7Rf8gODNoiw5oGtrlp
         uIHIDpAqX515+rEV3fGc0RlVqPTiyOQwlJ+Jhw4b7SeBJYdEmCvT6jHYU3gI8F27n0jT
         cvLQ==
X-Gm-Message-State: APt69E3cqZkDN1c0yCBZM2Mb6PUChanxkKrpN//hIR+WBirChKlmr1MD
        badtPAb0eIB0W2xzg257byo=
X-Google-Smtp-Source: AAOMgpcXYKYAmVJl/tZ140bXbpgmUgqkRCkR3LXa84+kueh7eTltkP3N0FZ7eoJZqgFufwGf9/Ezcg==
X-Received: by 2002:a1c:338c:: with SMTP id z134-v6mr4186726wmz.93.1530086784252;
        Wed, 27 Jun 2018 01:06:24 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e17-v6sm1147399wrr.85.2018.06.27.01.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 01:06:23 -0700 (PDT)
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@linux.intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
Date:   Wed, 27 Jun 2018 11:06:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627073328.aws2apvc357jobge@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Not related to your patch, but I did notice that the req->q->id isn't
>> really useful here since that's not the hardware context identifier.
>> That's just some ida assigned software identifier. For the admin command
>> completion trace, it's actually a little confusing to see the qid in the
>> trace.
> 
> It was actually requested by Martin so we can easily see which request
> got dispatched/completed on which request queue.

Would be good in the future to display the hwqid, but we'll need to work
before we can do that.

Maybe change the display to request_queue_id=%d?
