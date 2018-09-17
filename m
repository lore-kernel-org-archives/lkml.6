Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BCF20671
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NxqKS6lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BCF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeIRFAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:00:38 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:46180 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbeIRFAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537227061; bh=XnzdHcSDfW7YrS7IHagChIU8lfaTzV3cjiStkPFdRpU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NxqKS6lGJ4oQrS/NVknsgu9mdvtIU372ibQSArCxPT9mu6x/XbXkrrvxZurQi65+fpgdsJp30V0iAX3VxmI5p4/FYYcivuVWm4Qq4hqT6xs1v1cN6FW7K1gDlVYRp7GQiH/rMvol6bE83QqgfRuAvnIG2e0cfxzxzLRNKsniqi3mwj6+yj5i6pCPnbjF194CWU40rWrt8raJnntSIAsocRX9qWu34lCLOvJIZw8srZUi4fpivmmgASZE0NNFi2+hcMM3SHGPA6GF3NB3Re/msdo+wJL7F9b1IRc1XsHpcBobRgq5qmVALFLnI4GBjHkEKfic6e1tWgokqeYb1myUsA==
X-YMail-OSG: LdJCluIVM1miFDb6RVr2YmxcL0n6dyitjN7jQSnHwTHTK5.TSa_bH.VBKxUNteo
 VYnqXtyFJ110J.bYtTZ17OJK7VDMtEae4v.Ruxrc.RXH.BTq73mDwnFrno.VyRsoerOoSCooSZu2
 wc70pcyUI.FXeSczyHcAmLSEhdxt4qwRJfrCcPz1dUrEMkr34JidJ57ya1on.BGyUWi_2h6E4Rl6
 8T5aKYR8CKZm9s3ewRRXblFH66XtYR0F1aheHA0dAyR2IUGAYN76eSlNUrvefBHxKVemH0VQ9L_C
 7bj3ppj6zeEoNCi4YJGl5w_RrkSGBNmFfzLXbtUFD3q7c_sOrMzca.G.Y8pIQA39Atxnuy25zvGq
 JzfljtTyevZzvg6ubOcZV973M24pH.Ns2yjrTcXg7QzIfiMiRk.rT8LlGO3m2bDJLvtNf7HwMddn
 xUW6VTyoxqEL3xVCOBHXEw0lJkOz2xh710LFweuAtmwBGoS4ewjrDPJT5TVy7Zi5V86gLVIc__et
 iTcSewBMeNPV.DNP6clZPQ3HhFiCo.2vPyeAWdQ1PNfycKI7ZTq81IrVE0jykxEQUQL9ImjcwjEE
 Bzp3rFNGiavYaWOZKcGZ8pYdSrl94BDDpxWJ8qNXImXYITtUpWqt4.LFqhcN5Fu7NUHLNz_EidRp
 Eh.ysPH0ol.k1p77.NVRSjZ_eAXQtJDIgtWUGpz2sssWsGxrXCCXvDPh9vbhTigavtqjWaY6Y4Wb
 H6DstYojL4cRfkKvLbHTCc7nyMJSGlHYGPg1ICswk287CK6oyai0iRw5cExjL25ITNSCQWKHNoqt
 iVh_sC.42mOFVYWJlU4hLaKB0dgZuYDtlIGUJ2cK2qr2ZIuhSS7yaAXACcBhxEiEyGoXZeTdu8tM
 gKzm3iXuxDraHX.dsrAMjY9wYciJbkLAyvyVwAiIR2hMxYkHApi28iy6.QxtYjS1q6S8TR3CnbsB
 C.1os8XuZ29MSqlta9JEaZaduPiDdSBpLsoZPA8.hzFUKWcSIdx6vDXbaVJAazFj0zpQBHJSKwcV
 Oy02xdIrD9PlOwfPRCTShrzaeMcm8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 23:31:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be572c3cd7073e44635ae2a5e6699ae0;
          Mon, 17 Sep 2018 23:30:58 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
 <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
 <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
 <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
 <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
 <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
 <CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3a90fe88-d74a-2c2c-c949-cabcaad2e1da@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 16:30:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 4:20 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 4:10 PM, Mickaël Salaün <mic@digikod.net> wrote:
>> Landlock, because it target unprivileged users, should only be called
>> after all other major (access-control) LSMs. The admin or distro must
>> not be able to change that order in any way. This constraint doesn't
>> apply to current LSMs, though.

What harm would it cause for Landlock to get called before SELinux?
I certainly see why it seems like it ought to get called after, but
would it really make a difference?

> Good point! It will be easy to add LSM_ORDER_LAST, though, given the
> machinery introduced in this series.
>
> -Kees
>

