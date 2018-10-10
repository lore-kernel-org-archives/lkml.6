Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E63C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF00D2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=clearskydata-com.20150623.gappssmtp.com header.i=@clearskydata-com.20150623.gappssmtp.com header.b="RGBSsBDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF00D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=clearskydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJKEXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:23:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40175 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKEXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:23:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id b4-v6so7399587qtc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clearskydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=7UNc6dFvjtWnKM1iq0ieYng9R4F/GnVCro+JcbsgTfE=;
        b=RGBSsBDJzR+jLGerpjGFHcdlq4QqgU1o5y0rQ5i8W2DINODr0stBjRXEvWI3hMRgCu
         cqclm0Hm70urTc2FCp/I2RIA9OYAnO+wrSlkHsUQLLGP3G1wXwmYFs9Cq7jWWTXXMaOh
         so5vv2dXTbWWoc2oEBYwDLt9wmYUyQX+Tmcv6bbJLv3wRr8iAEk1b1S55rK2b8Uc50uU
         Vrdo60m0bvCZKidlwnvgldw73G87namJXWYjtjsIFXBVXA9EckRL9cROWtOK1eXedzt5
         VZCeGuLHNYPFhONs8wrWvoJlS2FIelyGldeS2INr1uTLNt9+QVneWKZgOYJOfpwBFGRr
         1HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7UNc6dFvjtWnKM1iq0ieYng9R4F/GnVCro+JcbsgTfE=;
        b=GgwxDBTWoGzOWHXmvmmcCkSGHLfMtbfIbg2yqqJjq6Qld6dAgPUozC4fJWyx8myxHo
         IOT1NE2poe+pnR5Dmr1hzphbtxqHflKI/u9EKdZTV2z+ly1K02n6Xkj2vbISgD1puRJY
         gwso9qqc15XwGhP0wuXpLd9RX42rA/BnZG11lGmEc6U+SduevbFZDBRl+AulyC2ykKnF
         7LXkLPFi3Xa3/lcs1ykJLArmiTm9H/Z277SZQ3EnyAPef4Wk4twAJoX9RqgF2WfEzd7o
         bG4LWuNzYhD3oJZsEcTk3JTb4Va2h/Aia5PKxtc0RUT/6J5eMIfwokcFcd8ljkXSKwey
         2+0Q==
X-Gm-Message-State: ABuFfogzf7ozigVegQKfsEf1X1qR7SWiPiHccvzmlJJ7DNdY5qW6S4f3
        xpl5zeOneQseN/kR6tfTJfRlGGFwM5lVb3uUf665EIfmVck=
X-Google-Smtp-Source: ACcGV62m6szRWXBW+7b0u4vwbm7XJVLsOUlw+yIgxrIeWHp0NgpFo6ZwKYwbrmTvdBadonQcHTxByfG5ZwehGl5PIJQ=
X-Received: by 2002:aed:2905:: with SMTP id s5-v6mr29829159qtd.101.1539205176747;
 Wed, 10 Oct 2018 13:59:36 -0700 (PDT)
MIME-Version: 1.0
From:   David Chen <dchen@clearskydata.com>
Date:   Wed, 10 Oct 2018 16:59:25 -0400
Message-ID: <CADfq4ba3pNwLc-7M5K8YiRB8r_2n8qE-XqA0ozyxGWkyZ_iqnw@mail.gmail.com>
Subject: PROBLEM: SCSI write error not seen by Linux AIO?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] SCSI write error not seen by Linux AIO?

[2.] Full description of the problem/report:
I filed a bug ( https://bugzilla.kernel.org/show_bug.cgi?id=201257 )
that looks pretty serious but quite possibly I've made some mistake. I
emailed the Linux AIO mailing list about it over a week ago but haven't
received any response.

The bug (as I see it) is: I do Linux AIO to write to a SCSI device, and
if the SCSI device returns an error (e.g. WRITE ERROR - AUTO
REALLOCATION FAILED) then I get a success from Linux AIO! Of course I
expect Linux AIO to indicate to me in some way that the write didn't
succeed, but AFAICT I get no such indication. I'm seeing this on the 4.9
LTS kernel but not on 4.18.10 (i.e. on 4.18.10 Linux AIO reports an I/O
error as expected), and I've reproduced this on a VMware VM as well as a
bare metal x86 server. I've reproduced this using both a fake SCSI
device created using the scsi_debug module as the SCSI device, and
ClearSky storage as the SCSI device. The bugzilla entry includes more
details, including reproduction steps.

[3.] Keywords (i.e., modules, networking, kernel): SCSI, Linux AIO
[4.1.] Kernel version (from /proc/version):
Linux version 4.9.129+ (dchen@qf-l208-a.dev-bos.csdops.net) (gcc
version 4.9.1 (GCC) ) #1 SMP Mon Oct 1 21:10:31 UTC 2018

[5.] Most recent kernel version which did not have the bug:
I only see it on 4.9 kernels. I see it on 4.9.0 and 4.9.129
(i.e. almost the most recent 4.9 kernel).

[7.] A small shell script or example program which triggers the
     problem (if possible)
There are test logs in the bugzilla entry (and pasted below),
but the steps I take to reproduce this are:
1) Boot a 4.9 kernel with the scsi_debug kludge applied.
2) Create a scsi_debug fake scsi device (i.e. "modprobe scsi_debug").
3) Enable write faults on that device
(e.g. "echo 2 > /sys/module/scsi_debug/parameters/opts")
4) Run the test program and observe that it doesn't fail an assert().
(e.g. "./aio_test /dev/sdb")
5) Check /var/log/messages to verify that SCSI saw an error.

