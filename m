Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1577CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6E21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netrounds-com.20150623.gappssmtp.com header.i=@netrounds-com.20150623.gappssmtp.com header.b="DRAzfPJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfADIV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:21:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41292 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfADIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:21:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so31790440ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netrounds-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NILzrmkyTJ7/wvG7cfrJ73pNIAK5HV4ABnNyKOHh2gk=;
        b=DRAzfPJpRzhfDxLIN4MerZWGroHrLFwgA5VJcKObqZU2HLuS/Fcx22lLO+0m+kT6VO
         rU5DBpIM/xKb/tMHS8LOom2E4E4AYk9GfzG/5/2KXsAL6EyQBaJ6er61rDfZSsS+AuPT
         2hm6/1WmGaTeRIfoBejFMc9eu/BpMllE/NFViEYGmZTWtZ6W2RjA4aR8m4+DW/kco77Z
         Z599rgsyApXCP28KMLPFAGxKp8n55owulCqxbusdu9gbI1xqBoma0Pd9BOtDhiC0uL45
         ajg94PJdbncQqBjsiIVWF3vBYJNUBUC/0pBpzA2qZZppjXhwYeU3lUR9A/yYPm1z7isp
         Nc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NILzrmkyTJ7/wvG7cfrJ73pNIAK5HV4ABnNyKOHh2gk=;
        b=fw6J+WPAE9JOaTyyFMbqOpsuO0EujNJ7yAX8VpBJpoD/R6I2jGAU52XhAxvdKYD3kP
         1eoseYQBSyMfwHJoRFt2GBKw1fxL8BrFJFz67H9kCboSOprdh1oeydTQAZV4oYIXCuNd
         jD7SNbXjkyWQex5p/iG0MMkMA0EDYTqpqNuV2UScnVXJY6O8rQ5VsYN6ftArmPwyeLqx
         ps2HPLO8hs/+0Pg0+6nRSj9M8kJjV/v6qUhJ5lrv9Ng9khwYvRs0ILX3pfq4zw0ghrnO
         yejwoBhOSRxWVifS9Ux7swm3ZG1coUPxq5SxTqY5C/8xbXvf433V++x28fWh7++zIYKz
         JUoA==
X-Gm-Message-State: AJcUukenBDfGMSNDmKMb55AAT5iVFFp3j2EIr0NyS233M4bWqZk9uATL
        nLrHYGPcomoJDiL2gt11NWEooceRXqE=
X-Google-Smtp-Source: ALg8bN66/+5ejZs2kmLVLGHle9nKZ81magjxhhvFzzCPRuV/k5lrhdOvXb1sCbiDX3wTv28dcdGKuw==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr31089572ljd.21.1546590085883;
        Fri, 04 Jan 2019 00:21:25 -0800 (PST)
Received: from [10.10.134.108] (31-186-192-122.static.chello.pl. [31.186.192.122])
        by smtp.gmail.com with ESMTPSA id p19-v6sm12318755ljb.47.2019.01.04.00.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 00:21:25 -0800 (PST)
To:     adobriyan@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?B?TWF0ZXVzeiBTdMSZcGllxYQ=?= 
        <mateusz.stepien@netrounds.com>
Subject: PROBLEM: Old content of /proc/net after switching network namespace
Message-ID: <4749d3bd-eac9-2a3e-aa93-d76d2e015945@netrounds.com>
Date:   Fri, 4 Jan 2019 09:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

After changing network namespace using setns, the content of /proc/net 
still represents the original namespace.
It looks like procfs dentries are not invalidated in dcache properly 
after the namespace switch.
It happens only, when you read content of /proc/net before changing 
namespace
The problem is reproducible in 4.19.13 but not in 4.14.X.
Bisecting the stable kernel tree shows that the commit
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=1da4d377f943fe4194ffb9fb9c26cc58fad4dd24 
introduced the problem.
Reverting mentioned commit resolves it.

MCVE (slightly modified example from [man 2 setns]):

#define _GNU_SOURCE
#include <fcntl.h>
#include <sched.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                         } while (0)

void print_dev()
{
     int fd2;
     fd2 = open("/proc/net/dev", O_RDONLY);
     char buf[2048] = {0};
     read(fd2, buf, 2048);
     printf("%s", buf);
     close(fd2);
}
int
main(int argc, char *argv[])
{
     int fd;

     printf("before namespace switch =========\n");
     print_dev();
     fd = open(argv[1], O_RDONLY); /* Get file descriptor for namespace */
     if (fd == -1)
         errExit("open");

     if (setns(fd, 0) == -1)       /* Join that namespace */
         errExit("setns");

     printf("after namespace switch ++++++++++\n");
     print_dev();
     return 0;
}


Steps to reproduce (assuming we have an interface named enp0s9):

ip netns add test
ip link set dev enp0s9 netns test
ip netns exec test sleep 30 &
gcc -o mcve mcve.c # mcve.c contains above C code
./mcve /proc/$(pidof sleep)/ns/net
# before namespace switch =========
# Inter-|   Receive                                                | 
Transmit
#  face |bytes    packets errs drop fifo frame compressed 
multicast|bytes    packets errs drop fifo colls carrier compressed
#     lo:       0       0    0    0    0     0          0         0 
   0       0    0    0    0     0       0          0
#    br0:       0       0    0    0    0     0          0         0 
   0       0    0    0    0     0       0          0
# enp0s3:  149625    1117    0    0    0     0          0         1 
61664     485    0    0    0     0       0          0
# docker0:       0       0    0    0    0     0          0         0 
    0       0    0    0    0     0       0          0
# enp0s8:   17086      60    0    0    0     0          0        29 
1006      13    0    0    0     0       0          0
# after namespace switch ++++++++++
# Inter-|   Receive                                                | 
Transmit
#  face |bytes    packets errs drop fifo frame compressed 
multicast|bytes    packets errs drop fifo colls carrier compressed
#     lo:       0       0    0    0    0     0          0         0 
   0       0    0    0    0     0       0          0
#    br0:       0       0    0    0    0     0          0         0 
   0       0    0    0    0     0       0          0
# enp0s3:  150813    1135    0    0    0     0          0         1 
64348     503    0    0    0     0       0          0
# docker0:       0       0    0    0    0     0          0         0 
    0       0    0    0    0     0       0          0
# enp0s8:   17086      60    0    0    0     0          0        29 
1006      13    0    0    0     0       0          0
ip netns exec test cat /proc/net/dev
## Should display
# Inter-|   Receive                                                | 
Transmit
# face |bytes    packets errs drop fifo frame compressed multicast|bytes 
    packets errs drop fifo colls carrier compressed
#    lo:       0       0    0    0    0     0          0         0 
  0       0    0    0    0     0       0          0
# enp0s9:   10438      33    0    0    0     0          0        17 
936      12    0    0    0     0       0          0

output from awk -f scripts/ver_linux

Linux test-agent 4.19.13 #1 SMP PREEMPT Thu Jan 3 12:03:20 UTC 2019 
x86_64 GNU/Linux

Util-linux          	2.29.2
Mount               	2.29.2
Module-init-tools   	23
E2fsprogs           	1.43.4
Linux C Library     	2.24
Dynamic linker (ldd)	2.24
Linux C++ Library   	6.0.22
Procps              	3.3.12
Net-tools           	2.10
Sh-utils            	8.26
Udev                	232
Modules Loaded      	ahci ata_generic ata_piix crc32c_intel e1000 
ehci_hcd ehci_pci i2c_core i2c_piix4 libahci serio_raw usb_common usbcore
