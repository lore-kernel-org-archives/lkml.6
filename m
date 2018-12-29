Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5438C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C872145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YKfbQ153"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeL2SeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:34:25 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38989
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbeL2SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1546108463; bh=ZgjrlLp7GmcYyFnk7yxZClNQSO1PLCovYVtYIkaSkpg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=YKfbQ153r+H9fGaF6UGTsxTplsB/ioUM9XEW31CziWQfSijEBaCcSkewhwWuBkPaSqbwfp2uYYkTLdul9+w0NmN7FeLf/4+TPte8GQkvZe77jywbK1tY9YpC82tLx4V2alzgMIjJBwCt9NY7Z9nbKEVlCBybhdAInrXIYHTTXK0b3aHidHcOCs8O9O+wv/womqP+Ok5ZSZRDYX6CjfgIns6fpPZF7lajDAb6ulDLV+mTTBg4LKdus7xW9kH4aCIMVoXCOTWEtRTmdkz2oI953VP8Boqw96GzRaRobu2woHzFLGTfgrJPRPaLyYOdSIlbqtICtcLfB//WEUtnOt5W5w==
X-YMail-OSG: 0PeUPgQVM1ndho2oWI.tcuN2r1KqXqNI6OtU2a5VLlJmS6zu.rpr2V4NEUqvj4K
 Xv_1fxrEHoL5EzEiVT2lIG9L5PsmZDEwOhxs3213UJa1wF4O9_w4kB2U_zJjxTXCAWuJvhgbl.QS
 aTnfw2z6u6WGv554ihvBa7Lz3G31CZl9YnTZQFA9HQU1izda9U9AMUHbBm1ufDAbLig0b2nUI5gT
 Jj6DEH3x83qTuyeEL3lv6sLQzQomdTDVV8acgprEjwefieenggajThyCtYw5whW_W6hxR9VZc_8Z
 PFq0HLrY2hgSe_94gz9aeD_2f3nwYyP8e.DIC1Ozj3oB4MidUfiVHzL5J0snGVABfNVFR73x.Kxw
 oh6CnzQyZLrzCyt0M_lQHbMqUVgNYQ3DdHXKv9f6.CTV5wmIkhzHSDgumTPzZfoYAZQScL5bNc4j
 4DjOitTf_hERpNNFrsefthYl32Tw5umsn4Fvh.VEGMnV2AVexc0cXj3gDxVqQCPxi6fGCr2BmMND
 zlk_2yEs3qISMBqEZ1VZhHWlfKcbdoXt33Tm2hLZ0YxZwirCkXY5a6XIFotGTeClgRQIQDp9DtBL
 uRTssqTsG6nmjsPS86eiwI4iRajDnPcxvh8zp71ObzvMtBOX5c3iprVzQwHh8wSzn6pLwz1VnMn3
 _dDAc9o9sTXRJLsbH53AdROyRblP83NPB6r0sbcJw_7orcUkNWCGUxhebr7mJTL2mEvNzM8y0Xqe
 NPuqPvhXPdInzlfj7Qz8XlxK3iJ.eXaCoCf2Rw0Kf9X3aNhGFmmiZZ_p37YfiKlWIyaAKrr_VSLQ
 VRcYyvzjA_pYKDuTU0q8F.TU6S8HH.cW.XqmqcTPqR8LoDn84zJm6MKV496uPzKFCTfTRgDisS_p
 GYNCikcu44omMD_q6aW3RX19cTUhXqJUdBl1fJdfePRocXf55Ofb74SYw3xGYavwbX2MFehen5zI
 j.rsIR8hXmwZA1wD2GrJ24o69TllJt.4z0ZFXjC.AHUeT63FGMBmpa9q88tqJyI2lwH3nd363Ju2
 lwZgKNlyl_IMshIAd3jczUNbNddyEp6JsaXGYuBcUr_AXqIKFkINOZaXsvupIrVfVpjvws5AOhAY
 PZnBWbIB9feHe1eVHOrOcpmKcH6g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 29 Dec 2018 18:34:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d48a13f66d8cb949f3d9195969ad350;
          Sat, 29 Dec 2018 18:34:21 +0000 (UTC)
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
 <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
 <alpine.LRH.2.21.1812291406530.29722@namei.org>
 <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
 <alpine.LRH.2.21.1812291505480.31477@namei.org>
 <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <45d180c5-a174-7eef-9e23-83b819f8abd6@schaufler-ca.com>
Date:   Sat, 29 Dec 2018 10:34:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/2018 8:15 PM, Linus Torvalds wrote:
> On Fri, Dec 28, 2018 at 8:09 PM James Morris <jmorris@namei.org> wrote:
>> Yep, I understand what you mean. I can't find the discussion from several
>> years ago, but developers asked to be able to work with more current
>> kernels, and I recall you saying that if you want to do this, merge to a
>> specific -rc tag at least.
> If people really want it, maybe the merge can state that explicit
> thing, as it is I'm trying to push back on empty merges that don't
> explain why they even exist.
>
>                   Linus

The security tree tends to get changed from multiple directions,
most of which aren't based out of the security sub-system. The mount
rework from David is an excellent example. It gets hit just about
any time there's a significant VFS or networking change. Keeping
it current has helped find issues much earlier in the process.

