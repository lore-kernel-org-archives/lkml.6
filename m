Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeCSVHW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:07:22 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:40589 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934946AbeCSVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:06:10 -0400
X-Google-Smtp-Source: AG47ELuCDWGMqiVw9vJBTDLEUUo8lCIh0LUVjzBGTBTFzb8LjijBf9fQn871mUM1JNSyFIfHVAau48op1aAYZ3WYjW8=
MIME-Version: 1.0
In-Reply-To: <20180319200813.GA18746@casa>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
 <20180312205158.GB21621@casa> <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
 <20180315210659.GA16037@casa> <1c75c511-eada-585e-297f-e90feb17ac8c@valvesoftware.com>
 <20180319200813.GA18746@casa>
From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date: Mon, 19 Mar 2018 22:06:09 +0100
Message-ID: <CAM4jgCpNptQz4nP1u0pcBo5fYXJxpxyR4j2U5YBCY2xiev0wug@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-19 21:08 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>:
> On Sat, Mar 17, 2018 at 02:54:07PM -0700, Pierre-Loup A. Griffais wrote:
>
> Now, what I would really want is a review by Valve of my set-lizard function:
>
> static void steam_set_lizard_mode(struct steam_device *steam, bool enabled)
> {
>         if (enabled) {
>                 steam_send_report_byte(steam, 0x8e); //enable mouse
>                 steam_send_report_byte(steam, 0x85); //enable esc, enter and cursor keys
>         } else {
>                 steam_send_report_byte(steam, 0x81); //disable esc, enter and cursor keys
>                 steam_write_register(steam, 0x08, 0x07); //disable mouse (cmd: 0x87)
>         }
> }
>
> While it works, I find its asymmetry quite uncanny. I'm afraid that some
> of these are there for a side effect, this is not their real purpose.
> Could you give me a hint about this?
>

If I remember correctly, you can also enable the mouse with "87 03 08
00 00". But that do not explain the asymmetry or why there are two
ways of doing it. I always found it weird that the "enable" value was
0x0000 and the "disable" value 0x0007.
