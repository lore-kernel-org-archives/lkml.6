Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155083-2-7210754206954740380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155082; b=jjPczjjMEtt5soIJNujgzqoHzU49RhyVvOjQOtyGI1CqtIe0RA
    sZRCTu3z67WXuQKARyPjL2vhlV5oh5TR/zDa7xnQIDPUxagn9ShZx9WUyXboV1+A
    0rOT8Wui0rvJUB7M5gwh3CFcjm/Xk8M1T6CPCY2mCV39QDgnytb3ngxE4fbGIdL/
    ThFnDxdGZUu/mbB5lIJpS1TB1Re6oko4OZRQX67ZkcK+oH6bCrE/yN15aYZzDohA
    BY929nHOetHtYegI5kVWV2KPWK//mC6PNKjqn2RS8cy/wfhHIsONLtUaFhxeRLqj
    hP+/y0SFufNXED/k05x685ZCOVEhxgqbrFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155082; bh=SVkHWFE7kyi1k01Su46M3L64nvoZ8u
    1yLPsAUJ0kfx4=; b=Y7JpLIwXS4CVnhhx/OvYExTRnJHOPTuvC4Af1Rq/y3azax
    0vcnaHetO3JpzxkSqgCeaX+wAtLJYBL6flzMEInx7vAliVQsWbDTDlMMHuMOiW0X
    GVnrtVqo9nXbnWj6i6EMDV9sIUGcxdyGmss7+dPtN3OwXxUlHUg9aU1jpb8S1uw2
    grLr1kjA8QYyESMQCIqI3sJ/kOTySKpfg6eh+U5hh7+oQDa5Wg5Q0hYStG32eC3g
    t1D44VBc14y8BHQIffEBnuhghwmj0iHj3vwwjmmK6BkXuV4Q6+0ZUSg4PkWOSuRv
    AIG6R8VfbAWHAx3xSQl1txp6m+DfpWaZZplktdhQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QNYUYjhW x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=QNYUYjhW x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN93urTeZni6tSYsZb9m9z2qH7sU0c0m43/ZTl6Kk28bQbRYb6EeaQ++SV9E2s5nCyeeRJokqgtdv+VtiRUS4VUh5hzuNtp8MbBuCTCohc/f5eqfW2Ro
    oOb5hMDcTKHypCZ3wLwzauYAPLZ/YykaoQczTC4lSTSxhLoIimcl9Sk1iLhoCnfp5aqfMn1/a8nmnqbK3ZM0SC3tydrt26kqcn4bvL+szjPHB9FR0Tj/CgZj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=AeCkNC4mAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=cfzF1Kdsd2S1pXbpAg0A:9 a=v_4f273H6JEDzoop:21
    a=t9XH_3beFySJcXqx:21 a=QEXdDO2ut3YA:10 a=3H0rhiSm_XezoJcgKFaR:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966655AbeEXJok (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966539AbeEXJod (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 10/92] openvswitch: Dont swap table in nlattr_set() after OVS_ATTR_NESTED is found
Date: Thu, 24 May 2018 11:37:47 +0200
Message-Id: <20180524093200.198399745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 72f17baf2352ded6a1d3f4bb2d15da8c678cd2cb ]

If an OVS_ATTR_NESTED attribute type is found while walking
through netlink attributes, we call nlattr_set() recursively
passing the length table for the following nested attributes, if
different from the current one.

However, once we're done with those sub-nested attributes, we
should continue walking through attributes using the current
table, instead of using the one related to the sub-nested
attributes.

For example, given this sequence:

1  OVS_KEY_ATTR_PRIORITY
2  OVS_KEY_ATTR_TUNNEL
3	OVS_TUNNEL_KEY_ATTR_ID
4	OVS_TUNNEL_KEY_ATTR_IPV4_SRC
5	OVS_TUNNEL_KEY_ATTR_IPV4_DST
6	OVS_TUNNEL_KEY_ATTR_TTL
7	OVS_TUNNEL_KEY_ATTR_TP_SRC
8	OVS_TUNNEL_KEY_ATTR_TP_DST
9  OVS_KEY_ATTR_IN_PORT
10 OVS_KEY_ATTR_SKB_MARK
11 OVS_KEY_ATTR_MPLS

we switch to the 'ovs_tunnel_key_lens' table on attribute #3,
and we don't switch back to 'ovs_key_lens' while setting
attributes #9 to #11 in the sequence. As OVS_KEY_ATTR_MPLS
evaluates to 21, and the array size of 'ovs_tunnel_key_lens' is
15, we also get this kind of KASan splat while accessing the
wrong table:

