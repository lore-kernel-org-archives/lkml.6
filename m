Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2748774-1523735206-2-5882076266471897526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523735205; b=JXQ9KmBEqWQ8uPw1r4ozLdh9nQ6IJ/5+7tre0nVNDHnemzTHzY
    xY+YnZsbaY7jqGk5ik48iRo/0275lt/5KvivOe1aLZsAotlK0kN+B6/Cvhkf0jtt
    fv+T5pLmheLJfjsh11hb7F+NKvooLqF3t1D4uYguiwo1OBF6DqcNCm72mpXmn1Pk
    f0zNHMnqUBP1uaJbs91ZMX7aWB8R5lqS5r7vDO7bKdtx8ROpbb8QVzzictBiUlIV
    IqpVZpyX9xRRz4iS1k4+XaEib7FGf8YYYvEAucGXdNpe1qnJe0MXq8ZFM8CSxPt5
    7MvG4oa0mdfdqEKXrQ4uz3dNshLlbv5YUL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523735205;
    bh=M9aceykpfUK7IXEVvRPQmE/L8xvpXVkO3GvvvShvW+M=; b=WLN2tIkeSBSh
    7jbOwZTnheGCC84+CulJfh0hc0LbeGX4zAuB7bgc0pp4XAV9pXNIO192G0BX9P8/
    N306O6vehTXKN9Jlj7PozyfiO5rIope5omR2hSUfUKIiZV19uIDG9RgVW8Zh9SJ1
    RGgS56ObWM0iNKthnc1d8rxH//U2NV5+KoCiTdHtaPxFAbV4raEZQNvb0iINEeLd
    iu69LU7jyW8hhB3P0vgU3uTtSVyPzP2tM8Y3G9tAHctPJhBE+7cpGuHP5FGLryn/
    CqTnoehLYyH9ZqG3JPw1R/LhkJJ352mwDeizQKdz6GLhRU3pGdb/osu2QblOPTeT
    4lYeIEyPBw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qKooEvNF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CH17uZAM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qKooEvNF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CH17uZAM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKzOJFJvahPWNnKyUuBXQTMTF3sAuddP9E5zolB+5ZqeV4iVLuy1r7y5GZSCRAFoI8btVVR6aSrRLo4M1ckUTYGf0HZh2g+81t0vgdsOXZ9XH8CnpXo5
    GDRdBk7Vtg/svfaYgMEvuxtnWbJ+KzDq0+4BrPb/rdPAf06FmqV4fdOjM0ccg9CJ6ey2/TBk5sOIusEc0z2hP1KB3lQtNoHeXNNOiGDAWBnp1bpZZW6yQ/js
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=206n46q3nOkA:10 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8 a=RLnl5i_utrFzWVWSv_wA:9
    a=s5zTMl_WUhGlvoSe:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeDNTql (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 15:46:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34049 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeDNTqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Apr 2018 15:46:40 -0400
X-Google-Smtp-Source: AIpwx49EESulOMKshnX3CXtBsO0zpycaFSRVp7g72zt+kMKXFVhJ7zg4/D6NjmXyecijGoXiPeUe3A==
Subject: Re: blktest for [PATCH v2] block: do not use interruptible wait
 anywhere
To: Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
 <1523608284.7787.3.camel@suse.de>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
Date: Sat, 14 Apr 2018 20:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523608284.7787.3.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/04/18 09:31, Johannes Thumshirn wrote:
> Hi Alan,
>
> On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>    while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>    echo mem > /sys/power/state ; \
>>    sleep 5; killall dd  # stop after 5 seconds
> Can you please also add a regression test to blktests[1] for this?
>
> [1] https://github.com/osandov/blktests
>
> Thanks,
> 	Johannes

Good question. It would be nice to promote this test.

Template looks like I need the commit (sha1) first.

I had some ideas about automating it, so I wrote a standalone (see 
end).  I can automate the wakeup by using pm_test, but this is still a 
system suspend test.  Unfortunately I don't think there's any 
alternative. To give the most dire example

     # This test is non-destructive, but it exercises suspend in all drivers.
     # If your system has a problem with suspend, it might not wake up again.


So I'm not sure if it would be acceptable for the default set?

How useful is this going to be? Is there an expanded/full set of tests 
that gets run somewhere?

If you can't guarantee it's going to be run somewhere, I'd worry the 
cost/benefit  feels a little narrow :-(. There were one or two further 
"interesting" details, and it might theoretically bitrot if it's not run 
periodically.

If you look at the diff and title for the fix, I don't think it's at 
high risk of being reversed unintentionally.

And I think you can trust users will notice if the fix gets merged away 
accidentally, before it hits -stable releases :-). The issue kills the 
entire GUI session on resume from suspend, say once every three days, on 
gnome-shell (due to Xwayland). One unfortunate user switched to Xorg 
only to find that was also affected.  I honestly assume the issue 
applies generally to laptop systems.  The only mitigating factor is if 
you have RAM to spare, so you don't hit the major pagefaults during resume.

#!/bin/bash

# This test is non-destructive, but it exercises suspend in all drivers.
# If your system has a problem with suspend, it might not wake up again.

# TEST_DEV must be SCSI (inc. libata).
#
# Additionally, this test will abort if $TEST_DEV is too tiny
# and we finish reading it within 3 seconds.  Sorry.
TEST_DEV=sda

# RATIONALE
#
# The original root cause issue was the behaviour around blk_queue_freeze().
# It put tasks into an interruptible wait, which is wrong for block devices.
#
# XXX Insert reference to fix commit XXX
#
# The freeze feature is not directly exposed to userspace, so I can not test
# it directly :(.  (It's used to "guarantee no request is in use, so we can
# change any data structure of the queue afterward".  I.e. freeze, modify the
# queue structure, unfreeze).
#
# However, this lead to a regression with a decent reproducer.  In v4.15 the
# same interruptible wait was also used for SCSI suspend/resume.  SCSI resume
# can take a second or so... hence we like to do it asynchronously.  This
# means we can observe the wait at resume time, and we can test if it is
# interruptible.
#
# Note `echo quiesce > /sys/class/scsi_device/*/device/state` can *not*
# trigger the specific wait in the block layer.  That code path only
# sets the SCSI device state; it does not set any block device state.
# (It does not call into blk_queue_freeze() or blk_set_preempt_only();
#  it literally just sets sdev->sdev_state to SDEV_QUIESCE).

set -o nounset

abort() {
     echo "$*"
     echo "=== Test ERROR ==="
     exit 2
}

SYSFS_PM_TEST_DELAY=/sys/module/suspend/parameters/pm_test_delay
SAVED_PM_TEST_DELAY=

# Child process IDs
DD=
SUBSHELL=

cleanup() {
     # In many cases the subshell will already have exited...
     # and semantics for `wait` are crappy in shell.
     # Failure will be harmless in most cases.
     # Just try to provide enough context for the user to guess.

     echo "Cleaning up"
     
     if [ -n "$SUBSHELL" ]; then
         echo "Killing sub-shell PID $SUBSHELL..."
         kill $SUBSHELL
         wait $SUBSHELL
     fi
     if [ -n "$DD" ]; then
         echo "Killing 'dd' PID $DD..."
         kill $DD
         wait $DD
     fi

     echo "Resetting pm_test"
     echo none > /sys/power/pm_test
     
     echo "Resetting pm_test_delay"
     if [ -n "$SAVED_PM_TEST_DELAY" ]; then
         echo "$SAVED_PM_TEST_DELAY" > "$SYSFS_PM_TEST_DELAY"
     fi
}
trap cleanup EXIT

# "If a user has disabled async probing a likely reason
#  is due to a storage enclosure that does not inject
#  staggered spin-ups. For safety, make resume
#  synchronous as well in that case."
if ! SCAN="$(cat /sys/module/scsi_mod/parameters/scan)"; then
     abort "error reading '/sys/module/scsi_mod/parameters/scan' ?"
fi
if [ "$SCAN" != "async" ]; then
     abort "This test does not work if you have set 'scsi_mod.scan=sync'"
fi

# Ignore USR1, in the hope that this applies to child processes.
# This allows us to safely `kill -USR1 $DD`, when we don't know
# whether the child process has fully started yet.
#
# I think this is the only place I relied on the specific
# shell (bash) behaviour.
trap "" USR1

# Check dd can work
if ! dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null count=1 status=none; then
     abort "'dd'"
fi

# Start dd, as a background process which submits IOs and yells when one fails.
# We want to hit the block layer, so use direct IO to avoid being served from
# page cache.
dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null status=none &
DD=$!

if ! echo devices > /sys/power/pm_test; then
     abort "Setting pm_test failed, does your kernel lack CONFIG_PM_TEST?"
fi

if ! SAVED_PM_TEST_DELAY="$(cat "$SYSFS_PM_TEST_DELAY")"; then
     abort "error reading pm_test_delay"
fi
if ! echo 0 > "$SYSFS_PM_TEST_DELAY"; then
     abort "error setting pm_test_delay"
fi

# Just keep sending signals to 'dd' as long as it's alive.
# dd accepts USR1 signal to print status.  It doesn't seem to be a problem
# that we told dd not to actually *print* anything ('status=none').
#
# In theory this script is probably subject to various pid re-use races.
# But I started in sh... so far blktests does not depend on python...
# also direct IO is best to reproduce this, which is not built in to python.
#
( while kill -USR1 $DD 2>/dev/null; do true; done ) &

SUBSHELL=$!

# Wait a second without suspending, it might pick up typos
# or other unexpected errors.
sleep 1
if ! kill -0 $DD; then
     DD=
     wait $DD || echo "'dd' exited with error"
     abort "'dd' exited early?"
fi
if ! kill -0 $SUBSHELL; then
     SUBSHELL=
     abort "subshell exited early?"
fi

# Log that we're suspending.  User might not have guessed,
# or maybe suspend (or pm_test suspend) is broken on this system.
echo "Now simulating suspend/resume"

if ! echo mem > /sys/power/state; then
     abort "system suspend failed or not supported?"
fi

# Now wait for TEST_DEV to resume asynchronously
if ! dd iflag=direct if="/dev/$TEST_DEV" of=/dev/null count=1 status=none; then
     abort "'dd'"
fi

# Wait another second.  This might be useful in the case dd got blocked on a
# page fault during the suspend; it will have a second to get sorted out,
# while potentially receiving an IO error and exiting.
sleep 1

if ! kill -0 $DD 2>/dev/null; then
     if wait $DD; then
         DD=
         abort "'dd' exited early, without error.  Device too tiny?"
     fi
     
     echo "'dd' exited with error"
     echo "=== Test FAIL ==="
     DD=
     exit 1
fi
echo "=== Test PASS ==="
