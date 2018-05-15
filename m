Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeEOVSS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:18:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45718 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752389AbeEOVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:18:16 -0400
X-Google-Smtp-Source: AB8JxZotfjNos+g5mLfSMyhjtHipReOIaxgAi9plOXuzmBdP2IUcnQSUoEWF5St9WeB/Na5AbflTbA==
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Al Stone <ahs3@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: linux-next 20180515 - ACPI disabled..
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1526419088_2497P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 May 2018 17:18:08 -0400
Message-ID: <50539.1526419088@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1526419088_2497P
Content-Type: text/plain; charset=us-ascii

Seeing this at boot with linux-next 20180415.  ACPI gets disabled, hilarity and hijinks
result - everything from a lot of stuff can't find an IRQ to the dual-core w/ HT CPU
coming up as just 1 core no HT. 20180430 works just fine...

[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000CB7F1000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000CB7F1088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CB7FB720 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CB7F11B0 00A56F (v02 DELL   CBX3     00000021 INTL 20091112)
[    0.000000] ACPI: FACS 0x00000000CCFED080 000040
[    0.000000] ACPI: APIC 0x00000000CB7FB830 000072 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CB7FB8A8 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: TCPA 0x00000000CB7FB8F0 000032 (v02 APTIO4 NAPAASF  00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 0x00000000CB7FB928 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CB7FB968 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CB7FB9A0 000415 (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 0x00000000CB7FBDB8 0009B9 (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000CB7FC778 000B22 (v01 PmRef  CpuPm    00003000 INTL 20051117)
[    0.000000] ACPI: DMAR 0x00000000CB7FD2A0 000080 (v01 INTEL  SNB      00000001 INTL 00000001)
[    0.000000] ACPI: ASF! 0x00000000CB7FD320 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000CB7FD3C8 000579 (v01 AMITCG PROC     00000001 INTL 20051117)
[    0.000000] ACPI: BGRT 0x00000000CB7FD948 000038 (v00 ??              01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000CB7FD980 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: [APIC:0x05] Invalid zero length
[    0.000000] ACPI: Error parsing LAPIC address override entry
[    0.000000] ACPI: Invalid BIOS MADT, disabling ACPI
[    0.000000] tsc: Fast TSC calibration using PIT

On next-20180430, the boot goes like this, and continues properly:

[    0.000000] ACPI: SSDT 0x00000000CB7FD980 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] tsc: Fast TSC calibration using PIT

Not seeing any commits to drivers/acpi/tables.c other than Al Stone's.

This ringing any bells before I go bisecting?


--==_Exmh_1526419088_2497P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWvtOkI0DS38y7CIcAQJ/ngf+IUIK/wrskwZHulluQ7Qi3IwgoT0dcl9F
ENageNbGhvgXKSNFfUN1tVP2lb5VPQYmeOmt1ChxyRNUDqXuYxSj/x55qYz+WW3y
fcxqIDknlt4WefOZOD7RKV8TncXF2dnj1JjDx5BWMHWOF8YcOtwYmIx/REJkPIS/
f9PRyCoylhlq/r8ljpXzmjUsa0fohTvJSpHopUCQjWuVoo+R9ridEnZAtffEw8M7
+MrsAw7T6PODp2WyuJ9yeFXI3t/fQj2m8WZQmh8veZWlBa9AeHWm+wk9sk6waZH4
JkDioKCJzLqm7TPKhuDtPB8PEvoZvJInCyRrc7+a+7opJxZFOwGDBw==
=xp5J
-----END PGP SIGNATURE-----

--==_Exmh_1526419088_2497P--
