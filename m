Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeBLPaS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:30:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37670 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeBLPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:30:15 -0500
X-Google-Smtp-Source: AH8x224LZVoRG/KdhVjcsmV0FYRIwrDCVCCS8rct9pXxZYAtsjy3EnWWASDq4sqsbRNpDGB0n2TXSw==
Date: Mon, 12 Feb 2018 16:30:12 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20180212153012.vffvjmz26ifyxbj5@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
 <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
 <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
 <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 January 2018 14:27:51 Andy Shevchenko wrote:
> On Wed, Jan 31, 2018 at 2:03 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
> >> On Sun, Jan 28, 2018 at 4:45 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> 
> >> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
> >> > function match only prefix and not exact string?
> >>
> >> OK, fair enough.
> >>
> >> Do we have more users of such pattern?
> >
> > I have not seen this ACPI pattern yet, so probably not.
> 
> I see. So, my  one concern is the implicit names of the devices. I
> would like rather to see
> 
> ... acpi_device_id ... []= {
>  {"SMO8800"},
>  {"SMO8810"},
> ...
> {}
> };

Following table already exists in dell-smo8800.c file:

static const struct acpi_device_id smo8800_ids[] = {
	{ "SMO8800", 0 },
	{ "SMO8801", 0 },
	{ "SMO8810", 0 },
	{ "SMO8811", 0 },
	{ "SMO8820", 0 },
	{ "SMO8821", 0 },
	{ "SMO8830", 0 },
	{ "SMO8831", 0 },
	{ "", 0 },
};

MODULE_DEVICE_TABLE(acpi, smo8800_ids);

Can we reuse it? Maybe moving array smo8800_ids[] into some header file
(which one?) and statically inline it? Or having it only in
dell-smo8800.c file and exporting its symbol? Or is there better idea?

For sure I do not want to copy paste this table into another module and
maintaining two copies of this list.

-- 
Pali Rohár
pali.rohar@gmail.com
