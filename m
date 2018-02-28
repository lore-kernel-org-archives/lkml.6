Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834912-2-7553385480327242555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834911; b=Xx5mW+oGt/Dmfn9TXKY5DGrxTCbVh0IBsKl7wAmSX1Lnhiy
    3S+tX4x+f6sX1iRmng7PBkqniaeRQ+9ki31LOu/NIrlx2ZKVmanFUDAIS0TMv2jg
    CNFUP9uDycW58MOBCa5FvqbGcs6L+RZSSz1GeoAp24hxfSPsTF0a8I97s301tYGB
    N3/i4sKII9BOdYz0rwugp4ij63dQzFRTzSmXsasCo3pt3DoSp6gIK8qpsBFgizAX
    AlCSAGXHxgzHDlBDkB49CBgh0uiuvifboFUd5H7pOJ3Lzh3pFfLKqxfQDN6+8WEW
    5yGfRxSJr8noZm5/5yazlDz/VDKQum0TDYzW3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834911; bh=sDWjPHHLPTmqCJ27q/t
    DTqsmbUoNCpozbFMy5fo9y30=; b=bZt+OPMCCk9Zco2IarUcO/FmI1cZZ+5wQFn
    m+9Via1WeuJd7RAuFgJ85dwJSM7a3/F1eWiA08NpydrL2vbOB2mU/OIqogHDrss6
    fEZiyiBOjAilKconj7lFqi4X8qmdqPb8r6PdRWLI8+CBfqu9v+3poQ3RVsc3avJd
    HVMfKgy3l9JrwAWia0MPkIWN7kHOTY5vymiWg+j0RweZT+aDuG/w8ELlrfL5gKtE
    PBIIs62SYCDdeC1OgvisYxQbOXv0K/hB7PhgxqkcVdWNHjFXn/SlnAeIXB8hk/NR
    XbYEwnS9pGzOA4GtY/C+kiExWhJgbAZwLTw0kwncgKZyYb2ygxw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935081AbeB1QVg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:21:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35413 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935262AbeB1QVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:21:01 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Jaejoong Kim" <climbbb.kim@gmail.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.966408469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 025/140] ALSA: usb-audio: Fix out-of-bound error
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -197,6 +197,10 @@ static void *find_audio_control_unit(str
 static int snd_usb_copy_string_desc(struct mixer_build *state, int index, char *buf, int maxlen)
 {
 	int len = usb_string(state->chip->dev, index, buf, maxlen - 1);
+
+	if (len < 0)
+		return 0;
+
 	buf[len] = 0;
 	return len;
 }
