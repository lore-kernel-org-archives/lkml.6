Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeBEUq7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:46:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60438 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBEUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:46:51 -0500
Subject: Re: [PATCH] libnvdimm: remove redundant assignment to pointer 'dev'
To: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-nvdimm@lists.01.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180205140852.14110-1-colin.king@canonical.com>
 <20180205182039.GA7891@linux.intel.com>
 <CAPcyv4geaysZ803Xtd27YGh0udww+95VaGP6r1Hdxx8SHxfX9w@mail.gmail.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <22ac2ac7-f75f-3cd0-30d7-8cfe7605c8fb@canonical.com>
Date: Mon, 5 Feb 2018 20:46:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4geaysZ803Xtd27YGh0udww+95VaGP6r1Hdxx8SHxfX9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 18:44, Dan Williams wrote:
> On Mon, Feb 5, 2018 at 10:20 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
>> On Mon, Feb 05, 2018 at 02:08:52PM +0000, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Pointer dev is being assigned a value that is never read, it is being
>>> re-assigned the same value later on, hence the initialization is redundant
>>> and can be removed.
>>>
>>> Cleans up clang warning:
>>> drivers/nvdimm/pfn_devs.c:307:17: warning: Value stored to 'dev' during
>>> its initialization is never read
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>>
>> More importantly this fixes a potential NULL pointer dereference.  nd_pfn
>> is checked for NULL a few lines down, but we would have crashed here trying to
>> get nd_pfn->dev.
>>
> 
> No we wouldn't crash. We're just calculating the address, not
> de-referencing a NULL pointer.

Indeed, it's just a warning clean up. Nothing more.

> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
