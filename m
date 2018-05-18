Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeERHLk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:11:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:29552 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERHLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:11:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="200419377"
Date: Fri, 18 May 2018 10:11:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: jmorris@namei.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v4.18
Message-ID: <20180518071134.GA11205@linux.intel.com>
References: <20180518070851.GA11123@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518070851.GA11123@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Sorry, pressed 'send' by accident before adding a cover message.

Anyway, this purely a bug fix release. The only major change is to move
the event log code to its own subdirectory because there starts to be
so much of it.

/Jarkko

On Fri, May 18, 2018 at 10:08:51AM +0300, Jarkko Sakkinen wrote:
> The following changes since commit 5859cdf55063943192f316b3d6c673fd6fcbee46:
> 
>   smack: provide socketpair callback (2018-05-04 12:48:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180518
> 
> for you to fetch changes up to 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> 
>   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)
> 
> ----------------------------------------------------------------
> tpmdd updates for Linux 4.18
> 
> ----------------------------------------------------------------
> Colin Ian King (2):
>       tpm: st33zp24: remove redundant null check on chip
>       tpm/st33zp24: Fix spelling mistake in macro ST33ZP24_TISREGISTER_UKNOWN
> 
> Jerry Snitselaar (1):
>       tpm_tis: verify locality released before returning from release_locality
> 
> Ji-Hun Kim (2):
>       tpm: replace kmalloc() + memcpy() with kmemdup()
>       tpm: replace kmalloc() + memcpy() with kmemdup()
> 
> Nayna Jain (3):
>       tpm: move the delay_msec increment after sleep in tpm_transmit()
>       tpm: reduce poll sleep time in tpm_transmit()
>       tpm: reduce polling time to usecs for even finer granularity
> 
> Tadeusz Struk (1):
>       tpm: fix use after free in tpm2_load_context()
> 
> Thiebaud Weksteen (4):
>       tpm: Add explicit endianness cast
>       tpm: Move eventlog files to a subdirectory
>       tpm: Move shared eventlog functions to common.c
>       tpm: Move eventlog declarations to its own header
> 
> Winkler, Tomas (1):
>       tpm: tpm_crb: relinquish locality on error path.
> 
>  drivers/char/tpm/Makefile                          |  10 +-
>  .../tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c}   |   3 +-
>  drivers/char/tpm/eventlog/common.c                 | 195 ++++++++++++++++++++
>  drivers/char/tpm/eventlog/common.h                 |  35 ++++
>  .../tpm/{tpm_eventlog_efi.c => eventlog/efi.c}     |   6 +-
>  .../char/tpm/{tpm_eventlog_of.c => eventlog/of.c}  |  11 +-
>  .../char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c}  | 200 ++-------------------
>  .../char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c}  |   3 +-
>  drivers/char/tpm/st33zp24/spi.c                    |   4 +-
>  drivers/char/tpm/st33zp24/st33zp24.c               |   2 -
>  drivers/char/tpm/tpm-interface.c                   |   5 +-
>  drivers/char/tpm/tpm.h                             |  32 +---
>  drivers/char/tpm/tpm2-space.c                      |   3 +-
>  drivers/char/tpm/tpm_crb.c                         |  10 +-
>  drivers/char/tpm/tpm_tis_core.c                    |  58 +++++-
>  15 files changed, 331 insertions(+), 246 deletions(-)
>  rename drivers/char/tpm/{tpm_eventlog_acpi.c => eventlog/acpi.c} (98%)
>  create mode 100644 drivers/char/tpm/eventlog/common.c
>  create mode 100644 drivers/char/tpm/eventlog/common.h
>  rename drivers/char/tpm/{tpm_eventlog_efi.c => eventlog/efi.c} (91%)
>  rename drivers/char/tpm/{tpm_eventlog_of.c => eventlog/of.c} (91%)
>  rename drivers/char/tpm/{tpm1_eventlog.c => eventlog/tpm1.c} (58%)
>  rename drivers/char/tpm/{tpm2_eventlog.c => eventlog/tpm2.c} (99%)
