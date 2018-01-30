Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeA3FFU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:05:20 -0500
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:49796 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeA3FFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:05:18 -0500
X-SecurityPolicyCheck: OK by SHieldMailChecker v2.5.2
X-SHieldMailCheckerPolicyVersion: FJ-ISEC-20170217-enc
X-SHieldMailCheckerMailID: fa0f78a204934e43881b21e338bc1bce
To: <linux-kernel@vger.kernel.org>
CC: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: Question about dmesg/sysfs output when retpoline config is disabled
Message-ID: <00bcb291-2b99-1122-9eb3-13c191fa3a5b@jp.fujitsu.com>
Date: Tue, 30 Jan 2018 13:52:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think dmesg/sysfs output messages are not suitable if retpoline config is off:

I intentionally compiled the kernel 4.15.0 with CONFIG_RETPOLINE=n for test and 
boot it with the following kernel command line option to check dmesg/sysfs:

(a) no command line option or "spectre_v2=on" or "spectre_v2=auto"
$ dmesg | grep -i spectre
[    0.017714] Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
$ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
Minimal generic ASM retpoline

(b) "spectre_v2=off"
$ dmesg | grep -i spectre
[    0.017002] Spectre V2 mitigation: disabled on command line.
$ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
Vulnerable

(c) "spectre_v2=retpoline"
$ dmesg | grep -i spectre
[    0.018002] Spectre V2 mitigation: kernel not compiled with retpoline; no mitigation available! 
$ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
Vulnerable

I think the output of (c) is correct for this case, or are these outputs actually right?

Also, the output of (a) is the same with following condition:
 (1) CONFIG_RETPOLINE=n, and
 (2) CONFIG_RETPOLINE=y but the compiler did not support retpoline
These cannot be distinguished unless option of (c) is explicitly used.

Regards,
Tomohiro Misono
