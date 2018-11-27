Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2320645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uT7UM/sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C2320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeK1G0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:26:23 -0500
Received: from sonic315-20.consmr.mail.bf2.yahoo.com ([74.6.134.194]:33486
        "EHLO sonic315-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbeK1G0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543346846; bh=+dBEI8Hn5IB8yAPR3LCebCeRlNZbPUXpV+/zZmgg4eY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uT7UM/sMJu0+jWUv57NJ90I227GATzMJTRq7+s/KVm07Gp43ENS6OWOTp+V12ZNW2zGG67kTpNS2CNYcow+Tij/iNhcxbebKT674yLAzi1rpa7GIo+TTH0iEeLMuvdVHTMhGQnhDDYrlIQfoZJc+vfxkeev2xuglORxtx0s+MMsj4SMfmLbetSgCGwHBzlYRMwHoGErUrElgHteGkAJLdrnB1/pfX6BLKAvX3kvQGnlCIE+YBoDwToiszWmNWwMlb1JS2o3QFk3H3BIqNAEnn9Mu9F/4G8GnM8dNhUA7VJkKuHAdcNg58smaXQhgYH35o9mHsqcRRgZQz2FKCkismQ==
X-YMail-OSG: DiPcviwVM1mIauYp4vp05KSAU1OOuIUoY5cD0SiXc9RFjv5RSeLoFYusAi78GwC
 ZfBnc4tsrMUJ.QOK0fUj3eCltycWQfOPdBZKOJt8Ic1etGckUPP7ZgbUscpmJflponZy709TRt1L
 sNouSuEvcc34iRXdD5FwWSNS4YnyhhKCnxpVAgLb9EgfeKOHhPQ6wDU9_G5HllqkmzF5e7z8wIZe
 xi_bqQBcIY_J.wSeQeI65xiseCSzrKTzS0AA9vTemVqYYgksA6k.MRqf_Srb53rf.zmvnWqVtKif
 ZX3zL6_i3Lk_9o8fgyBzyWH.X8C6yPGUB_nSQoO77OPWRbk.ap58YZCWj_4_udYikza8MZXauaEP
 fQ1qQBrbhCK10Nnaysax9DRVP6AAj3W9ULa4NSzGodloU6V42KzaYbxDesNVpLsUev6j0_EVcbNp
 wNRt7ficgUkBRevwK0N4Zjdj7yQnp.ffzu_H4nr64UziKAaE63rQrt5x3HY86crRJ4jGrNgJBLAC
 2kp9ttN7ohVa468hS1nmFM3mCWQHowXo_YQkfC7OJMdKJgsPkWwS_5bCXeCAl9Nahr_r2F3uqTko
 wSawwMIklHf1vgcAciMd82q41KEf1hafFfLuqUZSnJLyX1VxChoO5wc5o2xots7vr01BlBV26Woa
 o__WrZuavlhYZCpk1_wAnmZB.ntxY1B8eHX6WL9VeG.e4.q66mWjC0qTZpb688XULf4eDdPUpEht
 vastbd9Hkpk60WQB7excuejmRGCyp5m1J2psMKzJ08lIqyJ_XaLs5xM9hUyfoELZVXBf_5XAO96I
 LCjEMbpdWI6l2EGjROOrR8h.gOyaqLsk_03BoLBwYRvJOvi2HxElr8X3lgG2iMOXUlvPEBlQkNom
 q1.vsFYqZSIDM2_LtoBbk0bTT_j82cWjBjSGQJIi2q.QnUoxwXW2imOWSBEBPcjy4bgETTIe40Xt
 MtJqhas9kJMx8KEoTYuGfxTZvlTwk0K8b9dLhI8I3kXBrBkmu0.RtcDeNClawZwibpbFtbGTjl37
 Jms8PnX.OGgAWlPFr5PwzAyPZffT.c2IV3kUor8M0CODMYiek901PuufvKtpv7TwVGiTot9VskTR
 SMIyIQasXM8Qc_vb5qSd_rBljlcSA7I3P
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Tue, 27 Nov 2018 19:27:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c6c50bc68b81c3271bf3c24543d3fbd6;
          Tue, 27 Nov 2018 19:27:25 +0000 (UTC)
Subject: Re: [PATCH v5 01/38] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
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
 <ecb10f5c-7bbd-fb2e-4148-63290bc9a7ff@schaufler-ca.com>
 <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <041a17b9-432d-97e1-c3a3-fbc9e3db13fc@schaufler-ca.com>
Date:   Tue, 27 Nov 2018 11:27:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 9:34 PM, Kees Cook wrote:
> On Mon, Nov 26, 2018 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Hmmm... the "From: Kees..." in the body is missing. Are you using "git
> send-email"?

Not for this posting. I will use it henceforth. I had some
email configuration issues to work through.

