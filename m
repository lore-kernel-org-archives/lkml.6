Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860B1206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860B1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLCVro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:47:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:34161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCVrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:47:43 -0500
Received: from [172.16.11.31] ([188.193.10.29]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFtf4-1ggZ6R3Fnq-00ExSG for
 <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 22:47:42 +0100
To:     linux-kernel@vger.kernel.org
From:   Michael Hennig <M_Hennig@gmx.net>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Autocrypt: addr=M_Hennig@gmx.net; prefer-encrypt=mutual; keydata=
 xsBNBE3ENdEBCACmeeN/ITypg8ydK9gftiHbJ0IKa3ReRhq4KUtiRzRkhpxaV1MB90NGjGDi
 Rq7E58Otjn4jqIGkv3zqDtQwLc5JmHTh6Mn7uZzxOAzWFtq321XdO0JsSQCb933YLbeaMcAY
 gkroCAwHevgtcvdr/2so2Ey9YcKw2ruQG7Q/R6sIGR0PqFpyE8O7XSpGR6zkff9IEvyc1l7L
 TrIrXOBeh/bH0lgKOG5nO9eCVSpYaP3NK8X2D6ap1lBWvy/lyw1Lo1OFPcLo7OL4Nzp1lxi/
 Evl5qdhCjdKEc5+4afH4zKRrnt23Ev4KIkrJhbx7B7k1JSUEDFyTfuxwirgVC6TrQYmFABEB
 AAHNIU1pY2hhZWwgSGVubmlnIDxNX0hlbm5pZ0BnbXgubmV0PsLAeAQTAQIAIgUCTcQ10QIb
 AwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQRTgxQ7ufc7Ln4wf/RzRC+t0esHPrY0d0
 dPT3ZQlUoc/t9MEuk14BLeY87hxd14bD2K3kKeZU/1FdA309SDF8s3XQiFUevFbNgr7vu3P/
 qXYfTd5F93dOt67Pz2Y/mORy0guSQbRxEchF+Sq1NkGfyFyF3CZxAr2cIfWhyRb/feg83dUU
 /bN3VCDrlnMl+FZ75mVDx+ypMeNas1fNIaRVPBxQhFqS6hbHZ6Kk1IvDfrzmECmchzzrMlgZ
 89Ht1H7S6G4bghXYA92rCngMHc/VGF1VzfDX4XNc9AlAWL0AL/VUDM6P6rjYFYfE1ZHR21+u
 UXgFQgeu/+iN4LL0dCyX/02Xg7F0k+V31FhJbM7ATQRNxDXRAQgA05YC7iYLvz3dyRQnFt70
 5DqKea7MBV707OwoA0PJpY7tEO5a15TusaWQ6ETd0Utxv/1y6d1upWBAa0NJSl9ubJ9Ta3EJ
 xuajhNefTM0/tuGZ9b9whCryZuKEVUBkRAB/VyoU2y5KKmw2AS07sImvK2Cnr4CHbWHWaX/w
 9/UIWC3XfVcdIf4K+HG5zTX3+ccAgjo8qsBGQ+922J0KD4USez8kV+cYJbpSbNO+c4K1I8/1
 Rw/gHLW4yTuMCfp/MTFyq7zz3xBaD5fwO6KIpFSTVHRxPQtHEcqv8ZYbTRvoyCLjPnbQK/dH
 v0BFxkbjbnOITV3BP2335BqFer4Um/N4NwARAQABwsBfBBgBAgAJBQJNxDXRAhsMAAoJEEU4
 MUO7n3OybG8H/2cyH3mvqofZF9sdzTMbxSF9vWQjEX5KhMAVJNkbepB6niU/fCEIQpOUAUU6
 k0p9JQVJ2fbeJ2tb3425adUWzKM8Oo/FuCd+vJ7c2TQ2z+V0Y+YQuyfX1pN8UHHKMMnE4DMi
 VBr0Dsq0oaiKhsIwr9wOFGOylYmmYk+hTyNc5w5VOnX7lpqKD3cHx162yQ1eoSM2881ZbBdB
 SHGhMPQIbRe+CaG7Vk5bd3/xK7ncS538VtlX4K57A2IZJI2sANkhRVwepFMZhCgJ4ORrH4Nw
 ht+1TeorBm8X59ro9csbAHQ/saXd/f6FY/N0bfOW9Yb4tDkI08nj/MR2wfY7FPgHu30=
Message-ID: <019a09df-df3d-3350-a779-e51886c2691b@gmx.net>
Date:   Mon, 3 Dec 2018 22:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TCL0CIuUMezFbA0s6GCkCokeXly9XORVWZMYxI5Li1ledF8EROf
 Z+URwa43+JtQEZZKZpKHLHhGGN4Bj2h3yshAkh6bHh9KGAB1EZGgPWFSDQYtbYuIsLT1cQS
 drRHoIVZI8ZqvI0a9aPyldnGunsk/+yC2FQtw2wqxNb11HhqqJ6NswoMcRNwvNcdCMBDNoW
 JnEEuu6yxEdFGlM9UFmQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rwuGmP/dATg=:aNGLckdJjgrgvkV0Rr/HGd
 073m+6I+jOVBWWvlIgM+DPG+GLUfyaMdTPYaulxsTcz0vOkd6qg9R1YzGYaONZ4yIesq+eIBV
 ozcGsM4anGnxv7Gg1zaqPVDxeaMxTh7Z9eud6mKn2SpOU9tRhmr+F+b9mkWNaRg3Kikdfge+a
 4c9H8/S/DUG9XP5twzbpkxQzVf1ShPlrQMlJHANbnEw8eN/CpX4iCgANAJdyWEsGttQi8/BkF
 0GM1TtOR4Pt/lLMEUQHdr+yvvSRWXZEvpTrveFVgBJc0hpt8WHRZkFoK0XsXSsymvl9JkP1gk
 Gwdz2Vw3l8Kj1cCLSbFnjY+S/MUK7yaGwG8y6pDEBwCqeBKpdDyyHNnAwmihReX5Kp6s1dzz8
 /akRfMTDRLDWJa4/Vrv49eGARyoyMB8GoaCTNljAh1BhUA0+JD49qnxZJesZvB0ghebel7vKE
 2bpWiWV+21QdrR6jxG100v7qO3/watHnGbDAadcgEYUtpPtQKi+NFXRfGU07nld4P6DGLNBs6
 OG/al7nPzvuS0pxgPjkpR77/KiNoxclbWyvnL3mXNt6A5CCCQjPEY19BISOKXVTt09gBfHApt
 +mtF34HDHk5hxlXH2ECs0KNjyXNbV1WQCJVq3dMDAG/HIoG6SZ+D3Rsg8ORK+fPAG6zYq/U+X
 xS8BwzC6GJcx4Kfri99ehBGLC6ujPppW5z5LzWXC/GLd95iBK0M4/cvxJN/tmUHXh6gtZJYoc
 RuA4XQhrz89YmxUpybIHYDF1LYw6Pl7mfu4Fl1MHbKwwB33Bd+gCtSgGuj73im/Te7HXgPACI
 9KM+gudAIPKz2hyIY9jSt1H5anX725AhTEZSJuxCQVFrKCjrRkx5noTWsxOIWiA1XQsA6yeuC
 k3tufkfnVMNSGAKADbmTLcKPtg6WftHvIM4Ei7wpWKjwfjFTyolqQDpADd5Y8F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm suffering from ext4 corruption too.
(Ubuntu 18.10, 4.19.6-041906-generic, 64 bit)

22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484759: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484759: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484754: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484755: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4851: inode
#42484768: comm rm: checksum invalid
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484767: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484763: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4851: inode
#42484766: comm rm: checksum invalid
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484761: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484764: comm rm: bad extra_isize 58853 (inode size 256)
22:00:01 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484765: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484759: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484754: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484755: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4851: inode
#42484768: comm rm: checksum invalid
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484767: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484763: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4851: inode
#42484766: comm rm: checksum invalid
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484761: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484764: comm rm: bad extra_isize 58853 (inode size 256)
21:00:48 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484765: comm rm: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484762: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484761: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484760: comm rsync: bad extra_isize 54976 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484759: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484758: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484757: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484756: comm rsync: bad extra_isize 63008 (inode size 256)
21:00:32 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484755: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:31 kernel: EXT4-fs error (device sda4): ext4_iget:4831: inode
#42484754: comm rsync: bad extra_isize 58853 (inode size 256)
21:00:31 kernel: EXT4-fs error (device sda4): ext4_iget:4851: inode
#42484753: comm rsync: checksum invalid


Checked some of the defective inodes only to find timeshift back-upped
files through rsync:

debugfs 1.44.4 (18-Aug-2018)
debugfs:  ncheck 42484759
Inode	Pathname
42484759
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxcb1:i386.symbols
42484759
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxcb1:i386.symbols
42484759
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxcb1:i386.symbols
42484759
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxcb1:i386.symbols
debugfs:  ncheck 42484754
Inode	Pathname
debugfs:  ncheck 42484755
Inode	Pathname
42484755
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxcb1:amd64.triggers
42484755
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.triggers
42484755
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.triggers
42484755
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.triggers
debugfs:  ncheck 42484768
Inode	Pathname
42484768
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxft2:amd64.list
42484768
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxft2:amd64.list
42484768
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxft2:amd64.list
42484768
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxft2:amd64.list
debugfs:  ncheck 42484767
Inode	Pathname
42484767
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxft-dev:amd64.md5sums
42484767
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxft-dev:amd64.md5sums
42484767
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxft-dev:amd64.md5sums
42484767
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxft-dev:amd64.md5sums
debugfs:  ncheck 42484763
Inode	Pathname
42484763
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxdo3:amd64.shlibs
42484763
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxdo3:amd64.shlibs
42484763
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxdo3:amd64.shlibs
42484763
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxdo3:amd64.shlibs
debugfs:  ncheck 42484753
Inode	Pathname
42484753
/timeshift/snapshots/2018-11-28_20-00-02/localhost/var/lib/dpkg/info/libxcb1:amd64.shlibs
42484753
/timeshift/snapshots/2018-11-30_18-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.shlibs
42484753
/timeshift/snapshots/2018-12-02_21-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.shlibs
42484753
/timeshift/snapshots/2018-12-01_21-00-01/localhost/var/lib/dpkg/info/libxcb1:amd64.shlibs

Maybe timeshifts rsync is related to this?


Kind regards
Michael Hennig
