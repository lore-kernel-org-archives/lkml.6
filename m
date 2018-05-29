Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbeE2HMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:12:37 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33756 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeE2HMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:12:34 -0400
X-Google-Smtp-Source: ADUXVKJYn/mYgvua28vQQAHqpCc9m7z79MDg9eOuznAyymSkN5oYdLxD7b9+PpKTVS329lD60xyp9W9leHJtbsjd8tc=
MIME-Version: 1.0
In-Reply-To: <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
References: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de> <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 29 May 2018 09:12:33 +0200
Message-ID: <CAO-hwJ+oO_8cGK+S9kxqOGZhwE2T+HucLWnKA7zjFm9cwvwjtQ@mail.gmail.com>
Subject: Re: [PATCH] HID: Add support for 146b:0902 Bigben Interactive Kids' gamepad
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Hanno Zulla <abos@hanno.de>, Jiri Kosina <jikos@kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:57 AM, Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
> Hi Hanno,
>
> A few suggestions for your patch based on a quick review (had limited time).
>
> In terms of code style, I noticed a lot of C++ style comments which
> are not part of the kernel code style instead use C comments. To check
> for potential other issues as well, run your patch through
> 'scripts/checkpatch.pl'.
>
> I noticed you fixed up reported descriptors a bit to get axes remapped
> in a different way. This is reasonable as the default mappings are
> often not good. However, I would suggest use the mapping functions
> instead (e.g. see hid-sony.c and other drivers). It also allows you to
> properly remap buttons as well. I suspect the current button mapping
> is all over the place as well. Make sure axis and button mapping
> complies to the Linux gamepad spec (see
> Documentation/input/gamepad.rst).

Thanks a lot Roderick for the review.

In addition to those comments, please also try to follow the
submission guidelines (point 6 of
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst).
It's easier for us to share comments if your patch is inlined in the
email, so we can directly pinpoint which line is in trouble.

Also, keep point 9 in mind ("Don't get discouraged - or impatient").
For the first submissions, it's usual to have several revisions of the
same series.

Cheers,
Benjamin

>
> Thanks,
> Roderick
>
> On Wed, May 23, 2018 at 8:57 AM, Hanno Zulla <abos@hanno.de> wrote:
>> Hello,
>>
>> this is a driver for the "BigBen Interactive Kid-friendly Wired
>> Controller PS3OFMINIPAD SONY" [1] with USB id 146b:0902. It was
>> originally sold as a PS3 accessory and serves as a very nice gamepad for
>> Retropie.
>>
>> With the help of serialusb [2], it was possible to analyze the protocol
>> used by the gamepad and fix the missing entries for the descriptor.
>>
>>
>> This is my *first* driver, so please review accordingly.
>>
>>
>> Three things where I'm not sure and hope to hear from you about:
>>
>> - is that the correct use of hid_validate_values() in bigben_probe()?
>>
>> - is the error handling in bigben_probe() correct?
>>
>> - how do I properly test possible suspend/resume scenarios?
>>
>> Thanks,
>>
>> Hanno
>>
>>
>> [1]
>> <https://www.bigben-interactive.co.uk/bigben-products/gaming-accessories/wired-mini-controller-ps3>
>>
>> [2] <https://github.com/matlo/serialusb>
