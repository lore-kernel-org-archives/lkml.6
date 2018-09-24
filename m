Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64899ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD542086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Na0AxsKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD542086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeIXWSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:18:04 -0400
Received: from sonic312-28.consmr.mail.gq1.yahoo.com ([98.137.69.209]:36974
        "EHLO sonic312-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729008AbeIXWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537805710; bh=b1IbP26AyjGXRDRHJnau4Ocgfyp60c4xpkDPN8AIZgQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Na0AxsKz7Bt6kaODaZoh3zuC2YV9ZAQt6n5vDxoaoKilVuG7tHXOCBFNSjp5Em711IALQcCGaOmdwblw+Kn0X4zj+wO67CZz970ctdXiskEyPKQZq/lz7RE6nxib4JqAPLiVcXkwbOHoowpbsVkXqF/6PyH67NPYLLPzHsSoHdsJ8QtkqPBpvVx9zqndjlWhn3qFIldHlRfGDlGM7bMMZZPJNNtxYCQENrcAQUVjwleg6sVEtFHjxXDNT+IsS/ctqB4nBIEbqoj9tND4Tbgv25jc54Q3ANKQ2+mpa9nAkFTVe2mBk6bgSr9+P3otBp3+JFlAaE9ziBSUbSaChcd3gw==
X-YMail-OSG: pW7QXAgVM1k.x8CWx4mYD5Na_clW6O44ycn9ZhiB1jBQfv76ejnNZim9Ij3jJ2s
 vmNtX2ImNZExa0A1V6618_ZCG5JMlm3y6Fl_09pi29m2PjBJdCOd9Q0wRaElnyZsHd2J0EKgLcQ0
 nzjZIpDzox7Cvb4AGIt9ZPDNKTEs6f9JTeoLuN3zpcFk7izYFlCk9YiCmlmCLwcsIC4GCizQSRt6
 RmpAB0FBVZZ5FgCeoap2B_l06AMnxt3IPBfZF_4VrUjkKrxDePaTk21ii3tR9VCt6S1GjboF6LiI
 fzw2o6QVYkZAxhEQDkY.Ar3hekT6VDgxSYDheUVsaT2Gy.vtaRHWi2MlFYHlKsVmudU6ePIC_SCo
 iXygJDYfHouGMILoPmG9jVDpc33Z1wpgTU0915ukGX00dMTpjI4uG71dFIQpkdiEN6l16m.J8qG0
 WtxlWzfyc6D4wAuU0o813eGFckUUxsF7_EiZGLuSs1nBwg7OXbzo5psBfTQ8BgAY5m.xYOjwuWig
 VPRdvewji3anWcwg175AItOw1ocEgW6SGlOfG3Hksj89QIjI56O1S1yRsmJH2JbDn3pxW6aWrP3H
 h0kaerKUB7I0RztcR9qnTzqpBKJ5rJegeOiwpqmw4U2LgNKKIW8cJ5ZGbyK4xaWfBBDC6qDIqedu
 ASllJwL4p0bfy3q2f9q8lWWs1rVEVABZhtCxfjbEA7fJUpArVvV4bC.aAo6AVjFudpnKo.2Lms8d
 czNKbF78nTCrs4qC.BKhR93TBn3.IGxLOHdMf_9qjoQ1ZCwN.PxVC36q0ict_84RE.yID1wDd5lM
 UIPeFtTJ609y6diBteX0LC0t1EWRLnZ5HAJAvtlC_8E5uOKCHwrv0eBXW1rCGn_9W0ZeQ7kDBBeD
 2tyl8rvP6yboxEvfhXoQanYWtvpVGdthOJzmJkW0kM500wz2jEnavNtUElyZq5EpALtSQmq.Z4.U
 tEzoQaHNNEHR4selheeQMGyYYG8d_mSqliKfddPCtidDDgR2R5uDad2rNywLEskRXCgkCn5jn0GN
 6iQeSSqn0lTz.GRRLGs0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Sep 2018 16:15:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac3248efb071c077a43390f9cff1f36e;
          Mon, 24 Sep 2018 16:15:07 +0000 (UTC)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <a2858469-cf38-7706-52b5-1d5fd5ed43ad@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
Date:   Mon, 24 Sep 2018 09:15:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a2858469-cf38-7706-52b5-1d5fd5ed43ad@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2018 8:01 AM, Stephen Smalley wrote:
> On 09/23/2018 01:09 PM, Casey Schaufler wrote:
>> On 9/23/2018 8:59 AM, Tetsuo Handa wrote:
>>> On 2018/09/23 11:43, Kees Cook wrote:
>>>>>> I'm excited about getting this landed!
>>>>> Soon. Real soon. I hope. I would very much like for
>>>>> someone from the SELinux camp to chime in, especially on
>>>>> the selinux_is_enabled() removal.
>>>> Agreed.
>>>>
>>> This patchset from Casey lands before the patchset from Kees, doesn't it?
>>
>> That is up for negotiation. We may end up combining them.
>>
>>> OK, a few comments (if I didn't overlook something).
>>>
>>>    lsm_early_cred()/lsm_early_task() are called from only __init functions.
>>
>> True.
>>
>>>    lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .
>>
>> Also true.
>>
>>>    lsm_early_inode() should be avoided because it is not appropriate to
>>>    call panic() when lsm_early_inode() is called after __init phase.
>>
>> You're correct. In fact, lsm_early_inode() isn't needed at all
>> until multiple inode using modules are supported.
>>
>>>    Since all free hooks are called when one of init hooks failed, each
>>>    free hook needs to check whether init hook was called. An example is
>>>    inode_free_security() in security/selinux/hooks.c (but not addressed in
>>>    this patch).
>>
>> I *think* that selinux_inode_free_security() is safe in this
>> case because the blob will be zeroed, hence isec->list will
>> be NULL.
>
> That's not safe - look more closely at what list_empty_careful() tests, and then think about what happens when list_del_init() gets called on that isec->list.  selinux_inode_free_security() presumes that selinux_inode_alloc_security() has been called already.  If you are breaking that assumption, you have to fix it.

Yup. I misread the macro my first time around. Easy fix.

> Is there a reason you can't make inode_alloc_security() return void since you moved the allocation to the framework? 

No reason with any of the existing modules, But I could see someone
doing unnatural things during allocation that might result in a
failure.

> Unfortunate that inode_init_security name is already in use for another purpose since essentially you have reduced these hooks to initialization only.

I considered that but decided that it makes more sense for the module hook names
to match the infrastructure name. Having security_inode_alloc() call
selinux_inode_setup_security() starts to get confusing.


