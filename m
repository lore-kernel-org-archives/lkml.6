Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeCLODi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:03:38 -0400
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:48542 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932332AbeCLODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:36 -0400
Subject: Linux 4.16: Reported regressions as of , 2018-03-12 (Was: Linux
 4.16-rc5)
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
References: <CA+55aFxXAMHeD8zz1BLv9r_2rjWJ6xE=cNGVAoWOvQJog7oz9A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <b5a36282-49a8-d6ca-8f68-ef15e1019fd3@leemhuis.info>
Date: Mon, 12 Mar 2018 15:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxXAMHeD8zz1BLv9r_2rjWJ6xE=cNGVAoWOvQJog7oz9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1520863416;bce1733f;
X-HE-SMSGID: 1evO32-0007FR-Ea
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 01:42, Linus Torvalds wrote:
> This continue to be pretty normal - this rc is slightly larger than
> rc4 was, but that looks like one of the normal fluctuations

Hi! Find below my fourth regression report for Linux 4.16. It lists 9
regressions I'm currently aware of. 1 was fixed since last weeks report.

To anyone reading this: Are you aware of any other regressions that got
introduced this development cycle? Then please let me know by mail (a
simple bounce or forward to the sender of this email address is enough!).

For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Dell R640 does not boot due to SCSI/SATA failure
- Status: WIP; some other changed planed for 4.17 solve this regression,
but there is a discussion if they are too big for 4.16-rc
- Cause: 84676c1f21e8
- Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151931128006031
- Last known developer activity:
https://marc.info/?i=1520515113.20980.31.camel%40gmail.com
- Last relevant activity:
https://marc.info/?l=linux-kernel&m=152026091325037
- Linux-Regression-ID: 15a115

[mm, mlock, vmscan]  9c4e6b1a70:  stress-ng.hdd.ops_per_sec -7.9% regression
- Status: looks stalled; side note: lkp-robot warned about something
else triggered by the same commit:
https://lkml.kernel.org/r/20180302093940.GE25699@yexl-desktop is related
- Cause: 9c4e6b1a7027f102990c0395296015a812525f4d
- Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151956997301994
- Note: performance regression found by lkp-robot

aim7.jobs-per-min -18.0% regression
- Status: looks stalled after some discussions happened the week before last
- Cause: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e
- Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151957120702272&w=2
- Note: performance regression found by lkp-robot

Interrupt storm after suspend causes one busy kworker
- Status: Waiting for data from reporter
- Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929
- Linux-Regression-ID: 41c451

hci_bcm: Streamline runtime PM code change for 4.16 kernel breaks
bluetooth on ASUS T100TA
- Status: WIP
- Cause: 43fff768346810042836df325d736bd2c2a634a7
- Reported: 2018-03-01
https://bugzilla.kernel.org/show_bug.cgi?id=198953

Error updating SMART data during runtime and could not connect to lv
["Possible Regression"]
- Status: Brand new
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152075643627082
https://bugzilla.kernel.org/show_bug.cgi?id=199077

Regression from efi: call get_event_log before ExitBootServices
- Status: WIP, looks like a firmware issue that gets triggerd
- Cause: 33b6d03469b2
- Reported: 2018-03-06
https://marc.info/?l=linux-kernel&m=152035206220237&w=2

15% longer running times on lvm2 test suite
- Status: Quite new
- Cause: 44c02a2c3dc55835e9f0d8ef73966406cd805001
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152077333230274


== Regressions with fixes heading mainline ==

[amdgpu CARRIZO] disabled backlight after S3 resume
- Status: Alex provided a patch "drm/amdgpu: save/restore backlight
level in legacy dce code"; assuming he'll send it upstream
- Cause: 4ec6ecf48c64d1da82a008f6fb0be86c4044287d
- Reported: 2018-03-07
https://bugzilla.kernel.org/show_bug.cgi?id=199047


== Fixed since last report ==

selftests: memory-hotplug: fix emit_tests regression
- Status: Fixed by https://git.kernel.org/torvalds/c/ba004a2955f7
- Cause: 16c513b13477
https://marc.info/?l=linux-kernel&m=151993543423651