Is this a serious bug, or does anyone see where I've made a mistake?

Thanks!

The following is information from the bugzilla entry for anyone who
prefers to see the info in email as opposed to bugzilla. For people
who prefer bugzilla there's nothing interesting below:

My test program (a slightly edited version of
https://gist.github.com/larytet/87f90b08643ac3de934df2cadff4989c) uses
Linux AIO to do a single write of 512B. I've included the program below.
The device I'm writing to is a fake SCSI device created by the
scsi_debug kernel module. I've added a small kludge to the scsi_debug
kernel module to return a WRITE ERROR - AUTO REALLOCATION FAILED error
when the SCSI device is written to. I've included a patch for the kludge
below.

I get this unexpected (to me anyway) behavior on kernel versions 4.9.129
and 4.9.0. I do get an error as I expect on kernel versions 4.18.10,
4.14.7, and 4.1.8.

I'm checking that the result code is zero for each of: the io_event
filled in by io_getevents(), the return code of io_setup(),
io_destroy(), fsync(), and close(). I'm checking that the result code
is 1 for each of io_submit() and io_getevents().

When I use dd to do a standard write() to the SCSI device, instead of
using Linux AIO, then I get an I/O error as expected. Also when I use
device mapper to create a flakey device
(e.g. "dmsetup create dchen-test --table="0 `blockdev --getsz /dev/sdg`
flakey /dev/sdg 0 9 1"), instead of using a SCSI device, then I get an
I/O error as expected.

This looks like a bug to me, but certainly I could have missed checking
a return code somewhere, or maybe I'm not supposed to get an error back
for a reason I don't know about yet, or...?

It could be that I'm seeing this unexpected (to me) behavior because of
some quirk with the scsi_debug fake SCSI device. However, I originally
ran into this behavior when testing against my company's ClearSky
Storage, using both iSCSI and Fibre Channel targets. Since I've seen it
on these different targets, I think it's unlikely to be some quirk of
scsi_debug.

Here are logs from my tests:

Test log for unexpected behavior on 4.9.129:

[root@vm-dchen ~]# uname -r
4.9.129+
[root@vm-dchen ~]# modprobe scsi_debug
[root@vm-dchen ~]# lsscsi
[1:0:0:0]    disk    VMware   Virtual disk     1.0   /dev/sda
[3:0:0:0]    disk    Linux    scsi_debug       0186  /dev/sdb
[root@vm-dchen ~]# dd if=/dev/zero of=/dev/sdb oflag=direct bs=512 count=1
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.00116091 s, 441 kB/s
[root@vm-dchen ~]#
[root@vm-dchen ~]# date
Thu Sep 27 17:00:45 EDT 2018
[root@vm-dchen ~]# echo 2 > /sys/module/scsi_debug/parameters/opts
[root@vm-dchen ~]# dd if=/dev/zero of=/dev/sdb oflag=direct bs=512 count=1
dd: error writing ?/dev/sdb?: Input/output error
1+0 records in
0+0 records out
0 bytes (0 B) copied, 0.0459316 s, 0.0 kB/s
[root@vm-dchen ~]#
[root@vm-dchen ~]# date
Thu Sep 27 17:01:01 EDT 2018
[root@vm-dchen ~]# ./aio_test /dev/sdb
[root@vm-dchen ~]#


And /var/log/messages output:
Sep 27 17:00:30 vm-dchen kernel: scsi host3: scsi_debug: version 1.86 [20160430]
  dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
Sep 27 17:00:30 vm-dchen kernel: scsi 3:0:0:0: Direct-Access     Linux
   scsi_debug       0186 PQ: 0 ANSI: 7
Sep 27 17:00:30 vm-dchen kernel: sd 3:0:0:0: [sdb] 16384 512-byte
logical blocks: (8.39 MB/8.00 MiB)
Sep 27 17:00:30 vm-dchen kernel: sd 3:0:0:0: [sdb] Write Protect is off
Sep 27 17:00:30 vm-dchen kernel: sd 3:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, supports DPO and FUA
Sep 27 17:00:30 vm-dchen kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Sep 27 17:00:30 vm-dchen multipathd: sdb: add path (uevent)

Sep 27 17:00:54 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#118 FAILED
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Sep 27 17:00:54 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#118 Sense Key :
Medium Error [current]
Sep 27 17:00:54 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#118 Add. Sense:
Write error - auto reallocation failed
Sep 27 17:00:54 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#118 CDB:
Write(10) 2a 00 00 00 00 00 00 00 01 00
Sep 27 17:00:54 vm-dchen kernel: blk_update_request: I/O error, dev
sdb, sector 0

Sep 27 17:01:18 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#163 FAILED
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Sep 27 17:01:18 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#163 Sense Key :
Medium Error [current]
Sep 27 17:01:18 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#163 Add. Sense:
Write error - auto reallocation failed
Sep 27 17:01:18 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#163 CDB:
Write(10) 2a 00 00 00 00 00 00 00 01 00
Sep 27 17:01:18 vm-dchen kernel: blk_update_request: I/O error, dev
sdb, sector 0


Test log for expected behavior on 4.18.10:

[root@vm-dchen ~]# uname -r
4.18.10+
[root@vm-dchen ~]# modprobe scsi_debug
[root@vm-dchen ~]# lsscsi
[1:0:0:0]    disk    VMware   Virtual disk     1.0   /dev/sda
[3:0:0:0]    disk    Linux    scsi_debug       0188  /dev/sdb
[root@vm-dchen ~]# dd if=/dev/zero of=/dev/sdb oflag=direct bs=512 count=1
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.0012098 s, 423 kB/s
[root@vm-dchen ~]#
[root@vm-dchen ~]# date
Thu Sep 27 16:41:13 EDT 2018
[root@vm-dchen ~]# echo 2 > /sys/module/scsi_debug/parameters/opts
[root@vm-dchen ~]# dd if=/dev/zero of=/dev/sdb oflag=direct bs=512 count=1
dd: error writing ?/dev/sdb?: Input/output error
1+0 records in
0+0 records out
0 bytes (0 B) copied, 0.0465222 s, 0.0 kB/s
[root@vm-dchen ~]#
[root@vm-dchen ~]# date
Thu Sep 27 16:41:31 EDT 2018
[root@vm-dchen ~]# ./aio_test /dev/sdb
I/O res: -5
aio_test: /mnt/nfs/home/dchen/linux_aio_test_scsi_debug2.c:88: int
main(int, char**): Assertion `events[0].res == 512' failed.
Aborted (core dumped)


And /var/log/messages:
Sep 27 16:40:54 vm-dchen kernel: scsi host3: scsi_debug: version 0188 [20180128]
  dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
Sep 27 16:40:54 vm-dchen kernel: scsi 3:0:0:0: Direct-Access     Linux
   scsi_debug       0188 PQ: 0 ANSI: 7
Sep 27 16:40:54 vm-dchen kernel: sd 3:0:0:0: Power-on or device reset occurred
Sep 27 16:40:54 vm-dchen kernel: sd 3:0:0:0: [sdb] 16384 512-byte
logical blocks: (8.39 MB/8.00 MiB)
Sep 27 16:40:54 vm-dchen kernel: sd 3:0:0:0: [sdb] Write Protect is off
Sep 27 16:40:54 vm-dchen kernel: sd 3:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, supports DPO and FUA
Sep 27 16:40:54 vm-dchen kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
Sep 27 16:40:54 vm-dchen multipathd: sdb: add path (uevent)

Sep 27 16:41:23 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 FAILED
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Sep 27 16:41:23 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 Sense Key :
Medium Error [current]
Sep 27 16:41:23 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 Add. Sense:
Write error - auto reallocation failed
Sep 27 16:41:23 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 CDB:
Write(10) 2a 00 00 00 00 00 00 00 01 00
Sep 27 16:41:23 vm-dchen kernel: print_req_error: I/O error, dev sdb, sector 0

Sep 27 16:41:43 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 FAILED
Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Sep 27 16:41:43 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 Sense Key :
Medium Error [current]
Sep 27 16:41:43 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 Add. Sense:
Write error - auto reallocation failed
Sep 27 16:41:43 vm-dchen kernel: sd 3:0:0:0: [sdb] tag#76 CDB:
Write(10) 2a 00 00 00 00 00 00 00 01 00
Sep 27 16:41:43 vm-dchen kernel: print_req_error: I/O error, dev sdb, sector 0

--- snip test program starts ---
/**
 * Based on https://www.fsl.cs.sunysb.edu/~vass/linux-aio.txt
 * Compile gcc -Wall test_aio.c -o test_aio
 * Run rm -rf /tmp/testfile ;./iotest
 */

/**
 * Based on https://gist.github.com/larytet/87f90b08643ac3de934df2cadff4989c
 */

#ifndef _GNU_SOURCE
#define _GNU_SOURCE /* syscall() is not POSIX */
#endif

#include <stdio.h> /* for perror() */
#include <unistd.h> /* for syscall() */
#include <sys/syscall.h> /* for __NR_* definitions */
#include <linux/aio_abi.h> /* for AIO types and constants */
#include <fcntl.h> /* O_RDWR */
#include <string.h> /* memset() */
#include <inttypes.h> /* uint64_t */
#include <assert.h>

#define TEST_IO_SIZE 512

static  int io_setup(unsigned nr, aio_context_t *ctxp)
{
return syscall(__NR_io_setup, nr, ctxp);
}

static int io_destroy(aio_context_t ctx)
{
return syscall(__NR_io_destroy, ctx);
}

static int io_submit(aio_context_t ctx, long nr,  struct iocb **iocbpp)
{
return syscall(__NR_io_submit, ctx, nr, iocbpp);
}

static int io_getevents(aio_context_t ctx, long min_nr, long max_nr,
struct io_event *events, struct timespec *timeout)
{
return syscall(__NR_io_getevents, ctx, min_nr, max_nr, events, timeout);
}

int main(int argc, char **argv)
{
aio_context_t ctx;
struct iocb cb;
struct iocb *cbs[1];
char data[TEST_IO_SIZE] __attribute__ ((aligned (4096)));
struct io_event events[1];
int ret;
int fd;

assert(argc == 2);
char const *testfn = argv[1];

fd = open(testfn, O_RDWR | O_DIRECT);
assert(fd > 0);

ctx = 0;

ret = io_setup(128, &ctx);
assert(ret == 0);

/* setup I/O control block */
memset(&cb, 0, sizeof(cb));
cb.aio_fildes = fd;
cb.aio_lio_opcode = IOCB_CMD_PWRITE;

/* command-specific options */
cb.aio_buf = (uint64_t)data;
cb.aio_offset = 0;
cb.aio_nbytes = TEST_IO_SIZE;

cbs[0] = &cb;

ret = io_submit(ctx, 1, cbs);
assert(ret == 1);

/* get the reply */
ret = io_getevents(ctx, 1, 1, events, NULL);
assert(ret == 1);
if (events[0].res != TEST_IO_SIZE)
 printf("I/O res: %d\n", events[0].res);
assert(events[0].res == TEST_IO_SIZE);

ret = io_destroy(ctx);
assert(ret == 0);

ret = fsync(fd);
assert(ret == 0);

ret = close(fd);
assert(ret == 0);
return 0;
}
--- snip test program ends ---

--- snip patch for scsi_debug kluge starts ---
--- a/drivers/scsi/scsi_debug.c
+++ a/drivers/scsi/scsi_debug.c
@@ -70,6 +70,7 @@ static const char *sdebug_version_date = "20160430";
 #define NO_ADDITIONAL_SENSE 0x0
 #define LOGICAL_UNIT_NOT_READY 0x4
 #define LOGICAL_UNIT_COMMUNICATION_FAILURE 0x8
+#define WRITE_ERROR_AUTO_REALLOCATION_FAILED_ASC 0xc
 #define UNRECOVERED_READ_ERR 0x11
 #define PARAMETER_LIST_LENGTH_ERR 0x1a
 #define INVALID_OPCODE 0x20
@@ -95,6 +96,7 @@ static const char *sdebug_version_date = "20160430";
 #define MICROCODE_CHANGED_WO_RESET_ASCQ 0x16

 /* Additional Sense Code Qualifier (ASCQ) */
+#define WRITE_ERROR_AUTO_REALLOCATION_FAILED_ASCQ 0x2
 #define ACK_NAK_TO 0x3

 /* Default values for driver parameters */
@@ -2918,6 +2920,13 @@ static int resp_write_dt0(struct scsi_cmnd
*scp, struct sdebug_dev_info *devip)
                return check_condition_result;
        }

+       if (unlikely((SDEBUG_OPT_MEDIUM_ERR & sdebug_opts))) {
+         mk_sense_buffer(scp, MEDIUM_ERROR,
+                         WRITE_ERROR_AUTO_REALLOCATION_FAILED_ASC,
+                         WRITE_ERROR_AUTO_REALLOCATION_FAILED_ASCQ);
+         return check_condition_result;
+       }
+
        write_lock_irqsave(&atomic_rw, iflags);

        /* DIX + T10 DIF */
--- snip patch for scsi_debug kludge ends ---
