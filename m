Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeBLWuC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:50:02 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36894 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbeBLWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:50:00 -0500
X-Google-Smtp-Source: AH8x224QFIKZI2zW+XtViXn147VapwMnfcQ14pFpcV4F+klMYAqiVKX/4zJfPzl/+zZO8P+kmv6SlOPVNkOjj2CGpu4=
MIME-Version: 1.0
In-Reply-To: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
References: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 12 Feb 2018 14:49:59 -0800
Message-ID: <CAPcyv4j6DWQEKt7gC9ZpisBMuyraCRw_JevOT9VOu0nLJV5XQQ@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Zwisler, Ross" <ross.zwisler@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 1:46 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> Re-enable deep flush so that users always have a way to be sure that a write
> does make it all the way out to the NVDIMM. The PMEM driver writes always
> make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
> flush the write buffers on power failure. Deep flush is there to explicitly
> flush those write buffers to protect against (rare) ADR failure.
> This change prevents a regression in deep flush behavior so that applications
> can continue to depend on fsync() as a mechanism to trigger deep flush in the
> filesystem-dax case.
>
> Fixes: 06e8ccdab15f4 ("acpi: nfit: Add support for detect platform CPU cache flush on power loss")
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Thanks Dave, applied.
