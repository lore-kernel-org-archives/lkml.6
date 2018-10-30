Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB052C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5172082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="FaOQuSQJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6Nacrj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5172082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJ3QNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:13:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42623 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeJ3QNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:13:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4916B2241E;
        Tue, 30 Oct 2018 03:21:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Oct 2018 03:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=/h9Zn0k6+SUQDai2HesjXXiQIQ
        9tXoY2NmhgM/bdfM4=; b=FaOQuSQJl3rReJlKrGPjahOx74Zr59s4dExdki4QxJ
        e3lFQJ4SGnjWeLTTiooL7QKL07Uot1OXT6Ton20ukNCNzKnijFy8Q3QlQCTuHtTW
        bEoHvNgmgfCY/Ky+huoBVSY1sb/sDafq3YqIqYHLYCdtVB1wjg6IuJRYbqa5SfkT
        Dy4fPdI1IbzwKiHxGMKCs7VW0/k1DPK0sif1abAN8As/PEQmW0PPcrxLqM13S/wZ
        xqwawdXBENcLvSDN7aVOGu3asmiv25uQU2KHUKLrdW8uafu+PEOUYqOyFwrWcHkR
        ik98s+ySnno59lPya3oShTQhATpBo+gFpQUcYTPFzQMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/h9Zn0
        k6+SUQDai2HesjXXiQIQ9tXoY2NmhgM/bdfM4=; b=C6Nacrj2YHQOQq176/Kw3Y
        3JlryVwU/00KN9Elmj0UXAHrRY7PHvptWMA3Z4+CH1FG1ihfk94yRj80hMSMoh92
        PETDOeNJ+lDZqHLYjwxt+JeuGHBmXjmqL8lCnDAh3EzwGY2mXurLJKVdJ0O/KhxR
        otKYEia0nWUtZl2bMFuZCOTiV+m41sQHU/EvwEAO6owK24AQNKjMQlN19erI7IKQ
        NoU9lQLCOenJQs9epvEZKQ86KbWnUtR0PVtZpCzm6i8FS1pmdO0/dYGjYJW/UqV3
        TdUMuU1S7XxqtcCS4iLuPoybx8w3sXvs6icoi9nbZdJ+ZxyjK4RY7jLTNrn/YrIQ
        ==
X-ME-Sender: <xms:cwbYW-Z2is_DqHnYLe1CN9faBvffYxsFKGnBPti76JId2uRwxBMvqw>
X-ME-Proxy: <xmx:cwbYW-cX9uApcmyqTzq_9joevmB3STJZ3dSASTjF9MQKtQ2XvyGR_A>
    <xmx:cwbYW6N90gAjI935OYvzoGbAw85pd1aIokg6seYbMKI2gvwHSmaaww>
    <xmx:cwbYW4VH-GMmJefuBZ0ExKo8immP9BbBYCuHyrwwiGPSZIIY4UOezQ>
    <xmx:cwbYWz1ebaext2nOIvPCDrNKqx9PmXxgmaRyjvozlh6WeNmLAp4vng>
    <xmx:cwbYW76y1344MjZu_C2btgoUbd0SVKH_9t2tSbGrWKE-cJ8hiKOiFA>
    <xmx:dAbYW0mk85hYbl5jfpH89CG8YXVpYHbZhVfzzPR2oGDbyMXuo0ueJw>
Received: from localhost (unknown [118.208.172.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 866BBE405D;
        Tue, 30 Oct 2018 03:21:22 -0400 (EDT)
Message-ID: <2045305c1fdf94f1f36c06f158264afbc01194ca.camel@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.5 release
From:   Ian Kent <raven@themaw.net>
To:     autofs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Oct 2018 15:21:18 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It's time for a release, autofs-5.1.5.

A few changes of note are:

With the deprecation of the fedfs-utils package it was necessary
to add a couple of binaries from that package for fedfs users to
give them time to migrate away from using fedfs. The binaries
included in autofs are fedfs-map-nfs4 and mount.fedfs. To exclude
these binaries from being included use "--without fedfs" with the
configure invocation.

A regression which broke amd format maps option parsing resulting
from the addition of amd program mount support was fixed.

When used as a systemd service there were problems with dependency
interactions that required changing the way autofs interacts with
systemd. Other than fixing the problem this should not have any
visible changes other than noticing a new command line option used
with automount(8) in the systemd unit definition.

There are some minor improvements to building without hesiod
support. This amounts to providing sensible error messages to
indicate autofs has been built without hesiod support rather
than the terse messages that would result otherwise.

The SIGUSR2 handling didn't work as documented in the automount(8)
man page. Adding the "--enable-forced-shutdown" option to configure
will now work as described in automount(8) if the kernel changes
needed to support it are present.

Additionally there are a number of bug fixes and other minor
improvements.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.5.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.5.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.5.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

30/10/2018 autofs-5.1.5
- fix flag file permission.
- fix directory create permission.
- fix use after free in do_master_list_reset().
- fix deadlock in dumpmaps.
- dont use array for path when not necessary.
- fix prefix option handling in expand_entry().
- fix sublink option not set from defaults.
- fix error return in do_nfs_mount().
- add error handling for ext_mount_add().
- account for recent libnsl changes.
- use_hostname_for_mounts shouldn't prevent selection among replicas.
- fix monotonic_elapsed.
- Makefiles.rules: remove 'samples' from SUBDIRS.
- dont allow trailing slash in master map mount points.
- fix libresolv configure check.
- add fedfs-getsrvinfo.c.
- add mount.fedfs.c.
- add fedfs-map-nfs4.c.
- add conditional inclusion of fedfs binaries.
- add an example fedfs master map entry to the installed master map.
- improve hostname lookup error logging.
- fix rpm spec install premissions on auto.net and auto.smb.
- tiny patch for autofs typo and possible bug.
- add units After line to include statd service.
- use systemd sd_notify() at startup.
- fix NFS version mask usage.
- fix fd leak in rpc_do_create_client().
- add-man page note about extra slashes in paths.
- change expire type naming to better reflect usage.
- use defines for expire type.
- enable SIGUSR2 handling in rpm spec file.
- fix age setting at startup.
- fix update_negative_cache() map source usage.
- fix program usage message.
- mark removed cache entry negative.
- set bind mount as propagation slave.
- add master map pseudo options for mount propagation.
- fix use after free in parse_ldap_config().
- fix incorrect locking in sss lookup.
- fix amd parser opts option handling.
- fix possible NULL pointer dereference in get_defaults_entry().
- better handle hesiod support not built in.
- fix indent in automount(8) man page.
- remove autofs4 module load code.
- add NULL check in prepare_attempt_prefix().
- update build info with systemd.
- use flags for startup boolean options.
- move close stdio descriptors to become_daemon().
- add systemd service command line option.
- refactor negative map entry check.
- remove unused function dump_master().
- remove unused function dump_state_queue().
- remove couple of undeeded requires.

Ian

