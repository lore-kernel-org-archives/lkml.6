Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27530C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B824E25E6C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d7CA9DfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B824E25E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeFYQla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:41:30 -0400
Received: from sonic313-19.consmr.mail.bf2.yahoo.com ([74.6.133.193]:34946
        "EHLO sonic313-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933432AbeFYQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1529944887; bh=xqeySOgjbZcidh0WLmHusAjXOJtj75jR6u+Va6K0zsQ=; h=From:To:Cc:Subject:Date:From:Subject; b=d7CA9DfUf5GtmM2URd/X7gM84MXoycpgEi+Htqz78g/KsmHx5h4F3hmKgb7Oa1Z+dug+8eK85XJPYjIoD4Sxf+bTmN31SyjjlX+QeK+aFLX7bG6ZYdKNjkUAxge8ecx6FKsl+g8Wm1h1vZkqpMlj+6rrIZ3PZTVAiQSGPc2V2YWvDjt8qyWMYdZ1wl6teEEWTknxH/fJ2BUhUKC+Z1RYvR/ZhvVd1i0qN9rs8KEmYRmt6YAQoZMC48cc2Nw3ywUrgIfM1DDcqhstpJEJQab+UGfQw6Ogorle7kEbCLOckUN63tTF7/zi6Oqf0SpsuD6sL5Rm3zf2UhEX4ot5me6E6w==
X-YMail-OSG: GsKpFWAVM1nkrHEV5WdBB9C3wmpYhrOsfbvy2x9DPj3KXgC0mf8LqdAF72e8UP5
 Fph7npl9G_bgkIUHVem8GtegbWCFjSjxs.84_qc8_FVGzcrndaBq17Tdvymo7bt0bQLrodoqZJvB
 edCBDO0op7wqdaToKdFMblcnJAFvacOPPbvOmQNfZURDEfXbQeky9NEpDQdg0j8.21qEoyPXp8OK
 0xmb5gDhYMNWKjeojYKq_707VAkDGt8VU4gu4dRA7pn09QKrVypAtMxcRSGf4B4PYsaqL6TpR4Xo
 3kBAuruYArD6HKZWmEUSlphmFRy0VkedDEbPWp1gYIrcZXUsuh5hixb_XAsw2vWRjVG4MG4s_U.i
 tXCZWGCpak2H0WPCnF5Xb2XsXfYS.mXwoA8fvqa.5cYIAO3KyJIJ2gDpr2GC_8AEdnh12L3w_mO8
 1HuNinbMJ796ji6o2ElQ4WDfw0DusgvERZ1O1YfILXGJ436pVl0nskeZ0NavCTDVzJ23noe.xfzl
 9.0jPD93DCMnc10jx6HUYycRo0DXu70M2m3CR6a6Ouazds8AdqPILYxbG2SardSlAb5jdD6Ch4Yr
 IjjazbBpRIxQ.BUv8XbzM_BJ8.M17SRrym3PQj0c77W2ylNuUNWqxt0sRWNldGQobt1VXUHBzwhK
 miGdyttYFRl4Y9K_gRU5uywk04kiv0rJDSvabsXTblS5f.OPyqY_qab9byBCD7lzBTdBClE6zpCt
 9m0lT1NZ4aPyl7fCsyqza1Z7F0yWzpKLqrKIIWmjSOEE7zu5ydfRY1CftJ2F4gC4kFQU_gQejYjF
 S6cpyuiWxT5ZArXOs97IiIrCIB9zCX5xvMD5Li9zmuHVrQ1LgTb.baGHG_poT_kuOBKnlrFSvFdo
 lI8IYfZer430PjEC_17fR7ZyuKnOpHcNtHOgz7um_jOeDvMgeRzlqdwOJSi5DYityUqzoXsXoYGo
 6YtfUbzpqualpPgKDucVAVWjyc2s.dtmDcU8ra_7q3_vqnowkHpNjYKRLnBKDj2VMtQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 25 Jun 2018 16:41:27 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b053fd075ce54d17be09014c9e897e0d;
          Mon, 25 Jun 2018 16:41:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     James Morris <jmorris@namei.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: Mark inode instant in smack_task_to_inode
Message-ID: <813ecc0b-4a9e-22c9-b893-504936bab342@schaufler-ca.com>
Date:   Mon, 25 Jun 2018 09:41:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James, would you please pull this change for 4.18.

Al Viro's /proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
created a regression in Smack xattr behavior in /proc. This fixes that problem
with a minimum of fuss.


The following changes since commit 0f8983cf97d3327531b7843c831517cac3a1b9ed:

  Smack: Fix memory leak in smack_inode_getsecctx (2018-06-05 12:16:01 -0700)

are available in the Git repository at:

  git://github.com/cschaufler/next-smack smack-for-4.18

for you to fetch changes up to aabfe8e2d9f49153bafefc82d10bcb6e1e12828d:

  Smack: Mark inode instant in smack_task_to_inode (2018-06-22 13:55:28 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

 security/smack/smack_lsm.c | 1 +
 1 file changed, 1 insertion(+)

