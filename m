Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E18214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ENlMcHMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E18214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeIRFah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:30:37 -0400
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:46306 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbeIRFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537228852; bh=smEEDhZI15HzrHaN0zph10l76gmjeOm4bwOyXNIDovI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ENlMcHMdRxiz/NdhEdnCo2Fi3/ZPX0l1v8qzL+p7L0vKKCnQBiqboVTphnHMN4qHYALMTEEt23N17E2OqaUvKDdsSsAClamwRzR9t38dOSsf9mNyJFlTqQWaN3fHRdWTlXuLQhd4NlSSYQSo6pq3eBe2s2ugU2xDU5iShcgP2K9eCIbBh0PVO75YHe3bg6utBM6OxIqgnpLnrtwd+1S7+ed7yOsvWCmeHKIpbdokZ0ANaJ7n9q02SiO/elqQxDS66wV29BLCKKZ4Bb2EweRUqKPhkK3Ed5Ilq5eZGYdBeNK47qChn2/sRcfSJYGJR7kriEm0DgUbrMhedZXiMZXxCg==
X-YMail-OSG: 0QMXJmEVM1lGEnKe9c8hWHSYaRMfWZuNJAWZ2uH21k79ls5sPsTDxqeS23IwQ0Z
 odozJPNUpotc21SCtjGVXi4P7gdXWoRO.Ff04LEAQa6mhD9MRORM.KN0PVo9v6_ZmqQ2tm2OCN2m
 q3zGgXiCuBFmPdqIalX0pk4j61L43ANoBB2vuDn1a6r0arSkRTCWWjssQHnaLoacD8MgctoL8rFz
 HOgmzBA.01djoeewEpFv.zOKelVCmzmeenTJxpkyD0MUPUdDPobsoUt_aB.Th9VWFwsvWQlF3pgB
 bAJWtR8QKB8K7UapmLN3LBt04uY23wTUf4uXA9_08JaA7SFLy3IM8Z1QYHMwZUEu.5rsuOz9nEPw
 OFNqP4xrS04IO2iAWijML5cB1N3E1fu8wG16.BoiONhePa9XP_HXyYpwy7ZY6IanD._y96v3vaV.
 998rlnkI23vD.on2OJi.qxZIdU90QS37CJW5o.N3C19ulP90PQABKlvbSzOxNX11DZeNGtMSKAlq
 iLBRWq.9c6mhuUXcLxxZ2P5vjK5f.KWgyaj59bIKO289ivvc3bu6GU5sPYibB7WDWtpc7.mclaE.
 u1R0uloqC63UJMp8xKdIkC.hmysil81SVSLQ9KARN1TNjsaOLd4vRNkkLUTmJSSt.utI1JviOVk9
 fY6hWQPoAjBwyl9V_9vSiy39GEG1vhhIwD45HH95c2lAbUdp4U7HBVA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Sep 2018 00:00:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fb7ad53ccb8e6346e5ebf463bba4c859;
          Tue, 18 Sep 2018 00:00:49 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>
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
 <3a90fe88-d74a-2c2c-c949-cabcaad2e1da@schaufler-ca.com>
 <968ac661-ad5d-c6e2-1587-971b6dceaaea@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <99de54b0-a659-a80e-0f52-8f540192a85e@schaufler-ca.com>
Date:   Mon, 17 Sep 2018 17:00:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <968ac661-ad5d-c6e2-1587-971b6dceaaea@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 4:47 PM, Mickaël Salaün wrote:
> On 9/18/18 01:30, Casey Schaufler wrote:
>> On 9/17/2018 4:20 PM, Kees Cook wrote:
>>> On Mon, Sep 17, 2018 at 4:10 PM, Mickaël Salaün <mic@digikod.net> wrote:
>>>> Landlock, because it target unprivileged users, should only be called
>>>> after all other major (access-control) LSMs. The admin or distro must
>>>> not be able to change that order in any way. This constraint doesn't
>>>> apply to current LSMs, though.
>> What harm would it cause for Landlock to get called before SELinux?
>> I certainly see why it seems like it ought to get called after, but
>> would it really make a difference?
> If an unprivileged process is able to infer some properties of a file
> being requested (thanks to one of its eBPF program doing checks on this
> process accesses), whereas this file access would be denied by a
> privileged LSM, then there is a side channel attack allowing this
> process to indirectly get information otherwise inaccessible.
>
> In other words, an unprivileged process should not be allowed to sneak
> itself (via an eBPF program) before SELinux for instance. SELinux should
> be able to block such information gathering the same way it can block a
> fstat(2) requested by a process.

The argument would feel a bit stronger if LSM checks happened before
the DAC checks. The opportunity to sneak a check in already exists, but
not with the tools you get with eBPF. For now at least I'll grant that
there's good reason for Landlock to go last.

