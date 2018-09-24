Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43879C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AE72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BtHfnUjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AE72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeIYChz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:37:55 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:34529
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbeIYChy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537821234; bh=Rurx9ZHNwhjWBpVfxZu5G9dFBDtm0qr/75sfd+4bDZI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BtHfnUjsHlCcD5Opu37op/j2byCx4PNMlWYbZXu4yumgJcM2tD+dAXYyXaOIskrhfEQDvNIbUdpTYg8nvntyZenIRSZi5R9yAnYnbyhDP7/cWw9LgJSAFuNqlrqpxa1wtYmSC/6wCCPLR9090UliReKsvjJIKJsMqLV+Kc0K2zhavTzgDKpsCBd/zJWsgGIlUNUD2B3e5XyIptuyADOTAcowWUVmdBMPfZ4Fup9nzLNfuE2jWV3Ggg5boPwHL+Atp231KcmkE/B7ee5pgBvYJllQDbCZNQk9+MzH51FiF9qfoEwzJn+QFLsgK4yQHCJz/oriESJ2zc648/8UJbGeYQ==
X-YMail-OSG: G938i_kVM1kW33_Gcm8B5Ud5AX03efUvZ3y21eNI_MfjoqjuP7YRKhh1w.ze0Yv
 LiGS1d.WnMhr0KfqLHyle3m7L.HoKQRf7mZ3Lc4CHi4lu6YydwT0R8PmbHhySRUGvwrPRJ_ZQHSH
 vauBvY8Bd1WP1au3ZsPVGXZXPh3XBLylUPdxLzzlOJdhg2IhNNCktId0R0fHnCHAr9UScAUbbTMa
 jC7msDEwWYQFVnFcsPgMBv7TlQZpGupUZ9gzRFqi2vGDMPLgIN_JWYD59lgKJDGojup92wMkuyiu
 1aIgat43u31dTsRAqzwn1jsHLy2e2wLLgxrTSw4308G6fxIfuT_CDoF3ifV5Tg.uoqaoYkLrHFz3
 Ux6nq4dchTV_l.spmhLsP8eQGMQzDrdJB9actIWApfOrbMmznQqGzLQB09R0sj87EMtIdE5yiKW.
 DWRD_A4n0lwrHqEbGghW3Dh1YWLD9svNnxZZoS9lZ0ZP1u1_EfyBMxOSxDQQYZcKM.77uDgaPQJb
 ccGr1LsWpvsu5N8aX0DZ6q2WFZyezceZx7laz1tNHOgodhFbEtH1ry9DI9VncLqDGYI3dFIW5871
 kUKzjkDhrtzI93oegmEKJVx5rEUZWlijtTF_lUl5B..vdZ.WzJZrVSCNqWxsjb3Zj8mg6LEwTf7T
 lcGuV1g6htm989sE25NL7X1k65IrwofKvlv1EpJtjxoRpIsju8yPmaccjtec5GdenD7l69yvdXlw
 OjR.kkM3i5vq0CTlq_5eiE3e_wTPHX21ljNuSHJBEGmLhqkMicJ_T8yz2PFkA_R87LltyH.DYp_b
 mbjqw5LH00XR83E010LZiGlx9ImIpmcYMlLUk_cvyk0nasxHHlCL3s9l6FnCG9xSHzLF_2wUpmKp
 IiIoxgJLZcgmaVJiZaZVqJi_3rq38eYENFcJvjCdTRUnew5rTpwEAkzJVCXdg9UJ8DaR0PZcfwx9
 ssN90lyzL4yNHZMV1mNRBMhhBl2tJ1viczLlPryqEC2ciPBt2kbl_1n4yngzW7ox_NCMXORitmYT
 DCaxC.rbvwJYC9GNIotcyRK9QSqA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Sep 2018 20:33:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c46ebf4d0dddcae4f2722441969ed02b;
          Mon, 24 Sep 2018 20:33:52 +0000 (UTC)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
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
 <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
 <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
 <eb1525f6-a3f8-4386-778f-8758c42326e5@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <28e4ca6d-e86c-ee1f-ead8-f03d1ccd7d54@schaufler-ca.com>
Date:   Mon, 24 Sep 2018 13:33:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eb1525f6-a3f8-4386-778f-8758c42326e5@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2018 10:53 AM, Tetsuo Handa wrote:
> On 2018/09/25 2:16, Casey Schaufler wrote:
>>> Not all of LKM-based LSMs use security blobs. And some of LKM-based LSMs
>>> might use security blobs for only a few objects. For example, AKARI uses
>>> inode security blob for remembering whether source address/port of an
>>> accept()ed socket was already checked, only during accept() operation and
>>> first socket operation on the accept()ed socket. Thus, there is no need
>>> to waste memory by assigning blobs for all inode objects.
>> The first question is why use an inode blob? Shouldn't you
>> be using a socket blob for this socket based information?
> Indeed. AKARI can as well use security_sk_free() using address of
> "struct sock" as a key.
>
>> If you only want information part of the time you can declare
>> a pointer sized blob and manage what hangs off that as you will.
>> I personally think that the added complexity of conditional
>> blob management is more pain than it's worth, but if you want
>> a really big blob, but only on occasion, I could see doing it.
> LKM based LSMs are too late for updating blob_sizes.* fields.

That is true with the code in this patch set. As I mentioned,
changing the blob handling to include a header with real use
information would be required.

> Even if they could, they after all have to somehow check whether
> corresponding init hook was called. That's checking for NULL.

Right.

>>>>> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>>>>>  {
>>>>>  	void *blob;
>>>>>  
>>>>> +	call_void_hook(file_free_security, file);
>>>>> +
>>>>>  	if (!lsm_file_cache)
>>>>>  		return;
>>>>>  
>>>>> -	call_void_hook(file_free_security, file);
>>>>> -
>>>> Why does this make sense? If the lsm_file_cache isn't
>>>> initialized you can't have allocated any file blobs,
>>>> no module can have initialized a file blob, hence there
>>>> can be nothing for the module to do.
>>>>
>>> For modules (not limited to LKM-based LSMs) which want to use
>>> file blobs for only a few objects and avoid wasting memory by
>>> allocating file blobs to all file objects.
>>>
>>> Infrastructure based blob management fits well for LSM modules
>>> which want to assign blobs to all objects (like SELinux). But
>>> forcing infrastructure based blob management can become a huge
>>> waste of memory for LSM modules which want to assign blobs to
>>> only a few objects. Unconditionally calling file_free_security
>>> hook (as with other hooks) preserves a room for allowing the
>>> latter type of LSM modules without using infrastructure based
>>> blob management.
>> There is a hypothetical issue here, but that would require abuse
>> of the infrastructure. Having a file_free_security hook that doesn't
>> free a security blob allocated by file_alloc_security may coincidentaly
>> be useful, but that's not the intent of the hook.
>>
> The free hook might be used for freeing resources which were not allocated
> by alloc hook. Yama is using task_free hook without task_alloc hook.
> Someone might want to use file_free hook without file_alloc hook.

OK, you're correct. Checking for an initialized kmem_cache isn't appropriate.

