Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3588EC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE8D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rzFLNFRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE8D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILFDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:03:10 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:44164
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbeILFDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536710487; bh=BlZb2E2m29zEhi71br7CS0nSP9bPUdZqI1/hV808ZOM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rzFLNFRmNXgHwYFW3jJgsyxTZry58o/xfo956k5Z5k09AF/vIsu8dvhMYfsNgS8RAdkI8vuqfJpW/yGY7sOuKvRV3WE12JV/hF05BQAWx4M7Wj62l5g9UWd2NFanifN4DOZ0hsX2fgR/0991kOOPSkYPQdxsfa8bjqm3oa3+1uxTYyTsix2ou+sOR/8ubAwM3h85mkMZggE3pOddhHF3b8nRJyS5O7aAwpMMrbrjLyT2mpf2WKg7nz91fg/9b2SFkulgwK4UgqSoR6DyGEJIp0KguaZ5Ta+jNoRdIhyjMSdlUgT83O6rtRRMgG6wLr+/GRmMN5NZMJ3UnePNQdAISQ==
X-YMail-OSG: QE7q0DYVM1nfAX4SFt0hot3VoXFu4_e9Ph_h1TQbNOzPY86MjWtQi8EsOqqFSXg
 CkxxpK7.3Q010JWuG2JZnzrW9EkqwzltVgPA_6Oh6efUxQYYUkIAKVDMhkP3H1q0EqdJRX5zA7Re
 5f4dVq7zlGA.Ev_tWrVMKzSk4WuQrT9peOw2qsmX7LEL8q..hWgLb7WBeM0sp5rXPWH9NEw_EJ.e
 nP.9mWDDYJrSajlBrcEMJVQJJVxQDkC9vrK86Ga_VpOyhYxCOF7LtX5gBG0H4v4LbCKaQ.yqozd5
 1uIXu.dmeCk70BfWpYwZBu1C98BXSV2uXTp.5VgNB0yRBpjK2ysZ_dCC5k5F6QnfG9RYvWbDE01r
 oOPU4GprvBIbMNEiUJd7YSa9aYwTANw0bJaRkYUM.8_5Q6pJDtWLplkBKwUQENeq.N5QWXJ2zscl
 Ck9fa4VMZROcr.WAIYBjFqX7h6HytAj.fxZ6USuKigN8zB89o8751DK6z6X43ODzvNJfG6fgx4ii
 wuHB.zy3YMQaXvSxjguvbkX1Mq5lrT0y2xDzxKM3rRjmzqg2qQigCro9KPD4Qa.jk9LOC3kOd4fc
 e2XTE3jsfOJm2Qd48NNevvHysQMl429fOYZ_N_Bzhu1QTro9dNJ6V4MESjzthXLOcqjTOuNLxZQS
 rlp_bz3xjnRmqZXWCTrMbRX3TRjlF58Ic0qL5tGwdvU9pKjVpp7o4EzEboOfNqdp65CZfMMh1qME
 iyYL5xBVF5P8XKTIWHXksUgQR1BIjNIYvg58tmvVQi3PHF4Dk5Ie9psSaXWrPyCOFNU6OAIqgWVD
 srO.wsmEh4wE2.LNFpyrchs5gSASexh.qXEvRlMutixD5kdz7.a5s0N50TKaUg71OJYW2VsEiSuL
 D8ky.1Cl5vrzkOKiqydCuYgn_ph7n.P5OondWqG6hH4zA1_k7YSmIweChnix5M4KKjHJu3LU9H4T
 Pm7D6cQwLx87GN.qwFUSjSk7lZu4QoeMGteBKowLQJTtO9HYJUuW33peJnjjnEJI9NAFkErijbaI
 9UDthws38deNgMJpUzw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Sep 2018 00:01:27 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a50e0ea40d0e5b481aefe24cc496da04;
          Wed, 12 Sep 2018 00:01:25 +0000 (UTC)
Subject: Re: [PATCH 01/10] procfs: add smack subdir to attrs
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
 <20180911234538.GB12337@darwi-kernel>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cb61a8bc-eb36-3eb9-88ab-d30c6522619b@schaufler-ca.com>
Date:   Tue, 11 Sep 2018 17:01:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911234538.GB12337@darwi-kernel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 4:45 PM, Ahmed S. Darwish wrote:
> On Tue, Sep 11, 2018 at 09:41:32AM -0700, Casey Schaufler wrote:
>> Back in 2007 I made what turned out to be a rather serious
>> mistake in the implementation of the Smack security module.
>> The SELinux module used an interface in /proc to manipulate
>> the security context on processes. Rather than use a similar
>> interface, I used the same interface. The AppArmor team did
>> likewise. Now /proc/.../attr/current will tell you the
>> security "context" of the process, but it will be different
>> depending on the security module you're using.
>>
>> This patch provides a subdirectory in /proc/.../attr for
>> Smack. Smack user space can use the "current" file in
>> this subdirectory and never have to worry about getting
>> SELinux attributes by mistake. Programs that use the
>> old interface will continue to work (or fail, as the case
>> may be) as before.
>>
> Did downstream distributions already merge the stacking patches on
> their own?

Ubuntu is leading the way with adopting the stacking patches.


