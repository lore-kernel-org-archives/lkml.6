Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A0BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A872084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A872084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJAKo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:44:26 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:13430 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbeJAKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:44:26 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 01 Oct 2018 13:38:23 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g6pVN-0005Uv-CZ; Mon, 01 Oct 2018 14:08:21 +1000
Date:   Mon, 1 Oct 2018 14:08:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20181001040821.GP31060@dastard>
References: <20180929103453.12025-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 08:34:50PM +1000, Aleksa Sarai wrote:
> I've added some selftests for this, but it's not clear to me whether
> they should live here or in xfstests (as far as I can tell there are no
> other VFS tests in selftests, while there are some tests that look like
> generic VFS tests in xfstests). If you'd prefer them to be included in
> xfstests, let me know.

xfstests, please. That way the new functionality will get immediate
coverage by all the main filesystem development and distro QA
teams....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
