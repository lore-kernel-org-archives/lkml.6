Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeEGOOT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeEGOOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:14:15 -0400
ARC-Seal: i=3; a=rsa-sha256; t=1525584030; cv=pass;
        d=google.com; s=arc-20160816;
        b=Lw3Zo2uGGyQ+QScyxJZqzfMvBLSTgCfM0kLfdnx9HFBbRKTC31gwf70X3ObwgUCyoB
         7Of4qv1bQMVd/YYOmUiPgK6Tg9msSlRIiX5wwI8rH9rZS/o1PziKOExV0UDqgXORDXUw
         ujXZ/VNBozJJkVsz6PpMvVuGSf8aM5HeyfWpwQTiNMgcvQWkfaJU0stQfFx5CiU94fx7
         rKA5N4RVfcZl+LuuXjNLyofcdc9tSnyFTjsKV/FNJik9vsrGrg/7YKsHTlOSmpjgpbIZ
         EBuxpLyjBKoro1993kHgJ3GyF43TBUO1dyGHQ6UU/oL1dNwgDWVBhzzyb4hmautJXbY1
         cgEA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:auto-submitted:content-transfer-encoding:message-id
         :date:subject:to:from:arc-authentication-results
         :arc-message-signature:delivered-to:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=NTKjkQcESMtuTXgSUgBP5kQAawSYmcyy9XCL5w5aVcQ=;
        b=EhTgwTDMZiOEsnwdBxK89K+eIf6a13WgEZbZNvuXskjBqcpCDVC4uorT196ZO1Hkab
         pZ4lgCVxj7Ux33Oun4IOq8073NV8HdvQCljP6Ym0lXtS+sskbGjbwaU2myHda1nVDSNl
         hJu/muFmoI+QdSnFrOclcYjxQiwrQBFZ3CwxR/x4pEZjJrCYD1PdhwncC1bGok8wotX0
         WCgU2FZkpvcrTfxNOR49/QoZC9ETKSs2FnhTX8VvwKdb1F3c1Z5kXl37ZHZPDyJgb11U
         AdeoyHqSveQ0Q8VE/sZy6JV83mAHH0MINgkNkXZfAbqpnzKvRnPCBFnk9jgZJaKinreB
         fteQ==
ARC-Authentication-Results: i=3; mx.google.com;
       arc=pass (i=2 spf=pass spfdomain=gmail.com);
       spf=pass (google.com: domain of bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE arc=pass) header.from=kernel.org
Authentication-Results: mx.google.com;
       arc=pass (i=2 spf=pass spfdomain=gmail.com);
       spf=pass (google.com: domain of bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE arc=pass) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZodxyZzq8+dhntkQK2EaRfhunzaBWzxRMXIdWE6QWcaj9/z69D4fx4zV8+CH2QmxO5bG7DJJg3/IEDeugHmfuN8MjOjUcE=
ARC-Seal: i=2; a=rsa-sha256; t=1525584030; cv=pass;
        d=google.com; s=arc-20160816;
        b=QwWJxs18C4Cpg4BpwSrlsF4vHj0IqIJ3X76keUPTPOaV5P7iJtDhMFqRufPj102Ypo
         IMQ2mek7KnaTdJvlbRsP1jFjt5RuR6CC9+I1y5WJIDXr3J3EGvINEdISPKsEN5hekZ7b
         GtYLbh9qABfgIZj8oclDPxWG1/xC5x3qkNEix2mHPSBHNSb1PD+6XlbMLmghHicGGdi/
         V+nru06QOalTeVsYUVA5435RcazH8gIohQJZ4hT/5LT9VtOmD/92SzSxgRNofTMwH6tK
         bRS07iR3Azo6H7A48OcpH0D0+A813LyqkawM/Qra6zwnlIaZhvl8u3Tmk5nOopQi01PU
         DkZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:auto-submitted:content-transfer-encoding:message-id
         :date:subject:to:from:arc-authentication-results
         :arc-message-signature:delivered-to:arc-authentication-results;
        bh=NTKjkQcESMtuTXgSUgBP5kQAawSYmcyy9XCL5w5aVcQ=;
        b=w0n0Jt0IaFZzSRxWbAJb8kJlE6gejukbOhgWDRztly88seNS8U4qlhyvC9NVQ8GV3q
         aDrXXdSlBIFvwCjxq1izXQzarIYrGBN3uipuarkkEnN4Afm4JRIo83pH8gJIJXf5EVMZ
         iBbbScHGEm2sfmO/PhkdmZC1YhNdzN1zgI+TH3qGAWDeHZSAwEEGoOhVFXi6+fffrW3i
         rOADM637meaaYqcCFISq2i9tKYPY30XOkXYBBSvkEvqpsoOkIa8wgx6CFBi+aep383dK
         6N0gLqpTigdeJDsn9cdfwfGqHkGI3/k4GpsiMJxQxbYbh+RzqtbpcsN4r5Cve6CWHF7t
         EJaQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       arc=pass (i=1 spf=pass spfdomain=bugzilla.kernel.org dmarc=pass fromdomain=kernel.org);
       spf=pass (google.com: domain of bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com designates 209.85.161.170 as permitted sender) smtp.mailfrom=bugzilla.pci+caf_=bjorn=helgaas.com@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE arc=pass) header.from=kernel.org
