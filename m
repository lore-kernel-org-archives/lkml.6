Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F60D218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ElQOXG/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfA3UwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:52:15 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50429 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbfA3UwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:52:14 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42E9D83645;
        Thu, 31 Jan 2019 09:52:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1548881531;
        bh=IKPOlqWea0KTz/1sD9lvXrfzSLG7pNh7TsnyhuGpAq4=;
        h=From:To:Cc:Subject:Date;
        b=ElQOXG/7xU7KDjc8oJjxHuzKffG0p9hb4SghdxyM1SNE6hol9DPghI+jjSbon/EYp
         WrI4c5xi8kEDgi8pWxr5Vf+n2KN/cwj7ierVm9q1Z7orY+ppec3zlx0PS5E3pkWhkn
         mx3k1Cs8Ju2ZJJrRI5UyTgdiJ9ejoP6ReMx24Q+5DyavFuNDXCnK8TzErZ+KwCz2HE
         UF0it5nFUG6Y55rrscrmIHYssc7Qj5Y6/F58I2wAfXiMay0L6AUp6mNaGY7+18UmwU
         XA96tW2iwKI8Pst7y652/ZEOL8U4hRkeNYc4vfcs4xGIsCjUDE2Wk9CNtPGyPqs7Uq
         AGwKqfLeYXfog==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c520e7a0000>; Thu, 31 Jan 2019 09:52:11 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id 7237413EDD6;
        Thu, 31 Jan 2019 09:52:16 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 854403A0987; Thu, 31 Jan 2019 09:52:10 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
Date:   Thu, 31 Jan 2019 09:52:08 +1300
Message-Id: <20190130205209.18183-1-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created a way to clear the multicast forwarding cache on a socket
without having to either remove the entries manually using the delete
entry socket option or destroy and recreate the multicast socket.

Patch Set 2:
  - Fix Compile Errors

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache only

 include/uapi/linux/mroute.h  |  3 ++-
 include/uapi/linux/mroute6.h |  3 ++-
 net/ipv4/ipmr.c              | 40 +++++++++++++++++++++----------
 net/ipv6/ip6mr.c             | 46 +++++++++++++++++++++++-------------
 4 files changed, 61 insertions(+), 31 deletions(-)

--=20
2.20.1

