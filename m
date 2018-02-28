Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519834070-2-1035263192666654315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834070; b=ZDsNYoUOWW8QOwe8C1oU08SI1JZgVbGrUfUyH46EnWU4LQW
    0ScUcgxN/8JaOP9UBwnhcDAOVHsSTvOf5UGrx1d4cO/bxVVXOAUqSZOg940mCU0A
    2MbnC1m19m3TJoX5PaB/UofytqKmEULNfaCeuKpUtJ/U3sgtqMj6sxdrvYqjpSj6
    SOBUvNhecCYhv9g3M6QkC4TcAsS3zqXptC8yFFHZ61jFIEQsmJD0rBwB819z/Q4e
    28S4jHLOJlaBqvh8lH5MTAgrM4Ear0k1CZRvEWm0++o7agyMlJVvB3Ot9qCroTrE
    2R/RPmZUeWQDSEndhBWpBAjLhig6h5THr8OuT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834070; bh=wE2fl0YNkPWF7SmK/HZ
    BwFyXv5BzoK3+Ffm49ru76uw=; b=isdb0gzvOAt2s5+7QlbH5VHyGQ5Z/f5hwXa
    yb4BJotLAI7IIp5wCxzj3kqZ7ly2R9ZvJI3+JLNsfFAvnZ43O1m3NR0cKdD9U6Ns
    JSiZeSQ12n6nzkiYDutNv6GDzB0qRTzNhlN6hT+TPBn0ubkEfQXFVFVWpQECTuZ9
    FqbssSv6dxHwKiltrFttVOTswO58cfLKOeOh65UOjGrcDg5Jl9CN49WdAZchxu0a
    nv4KXuzd+iY3RU1gR9bvtXgSTvoHyQ+1M48eSapFxG7LVWXQ0T9JCbkszY4KMs0i
    iRv53V/lzMNf+1V3nnXpiw94BB8KnuFn5InfsY2U2DmlIUPvc9g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934456AbeB1QFO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34870 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934454AbeB1QFJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Jaejoong Kim" <climbbb.kim@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.72057639@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/254] ALSA: usb-audio: Fix out-of-bound error
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jaejoong Kim <climbbb.kim@gmail.com>

commit 251552a2b0d454badc8f486e6d79100970c744b0 upstream.

The snd_usb_copy_string_desc() retrieves the usb string corresponding to
the index number through the usb_string(). The problem is that the
usb_string() returns the length of the string (>= 0) when successful, but
it can also return a negative value about the error case or status of
usb_control_msg().

If iClockSource is '0' as shown below, usb_string() will returns -EINVAL.
This will result in '0' being inserted into buf[-22], and the following
KASAN out-of-bound error message will be output.

AudioControl Interface Descriptor:
  bLength                 8
  bDescriptorType        36
  bDescriptorSubtype     10 (CLOCK_SOURCE)
  bClockID                1
  bmAttributes         0x07 Internal programmable Clock (synced to SOF)
  bmControls           0x07
  Clock Frequency Control (read/write)
  Clock Validity Control (read-only)
  bAssocTerminal          0
  iClockSource            0

To fix it, check usb_string()'return value and bail out.

==================================================================
BUG: KASAN: stack-out-of-bounds in parse_audio_unit+0x1327/0x1960 [snd_usb_audio]
Write of size 1 at addr ffff88007e66735a by task systemd-udevd/18376

CPU: 0 PID: 18376 Comm: systemd-udevd Not tainted 4.13.0+ #3
Hardware name: LG Electronics                   15N540-RFLGL/White Tip Mountain, BIOS 15N5
Call Trace:
dump_stack+0x63/0x8d
print_address_description+0x70/0x290
? parse_audio_unit+0x1327/0x1960 [snd_usb_audio]
kasan_report+0x265/0x350
__asan_store1+0x4a/0x50
parse_audio_unit+0x1327/0x1960 [snd_usb_audio]
? save_stack+0xb5/0xd0
? save_stack_trace+0x1b/0x20
? save_stack+0x46/0xd0
? kasan_kmalloc+0xad/0xe0
? kmem_cache_alloc_trace+0xff/0x230
? snd_usb_create_mixer+0xb0/0x4b0 [snd_usb_audio]
? usb_audio_probe+0x4de/0xf40 [snd_usb_audio]
? usb_probe_interface+0x1f5/0x440
? driver_probe_device+0x3ed/0x660
? build_feature_ctl+0xb10/0xb10 [snd_usb_audio]
? save_stack_trace+0x1b/0x20
? init_object+0x69/0xa0
? snd_usb_find_csint_desc+0xa8/0xf0 [snd_usb_audio]
snd_usb_mixer_controls+0x1dc/0x370 [snd_usb_audio]
? build_audio_procunit+0x890/0x890 [snd_usb_audio]
? snd_usb_create_mixer+0xb0/0x4b0 [snd_usb_audio]
? kmem_cache_alloc_trace+0xff/0x230
? usb_ifnum_to_if+0xbd/0xf0
snd_usb_create_mixer+0x25b/0x4b0 [snd_usb_audio]
? snd_usb_create_stream+0x255/0x2c0 [snd_usb_audio]
usb_audio_probe+0x4de/0xf40 [snd_usb_audio]
? snd_usb_autosuspend.part.7+0x30/0x30 [snd_usb_audio]
? __pm_runtime_idle+0x90/0x90
? kernfs_activate+0xa6/0xc0
? usb_match_one_id_intf+0xdc/0x130
? __pm_runtime_set_status+0x2d4/0x450
usb_probe_interface+0x1f5/0x440

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -199,6 +199,10 @@ static int snd_usb_copy_string_desc(stru
 				    int index, char *buf, int maxlen)
 {
 	int len = usb_string(state->chip->dev, index, buf, maxlen - 1);
+
+	if (len < 0)
+		return 0;
+
 	buf[len] = 0;
 	return len;
 }
