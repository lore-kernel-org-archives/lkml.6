Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfAOOQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:16:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfAOOQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:16:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 580CF99D2E;
        Tue, 15 Jan 2019 14:16:21 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.18.25.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57595600C9;
        Tue, 15 Jan 2019 14:16:20 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, stable@vger.kernel.org,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] acpi/nfit: Fix command-supported detection
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 15 Jan 2019 09:16:19 -0500
In-Reply-To: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Mon, 14 Jan 2019 17:57:04 -0800")
Message-ID: <x49tvia80r0.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 15 Jan 2019 14:16:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Changes since v1 [1]:
> * Include another patch make sure that function-number zero can be
>   safely used as an invalid function number (Jeff)
> * Add a comment clarifying why zero is an invalid function number (Jeff)
> * Pass nfit_mem to cmd_to_func() (Jeff)
> * Collect a Tested-by from Sujith
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019435.html

For the series:

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks, Dan!


>
> ---
>
> Quote patch2 changelog:
>
> The _DSM function number validation only happens to succeed when the
> generic Linux command number translation corresponds with a
> DSM-family-specific function number. This breaks NVDIMM-N
> implementations that correctly implement _LSR, _LSW, and _LSI, but do
> not happen to publish support for DSM function numbers 4, 5, and 6.
>
> Recall that the support for _LS{I,R,W} family of methods results in the
> DIMM being marked as supporting those command numbers at
> acpi_nfit_register_dimms() time. The DSM function mask is only used for
> ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.
>
> ---
>
> Dan Williams (2):
>       acpi/nfit: Block function zero DSMs
>       acpi/nfit: Fix command-supported detection
>
>
>  drivers/acpi/nfit/core.c |   53 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 14 deletions(-)
