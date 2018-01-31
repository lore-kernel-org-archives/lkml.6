Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbeAaRPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:15:37 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37360 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeAaRPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:15:34 -0500
X-Google-Smtp-Source: AH8x225tS7Q5o8AoD4QKVD9Ud9RO3XDbWPWQ2Rf/ZrLxeVWxVFc70qFq5Qq9Tsz1piOqZNprKrvmU2t1UMpfNd/BlrQ=
MIME-Version: 1.0
In-Reply-To: <20180131170639.fhmodmamu4mi6ubw@pali>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
 <20180130171745.i5wwcwr4qdbcoxhm@pali> <CAHp75VcqCdEQjUCoSGz87Mb3HFomfOwKWxC7S2CjtqSAZQEpsA@mail.gmail.com>
 <20180131090758.v6eyj35gymlfyzhk@pali> <bb29662337484ad8bd2350e6b68133d3@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VcqYgDCTPqjn9F1SpAbamgPk8B7s4zYAb8csD8oFpLihw@mail.gmail.com> <20180131170639.fhmodmamu4mi6ubw@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 19:15:33 +0200
Message-ID: <CAHp75Vc5OCrKUF+c6LkqN_QtQox7P0bUb8nZEQeO5mzhc=860w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap rather
 than globally
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VHFfuN019722

On Wed, Jan 31, 2018 at 7:06 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Wednesday 31 January 2018 18:53:19 Andy Shevchenko wrote:
>> On Wed, Jan 31, 2018 at 6:46 PM,  <Mario.Limonciello@dell.com> wrote:

>> >> Ok. Then we need to stick with 5 arguments... What about name
>> >> dell_fill_request()? E.g.

>> > +       struct calling_interface_buffer buffer = {CLASS_INFO,
>> > +                                                 SELECT_RFKILL,
>> > +                                                 {0, 0, 0, 0},
>> > +                                                 {0, 0, 0, 0}};
>>
>> Looking to this approach I would rather provide a macro then.
>>
>> #define FILL_REQUEST(a,b,c,d,...) \ // variant FILL_RFKILL_REQUEST(a,b,c,d)
>> (struct calling_interface_buffer) { \
>>  ... \
>> }
>>
>> But then it is macro(s) vs. function(s) debate.
>
> Does not matter, I'm fine with either macro or function.

Mario, it's now up to you. Choose one of the option and send new version.
Thanks!

-- 
With Best Regards,
Andy Shevchenko
