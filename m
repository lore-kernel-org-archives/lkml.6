Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966987AbeCAJ3H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:29:07 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53029 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966861AbeCAJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:29:03 -0500
X-Google-Smtp-Source: AG47ELt/IrdqOgA6bV8X3L5+25QCF8HQYt9U9fOrIwz1xtS1PGVwnX9rZBhAQA6KTrtxJAtz6k57Qw==
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
Date: Thu, 1 Mar 2018 11:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228164726.GB16536@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

I still don't understand what this buys us in practice. Seems redundant
to allocate another vector without any (even marginal) difference.
