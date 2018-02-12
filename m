Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933165AbeBLWxo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933084AbeBLWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:53:42 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ross.zwisler@intel.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
References: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 12 Feb 2018 17:53:40 -0500
In-Reply-To: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
        (Dave Jiang's message of "Mon, 12 Feb 2018 14:46:13 -0700")
Message-ID: <x49inb1n7kb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> writes:

> Re-enable deep flush so that users always have a way to be sure that a write
> does make it all the way out to the NVDIMM. The PMEM driver writes always
> make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
> flush the write buffers on power failure. Deep flush is there to explicitly
> flush those write buffers to protect against (rare) ADR failure.
> This change prevents a regression in deep flush behavior so that applications
> can continue to depend on fsync() as a mechanism to trigger deep flush in the
> filesystem-dax case.

That's still very confusing text.  Specifically, the part where you say
that pmem driver writes always make it to the DIMM.  I think the
changelog could start with "Deep flush is there to explicitly flush
write buffers...."  Anyway, the fix looks right to me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
