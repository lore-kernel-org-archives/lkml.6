Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R2zZIBDIGVtKagAAmS7hNA
	; Fri, 08 Jun 2018 00:07:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 097326074D; Fri,  8 Jun 2018 00:07:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JERBz0pq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6AF4960290;
	Fri,  8 Jun 2018 00:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AF4960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeFHAHJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:07:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59210 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeFHAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=luodI2Y1LPtjolK47Bhx+AS0gYS+PZBx1b5+Ma50Cd0=; b=JERBz0pqyt8kOYPfyeahWPqhP
        XW6QvOBThtNbn+NPsHQ79jOZEdxax2mq1EGqOiISnB+IPtaq3a+93ubHvURgb+oeZfA8nzn+YKhoi
        tRVtLMQWyFmDY+ydLbIBTLkGMkvMQe1p4/stsD1l2DFiNSlUUdDbLZT8pmcFp9P1kx2To1Mc3+VdO
        Hr9H7EEALRh9sDF8aXJpD/6TCj0VwcMQHAfjmWPkiSKURZmtrxZwFCDf2akCHmCZ7JLwa/odhYkrv
        fvdE84MSkc94Wxfq/+28BB3XDOXp9n/Vsj3l28Eqqc3lY4903IpWiMbUkQiiXxEpqs7g7Tkb0NtNi
        QcB+qLBng==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR4vn-0003xm-U9; Fri, 08 Jun 2018 00:07:04 +0000
Subject: Re: [PATCH] uapi: Make generic uapi headers compile standalone.
To: Jayant Chowdhary <jchowdhary@google.com>,
        linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, kernel-team@android.com,
        linux-kbuild@vger.kernel.org
References: <20180606231602.231326-1-jchowdhary@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b6b6dd56-c948-54e8-df95-3d170a3c1e7d@infradead.org>
Date: Thu, 7 Jun 2018 17:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606231602.231326-1-jchowdhary@google.com>
Content-Type: multipart/mixed;
 boundary="------------B62B25DCCC7D3ABB45F9F1E7"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B62B25DCCC7D3ABB45F9F1E7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 06/06/2018 04:16 PM, Jayant Chowdhary wrote:
> In order for static analysis tools to analyze each of the uapi headers,
> we need to enable them to compile stand-alone. Some uapi headers were
> missing dependencies which would not make them compile stand-alone in
> user-land. This patch adds those dependencies.

Hi,

Thanks for getting started on this.  I see that the kbuild robot and I were
still not able to do successful builds even after this patch is applied.
We were building different targets though.  robot was doing kernel builds
and I was doing a large "all-uapi" build.

I started on my all-uapi work about 1 week ago but haven't posted anything yet,
but it's posted (attached) below.  It's not yet up to kernel quality yet (for a
Makefile), and I have made very little progress toward a successful userspace build.

If anyone is interested, just put these 3 files in <kernel_tree>/tools/build
and then run:

make ARCH=$some_arch O=build_dir headers_check
so that the headers will be cleaned up and installed in build_dir/usr/.

Then run 'make -f all-uapi.mk'
and the userspace program with all header files found in build_dir/usr/include
will be built -- i.e., attempted (not successfully).

(note: chmod +x hdr-fix-lines.pl)


-- 
~Randy

--------------B62B25DCCC7D3ABB45F9F1E7
Content-Type: text/x-makefile;
 name="all-uapi.mk"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="all-uapi.mk"

# all-uapi.mk
# currently resides in tools/build/
#
# before running 'make -f all-uapi.mk',
# run (from top of kernel tree): make ARCH=arch O=dir headers_check
# so that the uapi headers will be installed.

srctree=../..
CC=gcc

all: all-uapi.h all-uapi.o

all-uapi.h: all-uapi.mk hdr-fix-lines.pl
	rm -f all-uapi.h
	touch all-uapi.h
#	find $(srctree)/xx64/usr/include/uapi -type f | grep -v \\.orig |
	find $(srctree)/xx64/usr/include -type f | grep -v \\.orig | \
		./hdr-fix-lines.pl >>all-uapi.h

all-uapi.o: all-uapi.h
	$(CC) -I../../xx64/usr/include all-uapi.c -o all-uapi.o

--------------B62B25DCCC7D3ABB45F9F1E7
Content-Type: text/x-csrc;
 name="all-uapi.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="all-uapi.c"

// SPDX GPL 2.0
// This userspace source file pulls in all #include <uapi/*> header files
// to see what kinds of problems happen.

#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>

#include <linux/posix_types.h>
#include <asm-generic/ipcbuf.h>

#include "all-uapi.h"

int main(int argc, char *argv[])
{
}

--------------B62B25DCCC7D3ABB45F9F1E7
Content-Type: application/x-perl;
 name="hdr-fix-lines.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdr-fix-lines.pl"

#! /usr/bin/perl

# $_ is a filename like ../../include/uapi/linux/prctl.h
# convert it to be like: $include <uapi/linux/prctl.h>
# input via stdin; output to stdout.
# vi:ts=4

LINE:
	while ($line = <STDIN>) {
		chomp $line;		# drop ending newline

		# skip if not a .h file
		next LINE if ($line !~ m/\.h$/);
		# skip any /asm.*posix_types/
		next LINE if ($line =~ "asm.*posix_types");

		$line =~ s@^.*include/@#include <@;
		$line =~ s@\.h$@.h>@;

		print "$line\n";
	} ### < STDIN

--------------B62B25DCCC7D3ABB45F9F1E7--
