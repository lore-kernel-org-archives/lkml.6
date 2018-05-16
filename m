Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519016-1526486587-2-16903373036815031520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526486586; b=jz1nHpGQm+qCoFbE+cwtZ4lxuBja8RRObXpBN9ns5hwdRAT2Se
    1Ne8MyUpsTeU08IPgczgNx2wxG6RQcXdlhPo6VdJRUHsrfQKGXdAcr6k4dRHNQ5l
    bjsX3rB/cNmzvvA8TKqzvXHFthxH5iikvmThSy8Wi020XcpJLOxuDT+mUai/seEX
    Y3N9iEok6Pp0LMac/ddbehCt19X8vJD/+/3MM7j6IUW2+CpVEPuAgTecUgBMs8vt
    nWGaZ/Vm3ew4Qwz7IZfGtbxQ93nm/HeDi00Ow04sEgDGeDYVdB0FQTxhA+WhOHMl
    0UlcY4F2sy9JOzkHzOYz5AaHr9i02c6Dn2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526486586;
    bh=lQHXIOSIJn59E7wfcgYL/zN96IhQ4JmU5qIrS2hCBCQ=; b=UEpQe+0ihDnh
    y5x3NEThk6OcMqNg+Th6zZMZvjCkDc96bpYgeWhRnRukZNhuMG8ZxmyyymybEPsX
    y2uMRnN4NW3/vp8SeXADzzDwhel2m6i8x1g/urjprzdM4AIIRqC890FE3WNzjlAZ
    FV1FAbf/qquCVH809vnVxF3WcIKko/ofl1i1sZGi/vas4dzH3AFoixSf0dH++4fu
    e0MAxFgvBpWPFpbR1TsitjrzXVLlNIGXE7pIjlgKA1vqFh0FWsyBTZ9A+pQsS5S4
    5wIPA44Qd9JDZW0LYtLzH1AnfMzRhwQKjKfATby06LOr+CgwTnaDNew25MjO7QE6
    Gg7aFmYGeQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dU7aeYo8 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dU7aeYo8 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTc/sbfs86fHFem5yJfY4c8609z8MFQ8lZbcSoKafLvtv+UYsai+ivghDC8iIgKkijzkmeM0++qTIix6UtsgAUua8y/L6CkWGWGLYwKPnTTnSTBCd0G
    zE2Bh4ZDPXnVu0cdeEaunu5Kvw1wsb1VgkP5Zoei2zyzQSrQY0+BhYFEE9jpu7xjhJ5miGjQhHXMp0nwMrdQn0w2NF4T66HN3w5D+z/2DxO37WHC6w57e2Q6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=AEgcmALYqtqQms4GJq0A:9 a=QEXdDO2ut3YA:10 a=7JRcy_VHuQgN7OWfaTQA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeEPQDE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbeEPQDD (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 12:03:03 -0400
Date: Wed, 16 May 2018 18:02:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.109
Message-ID: <20180516160245.GA18420@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.109 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                           |    2 -
 drivers/ata/libata-core.c          |    3 +
 drivers/infiniband/hw/mlx5/qp.c    |    4 ++
 drivers/net/can/usb/kvaser_usb.c   |    2 -
 drivers/net/usb/qmi_wwan.c         |    1=20
 drivers/usb/musb/musb_host.c       |    4 +-
 drivers/usb/serial/visor.c         |   69 ++++++++++++++++++--------------=
-----
 include/net/inet_timewait_sock.h   |    1=20
 include/net/nexthop.h              |    2 -
 kernel/events/callchain.c          |   10 +----
 kernel/events/core.c               |    2 -
 kernel/trace/trace_events_filter.c |    3 +
 kernel/trace/trace_uprobe.c        |    2 +
 mm/percpu.c                        |    1=20
 net/core/dev_addr_lists.c          |    4 +-
 net/core/skbuff.c                  |    1=20
 net/ipv4/inet_timewait_sock.c      |    1=20
 net/ipv4/tcp.c                     |    2 -
 net/netlink/af_netlink.c           |    2 +
 net/rfkill/rfkill-gpio.c           |    7 +++
 sound/core/pcm_compat.c            |    2 +
 sound/core/seq/seq_virmidi.c       |    4 +-
 sound/drivers/aloop.c              |   29 ++++++++++++---
 tools/perf/util/session.c          |    1=20
 24 files changed, 101 insertions(+), 58 deletions(-)

Bin Liu (1):
      usb: musb: host: fix potential NULL pointer dereference

Eric Dumazet (6):
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      soreuseport: initialise timewait reuseport field
      tcp: fix TCP_REPAIR_QUEUE bound checking

Greg Kroah-Hartman (2):
      USB: serial: visor: handle potential invalid device configuration
      Linux 3.18.109

Hans de Goede (1):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_=
msg()

Jiri Olsa (1):
      perf: Remove superfluous allocation error check

Johan Hovold (1):
      rfkill: gpio: fix memory leak in probe error path

Leon Romanovsky (1):
      RDMA/mlx5: Protect from shift operand overflow

Masami Hiramatsu (1):
      tracing/uprobe_event: Fix strncpy corner case

Murilo Opsfelder Araujo (1):
      perf session: Fix undeclared 'oe'

Robert Rosengren (1):
      ALSA: aloop: Mark paused device as inactive

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

Takashi Iwai (3):
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks

Tan Xiaojun (1):
      perf/core: Fix the perf_cpu_time_max_percent check

Tejun Heo (1):
      percpu: include linux/sched.h for cond_resched()


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlr8ViEACgkQONu9yGCS
aT7Aug/9HdOGulHDzDYtRXVCvTc6UA7uZL3xRJlGD9AL2XnRx3ttzVFfDAbcPBNE
3/nD+xprd6e8zJURlZlsao3IiE5T8HVCsu5lvjgGyT0dXRnIVzLUmI1vGnF7cNrM
u7j164N8RQYlp+ondkh9LTP6mRts/9MsyWRDWdXGeXi2Y+aB4uyqR3O4zqjjesS2
GgBbKvHCdOLsRs/HFYFCHy/qgI3lra3PvXI3XhYN4lZEAp5W3cU66gQdtW0POG1t
qHwk8KtsLLg1Cb0sYTzuhDpySwQkt37ukJGT33oQc0Fj+4pyjvFqALZsMsSMwSd4
kskU8a13L38RNz4CAuucKhnxkXx2/tHKwCVsfDWg2Tg8JpZ4W1Zt7KqhK9D/qivi
2/vdEA6+Es4EWxWYpcVFIL0RcvqQXILlT9hCsq3qrRBb4Q0i36zW0B8UVwwClSf8
Q0YhHlv5HNzeUgJBMlUuy+WpJZjefGxD+xWDs8R+1AUxA9eN8EihAHImE3iSAlK1
7LEC4JxiXkIrod07509qiqvb+KWfFRKSvyYgvCgjg+7yFixe7H/5SdGQYNZW+u8w
/i9T+1kAZMhZI5Mhd6jBuniR2gbKg7vPZcbyvqusFaNEdk7Z0q/dHiXhJY1drASd
irRCv94GoUwngMn3/1eI2z0+qbfzseEkvKO/NSZaPX0aX779XG4=
=eHUN
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
