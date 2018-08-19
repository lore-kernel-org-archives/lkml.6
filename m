Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E6C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2C20BED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J2K857ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHTB0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 21:26:40 -0400
Received: from ozlabs.org ([203.11.71.1]:43155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHTB0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 21:26:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41trmv4s0Mz9s4s;
        Mon, 20 Aug 2018 08:13:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534716815;
        bh=XBDfLeLzk9lujO8Ouvxg7qSzBUUmhyTjw2miwChPKM8=;
        h=Date:From:To:Cc:Subject:From;
        b=J2K857taSWbKonG31r11N1dP7XzMHv1ppHBe7/Mt8NR+7GBonkz1re/XK4NTAckXz
         05U+weaLyCEhFzZABCK9reYnR8B9bnjR7Bx4oy9H2lqWKkcTY0CjnZMKNuIroZDKx2
         L2VF8zAW16Y2Z9ytPpb9Ihi+Iah0/wyixax4h+19ZcS8CNWakJkTVKrmgFKHWSBSjN
         iOKvVYRnYXmVUPXD+ICr9PySjNrcxXSlWLBuhD60zF5lwNn4LkzR55czOkvmOo3LZB
         mVpjmcG6/lVzP3yAnXvKitRLVEhuHJcCjqrVofLGXYtlAmaS/J6tKH4NXnlypyvtPk
         IRZyLqcas1bLw==
Date:   Mon, 20 Aug 2018 08:13:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings from Linus' tree
Message-ID: <20180820081323.23a47af3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uzsCoRyFxvT=7nStkg8w7Ff"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uzsCoRyFxvT=7nStkg8w7Ff
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Today's linux-next build (powerpc ppc64_defconfig) produced these
warnings:

fs/cifs/cifssmb.c: In function 'CIFSSMBNegotiate':
fs/cifs/cifssmb.c:605:3: warning: 'strncpy' writing 16 bytes into a region =
of size 1 overflows the destination [-Wstringop-overflow=3D]
   strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'get_sensor_index_attr',
    inlined from 'create_device_attrs' at drivers/hwmon/ibmpowernv.c:293:8,
    inlined from 'ibmpowernv_probe' at drivers/hwmon/ibmpowernv.c:699:8:
drivers/hwmon/ibmpowernv.c:256:2: warning: 'strncpy' specified bound 32 equ=
als destination size [-Wstringop-truncation]
  strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/hfsplus/xattr.c: In function 'copy_name':
fs/hfsplus/xattr.c:416:3: warning: 'strncpy' output truncated before termin=
ating nul copying 4 bytes from a string of the same length [-Wstringop-trun=
cation]
   strncpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/super.c: In function '__save_error_info':
fs/ext4/super.c:344:2: warning: 'strncpy' specified bound 32 equals destina=
tion size [-Wstringop-truncation]
  strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/super.c:349:3: warning: 'strncpy' specified bound 32 equals destina=
tion size [-Wstringop-truncation]
   strncpy(es->s_first_error_func, func,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    sizeof(es->s_first_error_func));
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/trace/define_trace.h:97,
                 from include/trace/events/writeback.h:762,
                 from fs/fs-writeback.c:98:
include/trace/events/writeback.h: In function 'perf_trace_writeback_work_cl=
ass':
include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:222:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_class':
include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:276:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_bdi_reg=
ister':
include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:292:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_bdi_register,
 ^~~~~~~~~~~
include/trace/events/writeback.h:298:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_wbc_class':
include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:323:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_queue_i=
o':
include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:360:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_queue_io,
 ^~~~~~~~~~~
include/trace/events/writeback.h:373:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_dirty_p=
age':
include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 3=
2 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:56:1: note: in expansion of macro 'TRACE_E=
VENT'
 TRACE_EVENT(writeback_dirty_page,
 ^~~~~~~~~~~
include/trace/events/writeback.h:68:2: note: in expansion of macro 'TP_fast=
_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_dirty_i=
node_template':
include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 3=
2 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:95:2: note: in expansion of macro 'TP_fast=
_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_write_i=
node_template':
include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    dev_name(inode_to_bdi(inode)->dev), 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:178:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_sb_inod=
es_requeue':
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'perf_trace_writeback_single_=
inode_template':
include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    dev_name(inode_to_bdi(inode)->dev), 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLAS=
S'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:659:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
In file included from include/trace/define_trace.h:96,
                 from include/trace/events/writeback.h:762,
                 from fs/fs-writeback.c:98:
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_dirty_page':
include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 3=
2 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:56:1: note: in expansion of macro 'TRACE_E=
VENT'
 TRACE_EVENT(writeback_dirty_page,
 ^~~~~~~~~~~
include/trace/events/writeback.h:68:2: note: in expansion of macro 'TP_fast=
_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_dirty_inode_template':
include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 3=
2 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:95:2: note: in expansion of macro 'TP_fast=
_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_write_inode_template':
include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    dev_name(inode_to_bdi(inode)->dev), 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:178:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_work_class':
include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:222:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_class':
include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:276:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_bdi_register':
include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:292:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_bdi_register,
 ^~~~~~~~~~~
include/trace/events/writeback.h:298:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_wbc_cl=
ass':
include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:323:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_queue_io':
include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:360:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_queue_io,
 ^~~~~~~~~~~
include/trace/events/writeback.h:373:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_sb_inodes_requeue':
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
           dev_name(inode_to_bdi(inode)->dev), 32);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
         PARAMS(assign),         \
         ^~~~~~
include/trace/events/writeback.h:572:1: note: in expansion of macro 'TRACE_=
EVENT'
 TRACE_EVENT(writeback_sb_inodes_requeue,
 ^~~~~~~~~~~
include/trace/events/writeback.h:585:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
include/trace/events/writeback.h: In function 'trace_event_raw_event_writeb=
ack_single_inode_template':
include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound =
32 equals destination size [-Wstringop-truncation]
   strncpy(__entry->name,
   ^~~~~~~~~~~~~~~~~~~~~~
    dev_name(inode_to_bdi(inode)->dev), 32);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:720:4: note: in definition of macro 'DECLARE_E=
VENT_CLASS'
  { assign; }       \
    ^~~~~~
include/trace/events/writeback.h:659:2: note: in expansion of macro 'TP_fas=
t_assign'
  TP_fast_assign(
  ^~~~~~~~~~~~~~
In function 'i40e_ptp_create_clock',
    inlined from 'i40e_ptp_init' at drivers/net/ethernet/intel/i40e/i40e_pt=
p.c:755:8:
drivers/net/ethernet/intel/i40e/i40e_ptp.c:697:2: warning: 'strncpy' specif=
ied bound 16 equals destination size [-Wstringop-truncation]
  strncpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c: In function 'qlafx00_fx_disc':
drivers/scsi/qla2xxx/qla_mr.c:1882:4: warning: 'strncpy' output may be trun=
cated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
    strncpy(phost_info->nodename,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        p_sysid->nodename, NODENAME_LENGTH);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1886:4: warning: 'strncpy' output may be trun=
cated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
    strncpy(phost_info->release,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
        p_sysid->release, RELEASE_LENGTH);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1888:4: warning: 'strncpy' output may be trun=
cated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
    strncpy(phost_info->version,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
        p_sysid->version, VERSION_LENGTH);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1890:4: warning: 'strncpy' output may be trun=
cated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
    strncpy(phost_info->machine,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
        p_sysid->machine, MACHINE_LENGTH);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_mr.c:1892:4: warning: 'strncpy' output may be trun=
cated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
    strncpy(phost_info->domainname,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        p_sysid->domainname, DOMNAME_LENGTH);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'ibmvfc_gather_partition_info',
    inlined from 'ibmvfc_npiv_login' at drivers/scsi/ibmvscsi/ibmvfc.c:4098=
:2:
drivers/scsi/ibmvscsi/ibmvfc.c:1156:3: warning: 'strncpy' specified bound 9=
7 equals destination size [-Wstringop-truncation]
   strncpy(vhost->partition_name, name, sizeof(vhost->partition_name));
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'ibmvfc_set_login_info',
    inlined from 'ibmvfc_npiv_login' at drivers/scsi/ibmvscsi/ibmvfc.c:4099=
:2:
drivers/scsi/ibmvscsi/ibmvfc.c:1194:2: warning: 'strncpy' specified bound 2=
56 equals destination size [-Wstringop-truncation]
  strncpy(login_info->device_name,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   dev_name(&vhost->host->shost_gendev), IBMVFC_MAX_NAME);
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvfc.c:1199:2: warning: 'strncpy' specified bound 2=
56 equals destination size [-Wstringop-truncation]
  strncpy(login_info->drc_name, location, IBMVFC_MAX_NAME);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Presumably caused by my update to gcc 8.2.0.

--=20
Cheers,
Stephen Rothwell

--Sig_/uzsCoRyFxvT=7nStkg8w7Ff
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt564MACgkQAVBC80lX
0GwJmAf+Oo4H769bGarxN1fgxN6+DVd6BE4n2deh0Go0Vu0BhagR9Tevm4ueu1LG
ncWmQEZvnbMMmVr2cukLhlgeCx27DZlz6FrHiHFHcOIBDMm5mFrV955Tsr20EyDc
mxczMXBhZkDUAWA0kdawQ4XJLmk8rJtppGaGAfM6TcWx0aFiyttNDFI1ijE4JVGi
FXanwvtPHUz8ZCywOjtfbwGvZVz4RU5WCwz5uCtSfjHx0Ii3+/pM78uVdxgGB28Z
vFDx61QqETGxJicz+uiWgC+I24LpkwGwJxRnX4sgBggwF7lbynY5KoSw5wr1am/h
5BoLoJV9kU+iu6oG58D8kjbNDQeHiA==
=7l3O
-----END PGP SIGNATURE-----

--Sig_/uzsCoRyFxvT=7nStkg8w7Ff--
