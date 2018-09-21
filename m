Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE21C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8FA21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gj4I+RrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8FA21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbeIUUqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:46:55 -0400
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:41789 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390227AbeIUUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537541858; bh=NZxr5DvYFN7iF1Ir6w85jsFCYmP6N+scR2Oj4Q3VULM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Gj4I+RrQKyw9iwnlSEO9A+/B3lRYouiP2+swJGlPHueRCmTUcZoh2IrjvPSFpUe1zHAaKYLVoybP/EWpIcmA/p+oW5LR0lFx7j2xzyRnTISe4b9A5zbhEfCBnew9HxM7QyR6yIw7RRzB2X5/jBuV+EfCPXEsZEj83XKV3qHb8JieFDN03VH0xLatL3hM/yuWUsOhYkGAMnx8KEc7TRxMYEV+5kU+eXaZuizYVbCYhO66+yL6jHjeoftT8NnZgAZuCp3317flT5Bj1SDErSDrI1Ahrh2oT2Ql4QNNNQNl2VMyX2/BOzMM10beMXaahcnZI9NWFS0TFR8ugUbAwp55wQ==
X-YMail-OSG: 3tH6jrgVM1lo6tiIeVzVZLXYFsp4V4T7tuogD66fi5oDxXc9hiepkqx6IcTO482
 cXAYQwzu5Fz8qZoxHVhz5kSr231skKhml.dIONfU6gdZcQ7t4HkpnK_rMwWmF4T0P3inAAEskTaM
 GQii7XPp1AnKG6hLroHOrJTS41Sqo0VwOkbzqKZXPDC.Ef5wQu7YAvlm7CQo4LvnDaFfYLJcgiNu
 bBdb9XY0TA9tz05EnzOsoxvgn9FrvCEMLUfN8mP94dxlrbOxgGxm3HRrk3VQ.46PTGhHAMAlTe0C
 2RnxBU59JVXvSsZ1BLTxqJQ2UWmPA6m8CCC2S6DqjOg4KOTP5aF7LGHTX8kyQA5iXVAQqMyBjJPH
 _GVBDC1iI7Hp84vxDh1AKQOExL1t1A8poxgw._aHi9lHZ3mzlL0fyYucyr_u1rnBD_9.PUrH0QH6
 hPiUeSjNA7EIAPP8IsPaeBFyETTlTpL1OyXVbLKl_3Y6PChdxgS00HOlnYTX_nXlaxE_K.0wFuNd
 3G.XbLbqZf3NFvgRFcOQAt3.I7sZf36I7sDX87TO_oNLTKkZc_vDqF3JiLlz8bcd0_TZn9_NUalB
 Yq3R7xXgMpJC08p_TLs.KlGrtXlBiyRxhiYYMV05eURcsyynZmvmVWlHcL.akZSGK9wRl7ykALaU
 RpSywYrADu3D77Vyf.cU2Bdu9RqA_sLKoqEhwdg943xLZtUMafKdgQLE3_KODceFdCn.Ol5ABTIV
 uyxe5WTg1fpEzHUlcr9WMHJeDWt2wm3nzDMg0dhn91fy5JR2X_lpUR6I6sBX94AXdE56GT_dLYJR
 R9DfNT3N7feQ52zqpGhRJFxVNrZ.N.SrgOQnvpDCgwclb7xK69nEayz_YCdnORQ74oOD8JX6.tno
 u1Z4BF6f_R_1OSVMU2CsOVS.r5OwBbhB0.ywKai2vWG1dfYtjD.loF0tCxUjMk2gu4eYBlQHeyau
 mpgGTmugcN51Zunftajwd.KhbvaCq5aEB3yRTVbb6sMX4BUbkX60xUp.8GytnHCvBUnAvmsyO4Xf
 bwkivyUGvmt6W4KeTb8zXXks7M_xx4td9gzaIEOFx7UHMjV8B
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Sep 2018 14:57:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b1ea943c7e117406b472149e3b4ed37f;
          Fri, 21 Sep 2018 14:57:34 +0000 (UTC)
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
To:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
 <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
 <CAGXu5jKzqij5dY2FYm5rafPNPpF1Tx9BPmK+=FvG+=tpFxpscw@mail.gmail.com>
 <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
 <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
 <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <78fc6ba1-881a-9c82-ebc1-64311279050c@schaufler-ca.com>
Date:   Fri, 21 Sep 2018 07:57:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 6:19 AM, John Johansen wrote:
> On 09/20/2018 08:02 PM, Kees Cook wrote:
>> On Thu, Sep 20, 2018 at 7:14 PM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 09/20/2018 07:05 PM, Kees Cook wrote:
>>>> On Thu, Sep 20, 2018 at 6:39 PM, John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>
>>>> Yes, I like CONFIG_LSM_ENABLE if "empty" means "enable all". Should
>>>> CONFIG_LSM_ENABLE replace all the other CONFIG-based LSM
>>>> enabling/disabling?
>>> I don't particularly like "empty" being "enable all". With that
>>> how would I disable all builtin lsms so that I just boot with
>>> capability.
>>>
>>> An option of all or even * is more explicit and leaves the empty
>>> set to mean disable everything
>> Okay, that works. I prefer "all" FWIW.
>>
> me too, I was just trying to throw out options.

I'll buy that. "all" is fine by me, although it means we
can't have an LSM named "all". :) We should also allow "none"
to mean no LSMs. I know lots of people who love using security=none.

