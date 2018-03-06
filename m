Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbeCFQwZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:52:25 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46323 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeCFQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:52:22 -0500
X-Google-Smtp-Source: AG47ELuBRlm5Cq6PC184yTXPsWBXpHvVafMUN710LJDBrH6DmYDsZi7Gv4x6PVt0w2GiV6vQCQxtL5RiyIkvJuD0Rhs=
MIME-Version: 1.0
In-Reply-To: <20180306040630.GA9905@linux.intel.com>
References: <20180302122049.13900-1-jthumshirn@suse.de> <20180306040630.GA9905@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Mar 2018 08:52:21 -0800
Message-ID: <CAPcyv4giwg1mStkA+7hXnABb8fV6VH2qQPstRfYU26-P56X4ug@mail.gmail.com>
Subject: Re: [PATCH] acpi, nfit: remove redundant __func__ in dev_dbg
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 8:06 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Fri, Mar 02, 2018 at 01:20:49PM +0100, Johannes Thumshirn wrote:
>> Dynamic debug can be instructed to add the function name to the debug
>> output using the +f switch, so there is no need for the nfit module to
>> do it again. If a user decides to add the +f switch for nfit's dynamic
>> debug this results in double prints of the function name like the
>> following:
>>
>> [ 2391.935383] acpi_nfit_ctl: nfit ACPI0012:00: acpi_nfit_ctl:nmem8 cmd: 10: func: 1 input length: 0
>>
>> Thus remove the stray __func__ printing.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>
> Oh, Johannes I noticed that here is one stray one still in
> drivers/acpi/nfit/mce.c.  Do you mind pulling it into your patch to keep the
> drivers/acpi/nfit/* changes together?

I'll fix this locally.
