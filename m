Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2EC83C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0097208B4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0097208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935401AbeFMLpy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:45:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:54327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935106AbeFMLpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:45:53 -0400
Received: from homer.simpson.net ([185.221.149.202]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgISa-1fz9qN04RQ-00nktV; Wed, 13
 Jun 2018 13:45:51 +0200
Message-ID: <1528890350.30527.16.camel@gmx.de>
Subject: [Fwd: avahi-daemon.service startup failure post kernel commit
 f396922d862a]
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     netdev <netdev@vger.kernel.org>
Date:   Wed, 13 Jun 2018 13:45:50 +0200
References: <1528889545.30527.6.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Z1YIx/gqx1Lcjb/2pjobsTV+hzE0rsinq/l/CMQf49AVRultOuO
 QUpVillTQqAOIMTCZT6HhYevN9c22t9zTMiq2ZOpvw273PFQxLXMaCKXp/SGYeC+Yxg+9q+
 aBK2Af3En9/nZ4dWu0gpVcEcGPQysdhhx0mRYb9xrMtSG+DTAveIJzIMOP2FrdCknDarnAC
 p19XmqcMmikPkuFZ/jbMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sJYBXcvgqHY=:sok+ypQCJYRp/j9LmFtGYi
 6tswp1ew2uLW9tBiCRVBftLPvAZVhIgsGq620CZ0ZgCDp/oI7rnoVccNg+aYrhkyQFPja5JQ2
 RxiN1RF0jmpXsaawVTfW/mf9aw5LXHnJO5z1WYYmEcROqp0K0Km2zk/nW6cCkHKAcp/lZB4CG
 X/umZzuNnWyOlts5JK6liM8jlQH+DRchZTr4b/eKfKcMttM2JedNne/bQ6oRgMqVn26K+9GXd
 dqZX1ZTszI0R1JlLc4Dg6Vs5tRPlG3IyIJCa8mfcc62WeztddKIBwtyyz+97buZkoBKiDlv8d
 4X5Wi9gr7jL7PtCgjDqjTC7jTo2UYFb3fvG3KyndiRpPD2GGvTGxdzfiMCoAkP3GutpYjRloO
 xNVXSrVnUhWRH69D2fkjOvOFJe7SpHMkVxm3sTQ+Fh4qvSPLXv3PIiVJfp9n3MILgd9wRnyUB
 3yGCtMeMK8crFVNnyFyYOCYs6azf+TstLcWyDjhI41ciRSS8vFnfgnlku0Wpzzd598a8PN0AF
 SPp0v8U+7iYLMHNZzrzRmOfbItkbgoE6CKXwtOpvX/b2A+iSGMyV5Pylly8R7YCevJ1d/lW4W
 1TYPT2oXHDqTxr6v7KPiaDGx/bSi9pn/4/83fF0HnwjHz3x5usj13cXmR41/f0jJLBtRYeCht
 /+E4osavRDvVZQZg6LbPUjuuDmtb7lzR+W78WMsxJo9Sud74Zm7t6DDOP3+A05dQJcdSjwg8A
 bVJEhHRfhYhS5xoejo7V10mPwJ6bIJ6RxnzYFznjHl3v5eTLH8OGZoLvv9at7OiuNgMiKGk/l
 9sIcLxi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the folks at "To:" below apparently don't want bug reports from
non-subscribers (no mediation, simply rejected).  Posting here simply
because it may save some other busy person a bisection. 

-------- Forwarded Message --------
From: Mike Galbraith <efault@gmx.de>
To: avahi@lists.freedesktop.org
Subject: avahi-daemon.service startup failure post kernel commit
f396922d862a
Date: Wed, 13 Jun 2018 13:32:25 +0200

Greetings,

Service startup failure bisected to a kernel commit, but that commit
points the finger at userspace, ergo an attempt to report it.  Let's
see if it bounces.

homer:~ # systemctl status avahi-daemon
● avahi-daemon.service - Avahi mDNS/DNS-SD Stack
   Loaded: loaded (/usr/lib/systemd/system/avahi-daemon.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Wed 2018-06-13 09:49:58 CEST; 1min 54s ago
  Process: 1930 ExecStart=/usr/sbin/avahi-daemon -s (code=exited, status=255)
 Main PID: 1930 (code=exited, status=255)
   Status: "avahi-daemon 0.6.32 exiting."

Jun 13 09:49:58 homer systemd[1]: Started Avahi mDNS/DNS-SD Stack.
Jun 13 09:49:58 homer avahi-daemon[1930]: Loading service file /etc/avahi/services/sftp-ssh.service.
Jun 13 09:49:58 homer avahi-daemon[1930]: Loading service file /etc/avahi/services/ssh.service.
Jun 13 09:49:58 homer avahi-daemon[1930]: SO_REUSEADDR failed: Structure needs cleaning
Jun 13 09:49:58 homer avahi-daemon[1930]: SO_REUSEADDR failed: Structure needs cleaning
Jun 13 09:49:58 homer avahi-daemon[1930]: Failed to create server: No suitable network protocol available
Jun 13 09:49:58 homer avahi-daemon[1930]: avahi-daemon 0.6.32 exiting.
Jun 13 09:49:58 homer systemd[1]: avahi-daemon.service: Main process exited, code=exited, status=255/n/a
Jun 13 09:49:58 homer systemd[1]: avahi-daemon.service: Unit entered failed state.
Jun 13 09:49:58 homer systemd[1]: avahi-daemon.service: Failed with result 'exit-code'.
homer:~ #

f396922d862aa05b53ad740596652691a723ee23 is the first bad commit
commit f396922d862aa05b53ad740596652691a723ee23
Author: Maciej Żenczykowski <maze@google.com>
Date:   Sun Jun 3 10:47:05 2018 -0700

    net: do not allow changing SO_REUSEADDR/SO_REUSEPORT on bound sockets
    
    It is not safe to do so because such sockets are already in the
    hash tables and changing these options can result in invalidating
    the tb->fastreuse(port) caching.
    
    This can have later far reaching consequences wrt. bind conflict checks
    which rely on these caches (for optimization purposes).
    
    Not to mention that you can currently end up with two identical
    non-reuseport listening sockets bound to the same local ip:port
    by clearing reuseport on them after they've already both been bound.
    
    There is unfortunately no EISBOUND error or anything similar,
    and EISCONN seems to be misleading for a bound-but-not-connected
    socket, so use EUCLEAN 'Structure needs cleaning' which AFAICT
    is the closest you can get to meaning 'socket in bad state'.
    (although perhaps EINVAL wouldn't be a bad choice either?)
    
    This does unfortunately run the risk of breaking buggy
    userspace programs...
    
    Signed-off-by: Maciej Żenczykowski <maze@google.com>
    Cc: Eric Dumazet <edumazet@google.com>
    Change-Id: I77c2b3429b2fdf42671eee0fa7a8ba721c94963b
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 39b702bc132c8aa812fbd452822a7047331553a1 e0ed7194986fd828073702d5346a4f91fbd6ea01 M	net
