Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05643C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF62070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZwLy5z3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfAHVhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:37:53 -0500
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:35438
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727917AbfAHVhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1546983471; bh=4gGLfs8Da9xg7fdVU51mrUWTmIlUtC0PvY3sTLbKPik=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZwLy5z3twJacaNUxL0LmwjcgaWnNuJraIEuAy6RQXXLWpkxVB8u0wAv9rlR7ju8OE8vSFWJD0kLCPJHwx1eh4fD/3+0IpTGtW1zHP++j8xapXmB3/tGXnkyfa/NVfFciEcfeEdoQVuHJGkLJ8nnxycYN5IucVFzLBpNBMNKbZrfCSKw1F34pB6ehYA5XPYW8K498+FxyL+eNWer8BMLZ5NVk2JF7Xt8IZNnVKo/WViXMMxospzxeWUv8VqAiPJdAnu2+gmbDYr4Y03tdzjzQjuJbc7ThT2PV9QZDVFIgaJGVed8kEnBFJ/kMJ6bgZuEMhcelq/bhExedokaw7zrjbA==
X-YMail-OSG: dt9_IA0VM1mXyEbxplzicdrl3zWXIFnvOGFT5Xk2KXhIhsg8KQLqy3.91HPS_JM
 kqi7FdgCGg..czcuQdSIugo82W4cSZSmPoEZmjA5I4Bxg8h2IiJUd6QsEFVHrQFrqkBjtCsnxkRq
 eye0.poY62PDszFv.dDL1O3nwlt_U8_UyEuvHF_DgMt_21SdYxJklWeLBlYgYPIbIQGNAHNSo0.D
 THK243zVLTuwjzxEa6F0zfZ6o2cgRuqfrJwZ9ZQNCCx8VGfdOjx.cGZujndvZY223oyysF6BB6tJ
 my67UghRTMIkingPcRmXHl_i.nORynomIDpY5ul8EpmZBCFxb598vxScihn.7ynU3COG4aQQPcdX
 IFnG8E7OEv6fUBE5ETSbKMqzPLGx1Q0OzlZgJfkHOiPKYQTOlGOtd666fGLx0ktiZb5S7VlDlAYs
 V8X_7YjbV8qicvx9RJtkkOf4CYkOVqG8WiGxI10u7YqWbrBUF_lzUXJ.X0vPOz2Ax8gJFJXXHLA0
 BqjxQsX4_WYKIx_i6Pq186keXhGHem65Six.m1J7aBJo7H.1CIvK8OkY.4LNMcuN6j9XFXuTuxkP
 trT6tOVWgJGRWcDwfxwpMil_yeSsXSCrE63JXYoTbUdjNKaQP6jKb4UmmcAsSSJcwxSiaYj02Diq
 jrQ.JNt8aTE2KGcx8Sqpxf2.zSrCpbVpLr8hGET8OQpBh7Pv0.TdD4uTgYC0R1VT46flPCpEO9Oh
 IlSM.4WpxToWdpicyxDvJS7h1hBQdurx7kt95AzhmMOp_tuZYIrKTh6gPFe.ChzrbdMIg3eDZD7D
 FfQMsFg_vBsbC8TKBTW22w9MIYiEW7snTikYgSIKtrJ0ig3XvxBJRacqKKDPNJrGHzBM.Gjskh2B
 p9O3x.T371SR.9P7PXAioLERhFG2pUIygwc.aZpCXO5.y7VZfJXmcNLnK5ehfM4tmKCCwTNrXk.5
 6ioXrjtZ120KlYuYGvrEnuUAbzIHdGhUPpImLR9mYhHwMAKLPQZxRNZ7KoKiy_2OClrwnnviZvcC
 0i9fddL0U4Z.LIbiIzmJ4JA505LEAM1qtrM2keu6jyftm5mShRZ7tuBIO7LQX4SodW1DLOyKVa9W
 b0snehKnZmrTPNxnyIMecQEJprCryQzC_9fFgHPec_Mc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 8 Jan 2019 21:37:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d5b6cdb001787338e2d275f3df3a03e8;
          Tue, 08 Jan 2019 21:37:47 +0000 (UTC)
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org>
 <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
 <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
 <alpine.LRH.2.21.1901090805121.24546@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
Date:   Tue, 8 Jan 2019 13:37:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1901090805121.24546@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/2019 1:05 PM, James Morris wrote:
> On Mon, 7 Jan 2019, Kees Cook wrote:
>
>> On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
>>> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
>>>> On Tue, 4 Dec 2018, Kees Cook wrote:
>>>>
>>>>> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> v5: Include Kees Cook's rework of the lsm command
>>>>>>     line interface. Stacking is not conditional.
>>>>> Can you resend this series with corrected "From:" lines in the body, etc?
>>>>>
>>>>> Beyond that, I obviously like it. James, what's needed for this to move forward?
>>>> If there are no outstanding issues, I plan to merge this for 4.21.
>>> Yeah, it looks good to me. (Excepting getting the authorship sorted.)
>> I didn't see this actually get merged? Was there something that needed
>> fixing? Should I send you a direct pull request for v5.1?
> Yep, please send a new pull request.

Do you want it as is or rebased on 5.0-rc1?

