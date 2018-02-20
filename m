Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeBTWgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:36:09 -0500
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:60866 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750884AbeBTWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:36:07 -0500
Subject: Re: [PATCH v2 0/3] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <673a2510-7d82-1b24-1085-9f5aa2bb9998@valvesoftware.com>
Date: Tue, 20 Feb 2018 14:29:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
Content-Language: en-US
X-Mlf-Version: 8.3.2.6535
X-Mlf-UniqueId: o201802202229380028279
X-MC-Unique: KjgueYcNPai2u_0-ULcoAg-1
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KMaDuT018984

Hi Rodrigo,

Thanks for working on that! I have a few questions and remarks.

For the reverse-engineering part, there's a lot of existing reference in 
existing (user-space) drivers for the controllers like sc-controller, 
but feel free to reach out if you have any questions. It's overall 
pretty simple and there's nothing secret about how it functions; there 
are some quirks, however. Nothing secret about it, but also no 
documentation, so might as well be... Have you tried deflecting the 
analog stick while touching the left trackpad? You'll most likely need 
special handling there. How are you planning to expose 
enabling/disabling auxiliary data like gyro over wireless?

Will this driver being loaded affect functionality of existing 
applications that talk to it through HID directly, like Steam or 
sc-controller? Will they be able to keep getting the same HID data they 
do today? If so, the extent of the work needed to support it in Steam 
might just be to ignore the controller device it's exposing, since Steam 
will expose that itself through its own means.

Thanks,
  - Pierre-Loup

On 02/20/2018 11:33 AM, Rodrigo Rivas Costa wrote:
> This patchset implements a driver for Valve Steam Controller, based on a
> reverse analysis by myself.
> 
> Notable changes from patchset v1:
>   * Remove references to USB. Now the interesting interfaces are selected by
>     looking for the ones with feature reports.
>   * Feature reports buffers are allocated with hid_alloc_report_buf().
>   * Feature report length is checked, to avoid overflows in case of
>     corrupt/malicius USB devices.
>   * Resolution added to the ABS axes.
>   * A lot of minor cleanups.
> 
> Rodrigo Rivas Costa (3):
>    HID: add driver for Valve Steam Controller
>    HID: steam: add serial number information.
>    HID: steam: add battery device.
> 
>   drivers/hid/Kconfig      |   8 +
>   drivers/hid/Makefile     |   1 +
>   drivers/hid/hid-ids.h    |   4 +
>   drivers/hid/hid-quirks.c |   4 +
>   drivers/hid/hid-steam.c  | 703 +++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 720 insertions(+)
>   create mode 100644 drivers/hid/hid-steam.c
> 
