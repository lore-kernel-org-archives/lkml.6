Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C4C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CF72081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CF72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeKELKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:10:06 -0500
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:48749
        "EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbeKELKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:10:05 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2018 06:10:05 EST
Received: from [192.168.1.101] ([99.92.55.146])
        by :SMTPAUTH: with ESMTPSA
        id JTxPg0uEk8xclJTxPgFSq3; Sun, 04 Nov 2018 18:45:35 -0700
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
From:   Dusty Mabe <dusty@dustymabe.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dusty@dustymabe.com; prefer-encrypt=mutual; keydata=
 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
 ZOAQJwRgw4eT5NWnKty3FMtMZAdKH0x1RSq0iXM=
Subject: multiplexing /dev/console to all console= entries
Message-ID: <46b26403-395b-6a3c-ea6e-c3c811fdc400@dustymabe.com>
Date:   Sun, 4 Nov 2018 20:45:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBVhhY4THURGrlgclGe7Psgp1ii+MeMhNXvrFbwQot0UjvyVRH1CET9D+sEGwW9SWGHBr+QhoM+MYoHoVSAddq72m3i/qQV1OqzP8NqOY/JXeIzbY6i1
 uTry2AqU/8lgM+TgGAInJAkXKtRGVt3SkJKR5h5E8X34EPx4hA5Q0Q82yZiB7CU043c3LpZs1z15l9nxgnDjtozzpEvTQfHbMn6F8LhB2jeDwgTg32YM8Rb8
 CAPiloQROwLgOYyP9Q26sg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg, Jiri,

I'd like to bring up a question about multiplexing /dev/console to
all specified console= devices on the kernel command line rather than just
the last entry. In my personal experience using linux systems and also in
my experience dealing with users of various server images (Fedora Cloud,
Fedora Atomic Host, Fedora Server, CentOS, RHEL, etc..) it is often hard
to debug properly when something goes wrong because of a number of reasons:

- the user doesn't know the difference between a serial console and 
  a VGA console
- the user doesn't know what the settings were on the image they booted
- the user doesn't know how to access the various console devices using
  the cloud environments they are on (i.e. they know of one but not the other)
- in an attempt to share configs for disk image creation the creators add
  extra console= entries to cover various console devices and various
  architectures (see [1] where we are covering VGA/serial, hvc0, AMA0. etc)

I believe it would simplify debugging/troubleshooting with users if we
were able to multiplex /dev/console to all console= entries. This
conversation actually started as a PR to dracut [2] to get all of the
systemd messages to be printed to all console= devices, but it was 
pointed out there [3] that rather than change the the settings in dracut
it would be better to attempt to change the kernel behavior.

If a patch were submitted to enable this type of behavior would such a
patch be acceptable? Maybe it could be a compile time option and also
have a kernel arg option to enable/disable it.


Note: I apologize if this functionality already exists and I missed it
      somehow.

Note: I grabbed info from [4] about who to contact for tty subsystem 
      questions. I apologize in advance if you are the wrong people to
      contact.

Thanks!
Dusty

[1] https://pagure.io/fedora-kickstarts/blob/ee84a1650b8188cbd00d54a688838207c34906f4/f/fedora-atomic.ks#_36
[2] https://github.com/dracutdevs/dracut/pull/445
[3] https://github.com/dracutdevs/dracut/pull/445#issuecomment-424755057
[4] https://github.com/torvalds/linux/blob/82aa4671516a3203261c835e98c3eecab10c994d/MAINTAINERS#L15149-L15151

