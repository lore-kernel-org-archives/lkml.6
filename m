Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B97C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0EC20830
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DzCdba5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBEC6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:58:12 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58602 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBEC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:58:11 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7F0F28011F;
        Tue,  5 Feb 2019 15:58:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549335489;
        bh=ItvI8D1+t0K8tCIcYejLqbWPGFUJob2uX1selWpy6aY=;
        h=From:To:Cc:Subject:Date;
        b=DzCdba5CJQB5B+QrrIVSNC08ezK/aNLVSCGE/ow5YRwKDYzX1iIVaYUI7U58kanDa
         +YRVnRELyLIFbRHtUbC2lon5Hu0qh79hz1P6Sz0N9Fp5kZxKFWeCZpKXw5aVnE3ak7
         CbIVLtD+uaDB8+f5YlrqpyEREfDOyfbk0MkgUhbnshw76swPByx7Qnknq4eGlztR/2
         AjO0EBxslOqW2LsdcV5U0SwxzKjli7EhtMVUoagH0v8my4gHq2MTLqsKfS2HL5KP0o
         NPvRs6+FBF89PYVvu9njLTH13m9C8KunpZ/ThVebL/cTRQMobK4BX0QFMAg+1uZ8/g
         Y7rUIAcDqR16w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c58fbc00000>; Tue, 05 Feb 2019 15:58:09 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id 7797F13EECA;
        Tue,  5 Feb 2019 15:58:13 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 7E5173A05BC; Tue,  5 Feb 2019 15:58:07 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
Date:   Tue,  5 Feb 2019 15:57:59 +1300
Message-Id: <20190205025800.17185-1-callum.sinclair@alliedtelesis.co.nz>
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

Patch Set 3:
  - Fix Style Errors

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache only

 include/uapi/linux/mroute.h  |  3 ++-
 include/uapi/linux/mroute6.h |  3 ++-
 net/ipv4/ipmr.c              | 40 +++++++++++++++++++++----------
 net/ipv6/ip6mr.c             | 46 +++++++++++++++++++++++-------------
 4 files changed, 61 insertions(+), 31 deletions(-)

--=20
2.20.1

