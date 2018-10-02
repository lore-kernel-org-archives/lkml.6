Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F482083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="E01hA/7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F482083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJCBdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:33:06 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35860 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCBdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1895; q=dns/txt; s=iport;
  t=1538506100; x=1539715700;
  h=mime-version:content-transfer-encoding:to:from:
   in-reply-to:cc:references:message-id:subject:date;
  bh=yRwg3aWxv4zSc+uU97PuzWKoS3pvw4RMNvkRqVaG5hg=;
  b=E01hA/7bIYbImSFeUlHKHrn9+Wx8qxhe0l1Jnybz9LQ5XP7d0oKhXelw
   kZZB2nCCZ+Dw17MZJQRuPFTynEDELi5KP+DhxM7fe6ITPFLu9ifvF4IXm
   bW8sSitG/g1/Y7Xsv/3OLMHezR1Yhptc0Tij8T7eZrtyeuAVMCKUDy33s
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAACBvLNb/4cNJK1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUYIOgWWEHIgVjBuBaIkShGeJCIF6C4RsAoQOITQYAQM?=
 =?us-ascii?q?BAQIBAQJtKIU5BiNWEAsaAiYCAkcQBgGFKA2nW4EuihcUd4l4F4FBP4FFgl+?=
 =?us-ascii?q?EfoMBglcCjwOOOQmQTwkCgT6OEYh7jEWBQjiBVXAVeAUGVoFPgiQXjjgfjwQ?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.54,332,1534809600"; 
   d="scan'208";a="242486273"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 18:48:19 +0000
Received: from localhost ([10.156.154.82])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id w92ImJR8006852;
        Tue, 2 Oct 2018 18:48:19 GMT
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <153790265614.6091.7582646556934797699@takondra-t460s>
Cc:     linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
 <153790265614.6091.7582646556934797699@takondra-t460s>
Message-ID: <153850609939.4490.12129272851093190248@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Tue, 02 Oct 2018 11:48:19 -0700
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.82, [10.156.154.82]
X-Outbound-Node: alln-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (2018-09-21 07:40:58)
> If we set the inode sid to the superblock def_sid on an invalid
> context, then we lose the association to the original context value.
> The support for deferred mapping of contexts requires allocating a new
> SID for the invalid context and storing that SID in the inode, so that
> if the context later becomes valid upon a policy update/reload, the
> inode SID will refer to the now valid context.
> To combine the two, we would need security_context_to_sid_core() to
> save the def_sid in the context structure for invalid contexts, and
> change sidtab_search_core() to use that value instead of
> SECINITSID_UNLABELED for invalid SIDs.  Then the inode would be
> treated as having the defcontext for access control and getxattr() w/o
> CAP_MAC_ADMIN purposes, but a subsequent policy update/reload that
> makes the context valid would automatically cause subsequent accesses
> to the inode to start using the original context value for access
> control and getxattr() purposes.  I think that's the behavior you
> want.
> =


While implementing the change I've realized that storing default context
for sidtab_search_core() in the context structure is not enough to
achieve the desired behavior. The same invalid context may exist in two
mounts with different 'defcontext', so default context can't be a
property of a context structure.

One way to address it is to propagate default context to sidtab_search() all
the way from inode hooks. But that will be a bit intrusive. Something like
avc_has_perm_default() will need to be added.

Other way is to check for context validity in inode hooks and provide a def=
ault
context to avc_has_perm() if the inode's sid is invalid. But this may have
performance implication since validity check will be done each time in fast
path.

Do you see any other options?
