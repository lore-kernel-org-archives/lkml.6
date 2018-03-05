Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeCESMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:12:22 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46065 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCESMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:12:21 -0500
X-Google-Smtp-Source: AG47ELsO/QUlJZo2WGE50+rRQWLVoPMyHuTI1S6ymnOQ6En9xyjwAjprvuAxR1FKnJscqFuKkB0rgbfrW4UTI5G5Q98=
MIME-Version: 1.0
In-Reply-To: <20180305180126.GB19268@linux.intel.com>
References: <20180302122049.13900-1-jthumshirn@suse.de> <20180305174920.GA19268@linux.intel.com>
 <CAPcyv4juD2m-4e7=uCy7P-retsTpWXJzVmO9fFcVbMcN_E=BXA@mail.gmail.com> <20180305180126.GB19268@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Mar 2018 10:12:20 -0800
Message-ID: <CAPcyv4gcpKa1JDcCUiz2eYhfsw3HRZRYpEHFiF6b4OxfsgXNAQ@mail.gmail.com>
Subject: Re: [PATCH] acpi, nfit: remove redundant __func__ in dev_dbg
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 10:01 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Mon, Mar 05, 2018 at 09:53:47AM -0800, Dan Williams wrote:
>> On Mon, Mar 5, 2018 at 9:49 AM, Ross Zwisler
>> <ross.zwisler@linux.intel.com> wrote:
>> > On Fri, Mar 02, 2018 at 01:20:49PM +0100, Johannes Thumshirn wrote:
>> >> Dynamic debug can be instructed to add the function name to the debug
>> >> output using the +f switch, so there is no need for the nfit module to
>> >> do it again. If a user decides to add the +f switch for nfit's dynamic
>> >> debug this results in double prints of the function name like the
>> >> following:
>> >>
>> >> [ 2391.935383] acpi_nfit_ctl: nfit ACPI0012:00: acpi_nfit_ctl:nmem8 cmd: 10: func: 1 input length: 0
>> >>
>> >> Thus remove the stray __func__ printing.
>> >>
>> >> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> >
>> > This makes sense to me, but I guess we'll see what Dan thinks.  If we decide
>> > to go this route we may also want to do the same to all the instances of this
>> > pattern in the libnvdimm debug output.
>>
>> Is there a way to turn on this '+f' flag from the kernel boot command
>> line? My primary debug scenario is specifying "libnvdimm.dyndbg
>> nfit.dyndbg" on the command line.
>
> Yep, it's just:
>
> libnvdimm.dyndbg="+fp"

Works for me, lets change this everywhere.
