Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeEMIah (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:30:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57812 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEMIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:30:36 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Al Stone <ahs3@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth Prakash <pprakash@codeaurora.org>
Subject: Re: [PATCH v3 0/3] mailbox: ACPI: Remove incorrect error message about parsing PCCT
Date: Sun, 13 May 2018 10:30:05 +0200
Message-ID: <190779407.lJoETU6Q66@aspire.rjw.lan>
In-Reply-To: <20180501003907.4322-1-ahs3@redhat.com>
References: <20180501003907.4322-1-ahs3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 1, 2018 2:39:04 AM CEST Al Stone wrote:
> This set of patches provide some cleanup in ACPI for minor issues
> found while correcting a bogus error message (the first two patches),
> and the correction for the error message itself (patch 3/3).  Note
> that patches 1/3 and 2/3 are not required for 3/3 to work: 1/3 only
> changes a comment and 2/3 makes an ACPI table parsing loop a wee bit
> more robust.
> 
> For patch 3/3, many systems on boot have been reporting "Error parsing
> PCC subspaces from PCCT" which turns out to not be an error at all.
> The issue is that the probe for ACPI mailboxes defined in the PCCT
> (Platform Communications Channel Table) makes a faulty assumption about
> the content of the PCCT.  What's more, when the error is reported, no
> further PCC mailboxes are set up, even when they have been defined
> in the PCCT.  So, in the reported cases, there was no error and the
> data in the PCCT was being ignored.  This is described in more detail
> in patch 3/3.
> 
> Since these patches primarily involve ACPI usages, it may make
> sense for all of them to go through the linux-acpi tree; clearly,
> this is up to the maintainers, though.
> 
> v3:
>   -- properly format docbook info in patch 1/3
>   -- remove extra parens in patch 2/3
>   -- clean up formatting, remove pr_warn() calls used in debugging but
>      providing no value, clean up docbook info for count_pcc_subspaces()
>      and parse_pcc_subspaces(), all in patch 3/3
> 
> v2:
>   -- removed one extraneous '+' in a comment in patch 3/3
>   -- fixed an if test that had a predicate that kbuild pointed out would
>      always be zero
> 
> Al Stone (3):
>   ACPI: improve function documentation for acpi_parse_entries_array()
>   ACPI: ensure acpi_parse_entries_array() does not access non-existent
>     table data
>   mailbox: ACPI: erroneous error message when parsing the ACPI PCCT
> 
>  drivers/acpi/tables.c | 12 ++++---
>  drivers/mailbox/pcc.c | 96 +++++++++++++++++++++++++++++++++------------------
>  2 files changed, 71 insertions(+), 37 deletions(-)

I've applied [1-2/3] and I'm waiting on input from Prashanth on the [3/3].

Thanks,
Rafael
