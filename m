Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CEDC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7266821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfAWKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:42:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfAWKmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:42:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3385187622;
        Wed, 23 Jan 2019 10:42:46 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-120-234.rdu2.redhat.com [10.10.120.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC7226C1E0;
        Wed, 23 Jan 2019 10:42:45 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 3C9907044067;
        Wed, 23 Jan 2019 11:42:43 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:42:42 +0100
From:   Jeremy Cline <jcline@redhat.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kamil =?utf-8?B?UMOhcmFs?= <kparal@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [regression] mei: me: allow runtime pm for platform with D0i3
Message-ID: <20190123104242.GA12532@laptop.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 23 Jan 2019 10:42:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Fedora has received a number of reports of e1000e-driven ethernet ports
negotiating 10Mbps links if the cable is disconnected and reconnected
after boot on a number of laptops, including the Lenovo T480s[0].

Kamil git-bisected the issue to commit cc365dcf0e56 ("mei: me: allow
runtime pm for platform with D0i3") and has confirmed that reverting
that commit in v4.20 fixes the issue.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1627816


Regards,
Jeremy
