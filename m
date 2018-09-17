Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C648ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF81B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uOghUlH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF81B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeIRFKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:10:35 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:38965 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbeIRFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537227655; bh=1xTiVgLZrE4AKSCW6kvUVMKw8bOMVjK/n/crsoP6FZs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uOghUlH6hFxRzddS2Vx9nja3zM28UuxyeT4fN+v3b5w/zCmC9ZPqELJoqMIQ+FN6+lmfCoDMbIW5H6jMa+5S1p4O5AVAJPQY3BEU/OIasmZZwqrx66LZqpunBx970RpNmdv1KPYqBb8Q5z3fILEwtvu4fTlSmizNpAYqWZXiL0GBL0YXpecfCvbDL7ajTQs+bmfxptjce/QskbnnZj7tmnA/XhvOwq4hsQNoiFwpI7kQFRWfjejQ3K6yLZzImLMWLzToA3O0QmV8E+X2rKp3o7WvRCTfav6GS81uLXoXRoKMlrCkv+kAsEkiaQNwHr67s+ZwmbU7UfD/Rvah0VD01g==
X-YMail-OSG: KwATkgUVM1kIDjDZHbemFx6dABinmcfBj9Na.AhrAPcu4mK_62O7abCcZ.B0KsT
 NGw5r9D2jDK_3pZKtN8Yr7M_xfNVkCWjflp4ZP90e5LGhlpJnoVY.31FOVc5kFORQBcPGiL80_p9
 8FcYuQ9Jc09KdYRu8CMmOqTHankOc4VsH54htDNGmq10mDM6ICXv8on8RWfxrv.e98gwktEOHf13
 uW5GeuChwAuBUiDl2ZPAC0bn9IGBci3ZSna5XXvr6XLGZyPAthiJFD0tieuYAZtuuEzRTFQMoBP8
 Z87VMtrmQrGJsn_8wYGBtFzgDDa4HJv_vPNE4W2CgUliVDK84.3iihdc1nOlXZWA_aUxLYOeuc6i
 pBXHJucYCuP6QSTA3RWsn7LZ9L9CawUVdaFE.ovcZysDgKqJ.hF_kn9V2wUN.qn1WSeBVUgiXw9N
 HJPZCw_xtdu_oCgBafekchRClhRhfzYnObXQgc802LGeWssREebApq_4MnKYRyluJ0OPsZCYxLhx
 T83_E5SS2X87MgMA8aNa5XSAUIL0ELpXaxXwGTbAs3gNKdMGdz_yKOwlVZXhezd6LXZw2RLKu_st
 iF4VTPyoHqZH2.Ux5bBqTyV6gkRRRunLggrC1jNNhOnknkBBkbiPGh_MyLrMeRLVkbsCzxEU6OLY
 GntMNfIVN_0mx_mScqDqf_9tJy40XbiQ9QXbyE6YX6H1GXPtbotnicHbvin2QrQT3Mcbg7fjuBmc
 35ijwBJfU1IC4Z8S4H43c.2FIRtvW0rlo8EKP5SHJ8zUXLRb9lTDXRtHy73WEqtWv5y.UNyrFTUk
 zs1c362s9SkZVMI_47jSoF_lRlBn3j2qgno3F.Kqu2YXnLVvIqr6CN3T3tGEpn.mCaZKixwVUkGW
 z.zV8QgRHxSyXo0aqz4prJ8g9MyIh3eKiD0Nc4jO1g4H2uaJsnf0SCTlC1mJ4XwMUcHiO8QeA5zw
 JHvJ3uNJVwAY2ao81iroiQrmw7ZJ91gqEy7wU2_QuhC9aAAcfxj0xo6c_Wh0VeO86WcqvLwq1M9M
 Gks4pGftLJQHWqID8gQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 17 Sep 2018 23:40:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e917b0489f2593a57538db83364356ca;
          Mon, 17 Sep 2018 23:40:54 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
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
 <060150b2-4bb4-bdcb-760a-5aa5e1ade381@canonical.com>
 <CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ddb2a534-0845-55c1-329c-70adcc3847b8@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 16:40:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 4:28 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 4:26 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/17/2018 04:20 PM, Kees Cook wrote:
>>> On Mon, Sep 17, 2018 at 4:10 PM, Mickaël Salaün <mic@digikod.net> wrote:
>>>> Landlock, because it target unprivileged users, should only be called
>>>> after all other major (access-control) LSMs. The admin or distro must
>>>> not be able to change that order in any way. This constraint doesn't
>>>> apply to current LSMs, though.
>>> Good point! It will be easy to add LSM_ORDER_LAST, though, given the
>>> machinery introduced in this series.
>>>
>> And when we have two LSMs that want to use that?
> We'll cross that bridge when we come to it, but perhaps "last
> exclusive"? (lsm.enable/disable to choose)

If we define restrictions on use of LSM_ORDER_LAST like we have
for LSM_ORDER_FIRST (only for capabilities) before anyone starts
abusing it we may be OK. Since an LSM_ORDER_LAST has to know that
it can't count on getting called (a non-last module may return -EACCES)
I don't see any way that having multiple LSM_ORDER_LAST modules in
any given order would be a real problem. Of course, a module could be
doing state management that *really* requires it be last, but that
would be a badly designed module and someone sensible would NAK it.

