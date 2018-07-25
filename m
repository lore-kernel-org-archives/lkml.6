Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91534C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DcjPM2sY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S+xIcORY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGYUCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:02:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeGYUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:02:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B7CC605BD; Wed, 25 Jul 2018 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532544580;
        bh=hqcVmCp7ExcjrQLAmHsgJU9CiWMSsU4oBFtN211aU7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DcjPM2sYVDKELq8R8a0TI18qyEMM65/9s6SnbFPiXsihIngb/4XBhc8JbMUqWgdVe
         AwL4IlrQjTqRKnX5qgRHsidHj9GzPXu1Hya4sJyuvgerPlKJdnUcx2EEqLE1vg1VEg
         khm2IZl8f/qTuAcv5f+9UI42B6luwpxwzhaLTVWI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8A4CC605BD;
        Wed, 25 Jul 2018 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532544579;
        bh=hqcVmCp7ExcjrQLAmHsgJU9CiWMSsU4oBFtN211aU7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S+xIcORYiOV1giBQ1shtgQfdHPpj7V878vrm26ttEyGOq38gIzwztIoLyErRCOyj6
         6TpJQMXepEeYg2Wd/G4sSrcNcSjknQgZSbCtTVUZtSa5w3BMAyf1qW1+4mKt3iSTwM
         aeUFnkLMlCUDWEcIf3wFjqza/zqZ7VDn6HVASIL4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Jul 2018 11:49:39 -0700
From:   pheragu@codeaurora.org
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, apw@canonical.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Require commit text and warn on long commit
 text lines
In-Reply-To: <59a1b82fd854c9bf8a530bb053b718dc@codeaurora.org>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
 <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
 <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
 <50a05aaf44e5f86cbf687863dadaa26b45debe2d.camel@perches.com>
 <59a1b82fd854c9bf8a530bb053b718dc@codeaurora.org>
Message-ID: <387ec7f1d900b3de28f3bbf82d36bf8a@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-16 11:20, pheragu@codeaurora.org wrote:
> On 2018-07-13 17:08, Joe Perches wrote:
>> On Fri, 2018-07-13 at 16:28 -0700, pheragu@codeaurora.org wrote:
>>> On 2018-07-13 14:46, Joe Perches wrote:
>>> > On Fri, 2018-07-13 at 14:40 -0700, Prakruthi Deepak Heragu wrote:
>>> > > Commit text is almost always necessary to explain why a change is
>>> > > needed.
>>> >
>>> > This bit seems sensible, but perhaps it should just count the
>>> > number of lines after the end of email headers and before any
>>> > Signed-off-by:/Signature line
>>> >
>>> 
>>> While committing the changes, one can just write the subject and not
>>> write
>>> the commit text at all. So, if we just count the lines between email
>>> headers
>>> and signed-off, we still do count lines which form the subject, but 
>>> the
>>> commit text is still absent. Also, subject can be longer than one 
>>> line.
>>> So,
>>> just counting lines doesn't really guarantee the presence of commit
>>> text.
>> 
>> Not true.
>> Look at $in_header_lines and $in_commit_log.
>> 
>>> > > Also, warn on commit text lines longer than 75 characters. The commit
>>> > > text
>>> > > are indented and may wrap on a terminal if they are longer than 75
>>> > > characters.
>>> >
>>> > This is already exists via
>>> >
>>> > # Check for line lengths > 75 in commit log, warn once
>>> > 		if ($in_commit_log && !$commit_log_long_line &&
>>> > 		    length($line) > 75 &&
>>> >
>>> 
>>> True, but this patch points out every line of the commit text that is
>>> exceeding the limit.
>> 
>> Which is bad because things like dump_stack() are added in
>> commit logs and those are already allowed to be > 75 chars.
>> 
>> Anyway, something like this probably works.  Please test.
>> ---
>>  scripts/checkpatch.pl | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index b5c875d7132b..8b5f3dae31c9 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2240,6 +2240,7 @@ sub process {
>>  	my $in_header_lines = $file ? 0 : 1;
>>  	my $in_commit_log = 0;		#Scanning lines before patch
>>  	my $has_commit_log = 0;		#Encountered lines before patch
>> +	my $commit_log_lines = 0;	#Number of commit log lines
>>  	my $commit_log_possible_stack_dump = 0;
>>  	my $commit_log_long_line = 0;
>>  	my $commit_log_has_diff = 0;
>> @@ -2497,6 +2498,18 @@ sub process {
>> 
>>  		$cnt_lines++ if ($realcnt != 0);
>> 
>> +# Verify the existence of a commit log if appropriate
>> +# 2 is used because a $signature is counted in $commit_log_lines
>> +		if ($in_commit_log) {
>> +			if ($line !~ /^\s*$/) {
>> +				$commit_log_lines++;	#could be a $signature
>> +			}
>> +		} else if ($has_commit_log && $commit_log_lines < 2) {
>> +			WARN("COMMIT_MESSAGE",
>> +			     "Missing commit description - Add an appropriate one\n");
>> +			$commit_log_lines = 2;	#warn only once
>> +		}
>> +
>>  # Check if the commit log has what seems like a diff which can 
>> confuse patch
>>  		if ($in_commit_log && !$commit_log_has_diff &&
>>  		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
> I checked all the cases that I mentioned before. The change you 
> suggested works
> for every case. Would you take care of merging this fix?
Any updates on this patch? Would you take care of merging this fix?
