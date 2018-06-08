Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +PvELyYtGlv0KgAAmS7hNA
	; Fri, 08 Jun 2018 07:16:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2C08D607E4; Fri,  8 Jun 2018 07:16:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4230A60590;
	Fri,  8 Jun 2018 07:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4230A60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeFHHQX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:16:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:34161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeFHHQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:16:22 -0400
Received: from homer.simpson.net ([185.191.216.72]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lubnw-1gQxGb0fc8-00zokR; Fri, 08
 Jun 2018 09:16:17 +0200
Message-ID: <1528442176.4678.10.camel@gmx.de>
Subject: regression: "95cde3c59966 debugfs: inode: debugfs_create_dir uses
 mode permission from parent" terminally annoys libvirt
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Date: Fri, 08 Jun 2018 09:16:16 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:msM1bvMiZnpiZBdtrTugrV6Alqn9t1bQibLRkoCiyy4jKR3x0k8
 Z5Wo1uF2F0hvKYpBdeX8H/p5tVNQESOPbN/L/aY+WfndE8gKnj5VtPVnR8K39bSGG94Vjd/
 8oDu/NBNomtsWXZgyjMJoqlb/5ySZPYH6Co+mgvjGnxcFbwpLQRHQh9kpGplwhbhSowGp2l
 2t1xNXKE8Y/jgJ3jqL3IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CQ9yRbZT424=:JMVFCjMs0Z9DLAj3aMwPHa
 RkHWwpKfxpCtMOe2OTdLtYtscNeItli7adHNDVLy2wmRUFZQOeQyvWo/zr0Gl3FJmpYvL3X9w
 2XoBhO11OgqGVqAgQlvj2hZ8lH5ZG9eZPU+S7CO8EM1NrRf0VZDToDeLHcJORuAzlNDTSd2Z9
 QOcbXksoJX70ycBexMJBHrIvK03B/3zJBwggPfzLzAd3ZvS4+86H7+LMQu16gJzd+nCPa08jE
 +r+PWQQ+zyqz604ttv7MGGy07BPpIMusdlUwW11KaQ5hakKuX/ZB39ESHNZiqUrviNcJsTyPl
 TlvLm1kVGtIDxBatATDEu7edrhHVcQlNishYOpCLKdgmyA6OLr8z/xqIBOHENLZHtbzpfrn9q
 8vJ5yIK164ecLHwh9KgUd5EqKPc8V8aluPGaHRdmHcOlrLAzkF0clyGyPISr3xrtWn4+G0gnW
 HBxcY2PODCemG/ISJXLS9zw2YMCmHKDvDev3ePkq325f6taGQj/Sk/MyCNQwztdGeN3yIwK9c
 H7xSFVJtg188Bi652HMS4MAD0OApHXka0kIzyqHShUffW87as2QHlgb6l67HIcibfYg2OFElg
 AQU23mkS1ExfRhArzUo6fquoPkDvHxyHhDj7l5EUHEFWGBB5xC0b+gOaAw/48rBD4XYdh+keg
 nydIkI7DFpyC4mA/RaQ47qoieLzcO4aAq6W6f/MtD/VIZqSYrKgantszYZNGAioZTWn4YzdPn
 Fyc3lTWnWKQwspSvm50E4aO0SUDDhw/Rv+ACl6qKMuDJAEV0TMutVwDGmt6q7qRcXfx9DJbeb
 qaPX0ci
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

$subject bisected and verified via revert.  Box is garden variety
i4790, distro is openSUSE Leap 15.0.

Error starting domain: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory

Traceback (most recent call last):
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 89, in cb_wrapper
    callback(asyncjob, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 125, in tmpcb
    callback(*args, **kwargs)
  File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 82, in newfn
    ret = fn(self, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/domain.py", line 1508, in startup
    self._backend.create()
  File "/usr/lib64/python3.6/site-packages/libvirt.py", line 1069, in create
    if ret == -1: raise libvirtError ('virDomainCreate() failed', dom=self)
libvirt.libvirtError: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 12 Cannot allocate memory
2018-06-08T03:18:00.453006Z qemu-system-x86_64: failed to initialize KVM: Cannot allocate memory

95cde3c59966f6371b6bcd9e4e2da2ba64ee9775 is the first bad commit
commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775
Author: Thomas Richter <tmricht@linux.ibm.com>
Date:   Fri Apr 27 14:35:47 2018 +0200

    debugfs: inode: debugfs_create_dir uses mode permission from parent
    
git bisect start
# good: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
git bisect good 29dcea88779c856c7dc92040a0c01233263101d4
# bad: [ba1b7309fc2e909a5828c36a7cd187e5d7df6f53] Merge branch 'next-smack' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect bad ba1b7309fc2e909a5828c36a7cd187e5d7df6f53
# bad: [135c5504a600ff9b06e321694fbcac78a9530cd4] Merge tag 'drm-next-2018-06-06-1' of git://anongit.freedesktop.org/drm/drm
git bisect bad 135c5504a600ff9b06e321694fbcac78a9530cd4
# good: [5231804cf9e584f3e7e763a0d6d2fffe011c1bce] Merge tag 'leds_for_4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
git bisect good 5231804cf9e584f3e7e763a0d6d2fffe011c1bce
# good: [315852b422972e6ebb1dfddaadada09e46a2681a] drm: rcar-du: Fix build failure
git bisect good 315852b422972e6ebb1dfddaadada09e46a2681a
# bad: [ec064d3c6b40697fd72f4b1eeabbf293b7947a04] Merge tag 'driver-core-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad ec064d3c6b40697fd72f4b1eeabbf293b7947a04
# good: [a941fc3957113df977e7396c2cf1679e87a65555] USB: typec: tcpm: no need to check return value of debugfs_create_dir()
git bisect good a941fc3957113df977e7396c2cf1679e87a65555
# good: [07c4dd3435aa387d3b58f4e941dc516513f14507] Merge tag 'usb-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 07c4dd3435aa387d3b58f4e941dc516513f14507
# good: [e55077307d6f7ce86f9a468408fa5613c4a5cb5d] nvmem: meson-efuse: add write support
git bisect good e55077307d6f7ce86f9a468408fa5613c4a5cb5d
# good: [fdff4053d51be4850185aa895813405decd6e956] fpga: clarify that unregister functions also free
git bisect good fdff4053d51be4850185aa895813405decd6e956
# good: [1bc4d68b06ab913d392c8ad6481b9729bd58b8d5] ath10k: re-enable the firmware fallback mechanism for testmode
git bisect good 1bc4d68b06ab913d392c8ad6481b9729bd58b8d5
# bad: [085aa2de568493d7cde52126512d37260077811a] mm: memory_hotplug: use put_device() if device_register fail
git bisect bad 085aa2de568493d7cde52126512d37260077811a
# good: [f0a462970ee19930518b03798a21cfdb3fd35877] Documentation: clarify firmware_class provenance and why we can't rename the module
git bisect good f0a462970ee19930518b03798a21cfdb3fd35877
# bad: [95cde3c59966f6371b6bcd9e4e2da2ba64ee9775] debugfs: inode: debugfs_create_dir uses mode permission from parent
git bisect bad 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775
# good: [964f8363a1aba6cb4198bfaaac538b08f1c538f1] debugfs: Re-use kstrtobool_from_user()
git bisect good 964f8363a1aba6cb4198bfaaac538b08f1c538f1
# first bad commit: [95cde3c59966f6371b6bcd9e4e2da2ba64ee9775] debugfs: inode: debugfs_create_dir uses mode permission from parent
