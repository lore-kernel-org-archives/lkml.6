Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6B62084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZMGC2lRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfAHXF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:05:27 -0500
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:37182
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729144AbfAHXF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1546988725; bh=nYwpBKP6IDLQh5uWUaxgaeOzbe9Bo+t0A6ErmpwOazc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZMGC2lRLkD/a/KlNKhfD37bX+++SwW8ffmzH8qdjGtVqQqgoudwlgGRS3xFTJVr9OJJ2iAzomoqag2cpsHLwAeMs377jRacvYvZw9JE1QcP0FJNUQMSfqGtaEyFh6VItGynxvvCGxGB7TwPq0MopRmJUwHLV2ifH6gyhkE9jir/wuaBuUy16kF0DB7UitlButZ+sYVJFLqVSOkaizj8T3RGMS+TFjnZxQk7dpcozCiIfIclgBn+lNhYuM0Oax+r6zGzs4bsMrR+R7PZKIMEuVwZp41yUKPWKQZAbPShY1zBWvYLjf2nApKrLirreJj5BYEHH9mVnMTvUEiFergymuQ==
X-YMail-OSG: seWxL1QVM1ntO_QAz5SaDt8nAxX3ZQ1Dh2tD2nER0b3jk5KSeFdAH2ZmewbIaFP
 Slx_z3GOJkeatIusDgdM.wywIElt3nbmKDarOcqSFWaAQ1mr8418_UEL15C4icNvkQDzA.dtAjwq
 WiPRrKJN2Zl4KRbpYhCzpHMeGVo5OSE5Haawljf4Hr4o5BA1ZgCowKxSxWanAs8v0nifW9cfqmXi
 X7U55O1TgrMfTf5EMpj1r35uacWFuL6dLSJHaJEx0q75DealjzXt4MNsKW9WLzAfzd9IK7brqw3P
 dRsoWbBbBVQarozU6wasv._lhi80wHFzQPKfbyHbRsqs7gHDIuj5lMUrn5WMAyhzaup0eGsHQrV6
 zg3p9TSive9m9zl.MZ70mPWrz6yYSxpn1Q47WbPS4c8cyluH48oxhncaF5sLFO43JLW0SHGvtPLE
 Mvd_w5LPR.p67DKQM2AkHNZI2GDYIuWTOr4XiXJOzHk4i2MHKqjV5LiKFQ5ZikzGE6wbLcRSAaAU
 X_uXjK0w1He3sA_GCCsx31v5_w4SZbHc1t.GmSNEOwJqu9464vpeHi1oT3TJ.QdFgWaJ6qDOCzGh
 pL3USEuFZnhkVnSUO1aMHR_C2Wgg5uG8W7DvSITr0cMdI0AYGg9nm5pOZbYr2lvxq1_dg.LTc3Sd
 qlutO2iue_sGTrJgmBFypHok8vgd7tE4ml5lq3N708KyuQl92LOdK6oRQea2ehnCNv8T.UJ0B7JU
 dXB6DeCcRpQ6mb6pqdSlXeo7UdqZMy.Sk_UEQR4wVorEIce7F_5IfhYaZ0vg5j0_35HhBjijQPhW
 B7ombGSQyfrXWSSGifZWqZmxyjZrawnwdkHyln3koldvoUgWBD3dAoK_RUePFzwNgOsFM2XK75H7
 uL6kbx5h7DmYg8LOYeITVTzqCii7CyxwLdlJSI.lFqfJ7DgrcVDNXPzws0VQnRjl0AYulXArdbtM
 qDW9ksF1tlEbcnxfDJEWfQAPURr0hGM0XARQdz3oyFypXPMfC1U79wEo99wYMHK7FK0_cnq9BdvY
 d5XQfnILuXnswSmabcPCt7J32rJI1Rvr2TLcmeNotrw.gvdM.YuG2hzhzMbv.A499w9kSZu11qVZ
 dgT9mH66TTtmrWSj3FpoEnr9z0bDv8sFsmA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 8 Jan 2019 23:05:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c27692f2203900284add210af0c02032;
          Tue, 08 Jan 2019 23:05:20 +0000 (UTC)
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
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
 <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
 <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7671ab97-d4e1-eb60-781f-ade40f559e02@schaufler-ca.com>
Date:   Tue, 8 Jan 2019 15:05:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/2019 1:42 PM, Kees Cook wrote:
> On Tue, Jan 8, 2019 at 1:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/8/2019 1:05 PM, James Morris wrote:
>>> On Mon, 7 Jan 2019, Kees Cook wrote:
>>>
>>>> On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
>>>>> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
>>>>>> On Tue, 4 Dec 2018, Kees Cook wrote:
>>>>>>
>>>>>>> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>> v5: Include Kees Cook's rework of the lsm command
>>>>>>>>     line interface. Stacking is not conditional.
>>>>>>> Can you resend this series with corrected "From:" lines in the body, etc?
>>>>>>>
>>>>>>> Beyond that, I obviously like it. James, what's needed for this to move forward?
>>>>>> If there are no outstanding issues, I plan to merge this for 4.21.
>>>>> Yeah, it looks good to me. (Excepting getting the authorship sorted.)
>>>> I didn't see this actually get merged? Was there something that needed
>>>> fixing? Should I send you a direct pull request for v5.1?
>>> Yep, please send a new pull request.
>> Do you want it as is or rebased on 5.0-rc1?
> I've rebased to 5.0-rc1, did some light (re)testing, and sent a pull request...

Thank you.


