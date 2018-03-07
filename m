Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeCGIl7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:41:59 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:42533 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeCGIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:41:54 -0500
X-Google-Smtp-Source: AG47ELtqmr05Y1+mBcmnesjRYLtgngY0SkWIKpgMQe/uGOUZ8PhefWG+fEpinhP3HcVO8ICAoL27pmKeSbBhuDDZLWc=
MIME-Version: 1.0
References: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
In-Reply-To: <01000161fc0b4755-df0621f4-ab5d-479a-b425-adf98427a308-000000@email.amazonses.com>
From: Thiebaud Weksteen <tweek@google.com>
Date: Wed, 07 Mar 2018 08:41:42 +0000
Message-ID: <CA+zpnLdSyuyKjJEH3Oowmha2mF0B-j5b4A7CLuXXY7RH47SiFQ@mail.gmail.com>
Subject: Re: Regression from efi: call get_event_log before ExitBootServices
To: jeremy@jcline.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, hdegoede@redhat.com,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for testing and sending this report! This patch relies heavily on
the functions exposed by the firmware. My first guess would be that some of
these may not be implemented correctly by the manufacturer.

Could you share more information on this specific device?
Do you have any link to the manufacturer website (I found [1] but it is
based on an ARM CPU)?
Do you have the option to update your firmware? Is a copy of the firmware
available from the manufacturer?

On your side, I assume no error message got displayed on the screen when
booting. Would you be able to try to boot in an UEFI shell [2] and execute
the command "dh -v"?

Thanks,
Thiebaud

[1] https://www.gp-electronic.nl/product/7inchtablet
[2]
https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#UEFI_Shell

On Tue, Mar 6, 2018 at 5:00 PM Jeremy Cline <jeremy@jcline.org> wrote:

> Hi folks,

> Commit 33b6d03469b2 ("efi: call get_event_log before ExitBootServices")
> causes my GP-electronic T701 tablet to hang when booting. Reverting the
> patch series or hiding the TPM in the BIOS fixes the problem.

> I've never fiddled with TPMs before so I'm not sure what what debugging
> information to provide. It's got an Atom Z3735G and the UEFI firmware is
> InsydeH20 version BYT70A.YNCHENG.WIN.007.


> Regards,
> Jeremy
