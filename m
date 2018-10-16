Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626AFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B9C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJPNw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:52:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:58523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:52:26 -0400
Received: from ls3530.fritz.box ([92.116.157.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqV4f-1fhLLV1ue9-00e7MK; Tue, 16
 Oct 2018 08:03:28 +0200
Received: from ls3530.fritz.box ([92.116.157.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqV4f-1fhLLV1ue9-00e7MK; Tue, 16
 Oct 2018 08:03:28 +0200
Date:   Tue, 16 Oct 2018 08:03:24 +0200
From:   Helge Deller <deller@gmx.de>
To:     Adam Borowski <kilobyte@angband.pl>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH] extract-vmlinux: Check for uncompressed image as fallback
Message-ID: <20181016060324.GA10928@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:3LD6VWcVSZLWL9kuwnFJZhNhrNSuerLp3xcpjk6M0bROoS7bkDx
 DjAyy4TPKpG4f2pKNwA6qIFLc5cIYqQUmx7bRBVugRNJigH86uTSWklsSNYr1sBp4cEuMx+
 ZZPZdAkJ8U3BOu5z7SMx/36CdpbViNNd0bifOIi5dkykwpgv0nDKBEG+/yOOJGDNMgACV5o
 TytuCsc/b+Yu1raOm3M/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tJQ9YFWuCMM=:k2DJmOJRH6aGUhJZmxPCxr
 2lzUooxp+IhDQDNpSwtwXM6LN1BL2HVUCxak5EmOxLEZ+Xg57xplbsLw9AgGuM+EihRNw7HE+
 sZME1sdYRDwPLj8ix/bCZkwTM4IDQUeQ3/gsqt8iNv68UvuET00Bk8ao4+K7Jj+0mq3YKpGAR
 sh77dt1FgGYqepSpH2OFQipcEqXbURoJktP8e2zKuGUDXbZmCfqfdtAFZgqveb25Ylu/oeUUa
 q5EgSTdvgNDxrICRvSoBKOzmNsCkK2gtSJZNsVIiSxdMy/dSIfC4bQsngq1g+9DBzVH0Vgx/3
 /vXBcyyaTtXS+4pr+BFAtUG9EAnrD5w7AcT8qkVt0MJ6Ntevaiul65UB84Gxssbn9EiRm2CZA
 leY4xU5au1mC8uorKXtvLc0X5+6bI73oeyVQ0aaNUbQobdsk+ktTxwa7QsoKXF+llePbI87UC
 O/jSMjuRCGYnHRd5nOiydcvh/3cpb8s8VV0wVTXLNaE8WfMr/edGtH+4VDPHcZMMCu4I9h8Nk
 P41gnzf3jHd6BsHSV7ztqtAH4D/oOd7+4RsAdRmhVlkl1A4kkiYGNdgwzJpmAr27vDHoUDvFU
 XgKf4rCg4GoA0ZBDvzQyC66h1zwEmto83wMrukFQQVPiIthCiAZ5CgARlPT3sHlr8x75KBKX0
 oVJaMm5oS7yBo3zeFwuo8UWH4tl/ltx5F5x77kDj9y6tCJDEo3wdQR1O/pk43yHOoRnwNOeZz
 GVj4Le4pIjhDDKtkje4zgNlph33THZgb4+J0WI6dA88TUrS54FAmHF+WTgRJCr/n9gRL+4OO1
 IXBTSexAhIV6op5z6e1UvmyAgrK0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As on x86-64 and other architectures, the boot kernel on parisc (vmlinuz
and bzImage) contains a full compressed copy of the final kernel
executable (vmlinux.bin.gz), which one should be able to extract with
the extract-vmlinux script.

But on parisc extracting the kernel with extract-vmlinux fails.
Currently the script first checks if the given file is an ELF file
(which is true on parisc) and if so returns it.  Thus on parisc we
unexpectedly get back the vmlinuz boot file instead of the uncompressed
vmlinux image.

This patch fixes this issue by reverting the logic. It now first tries
to find a compression signature in the given file and if that fails it
checks the file itself as fallback.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index e6239f39abad..85e1f32fb4a0 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -48,9 +48,6 @@ fi
 tmp=$(mktemp /tmp/vmlinux-XXX)
 trap "rm -f $tmp" 0
 
-# Initial attempt for uncompressed images or objects:
-check_vmlinux $img
-
 # That didn't work, so retry after decompression.
 try_decompress '\037\213\010' xy    gunzip
 try_decompress '\3757zXZ\000' abcde unxz
@@ -60,5 +57,8 @@ try_decompress '\211\114\132' xy    'lzop -d'
 try_decompress '\002!L\030'   xxx   'lz4 -d'
 try_decompress '(\265/\375'   xxx   unzstd
 
+# Finally check for uncompressed images or objects:
+check_vmlinux $img
+
 # Bail out:
 echo "$me: Cannot find vmlinux." >&2
