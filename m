Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6705520836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B8AEb7U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbfAKR3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:29:41 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:38327 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729727AbfAKR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547227779; bh=ddYnozeCksRkFe7n3I7xLUK/K9qy+lww0wvNY7WJ0jg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=B8AEb7U35qMYhQw+Omzng5CskxEsEuMNvWWvWtWZihTLMiJKgCrwYDkqpaqZyEK57JyoEfkyeZLN+AbTNYo593yuM9Ql0gWPIrZFPUTdeEbKllyD+4aMq2Beo2U54azSGjHe+6H2z6jre2Fcp+fr9CTYaard7Dp0BnKzQ261ZN2HAs38swQYpR3hDps+pdSBX4rcHK+QZvm7F60aCXaMoc1MRF6UGMPc2nc4KM2t9xxiL4fVLGerPW9IBeT16G2FMHfyCyEcq1kIWaRTuQxfNDTtk5HPi+x6Mq7Hp7HoIJDdaiEEDl+mA/rAwl8UED+rf1+d9ZJNvDxkvPYdZ0s7vA==
X-YMail-OSG: J6RB2JEVM1lfJSRVMH7lI0sm.xhW4JMVYpEpLLGim2xq3ndkNrAwiuTf7w8d.Ok
 cC05o9hy4K7fhlL0CbxANr17HpiOnGecFVADHuPAm_s2bIQfW69Lw46X_KGBKPjCUyibIFR9XrLf
 E7_zbmJykmZcin8nO0LEJtWZrzn4Rkz3HDLZIHdWhsJqgs8TkngvKV5z3Tzvhr6tXYqnUvdfLBmz
 CXQ9Z3CJKfrnsZ0PoQ6Uk51XgNPfCnnKpk0N5UZuzpghfJDED_bEShBcA8y5qKgo1M6UAH9aTqul
 3zXZqoGafmqWWK8NCnvv9SRP24UxWE.1IMOyQwK_0WEIYOlNU5L2SYaVgROLKLh8BJH4AZEgpkKL
 iwogE064Ay.dsmmM6UjkJB5VOT8DuGqH.sfM1x0CZiuKgzXQQxhsr4sC7NBmvB.eDlrvVBnyPwjV
 vhsR9coZ1ueFWk9rNhwgdVuM2_48g1BKdLkmWd8Ewz.NAl6EsQ3Xgwn44k1H_UwoqOdu_.U71xHC
 HB9rigIx3psMXOetK6cjxSXr_HHnAAg4HAHTyJcPsL6Skof2klIJqBhPrcT_fJb8608V3z3A7crl
 his3SCBaDkWUUUfjitNCusyEjld09TnA6Zk1eiEqwe884VrQxMQPUHP_jx5Ujzl42AfD3qWE.b1X
 yhrHEzGl29A5gKF48uAjcRMkm4StlB3_3dLXauYXIhAmXEtFW_9LGa3GVavkxQQTRcPQObRFcUnp
 DW9pyxjjS9w885zF0U9aT71GtRRIU37c6GDuCSy_BBm7q9OtxkGMPx3n3hdDXovx43NGItqKF9.X
 m_vrNK38995t83siW.b5vtTZ3xhIoDbD03zE_e6.FLij5QncNzEftxZT4tK7mQv6vayDRqSGTHx.
 geGTq5yv.1FOl3f61XnkWIl5a6w7jDCGd.EmBD2jp1gyUG7tzdXfvXZpfILWtbxeTCyuX7vrvG0P
 ZHOnav9Z6ojwvMRzqBKU.KEsnHpXKZylBDio6x1IADEe5Poar9OR0gWn5sgSl7uRX7YLtKx6hXXs
 ot60Ohh86v9Xge6Y5sKiNUGY8mlG9PoXRQ6yy.X_nrB5X74ApyE90.oHqW08RWmQmjwti.8cjIUy
 EEZwZOBv6QvaC.wBnO8aatsB.LSzYIVOJ6V3Ap7_Q1bq4pJUSOOUDrdQG2F1AlcujjEGpt1osQA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 17:29:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 77a2e25944ae44607f3b50eba103d1d3;
          Fri, 11 Jan 2019 17:29:39 +0000 (UTC)
Subject: Re: [GIT PULL] blob-stacking updates for security-next
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <20190108213504.GA32901@beast>
 <ce79cdd5-3020-8901-a5a4-ec42005734fd@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c38efdfa-4302-8c63-e11e-7ea6a3f85035@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 09:29:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <ce79cdd5-3020-8901-a5a4-ec42005734fd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 2:38 AM, Tetsuo Handa wrote:
> On 2019/01/09 6:35, Kees Cook wrote:
>> Hi James,
>>
>> Please pull these blob-stacking changes for security-next.
>>
>> Thanks!
>>
>> -Kees
>>
>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>>
>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/blob-stacking-security-next
>>
>> for you to fetch changes up to a5e2fe7ede1268d2f80fe49ca1f717d0e3750995:
>>
>>   TOMOYO: Update LSM flags to no longer be exclusive (2019-01-08 13:18:45 -0800)
>>
> And syzbot already found a bug.
> This is occurring immediately after memory allocation failure for cred object.
> We need to be prepared for free() function being called when alloc() function failed.
>
> [   59.992498][ T8010] FAULT_INJECTION: forcing a failure.
> [   59.992498][ T8010] name failslab, interval 1, probability 0, space 0, times 1
> [   60.005214][ T8010] CPU: 0 PID: 8010 Comm: syz-executor178 Not tainted 5.0.0-rc1-next-20190111 #10
> [   60.014337][ T8010] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [   60.024383][ T8010] Call Trace:
> [   60.027657][ T8010]  dump_stack+0x1db/0x2d0
> [   60.063731][ T8010]  should_fail.cold+0xa/0x14
> [   60.089894][ T8010]  __should_failslab+0x121/0x190
> [   60.094810][ T8010]  should_failslab+0x9/0x14
> [   60.099411][ T8010]  __kmalloc+0x2dc/0x740
> [   60.124293][ T8010]  security_prepare_creds+0x123/0x190
> [   60.129644][ T8010]  prepare_creds+0x3c4/0x510
> [   60.149852][ T8010]  __x64_sys_capset+0x58c/0x9b0
> [   60.185347][ T8010]  do_syscall_64+0x1a3/0x800
> [   60.206747][ T8010]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

I'm staring at the code and trying to see what this is telling me.
There is a failure check immediately after the allocation. If any
of the modules fail in their hooks, the whole thing is freed.

