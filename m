Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08119FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94C220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T9tTd7d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94C220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeINVM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:12:27 -0400
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:41990 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728076AbeINVM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536940637; bh=gao7PJ6bBOPWJNRvXaiLpLdx9SmHgbKD+8I1SyUpkuI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=T9tTd7d6TBLZMru15ncRyV6KMl5/FCbnu9x7gjXtqIva55WwS9MojnvxvJjg1sCNB2Yiw5sJmciF0tk6Dx4+1cA0mghp77sd+LhBwqy2gq78jb3Nm4ChKVkvZ98+pcc8i9AEs7zX47L154uYSzQZ6vud5q4R+p+dYBzoMe1n2vKgHNobn35dOplcVTg7KCp1vYCAvKLoYqFQG3nKtOM1j30CxSE+AHHGifVh67CWhMmV83hZpA4nvl1O7G573DnjmFCqTDROV9DLvZ93gBLZxk2AFMbWMy8WrVGznm6/V0oSP3xtukuddUczBZsVZemVHXnEylh/hm8Mg//q2dlwxw==
X-YMail-OSG: N7Jyt1gVM1nLphOS3aVwEkKQ2yDdUp.scPTNn77JmvM3T6Ly0BiAQjlKvs3AbNS
 8M2rNsymYnUiAjjhUarTgFoi5i2D05b04P6cklfsH1MeL6Vl1kfEgKIiGpu1R7T9Q3ibFhJJdD1c
 vbcjyd_0XTjgy88APwGviMEFpH.xFLtLfmATcZX20FReSX8gNKsnmi2Gz4R3JGrXg9SskcVGWTJ8
 wJl3LZtZUJRfTdCobOsdivruj6zO1e5RnKQBcnboeok3VdCkHfqzXkt6jY.LEMek1KpyfJwQFppj
 5RYp7aNGF6fHkpqhpyeXUSI31bZUTeISSuEAGb8koXGR4TKhiJwfKAWHIAXRiYkMBUAKoKOtfiXl
 wMsxmODiOk.BD30kNK3PLVz2zkoib60Z7MHC90SS7v7xDcZy4HmavL_oeOrDJf.z1O6wY7rTP7ND
 qbDvf3wtltYWEophByHN8U71Rhgif8o7xHznHh93iJEtF5ZFGujtSGZtWs0dScZipMfnG._MNAB8
 1bX3LqvmrK6SNjXrRjYMNlVOfvwPONvtwKN7b0cbpqs07qGgDyWJINKQ1plXrbwgmwoBZmFrrr.G
 7qdhCge2B8emuxnIal.6gGYdSwbzHTp.wLm4IN6inJpcJaSltbx0FqrXEA7Pl6meU5J4A1ipMD.q
 WEFGNGYhlW4skEZkwrwcZ8s8zc1PAf.eGMMq2gSlgohqoLSuZeYMASoL8SDjYb4N_8jsZO04QINh
 ieKm2ljtmH.ChxC63AVxEx6EVkh3U.QzE5cnAq1HSVYQhTxb7lNg5YaZ04tuAlcOw.6rAXZ5Vrj9
 M0lcOxaRioJIBCW8uutXJDeY6Vuvq9YheeKiA7dtNT6HxByE8GsSCvOS529nschBYYu.1B5atjze
 npao0jls_n219NL3P.FsZJO1QlkWaxxz71nJ4s4DVZXlBNXnP_VwXDz75_ajUbDZnHKmmeLMb5YY
 XRkz3K8d_Z2Veb.98J5yk3mPOj30Df.KqYOvrLH5Wl3zMkJh1_2sQMCIiPJEbkfb_PKyo4BzzZ15
 rYDBCzRKu2iZRsWhnU2Ck6.6ZyFalgDY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 14 Sep 2018 15:57:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a9208e24391501f37450496b3fbdb868;
          Fri, 14 Sep 2018 15:57:17 +0000 (UTC)
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
 <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
 <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2bc5e4f5-8429-6843-f255-8fab6dacf39b@schaufler-ca.com>
Date:   Fri, 14 Sep 2018 08:57:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 5:19 PM, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 5:08 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/13/2018 4:57 PM, Kees Cook wrote:
>>> On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/13/2018 4:06 PM, Kees Cook wrote:
>>>>> - what order should any stacking happen? Makefile? security=?
>>>> Makefile by default.
>>> Okay, if ordering is by Makefile and everyone dislikes my
>>> $lsm.enabled=0/1 thing, then these mean the same thing:
>>>
>>> security=selinux,tomoyo
>>> security=tomoyo,selinux
>>>
>>> i.e. order of security= is _ignored_ in favor of the Makefile ordering.
>> No, I think that the two lines above should have a different
>> execution order. If we really need to specify multiple modules
>> at boot time that is what makes the most sense.
>>
>> It's a matter of mechanics and probably another pass during the
>> init process, but it's doable. If we determine it's necessary for
>> this stage it is just work.
> We already have the minor LSMs that cannot change order.

Are you saying that we don't have a mechanism to change
the order, or that they wouldn't work right in a different
order? Well, there's the capability module that has to be
first.

> They aren't
> part of security= parsing either.

True, but there's no reason now that we couldn't change that.
Except for capability. Hmm.

> To enable/disable LoadPin, you do
> "loadpin.enabled=1/0" separate from "security=".

SELinux and AppArmor have the same.

> Should "blob-sharing" LSMs be like major LSMs or minor LSMs?

I like the idea of changing the minor modules to do the full
registration process. That would make them all the same.
Except for capability. In any case, the "blob-sharing" LSMs
need to do the full registration process to account for their
blobs sizes, and that brings the "major" behavior along with it.

> If someone is booting with "security=selinux,tomoyo" and then SARA
> lands upstream, does that person have to explicitly add "sara" to
> their boot args, since they're doing a non-default list of LSMs?

Yes. security= is explicit.

> (I actually prefer the answer being "yes" here, FWIW, I just want to
> nail down the expectations.)

For now let's leave the minor (capability, yama, loadpin) as they are,
and require all new modules of any flavor to use full registration.

We could consider something like

security=$lsm		# Stack with $lsm at priority 2 - Existing behavior
$lsm.stacked=N		# Add $lsm to the stack at priority N. Delete if N == 0

It's OK to specify "selinux.stacked=2" and "sara.stacked=2". Which gets
called first is left up to the system to decide. Whatever the behavior is
gets documented. Capability will always be first and have priority 1.
It's OK to specify "smack.stacked=1".

The default stack is determined by CONFIG_SECURITY_$lsm_STACKED at
build time. CONFIG_SECURITY_$lsm_STACKED changes from a boolean to
an integer value to establish the default hook order.

/sys/kernel/security/lsm reports the modules in hook call order.
/sys/kernel/security/lsm-stack reports the list with the hook call priority

	capability:1,yama:1,selinux:1,sara:5,landlack:17

If stacking is not configured $lsm.stacked=0 is treated as security=none.
For other values of N $lsm.stacked=N is treated as security=$lsm.

