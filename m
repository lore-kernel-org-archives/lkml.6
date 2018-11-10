Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF644C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE420818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeKJU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 15:26:48 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45172 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbeKJU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 15:26:48 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42sYVt5rkPz1r4wX;
        Sat, 10 Nov 2018 11:42:14 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42sYVt56j7z1qqkq;
        Sat, 10 Nov 2018 11:42:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id njDz1bTsGypG; Sat, 10 Nov 2018 11:42:13 +0100 (CET)
X-Auth-Info: 7IJp+EcA0vL3jJGz3YCxZhpq/EA8oTFRJLz8s9TKttmudLeuwuCEnM40SkZDeeWl
Received: from linux.local (ppp-188-174-147-181.dynamic.mnet-online.de [188.174.147.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 10 Nov 2018 11:42:13 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
        id 2ADCD1E586D; Sat, 10 Nov 2018 11:42:12 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Genki Sky <sky@genki.is>
Cc:     Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with git-status --no-optional-locks
References: <20181107022156.GA254567@google.com>
        <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
        <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
        <20181107184435.GA168339@google.com>
        <20181107.204358.257636196@genki.is>
        <20181107205514.GB12273@roeck-us.net>
        <20181107.210731.330601031@genki.is>
        <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
        <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
        <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
        <20181109183436.GA45531@google.com>
        <20181110.085826.230851261@genki.is>
X-Yow:  I FORGOT to do the DISHES!!
Date:   Sat, 10 Nov 2018 11:42:11 +0100
In-Reply-To: <20181110.085826.230851261@genki.is> (Genki Sky's message of
        "Sat, 10 Nov 2018 00:58:26 -0800")
Message-ID: <m24lcpjjss.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10 2018, Genki Sky <sky@genki.is> wrote:

> On Fri, 9 Nov 2018 10:34:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
>> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
>> index 71f39410691b..eab1f90de50d 100755
>> --- a/scripts/setlocalversion
>> +++ b/scripts/setlocalversion
>> @@ -73,8 +73,19 @@ scm_version()
>>  			printf -- '-svn%s' "`git svn find-rev $head`"
>>  		fi
>>
>> -		# Check for uncommitted changes
>> -		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
>> +		# Check for uncommitted changes.
>> +		# First, with git-status, but --no-optional-locks is only
>> +		# supported in git >= 2.14, so fall back to git-diff-index if
>> +		# it fails. Note that git-diff-index does not refresh the
>> +		# index, so it may give misleading results. See
>> +		# git-update-index(1), git-diff-index(1), and git-status(1).
>> +		local git_status
>> +		git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
>> +		if [ $? -eq 0 ]; then
>> +			if echo "$git_status" | grep -qv '^.. scripts/package'; then
>
> Shouldn't this be:
>
> 	if printf '%s' "$git_status" | grep -qv '^.. scripts/package'; then
>
> I.e., use printf not echo? Because of echo introducing a newline.

The input to grep should be a text file, thus should end with a newline.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
