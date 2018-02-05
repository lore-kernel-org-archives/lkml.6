Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeBESoV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:44:21 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46717 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeBESoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:44:08 -0500
X-Google-Smtp-Source: AH8x227J4gpR1AhN83H8RTV16fwidZXI6UbyShMIXaqFUDeAha1pL8lNodsTydIT7PR5DE6XFWQo3Om3CC1J/s+a/Po=
MIME-Version: 1.0
In-Reply-To: <20180205182039.GA7891@linux.intel.com>
References: <20180205140852.14110-1-colin.king@canonical.com> <20180205182039.GA7891@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Feb 2018 10:44:07 -0800
Message-ID: <CAPcyv4geaysZ803Xtd27YGh0udww+95VaGP6r1Hdxx8SHxfX9w@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: remove redundant assignment to pointer 'dev'
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Colin King <colin.king@canonical.com>, linux-nvdimm@lists.01.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:20 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Mon, Feb 05, 2018 at 02:08:52PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Pointer dev is being assigned a value that is never read, it is being
>> re-assigned the same value later on, hence the initialization is redundant
>> and can be removed.
>>
>> Cleans up clang warning:
>> drivers/nvdimm/pfn_devs.c:307:17: warning: Value stored to 'dev' during
>> its initialization is never read
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>
> More importantly this fixes a potential NULL pointer dereference.  nd_pfn
> is checked for NULL a few lines down, but we would have crashed here trying to
> get nd_pfn->dev.
>

No we wouldn't crash. We're just calculating the address, not
de-referencing a NULL pointer.
