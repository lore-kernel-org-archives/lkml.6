Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F63AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgf80wR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECB120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeKFVAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:00:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:00:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id j22-v6so6002520pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0l4Fd2VPkGRcQpITZhcxqNJcoYTw9lq1oiaUBmHGLpY=;
        b=sgf80wR2KH7vOmMwKfCONU1dw7TKYF8mi5L6031uFXZD3A7k4S6gtmg9+f92mYnXKm
         3AWnXExeiUwB9rOy882BbMV5JjnqYKnNUIwYjSGaJfhrqjE5e9qnek3Re43VnjK60YTo
         oJaudbC/qqfwve4iY0L8291HA+bUwFBp1GSfd8sd0+6oYkGtQYDNpaqzp1HW+u1TEFNr
         BCQXOcl3b4w1L2qx35YG+JqAq52BEXA3f+btmr8xdzPOKl6abasIOmImtyB1rEh6duou
         ZgAKsV02vjFNZC2BPeAsJqjk4KUlB0w3V1uFhiuYbIhjOJbtSjaCq/SALA+EhYMT3+ga
         D2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0l4Fd2VPkGRcQpITZhcxqNJcoYTw9lq1oiaUBmHGLpY=;
        b=TnBBXqx8H/8uSVcvDxobcc5G8AMoOhDpTIjWWzt2avxo8w62cHHmHddhRTyINgb5tb
         2zDdwPFHt1rJw8DovdP9eJtPPXyZMu6RjiqQIru5MMhWCpMNqeN6Tb9X0txgucxnEa3C
         qWptKkDBfpkFwxbkz0CXVs+u0g8AACpRblJ2ZJ/J+jajYuLi5bT0qjrFjYxNpP6ap+ZH
         RSrxCdx/EGDc9XHXOYeZoZXvwmtFniO3FgkoeMi756EXzN8uvqWQtHvr6YEC/zHqhN/9
         sB3sGGUGUTAOGgOy47u0VGSA1tmLTEVO2lzyNEmHGnTsSXQlsC6TGafn4oWCGtqGNfE4
         qf0A==
X-Gm-Message-State: AGRZ1gKV2Z4xDlAVIXZbDkqUjfFyliJK2784UCIoY9Wuzf6rWpMtInCe
        ic0Y/7avspkPq2KCodZXs8o=
X-Google-Smtp-Source: AJdET5ewkZHc6bAqyeDQ9E6OH/rwXecowMOQdUX1AqakrnB+Cl03Kglg+8QIgMXCECafbYhrB0TT+w==
X-Received: by 2002:a62:14d4:: with SMTP id 203-v6mr25611603pfu.221.1541504165759;
        Tue, 06 Nov 2018 03:36:05 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id p64-v6sm47422418pfi.22.2018.11.06.03.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 03:36:05 -0800 (PST)
Date:   Tue, 6 Nov 2018 06:36:04 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kobject: to use pr_warn replace KERN_WARNING
Message-ID: <20181106113603.ydi6xyrwe23zykfm@yubo-2>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
 <CAJZ5v0gzM+_a+HJa_kjpgaj96iiH3f_x1ZXjK3HE8=E5FvuAPA@mail.gmail.com>
 <932e46a701ebe9b3b33a110d187880eda14c23fb.camel@perches.com>
 <CAJZ5v0ha=+g2bCr+0Xf47bh-fr66woJfhubd7guc-Dr-xC9x1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ha=+g2bCr+0Xf47bh-fr66woJfhubd7guc-Dr-xC9x1g@mail.gmail.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:09:15AM +0100, Rafael J. Wysocki wrote:
>On Tue, Nov 6, 2018 at 8:58 AM Joe Perches <joe@perches.com> wrote:
>>
>> On Tue, 2018-11-06 at 08:49 +0100, Rafael J. Wysocki wrote:
>> > On Tue, Nov 6, 2018 at 3:42 AM Bo YU <tsu.yubo@gmail.com> wrote:
>> > > Fix warning form checkpatch, use pr_warn replace KERN_WARNING
>> > >
>> > > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>> >
>> > First off, IMO, you should not change the existing code just in order
>> > to make checkpatch happy about it.  That alone is not a good enough
>> > reason for modifying it.
>> >
>> > If the checkpatch warning indicates an issue like broken white space
>> > (and I mean really broken and not lines longer than 80 chars etc),
>> > then that may be a reason to modify the existing code, depending.
>>
>> Existing code is slightly broken.
>> There is currently a missing terminating newline in the
>> non-switch case match, when msg == NULL;
>
>OK, so this should be explained in the patch changelog.
>
>Saying "I do this to make checkpatch happy" in the changelog is just
>not enough IMO (if not outright misleading).
Using pr_* code become more and more in kernel when i read code and then i ask
for help from checkpatch. In commit log i just copy the what to to but not my
explations that why to do such.
I will send V3, thanks.
