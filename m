Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeDIJk3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:40:29 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36733 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeDIJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:40:25 -0400
X-Google-Smtp-Source: AIpwx49Lv2/kc3f6ksvigx10dKfHUukm2CGTAZxEdASQkFZb0wSmHkD/f51EATHqZchpZdFnmiHdRcIGrNSmNxiWZh8=
MIME-Version: 1.0
From: Pete M <pete.m@expressvpn.com>
Date: Mon, 9 Apr 2018 17:40:23 +0800
Message-ID: <CAOEaCsE=burVT7X1zo6ffnSyEByY55AKD9_ietczksiajyD49A@mail.gmail.com>
Subject: Kernel lockup on servers running OpenVPN
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w399eYfr018366

Hi guys,


We’re consistently seeing a hung kernel and need help finding and
fixing the root cause. We’re posting to the general list as we have
not been able to identify the affected subsystem or confirm if it is
architecture specific.


Some key points:

Repro steps:

  1. Install Ubuntu or Debian on a dedicated server
  2. Upgrade to Kernel 4.13 or later
  3. Drive some OpenVPN traffic at the server
  4. Wait anywhere from a few hours to a few days
  5. The server becomes completely unresponsive and requires a
physical reboot. We’ve seen this happen hundreds of times over the
past 3 months on various types of hardware.

Observations about the hang:

  1. There is no response to SysRq either from the keyboard or from
serial (SOL). Logs simply stop at the time of the crash.
  2. The CPU temperature for a crashed machine was significantly
higher (50%) than the CPUs of similarly loaded but non-crashed
servers.
  3. Screen on KVM shows login prompt but it's unresponsive, no blinking cursor.

Debugging steps we’ve tried:

  1. We have been unable to generate a crash report, either by using
SysRq (no response) or by enabling crash dumps.
  2. We have also recompiled the kernel with support for
hardlockup_panic and softlockup_panic, in the hope that this would
trigger the panic and generate a crashdump, but the system locked up
in the same way.

Kernel versions:

  a. 4.4: we’re quite certain that the problem does NOT reproduce
here. We’ve driven load at 1000+ such servers for years, no such
crashes.
  b. 4.13, 4.14 and 4.15: the problem reproduces consistently.
  c. 4.8 to 4.12: we’re not sure. We haven’t seen crashes, but haven’t
spent enough load+time on these yet.

OS versions:

  We’ve seen the problem on Ubuntu 14.04, 16.04 and Debian stable and testing.

Hardware:

  We’ve seen the problem on Intel Xeon, i7 and AMD, as well as both
Intel and Broadcom network cards. We’ve not been able to isolate a
particular piece of hardware as the cause. All of the machines were
configured from the same playbook, so barring driver differences, the
installs should be the same.

Impact of load:

  Crashes do require there to be network traffic going through the
server (an idle server won’t crash) but it does not appear to be
directly related to load or a particularly period of time. Very busy
servers have stayed up for weeks, whilst a new server with a few users
has crashed within hours.

Software running on the servers:

  OpenVPN version 2.3 (with 2.3.14 and 2.3.18 tested specifically)
with very little else (minimal firewall, minimal config, bare minimum
of active components).


We’re looking for:

  1. Advice on how to isolate and fix the root cause
  2. If appropriate: referrals to people who might be open to helping
us work through this issue as a paid consulting project.

Thanks in advance!

Kind regards,


Pete M
