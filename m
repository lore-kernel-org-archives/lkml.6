Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422793AbeCBEmW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:42:22 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33409 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164297AbeCBEmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:42:21 -0500
X-Google-Smtp-Source: AG47ELtf8FDVUeadb1zh8zI0TnGefO5D3RyXtgVWh40xdqSVp0/clp4evmLu/BSiPEuSm9ctGt2sKA==
Subject: Re: [PATCH v5 0/9] watchdog/hpwdt: Update driver to use watchdog
 core.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9f35de2d-f716-3a57-de96-e9ff7bf4d9ef@roeck-us.net>
Date: Thu, 1 Mar 2018 20:42:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226032227.14615-1-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2018 07:22 PM, Jerry Hoemann wrote:
> == v5 ==
> 
> Patch numbers changing due to squash and reorder.
> Using Prior (v4) Patch number noting *new* patch numbers as bullet item.
> 
> 
> Patch 0001 & 0004 Merged into: Update-Module-info-and-copyright
> 1) New Patch 0001
> 
> Patch 0002 Remove legacy NMI sourcing
> 1) Unmodified
> 
> Patch 0003 Update nmi_panic message.
> 1) Unmodified
> 
> Patch 0004 Update Module info.
> 1) Merged into 0001 above.
> 
> Patch 0005 Modify to use watchdog core
> 1) syntatic sugar.
> 2) Now Patch 0004
> 
> Patch 0006 condition-early-return-of-NMI-handler
> 1) Now Patch 0005
> 2) Casing on iLO5
> 3) true for boolean
> 
> Patch 0007 remove allow_kdump module param
> 1) Now patch 0006
> 
> Patch 0008 Programable Pretimeout NMI
> 1) Now patch 00007
> 
> Patch 0009 Add dynamic debug
> 1) Now patch 0008
> 
> Patch 0010 Update driver version.
> 1) Now Patch 0009
> 
> 
> == v4 ==
> 
> Modifications from prior version:
> 
> Manual merging and patch reordering has cause minor white
> space and diff changes.  Such change shouldn't have effected
> the logic and are omitted below:
> 
> Patch 001  Remove legacy NMI sourcing.
> 1) Updated patch documentation to reflect Spectre concerns.
> 2) Restored comment at #endif
>>>>>>>>>> 3) New Patch 0002  <<<<<<<<
> 
> Patch 002 watchdog/hpwdt: remove include files no longer
> 1) Squashed onto Patch001.
>>>>>>>>>> 3) Still Patch 0002  <<<<<<<<
> 
> 
> Patch 0003: watchdog/hpwdt: Update nmi_panic message.
> 1) Unchanged
> 
> 
> Patch 0004:  watchdog/hpwdt: white space changes
> 1) Redacted.
> 
> Patch 0005: watchdog/hpwdt: Update Module info.
> 1) Now Patch 0004
> 2) Update only module description to reflect branding changes.
> 3) Rest of patch redacted.
> 
> Patch 0006 Select CORE
> 1) Merged with 0007
> 
> Patch 0007 Modify to use watchdog core
> 1) squashed on Patch 0006.
> 2) Now Patch 0005
> 3) Requested white space changes.
> 4) Use "wdd" for watchdog_device like other watchdog drivers do
> 
> Patch 0008 Programable-Pretimeout
> 1) hpwdt_settimeout re-worked to take into account timeout <= pretimeout.
>     Patterned after watchdog_set_timeout.
> 2) hpwdt_set_pretimeout re-worked to take into account requested
>     pretimeout <= timeout.
> 3) Clarify patch doc to reflect above.
> 
> Patch 0009 condition-early-return-of-NMI
> 1) Requested syntatic surgar.
> 2) Now Patch 0006
> 
> Patch 0010 remove-allow_kdump
> 1) Now Patch 0007
> 
> Patch 0011 Add-dynamic-debug
> 1) Now Patch 0009
> 2) Typo fix
> 3) New dev_dbg resulting from changes to set timeout and pretimeout.
> 
> Patch 0012 Update driver version.
> 1) Now Patch 0010
> 
>   
> New Patch
> 1) Patch 0001 Update Copyright
> 
> 
> 
> == v3 ==
> 
> Incorperating code review feedback.
> 
> 1) Patch 0003: Use existing hex_byte_pack instead of creating new function.
> 2) Patch 0005: Redacted change in module_param permission.
> 3) Patch 0006: switch from pr_debug etc., to dev_dbg where possible.
> 4) Patch 0006: No longer updating soft_margin post module load.
> 5) Patch 0006: Initialize hpwdt_dev.parent before registering watchdog.
> 6) Patch 0006: Redacted change to dev_info message w.r.t. allow_kdump
> 7) Patch 0006 & 0007: Reorder patches to maintain bisectability.
> 8) Patch 0008: Change pr_debug to dev_dbg
> 9) Patch 0010: Change dev_info message w.r.t. allow_kdump where feature
> 		is removed.
> 
> Note, I am explicitly ignoring the checkpatch error on Patch 0008
> for specifying permisson of "0" instead of "0000".
> 
> == v2 ==
> 
> 1) Fix compiler error when CONFIG_HPWDT_NMI_DECODING is not defined.
> 
> 2) Break out driver version change to its own patch (0011).
> 
> 
> == v1 ==
> 
> The primary purposes of this patch set are to
> 
> 1) Update the hpwdt driver to use the watchdog core.
> 2) Reduce complexity by removing unnecessary features.
> 3) Add customer requested features like optional pretimeout.
> 4) Enhance readability/maintainability of the driver.
> 
> The size of the resultant driver is reduced from over 900
> lines to 350 lines.
> 
> Patch 1& 2 remove legacy NMI sourcing.
> Patch 3	adds useful indication of NMI cause to panic message
> Patch 4 & 5 are general cleanup
> Patch 6 & 7 updates the driver to user the watchdog core.
> Patch 8 makes the pretimeout NMI programmable.
> Patch 9 modifies whether the NMI handler claims the NMI.
> Patch 10 retracts the allow_kdump module parameter.
> 
> 
> 
> Jerry Hoemann (9):
>    watchdog/hpwdt: Update Module info and copyright.
>    watchdog/hpwdt: Remove legacy NMI sourcing.
>    watchdog/hpwdt: Update nmi_panic message.
>    watchdog/hpwdt: Modify to use watchdog core.
>    watchdog/hpwdt: condition early return of NMI handler on iLO5
>    watchdog/hpwdt: remove allow_kdump module parameter.
>    watchdog/hpwdt: Programable Pretimeout NMI
>    watchdog/hpwdt: Add dynamic debug
>    watchdog/hpwdt: Update driver version.
> 
>   drivers/watchdog/Kconfig |   1 +
>   drivers/watchdog/hpwdt.c | 791 +++++++----------------------------------------
>   2 files changed, 121 insertions(+), 671 deletions(-)
> 
For the series:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
