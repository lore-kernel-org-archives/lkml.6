Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C274ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9042088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mnhwv/RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9042088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeIRFye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:54:34 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:33839 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbeIRFyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537230283; bh=JHE6sU/duMo8wzT7mBjmd0/t5tsYqLIaVbyaHYBCiNE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mnhwv/RS4GRmmfj8fQ3WEbW+eOSDZIWLWrZ3dWt6gWL8e1mSsofaZhHZOkCBJopsitUAjPC6Wil2ijp5WJsxpN3QuUOKvwTVRpykNhCZVrLiYkeciPt7jdLWAqsYDhH+24TSpoP0xJgdUhByjeIF/irap9PZbXDGHxLpugtMSq+zNPIDSkDLKg96q7e+VsvbWzyE0FybGcHg4Uzm9g2qlIPs2qCGTpinKeCeFqUrQc1/SI4ohOv7uZBN3z8Yn8Rc/tzFHHbGsC4XJlaIZxxSI8BxwK7K2m9HIk8dJORUMHU+SAKuWTm9jLK76B+xaY9abqOTTHhfmJf6LOA+n5zIsw==
X-YMail-OSG: nxELvDgVM1mQX9b5vKt0xJflEOTxtat6lnAmHYVYHCZLWiTOFG7_GsSp2RoeERX
 A.ypxrzQcK1jY2ip4GdtayOzPTeNbsHmauoUtFYvsEVfXF6IjKl8Exm3.a_r4iWHjmzRQ8PpkmVh
 FWOPjvoST7RGaA.QniSs0In2Ah_te6gA2OiHqxu5mjafyOC5.Y2PC8HEyIlQrvVueF8ClKnJFAGR
 bR.lFLns7PRGHPSX4p8weltlyw5JBjNQbhLZ59oYiSRxnak.T_OwrMIECzOS1KLD8OGmZBe8efVR
 blLqwCNPw_4JaTRyr4M9QZyvm2fLExm8xPXe8ZrYjrWzlL1dTOjFq5XWWa4YlmOaK.ebNjDxTF.1
 pHgqSYDl9yENP4Ilu92inr3X6Ji7g8P66ZdM3XhVI4lwoxNR4PBVXG1a6wWliPOkeGlwzN1oXvGG
 1VG6KphEDaOPmSxpqyEUTAkeJ5lJ6e0Gp3TPrubVEpR5yoy1p29eYilRUf3z.UC5tucC86V.k6FZ
 Heav1ch6VOlRqKjN6Wmc0MsZTipiprbOFCxaR1LBXxU9RRuZss_nbo_g5rULbcyaGDYZ_9M2_erU
 vpTo58Q8yjU_.VSRPNPl6LU3wZn6cVNLchN9vZUli.NsXl9xp.SYsvwJx_kCk7jfNJt2G8BLEccc
 3VCKj_SRiL5jYhDHJdiXDJ4FKfUoJekS1rZrDNz5EhFntEX2zWi3Zp2N.FtSEsdtk74SSrwtxj.7
 nPePqbY6nmua2uhCZKMP4t_EPOCm0gnnHZemHlTJVc93REYD8_.IsAg6JtdgYVKgSIfnEYibiTk2
 a4mGaHrEAp.ghh1DPgwHPPwrqfUrhzw_0kLqGlfenEkYHJxHRG31CwMSf37_JlnTqNisN16IhExB
 joMisOr7NsfHek.P8UoHw3W1GGIhEdbdJ1DfnAgtjXLFk3Hcrp3uQzLzqGCPW7zjmuqCk2yFY5sG
 L5inwUA2jo.79F2M7u2sJtauH0Y0EI5QHshUAv0UEKy.dwAMl9dJCrp00jqyS9MKLOXfr3KKy..m
 NZL1vRN.qG0vAubE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Sep 2018 00:24:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2286c4dc9ee87d92080386bf8d7434e6;
          Tue, 18 Sep 2018 00:24:41 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
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
 <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 17:24:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 5:00 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 3:36 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/17/2018 02:57 PM, Casey Schaufler wrote:
>>> Modules not listed may go anywhere there is a "*" in the order.
>>> An lsm.order= without a "*" is an error, and ignored.
>>> If a module is specified in lsm.order but not built in it is ignored.
>>> If a module is specified but disabled it is ignored.
>>> The capability module goes first regardless.
>> I don't mind using lsm.order if we must but really do not like the '*'
>> idea. It makes this way more complicated than it needs to be
> Having the "*" means that _not_ having it in "lsm.order=" is an
> implicit form of LSM disabling.

That's not what I said. What I said was that without a "*" the ordering
goes back to what was specified at build time. lsm.order does nothing
with enablement or disablement. If you say "lsm.order=smack,sara,*" and
sara is not compiled in you get smack followed by everything else.

> And I think we've gotten to the point
> where we agree on the enable/disable logic, so I don't want to mess
> that up again.
>
> For enable/disable, I think we're agreed on:
>
>     lsm.enable=$lsm
>     lsm.disable=$lsm

Works for me.

> lsm.disable takes precedent for disabling. (e.g. "lsm.disable=apparmor
> apparmor.enable=1" will leave apparmor disabled)
> lsm.enable will allow per-LSM enable/disable to operate. (e.g.
> "lsm.enable=apparmor apparmor.enable=0" will leave apparmor disabled)
>
> lsm.enable/disable ordering will be "last match": "lsm.disable=smack
> lsm.enable=smack" will leave smack enabled.

So far do good.

> The legacy per-LSM
> enable/disable ordering is the same, but ordering between
> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
> precedent mentioned in the prior paragraph.

That is, capability,yama,loadpin,<major>

> To support "security=", we'll still have some kind of legacy
> LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
> other "major" LSMs. This means "security=$foo" will be a short-hand
> for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
> exactly match current behavior (i.e. "security=smack" and if smack
> fails initialization, we do not then fall back to another major).

Right.

> I think we have to support runtime ordering for the reasons John
> specifies. Additionally, I have the sense that anything we can
> configure in Kconfig ultimately ends up being expressed at runtime
> too, so better to just make sure the design includes it now.

Right.

> What we have now:
>
> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>
> - we can't change first.
> - exclusivity-ordering only matters in the face of enable/disable
> which we have solved now (?)

I'm not sure where you get the conclusion we've solved this.
Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
there's no mechanism to prevent that.

> so, ordering can be totally arbitrary after "first" (but before some
> future "last"). We must not allow a token for "everything else" since
> that overlaps with enable/disable, so "everything else" stay implicit
> (I would argue a trailing implicit ordering).

There's an assumption you're making that I'm not getting. Where does
this overlap between ordering and enable/disable come from?

> The one complication I see with ordering, then, is that if we change
> the exclusivity over time, we change what may be present on the
> system. For example, right now tomoyo is exclusive. Once we have
> blob-sharing, it doesn't need to be.
>
> so: lsm.order=tomoyo  after this series means
> "capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
> non-exclusive, suddenly we get
> "capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
> (i.e. if selinux is disabled then move on to trying smack, then
> apparmor, etc.)

We're missing a description of what happens at build time.
It's hard to see what you expect to happen if I want to build in
all the major modules and don't plan to use the boot command line
options.

> I would argue that this is a design feature (LSMs aren't left behind),
> and order of enabled exclusive LSMs "wins" the choice for the
> exclusivity (instead of operating "by name" the way "security="
> works).

I think I see more, but I'm guessing. At build time it looks like
you're dropping the specification on the "major" module. We can't
do that because I want to build kernels that run Smack by default
but include SELinux for when I'm feeling less evil than normal.

