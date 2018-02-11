Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeBKR42 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 12:56:28 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44860 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753524AbeBKR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 12:56:27 -0500
X-Google-Smtp-Source: AH8x224jXOomUsGn4wU8QxHSk7U57hVTNZwP/oZ0BTYIA/oXC5dDFIwY4vV7F9PQVdgTMnt6+h2kLw==
Date: Sun, 11 Feb 2018 09:56:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [01/10] watchdog/hpwdt: Remove legacy NMI sourcing.
Message-ID: <20180211175625.GA22035@roeck-us.net>
References: <20180206225855.30582-2-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206225855.30582-2-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 03:58:46PM -0700, Jerry Hoemann wrote:
> Gen8 and prior Proliant systems supported the "CRU" interface
> to firmware.  This interfaces allows linux to "call back" into firmware
> to source the cause of an NMI.  This feature isn't fully utilized
> as the actual source of the NMI isn't printed, the driver only
> indicates that the source couldn't be determined when the call
> fails.
> 
> With the advent of Gen9, iCRU replaces the CRU. The call back
> feature is no longer available in firmware.  To be compatible and
> not attempt to call back into firmware on system not supporting CRU,
> the SMBIOS table is consulted to determine if it is safe to
> make the call back or not.
> 
> This results in about half of the driver code being devoted
> to either making CRU calls or determing if it is safe to make
> CRU calls.  As noted, the driver isn't really using the results of
> the CRU calls.
> 
> As the CRU sourcing of the NMI isn't required for handling the
> NMI, remove the legacy (pre Gen9) NMI sourcing and the DMI code to
> determine if the system had the CRU interface.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Spoke too early. This fails to compile if CONFIG_HPWDT_NMI_DECODING
is disabled. Please fix and resubmit the series, and please make sure
that each patch compiles on its own.

Thanks,
Guenter
