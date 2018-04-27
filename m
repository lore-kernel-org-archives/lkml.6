Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837958-2-2976773552897646945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837957; b=TuMhF1tfRlZpC2AO8dqp6c54i+pr3rqqIdtrblrpBXeChgIWFc
    MEqLF1oI807niA6pykk43/6mDtlK/4LYfzMshGwoTgkgmhg32UP6w/hxjkwkfkW+
    Z1TRajn1XrqyjeRS4oi82XkbFoSwFZT90hhTiMcoAjhcDq35E98kqn1WH2GtEbkt
    SdY8KnP4uYu6rvYPaouqzjnfYoSF5zay8UGdVihSl6UU435vlM1hXB5d8dgYkKck
    NkCwH9Zq2uJi5/s9HPOpwBxIdP63Fl23XPsn0WWwgt3XE88YiAfx8yfBrGk/dyIl
    Xkz7Z7+g8ei7LM5cB0C72488j46CzDxIpBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837957; bh=D/eOtKK/0eQdi+Agx8I4/N/RIYcEe2
    NuUzyc+Sn71A0=; b=BszpNYnxRQAd16OSIY2+H48ICbz4OXH9S2k4DGG4GXvszV
    7/PGsZlRxSjirRp8EO5ZX7g/Vmsg+FXinixSI7LGP9jZ2edyH74L7a2BMc+qY3y2
    DtbfYXuDIlR3zZcuKU/C99yJK9nUdyg4EecvNxivLlyRHw9TpdzgG8cFRqceF70k
    T2z6bR/MzHxIHeh6/mD4vBnY28ahXwbwbBQkqQA/aG8SDVkaMJ1ljHm38CmWJ3rU
    5rB8q6nD/cnDl5hiJyiKE5ZvU+pvnz9b4eNUBybxu8uroNbjn/zzXbWbqw4WmBNe
    olE4Qen5wK0A6ejwMBXsYcE3/I7Fzb82sPAEuALg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI7QhbBAcCAe4Nd7yfRAdoIUc4UH6buhXLhDwRHB7YNUlF/90FEcbUoTzFYGMK3Zk1+xwksA3aqKTxWonm5mLRg5V1Ayrbg3TLZ6VElf4CfuMz45YlW5
    5/WjDpmC6pwXhPko7FfXVRZUR4xcoqWYkjxhQO6v0UMm4QV2mcplo/mP1WKoJMFeaTEAuUWApREB++aiPm4GWQRaoZDNv/Xo4jOXsAs6yQgB8dnDQiBgkBra
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=ZgEYA8WsG4xE_VKs9oQA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeD0OFq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933699AbeD0OFn (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:05:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83E921890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 53/74] team: avoid adding twice the same option to the event list
Date: Fri, 27 Apr 2018 15:58:43 +0200
Message-Id: <20180427135712.137854708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit 4fb0534fb7bbc2346ba7d3a072b538007f4135a5 ]

When parsing the options provided by the user space,
team_nl_cmd_options_set() insert them in a temporary list to send
multiple events with a single message.
While each option's attribute is correctly validated, the code does
not check for duplicate entries before inserting into the event
list.

Exploiting the above, the syzbot was able to trigger the following
splat:

kernel BUG at lib/list_debug.c:31!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4466 Comm: syzkaller556835 Not tainted 4.16.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__list_add_valid+0xaa/0xb0 lib/list_debug.c:29
RSP: 0018:ffff8801b04bf248 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8801c8fc7a90 RCX: 0000000000000000
RDX: 0000000000000058 RSI: ffffffff815fbf41 RDI: ffffed0036097e3f
RBP: ffff8801b04bf260 R08: ffff8801b0b2a700 R09: ffffed003b604f90
R10: ffffed003b604f90 R11: ffff8801db027c87 R12: ffff8801c8fc7a90
R13: ffff8801c8fc7a90 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000b98880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043fc30 CR3: 00000001afe8e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  team_nl_cmd_options_set+0x9ff/0x12b0 drivers/net/team/team.c:2571
  genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
  genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  SYSC_sendmsg net/socket.c:2164 [inline]
  SyS_sendmsg+0x29/0x30 net/socket.c:2162
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4458b9
RSP: 002b:00007ffd1d4a7278 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00000000004458b9
RDX: 0000000000000010 RSI: 0000000020000d00 RDI: 0000000000000004
RBP: 00000000004a74ed R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffd1d4a7348
R13: 0000000000402a60 R14: 0000000000000000 R15: 0000000000000000
Code: 75 e8 eb a9 48 89 f7 48 89 75 e8 e8 d1 85 7b fe 48 8b 75 e8 eb bb 48
89 f2 48 89 d9 4c 89 e6 48 c7 c7 a0 84 d8 87 e8 ea 67 28 fe <0f> 0b 0f 1f
40 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41
RIP: __list_add_valid+0xaa/0xb0 lib/list_debug.c:29 RSP: ffff8801b04bf248

This changeset addresses the avoiding list_add() if the current
option is already present in the event list.

Reported-and-tested-by: syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 2fcdb2c9e659 ("team: allow to send multiple set events in one message")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -261,6 +261,17 @@ static void __team_option_inst_mark_remo
 	}
 }
 
+static bool __team_option_inst_tmp_find(const struct list_head *opts,
+					const struct team_option_inst *needle)
+{
+	struct team_option_inst *opt_inst;
+
+	list_for_each_entry(opt_inst, opts, tmp_list)
+		if (opt_inst == needle)
+			return true;
+	return false;
+}
+
 static int __team_options_register(struct team *team,
 				   const struct team_option *option,
 				   size_t option_count)
@@ -2569,6 +2580,14 @@ static int team_nl_cmd_options_set(struc
 			if (err)
 				goto team_put;
 			opt_inst->changed = true;
+
+			/* dumb/evil user-space can send us duplicate opt,
+			 * keep only the last one
+			 */
+			if (__team_option_inst_tmp_find(&opt_inst_list,
+							opt_inst))
+				continue;
+
 			list_add(&opt_inst->tmp_list, &opt_inst_list);
 		}
 		if (!opt_found) {