X-Original-Authentication-Results: mx.google.com;       spf=pass (google.com: domain of bugzilla-daemon@bugzilla.kernel.org designates 198.145.29.98 as permitted sender) smtp.mailfrom=bugzilla-daemon@bugzilla.kernel.org;       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Forwarded-To: bjorn@helgaas.com, linux-pci@vger.kernel.org
X-Forwarded-For: bugzilla.pci@gmail.com bjorn@helgaas.com, linux-pci@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; t=1525584029; cv=none;
        d=google.com; s=arc-20160816;
        b=yOCFuUF3o0I/aR5n1yNf1t8bAm/v19QqSk6j+BwyUlY1xITWu6lYGXBFEvdo3dPj8e
         2IlLxQAej7A60jyKQwhCLrF9bzZZGx9j0/QyCvAztR220ndyVxGajWKpVJ484DbKiyqY
         jSG9SJ9R8p132/ud+nIA2LxtX/jrrF4pqVycfXi2F6z1XWWv5s3vuZjKSZ05DZza/CAn
         iEFdF/1mzcAjExLfEDKSorBtL+UC3XZKSNfgi8++WghTXoZrdI1s1tU/B/Irco27fNPR
         2vZ6unyV6u8iEK9aFnmhycRnFN9PF5UDyvIXtHE+pspa229vpTNKBpneZ75fXMW/EqlZ
         qSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:auto-submitted:content-transfer-encoding:message-id
         :date:subject:to:from:arc-authentication-results;
        bh=NTKjkQcESMtuTXgSUgBP5kQAawSYmcyy9XCL5w5aVcQ=;
        b=BDRPZ77ZeKLx9NhNXcsDBqy+OyXccWyfN/FwP4xf71wyQPB7Gn0Q+p+gVjpUn5IUh/
         7ETn1m+FYuFTPLR/9aSRz+XanpWUzVy5cKQwb6+ysz80kI/I13rVFLZsBPeubucLGF8h
         Th+7OrOzLAW8a4eM6VCRyvn9eIVK1Dp49M8sYoq9f8hIJ03NUudrXAcGIWHh3ADqst/q
         GYCpa9KRM0NbwYDp2qEl3yzPQOb2lSFGP/PdS/QeqemiTPxSZYf3s0vvCPl2DD2pnf9G
         IPbK+cM/AA7QsSG6plqY1+L9pH3AdZ9WKEZCrIbx0YT5wj98vhB9HtuxA0oMLHGza4xP
         w9Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bugzilla-daemon@bugzilla.kernel.org designates 198.145.29.98 as permitted sender) smtp.mailfrom=bugzilla-daemon@bugzilla.kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 199631] New: WARNING:  at drivers/thunderbolt/switch.c:587
 tb_switch_add+0x63e/0x730 [thunderbolt]
Date: Sun, 06 May 2018 05:20:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_pci@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: PCI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@colorremedies.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_pci@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-199631-193951@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-TUID: FawUHjHyKYJ8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199631

            Bug ID: 199631
           Summary: WARNING:  at drivers/thunderbolt/switch.c:587
                    tb_switch_add+0x63e/0x730 [thunderbolt]
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.17.0-0.rc3.git4.1.fc29.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: bugzilla@colorremedies.com
        Regression: No

Soon after boot, I'm getting a warning and a call trace

[   36.051674] thunderbolt 0000:03:00.0: timeout reading config space 1 from
0x36
[   36.051757] ------------[ cut here ]------------
[   36.051769] thunderbolt 0000:03:00.0: 0:1: non switch port without a PHY
[   36.051881] WARNING: CPU: 3 PID: 1511 at drivers/thunderbolt/switch.c:587
tb_switch_add+0x63e/0x730 [thunderbolt]


Does not happen with 4.16.6.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
