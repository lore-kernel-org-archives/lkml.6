Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935272AbeBMNRl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:17:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935175AbeBMNRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:17:40 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
        "Zwisler\, Ross" <ross.zwisler@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
References: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
        <x49inb1n7kb.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4gt88pEivOyEGdYbTx9H2LV7+mQQ9H1ESWhzM+gpbtW0g@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Tue, 13 Feb 2018 08:17:38 -0500
In-Reply-To: <CAPcyv4gt88pEivOyEGdYbTx9H2LV7+mQQ9H1ESWhzM+gpbtW0g@mail.gmail.com>
        (Dan Williams's message of "Mon, 12 Feb 2018 15:05:10 -0800")
Message-ID: <x49bmgtqb9p.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Feb 12, 2018 at 2:53 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Dave Jiang <dave.jiang@intel.com> writes:
>>
>>> Re-enable deep flush so that users always have a way to be sure that a write
>>> does make it all the way out to the NVDIMM. The PMEM driver writes always
>>> make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
>>> flush the write buffers on power failure. Deep flush is there to explicitly
>>> flush those write buffers to protect against (rare) ADR failure.
>>> This change prevents a regression in deep flush behavior so that applications
>>> can continue to depend on fsync() as a mechanism to trigger deep flush in the
>>> filesystem-dax case.
>>
>> That's still very confusing text.  Specifically, the part where you say
>> that pmem driver writes always make it to the DIMM.  I think the
>> changelog could start with "Deep flush is there to explicitly flush
>> write buffers...."  Anyway, the fix looks right to me.
>
> I ended up changing the commit message to this, let me know if it reads better:

Thanks.  It's still unclear to me what the text, "The PMEM driver writes
always arrive at the NVDIMM" means.  However, it's good enough.

Thanks!
Jeff

>
>     libnvdimm: re-enable deep flush for pmem devices via fsync()
>
>     Re-enable deep flush so that users always have a way to be sure that a
>     write makes it all the way out to media. The PMEM driver writes always
>     arrive at the NVDIMM, and it relies on the ADR (Asynchronous DRAM
>     Refresh) mechanism to flush the write buffers on power failure. Deep
>     flush is there to explicitly flush those write buffers to protect
>     against (rare) ADR failure.  This change prevents a regression in deep
>     flush behavior so that applications can continue to depend on fsync() as
>     a mechanism to trigger deep flush in the filesystem-DAX case.
>
>     Fixes: 06e8ccdab15f4 ("acpi: nfit: Add support for detect platform
> CPU cache...")
>     Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
