Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CCF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O/5gGep5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GNv7IwaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CCF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeGMXot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:44:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbeGMXos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:44:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1879B60541; Fri, 13 Jul 2018 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531524482;
        bh=XkuJBa0SlFu3FTCP9FaWlEdE100Oo7pdIr4awoh/fnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/5gGep5BZ0/Pi3ekKvRS+d1qctQ+noHfjUM1rhgI74Ylmb8lfuz8uu/yxwmuPwTv
         qq6TVF25S+UmhwYbLtMSy0Dp05gqhZ8mTKIBFs1m2eElrFNIcWGpZa3vRadrKH13ZL
         OWeeMdFc/0TFbcF3OKqpfVC5n3RKt2BPjBzpdKDg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0AACD60227;
        Fri, 13 Jul 2018 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531524481;
        bh=XkuJBa0SlFu3FTCP9FaWlEdE100Oo7pdIr4awoh/fnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GNv7IwaUOfYHAqUMiJqOtxkOShixWgeUvFPxUVlTe3TUluVKA9qUt2EboFw+yqNkT
         qCeFG7bLlQAboGZ23NMrdjXrry2P5t6ABdl1yzCgT6QTQAhar2iqZIh/SJB/tWJdzP
         FAtABX9cEsv1/0GcI9QvOnWkdVkFs3X1qtQeb0B0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Jul 2018 16:28:01 -0700
From:   pheragu@codeaurora.org
To:     Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        ckadabi@codeaurora.org, David Keitel <dkeitel@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Require commit text and warn on long commit
 text lines
In-Reply-To: <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
 <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
Message-ID: <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-13 14:46, Joe Perches wrote:
> On Fri, 2018-07-13 at 14:40 -0700, Prakruthi Deepak Heragu wrote:
>> Commit text is almost always necessary to explain why a change is 
>> needed.
> 
> This bit seems sensible, but perhaps it should just count the
> number of lines after the end of email headers and before any
> Signed-off-by:/Signature line
> 
While committing the changes, one can just write the subject and not 
write
the commit text at all. So, if we just count the lines between email 
headers
and signed-off, we still do count lines which form the subject, but the
commit text is still absent. Also, subject can be longer than one line. 
So,
just counting lines doesn't really guarantee the presence of commit 
text.

>> Also, warn on commit text lines longer than 75 characters. The commit 
>> text
>> are indented and may wrap on a terminal if they are longer than 75
>> characters.
> 
> This is already exists via
> 
> # Check for line lengths > 75 in commit log, warn once
> 		if ($in_commit_log && !$commit_log_long_line &&
> 		    length($line) > 75 &&
> 
True, but this patch points out every line of the commit text that is
exceeding the limit.

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -14,6 +14,13 @@ use File::Basename;
>>  use Cwd 'abs_path';
>>  use Term::ANSIColor qw(:constants);
>> 
>> +use constant BEFORE_SHORTTEXT => 0;
>> +use constant IN_SHORTTEXT_BLANKLINE => 1;
>> +use constant IN_SHORTTEXT => 2;
>> +use constant AFTER_SHORTTEXT => 3;
>> +use constant CHECK_NEXT_SHORTTEXT => 4;
>> +use constant SHORTTEXT_LIMIT => 75;
> 
> probably overly complicated