[ 7654.586496] ==================================================================
[ 7654.594573] BUG: KASAN: global-out-of-bounds in nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.603214] Read of size 4 at addr ffffffffc169ecf0 by task handler29/87430
[ 7654.610983]
[ 7654.612644] CPU: 21 PID: 87430 Comm: handler29 Kdump: loaded Not tainted 3.10.0-866.el7.test.x86_64 #1
[ 7654.623030] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7 06/16/2016
[ 7654.631379] Call Trace:
[ 7654.634108]  [<ffffffffb65a7c50>] dump_stack+0x19/0x1b
[ 7654.639843]  [<ffffffffb53ff373>] print_address_description+0x33/0x290
[ 7654.647129]  [<ffffffffc169b37b>] ? nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.654607]  [<ffffffffb53ff812>] kasan_report.part.3+0x242/0x330
[ 7654.661406]  [<ffffffffb53ff9b4>] __asan_report_load4_noabort+0x34/0x40
[ 7654.668789]  [<ffffffffc169b37b>] nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.676076]  [<ffffffffc167ef68>] ovs_nla_get_match+0x10c8/0x1900 [openvswitch]
[ 7654.684234]  [<ffffffffb61e9cc8>] ? genl_rcv+0x28/0x40
[ 7654.689968]  [<ffffffffb61e7733>] ? netlink_unicast+0x3f3/0x590
[ 7654.696574]  [<ffffffffc167dea0>] ? ovs_nla_put_tunnel_info+0xb0/0xb0 [openvswitch]
[ 7654.705122]  [<ffffffffb4f41b50>] ? unwind_get_return_address+0xb0/0xb0
[ 7654.712503]  [<ffffffffb65d9355>] ? system_call_fastpath+0x1c/0x21
[ 7654.719401]  [<ffffffffb4f41d79>] ? update_stack_state+0x229/0x370
[ 7654.726298]  [<ffffffffb4f41d79>] ? update_stack_state+0x229/0x370
[ 7654.733195]  [<ffffffffb53fe4b5>] ? kasan_unpoison_shadow+0x35/0x50
[ 7654.740187]  [<ffffffffb53fe62a>] ? kasan_kmalloc+0xaa/0xe0
[ 7654.746406]  [<ffffffffb53fec32>] ? kasan_slab_alloc+0x12/0x20
[ 7654.752914]  [<ffffffffb53fe711>] ? memset+0x31/0x40
[ 7654.758456]  [<ffffffffc165bf92>] ovs_flow_cmd_new+0x2b2/0xf00 [openvswitch]

[snip]

[ 7655.132484] The buggy address belongs to the variable:
[ 7655.138226]  ovs_tunnel_key_lens+0xf0/0xffffffffffffd400 [openvswitch]
[ 7655.145507]
[ 7655.147166] Memory state around the buggy address:
[ 7655.152514]  ffffffffc169eb80: 00 00 00 00 00 00 00 00 00 00 fa fa fa fa fa fa
[ 7655.160585]  ffffffffc169ec00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 7655.168644] >ffffffffc169ec80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa fa
[ 7655.176701]                                                              ^
[ 7655.184372]  ffffffffc169ed00: fa fa fa fa 00 00 00 00 fa fa fa fa 00 00 00 05
[ 7655.192431]  ffffffffc169ed80: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
[ 7655.200490] ==================================================================

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Fixes: 982b52700482 ("openvswitch: Fix mask generation for nested attributes.")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1141,13 +1141,10 @@ static void nlattr_set(struct nlattr *at
 
 	/* The nlattr stream should already have been validated */
 	nla_for_each_nested(nla, attr, rem) {
-		if (tbl[nla_type(nla)].len == OVS_ATTR_NESTED) {
-			if (tbl[nla_type(nla)].next)
-				tbl = tbl[nla_type(nla)].next;
-			nlattr_set(nla, val, tbl);
-		} else {
+		if (tbl[nla_type(nla)].len == OVS_ATTR_NESTED)
+			nlattr_set(nla, val, tbl[nla_type(nla)].next ? : tbl);
+		else
 			memset(nla_data(nla), val, nla_len(nla));
-		}
 
 		if (nla_type(nla) == OVS_KEY_ATTR_CT_STATE)
 			*(u32 *)nla_data(nla) &= CT_SUPPORTED_MASK;
