Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84FE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jUBcnXYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84FE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLECh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:37:58 -0500
Received: from sonic312-29.consmr.mail.ne1.yahoo.com ([66.163.191.210]:40489
        "EHLO sonic312-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbeLECh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543977477; bh=dwTMjSFF5Nukzb6JeL4PjgPuasWoyDNv/q64zN9dU7g=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jUBcnXYazgb+oFcPRvXjJvsOU21iwdv42vMTVCvGD4iRmByKp9gUgltmYvqe4rxg/ON9OFjVaphBzWJN8z17b5WxqFFG/a3oOgk4Qmz2hszor8a51UOIA1t5xF30RSygTi8t3f0sEFNOhkEDAbgrKiFOGPq0o4eIfxnzttj9bIpWSfMtfLudckdXoq7QxSQU+G4jthdpocc/I7mfUJ0cisoeqtQHs+5yvU8jfyKGc3AHHHJkayhaxwRdBJQK1oiu5AMq/lu3ZYTW5NEiNfuk+hN6Y8Tjjkl20D7W33G/WZhPaFqGOL/rqoBhDm8/T8O0sZzFMi01gAeWm37gB9OkaA==
X-YMail-OSG: vlP1BpYVM1n_s7R0rjC8YkE7yCKM5WBHs8EohnXOumFV_2vgMf9mknCguTKWz5M
 .YFt6GUX711HlkShuPTR8IV8ZGUCG1ktPI7ANu0apxX24EMbLFm3nUt4Kao.mg3qjPRWz9lWdOV.
 rQQueiTEHhaHrLAZJyviTaNvXTEjvwbj.zuY_e4aiTrQt3sHK6ic07AQayy2Paz9TDaxp5TXncdt
 KrHE2RoMb7JsnXVlAIqPjFhl1xG_KM1lbp_yW.1fAbxnu8zQyYUKcq9gV.spQ1Qw81yrxY7uuS6X
 mvwnXR5WONyrKQuG40ci1538id_7SUpfeyFPSOAcZhoQIQWpNZpOJHwxnUlW2uW5OZnn2Az1tRyE
 oLLqIcG9HKXZm.HGL7LmUy5tI91iA4w36.WQbeKk0G7Xf70AN9QvWUk3hE0.31vilT5nUNM5sOda
 o6fagsjc2EJSB.8B98cbGZyr3O3pE3PrZjxNCM3isAgii8vJ0KEQlJVs6irw41k9WfaenHsa6_u7
 F81ILwDz0HwkeVSKCS9A8nwOHNJVzkJZCBa8z0ggQSkXIaC5kmOVo4pGQvnPmUnO..EGMyrQN3RU
 FuoN4gRERfc5fNmuOY3.NmFxoLavX1KgkkTlfvlvPij_Lm2kvCYYiDrmNzCdeA6bVFIh8UlN1Azi
 hsyTLjoYsYgfBxd8s4E4qloEYR5poqG6cDTT0myZFxjQ2OgJfTNZ8cazS65q3l2aPw8aj9.mkkYY
 rEyug8VLYU2CYLsD9Ll55tCrF7WgkBk.Xh3reQxV_4M.o.d_f5PvZFWo34H.nSojcQprK_T5zVNK
 8YT7ncOe3QuK0G2u9wn7aXpvDgE4oCdamJqTZhs9tZNbwLF2Q7T13OaAUcvW7awTn0z5YYYEBFIg
 nnkJcwzGTlPYpCs1X_KJxlg8yicRqt3D_C2WYjpUNzt5qyilcmsHkRSuShNvHHQ8YWPZMnpAotPl
 RILqVU7v8hIgxz5copTNOhr0_GEHFRDU3X7YWTjSaA.WouR1dNQ_6A5GppYqNKpn0OREZtTtcvej
 8GDuLH4kRR2J53_UOag7QiYNy6VgMaUwYt4UjUTmSVDauYfbQ1PkqB5JkkFooyDsA9.swYTu49ef
 D3H8J79S1njGaZdng4A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Dec 2018 02:37:57 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6c9a182b8cb3a9f3d7d2a5eccbf4aa61;
          Wed, 05 Dec 2018 02:37:52 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fead393a-ef06-0008-e795-a480aa75b8b5@schaufler-ca.com>
Date:   Tue, 4 Dec 2018 18:37:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/2018 4:31 PM, Kees Cook wrote:
> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> v5: Include Kees Cook's rework of the lsm command
>>     line interface. Stacking is not conditional.
> Can you resend this series with corrected "From:" lines in the body, etc?

Yes, I can. I was hoping to hear something other than crickets.

> Beyond that, I obviously like it. James, what's needed for this to move forward?

Agreed.

